package org.zxy.abilitynews.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.enums.SystemState;
import org.zxy.abilitynews.exception.CheckValueException;
import org.zxy.abilitynews.lock.WriteLock;
import org.zxy.abilitynews.model.dto.OpenBLogsDto;
import org.zxy.abilitynews.model.entity.ArticleSource;
import org.zxy.abilitynews.model.entity.ArticleWithBLOB;
import org.zxy.abilitynews.model.entity.User;
import org.zxy.abilitynews.model.mapper.BlogMapper;
import org.zxy.abilitynews.service.BLogsService;
import org.zxy.abilitynews.utils.MD5Utils;
import org.zxy.abilitynews.utils.MinioUtil;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:06
 */
@Service
@SuppressWarnings("all")
public class BlogsServiceImpl implements BLogsService {

    @Autowired
    BlogMapper blogMapper;

    /**
     * 用户是否在缓存中存过文章的key
     */
    public static final String USER_LOGS_KEY = "WRITE_LOGS_KEY";

    /**
     * 用户文章的详细信息
     */
    public static final String GET_USER_LOGS_CONTENT = "GET_USER_LOGS_CONTENT";

    /**
     * 该用户编辑中的文章的图片缓存Key
     */
    public static final String IMAGE_CACHE_KEY = "IMAGE_CACHE_KEY";

    /**
     * 图片服务器的地址、账号、密码
     */
    public static final String FILE_SERVER_URL = "http://47.103.139.22:9000/";
    public static final String FILE_USER_NAME = "access_key";
    public static final String FILE_PASS_WORD = "secret_key";
    public static final String FILE_BUCKET_NAME = "blogs";

    @Value("${USER_DEFAULT_IMAGE}")
    private String USER_DEFAULT_IMAGE;

    /*
     * @description 初始化,获取blogsource
     * @author Xingyu Zhou 
     * @param []
     * @updateTime 2021/7/28 22:48 
     * @return java.util.List<org.zxy.abilitynews.model.entity.ArticleSource>
     */
    @Override
    public List<ArticleSource> initConfirmRelease() throws Exception {
        synchronized (this) {
            //TODO从缓存中获取数据
            List<ArticleSource> sources = new ArrayList<>();
            if (CollectionUtils.isEmpty(sources)) {
                // 缓存没数据
                sources = blogMapper.getAll();
                //TODO 并存入缓存
            }
            return sources;
        }
    }

    /**
     * 写博客
     *
     * @param article
     * @param token
     * @param request
     * @return
     */
    @Override
    public CommonResult writeLogs(ArticleWithBLOB article, String token, HttpServletRequest request) throws Exception {
        // 加锁 以防数据安全问题
        ReentrantReadWriteLock lock = WriteLock.getInstance().getLock();
        lock.writeLock().lock();
        try {
            // 获取用户的信息
            User userInfo = (User) request.getAttribute("user");
            checkHandleIsLoginUser(userInfo, token);
            // 插入数据库之前的操作
            beforeCreateMySqlProceeeor(article, userInfo);
            // 校验完成 插入数据库
            blogMapper.insert(article);
            // 插入成功 我们再去删除缓存中的数据
            deleteSuccess(userInfo, token);
        } catch (Exception e) {
            throw e;
        } finally {
            lock.writeLock().unlock();
        }

        return new CommonResult(SystemState.SUCCESS);
    }

    /*
     * @description 初始化写文章的页面信息
     * @author Xingyu Zhou
     * @param [request]
     * @updateTime 2021/7/28 22:45
     * @return org.zxy.abilitynews.component.CommonResult
     */
    @Override
    public CommonResult init(HttpServletRequest request) {
        // 加锁 以防数据安全问题
        ReentrantReadWriteLock lock = WriteLock.getInstance().getLock();
        lock.writeLock().lock();
        try {
            // 获取用户的信息
            User userInfo = (User) request.getAttribute("user");
            // 创建返回的信息
            OpenBLogsDto dto = new OpenBLogsDto();
            //TODO 从缓存中获取数据
            String logsToken = "";
            if (StringUtils.isEmpty(logsToken)) {
                logsToken = userInitLogs(userInfo);
                dto.setToken(logsToken);
            } else {
                // 这边是有数据
                String contentToken = GET_USER_LOGS_CONTENT + "#" + userInfo.getUsername() + "#" + logsToken;
                //从缓存中获取内容
                String logsContent = null;
                dto.setContent(logsContent);
                dto.setToken(logsToken);
            }
            return new CommonResult(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            lock.writeLock().unlock();
        }
    }

    /*
     * @description 用户第一次点击写文章后 需要进行初始化，并返回初始化后生成的token
     * @author Xingyu Zhou
     * @param [userInfo]
     * @updateTime 2021/7/28 22:45
     * @return java.lang.String
     */
    @Override
    public String userInitLogs(User userInfo) {
        // 说明该用户是第一次点击
        String newLogsToken = MD5Utils.md5(userInfo.getUsername() + UUID.randomUUID().toString() +
                System.currentTimeMillis());
        // TODO 写回缓存
        return newLogsToken;
    }

    /*
     * @description 上传图片
     * @author Xingyu Zhou
     * @param [request, file, token]
     * @updateTime 2021/7/28 22:46
     * @return org.zxy.abilitynews.component.CommonResult
     */
    @Override
    public CommonResult upload(HttpServletRequest request, MultipartFile file, String token) throws Exception {
        // 加锁 以防数据安全问题
        ReentrantReadWriteLock lock = WriteLock.getInstance().getLock();
        lock.writeLock().lock();
        try {
            // 获取用户的信息
            User userInfo = (User) request.getAttribute("user");
            // 判断一下 当前的文章是否是该用户的
            checkHandleIsLoginUser(userInfo, token);

            // 然后我们需要调用MINIO进行图片的上传
            // 上传之前 我们需要对file进行判断
            StringBuffer fileName = new StringBuffer();
            checkUploadFile(file, fileName);
            MinioUtil util = new MinioUtil(FILE_SERVER_URL, FILE_USER_NAME, FILE_PASS_WORD,
                    FILE_BUCKET_NAME);
            CommonResult uploadResult = util.uploadFile(file, fileName.toString());

            // 取出图片地址
            String data = (String) uploadResult.getData();
            // TODO 存入到图片缓存中去
            imageAddressWriteCahce(userInfo, data);
            return new CommonResult(SystemState.SUCCESS.getVALUE(),
                    SystemState.SUCCESS.getKEY(), data);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            lock.writeLock().unlock();
        }
    }

    /*
     * @description 将图片写到缓存
     * @author Xingyu Zhou
     * @param [userInfo, imageAddress]
     * @updateTime 2021/7/28 22:46
     * @return void
     */
    @Override
    public void imageAddressWriteCahce(User userInfo, String imageAddress) {
        // 判断缓存中是否有我们当前用户的图片集合
        List<String> images = null;
        if (CollectionUtils.isEmpty(images)) {
            // 说明这个用户在缓存中没有图片的缓存
            images = new ArrayList<>();
        }

        images.add(imageAddress);
        // TODO 重新写入缓存
    }

    /*
     * @description 判断本次操作的是否是登录的用户
     * @author Xingyu Zhou
     * @param [userInfo, token]
     * @updateTime 2021/7/28 22:46
     * @return void
     */
    @Override
    public void checkHandleIsLoginUser(User userInfo, String token) {
        //TODO 缓存中取出token，查看是否相等，不等则不是登录用户
    }

    /*
     * @description 对上传的图片进行校验
     * @author Xingyu Zhou
     * @param [file, fileName]
     * @updateTime 2021/7/28 22:46
     * @return void
     */
    @Override
    public void checkUploadFile(MultipartFile file, StringBuffer fileName) throws CheckValueException, IOException {
        if (file == null) {
            throw new CheckValueException("图片不能为空");
        } else if (file.getInputStream() == null) {
            throw new CheckValueException("图片不能为空");
        } else if (file.getBytes() == null || file.getBytes().length <= 0) {
            throw new CheckValueException("图片不能为空");
        }
        String fileNamefix = MD5Utils.md5("IMAGE_" + UUID.randomUUID().toString() +
                System.currentTimeMillis());
        String originalFilename = file.getOriginalFilename();
        String fileNameEnd = originalFilename.substring(originalFilename.lastIndexOf("."));
        fileName.append(fileNamefix).append(fileNameEnd);
    }

    /*
     * @description 保存草稿
     * @author Xingyu Zhou
     * @param [request, token, content]
     * @updateTime 2021/7/28 22:46
     * @return org.zxy.abilitynews.component.CommonResult
     */
    @Override
    public CommonResult saveDraft(HttpServletRequest request, String token, String content) {
        // 加锁 以防数据安全问题
        ReentrantReadWriteLock lock = WriteLock.getInstance().getLock();
        lock.writeLock().lock();
        try {
            // 获取用户的信息
            User userInfo = (User) request.getAttribute("user");
            // 判断一下 当前的文章是否是该用户的
            checkHandleIsLoginUser(userInfo, token);
            // TODO 保存到缓存草稿中
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            lock.writeLock().unlock();
        }
        return new CommonResult(SystemState.SUCCESS);
    }

    /*
     * @description 插入数据库之前的一个操作,补全信息
     * @author Xingyu Zhou
     * @param [article, bLogsUser]
     * @updateTime 2021/7/28 22:47
     * @return void
     */
    @Override
    public void beforeCreateMySqlProceeeor(ArticleWithBLOB article, User bLogsUser) {
        // 补全信息
        article.setAuthorNumber(bLogsUser.getNickname());
        // 显示的图片
        // TODO 判断缓存中是否有我们当前用户的图片集合
        List<String> images = null;
        if (CollectionUtils.isEmpty(images)) {
            // 我们需要给他注入一个默认的图片
            article.setCover(USER_DEFAULT_IMAGE);
        } else {
            article.setCover(images.get(0));
            article.setImgLists(Arrays.toString(images.toArray()));
        }
        article.setCreateTime(new Date());
        article.setLike("0");
        article.setReadCount("0");
        article.setStatus(1);
    }

    /*
     * @description 删除缓存的数据
     * @author Xingyu Zhou
     * @param [userInfo, token]
     * @updateTime 2021/7/28 22:47
     * @return void
     */
    @Override
    public void deleteSuccess(User userInfo, String token) {
        // 加锁 以防数据安全问题
        ReentrantReadWriteLock lock = WriteLock.getInstance().getLock();
        lock.writeLock().lock();
        try {
            // TODO 删除用户对应的token
            // TODO 删除图片
            // TODO 删除用户的内容
        } catch (Exception e) {
            throw e;
        } finally {
            lock.writeLock().unlock();
        }
    }
}
