package org.zxy.abilitynews.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.model.dto.IndexDto;
import org.zxy.abilitynews.model.entity.ArticleWithBLOB;
import org.zxy.abilitynews.model.entity.User;
import org.zxy.abilitynews.model.mapper.IndexMapper;
import org.zxy.abilitynews.service.IndexService;
import org.zxy.abilitynews.service.UserService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 15:11
 */
@Service
public class IndexServiceImpl implements IndexService {
    public static final String ART_CACHE_KEY = "ART_CACHE_KEY";

    @Autowired
    private IndexMapper indexMapper;

    @Autowired
    private UserService userService;

    /*
     * @description 查询文章
     * @author Xingyu Zhou
     * @param [request]
     * @updateTime 2021/7/25 15:17
     * @return org.zxy.abilitynews.component.CommonResult
     */
    @Override
    public CommonResult index(HttpServletRequest request) throws Exception {
        // 从request中取出用户的信息
        Object user = request.getAttribute("user");
        // 创建返回的Dto信息
        IndexDto indexDto = new IndexDto();
        if (user == null) {
            indexDto.setIsLogin(false);
        } else {
            // 这边说明是登录了， 我们需要进行其他的处理
            User logsUser = (User) user;
            userService.writeToDto(indexDto, logsUser);
            indexDto.setIsLogin(true);
        }

        // 公共处理。。。
        // 比如首页的内容  推荐的博客。。。。
        commonHandle(indexDto);

        return new CommonResult(indexDto);
    }

    /*
     * @description 首页显示的公共信息
     * @author Xingyu Zhou
     * @param [indexDto]
     * @updateTime 2021/7/25 15:17
     * @return void
     */
    @Override
    public void commonHandle(IndexDto indexDto) throws Exception {
        getArticle(indexDto);
    }

    /*
     * @description 查询文章的信息
     * @author Xingyu Zhou
     * @param [indexDto]
     * @updateTime 2021/7/25 15:18
     * @return void
     */
    @Override
    public void getArticle(IndexDto indexDto) throws Exception {
        //保证只有一个数据加入到缓存中去
        synchronized (ART_CACHE_KEY) {
            //TODO 从缓存中获取文章
            Object cacheData = null;
            if (cacheData == null) {
                // 缓存中没有数据嘛 需要去数据库查询
                List<ArticleWithBLOB> article = indexMapper.getArticle();
                // TODO存入缓存

                cacheData = article;
            }
            indexDto.setArticleWithBLOBs((List<ArticleWithBLOB>) cacheData);

            //TODO 定时器每天清空文章缓存
        }
    }
}
