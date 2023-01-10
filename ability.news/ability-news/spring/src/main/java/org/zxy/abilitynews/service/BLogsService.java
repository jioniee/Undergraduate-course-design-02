package org.zxy.abilitynews.service;

import org.springframework.web.multipart.MultipartFile;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.exception.CheckValueException;
import org.zxy.abilitynews.model.entity.ArticleSource;
import org.zxy.abilitynews.model.entity.ArticleWithBLOB;
import org.zxy.abilitynews.model.entity.User;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

/**
 * 写博客Service
 */
public interface BLogsService {

    /**
     * 初始化确认提交的信息
     */
    List<ArticleSource> initConfirmRelease() throws Exception;


    /**
     * 写博客
     *
     * @param article
     * @param token
     * @param request
     * @return
     */
    CommonResult writeLogs(ArticleWithBLOB article, String token, HttpServletRequest request)
            throws Exception;

    
    /*
     * @description 初始化写文章的页面信息
     * @author Xingyu Zhou 
     * @param [request]
     * @updateTime 2021/7/28 22:45 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    CommonResult init(HttpServletRequest request);

    /*
     * @description 用户第一次点击写文章后 需要进行初始化
     * @author Xingyu Zhou 
     * @param [userInfo]
     * @updateTime 2021/7/28 22:45 
     * @return java.lang.String
     */
    String userInitLogs(User userInfo);

    /*
     * @description 上传图片
     * @author Xingyu Zhou 
     * @param [request, file, token]
     * @updateTime 2021/7/28 22:46 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    CommonResult upload(HttpServletRequest request, MultipartFile file, String token) throws Exception;

    /*
     * @description 将图片写到缓存
     * @author Xingyu Zhou 
     * @param [userInfo, imageAddress]
     * @updateTime 2021/7/28 22:46 
     * @return void
     */
    void imageAddressWriteCahce(User userInfo, String imageAddress);

    /*
     * @description 判断本次操作的是否是登录的用户
     * @author Xingyu Zhou 
     * @param [userInfo, token]
     * @updateTime 2021/7/28 22:46 
     * @return void
     */
    void checkHandleIsLoginUser(User userInfo, String token);

    /*
     * @description 对上传的图片进行校验
     * @author Xingyu Zhou 
     * @param [file, fileName]
     * @updateTime 2021/7/28 22:46 
     * @return void
     */
    void checkUploadFile(MultipartFile file, StringBuffer fileName) throws CheckValueException, IOException;

    /*
     * @description 保存草稿
     * @author Xingyu Zhou 
     * @param [request, token, content]
     * @updateTime 2021/7/28 22:46 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    CommonResult saveDraft(HttpServletRequest request, String token, String content);

    /*
     * @description 插入数据库之前的一个操作,补全信息
     * @author Xingyu Zhou 
     * @param [article, bLogsUser]
     * @updateTime 2021/7/28 22:47 
     * @return void
     */
    void beforeCreateMySqlProceeeor(ArticleWithBLOB article, User bLogsUser);

    /*
     * @description 删除缓存的数据
     * @author Xingyu Zhou
     * @param [userInfo, token]
     * @updateTime 2021/7/28 22:47
     * @return void
     */
    void deleteSuccess(User userInfo, String token);
}
