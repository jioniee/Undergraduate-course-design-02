package org.zxy.abilitynews.service;

import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.model.dto.IndexDto;

import javax.servlet.http.HttpServletRequest;

public interface IndexService {
    /*
     * @description 查询文章
     * @author Xingyu Zhou 
     * @param [request]
     * @updateTime 2021/7/25 13:43 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    CommonResult index(HttpServletRequest request) throws Exception;
    
    /*
     * @description 首页显示的公共信息
     * @author Xingyu Zhou 
     * @param [indexDto]
     * @updateTime 2021/7/25 13:44 
     * @return void
     */
    void commonHandle(IndexDto indexDto) throws Exception;

    /*
     * @description 查询文章的信息
     * @author Xingyu Zhou 
     * @param [indexDto]
     * @updateTime 2021/7/25 13:49
     * @return void
     */
    void getArticle(IndexDto indexDto) throws Exception;
}
