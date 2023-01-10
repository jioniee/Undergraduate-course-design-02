package org.zxy.abilitynews.service;

import org.zxy.abilitynews.component.CommonResult;

import javax.servlet.http.HttpServletRequest;

public interface MyInfoService {
    /*
     * @description 显示我的信息首页
     * @author Xingyu Zhou 
     * @param [request]
     * @updateTime 2021/7/26 14:50
     * @return org.zxy.abilitynews.component.CommonResult
     */
    CommonResult index(HttpServletRequest request);

    CommonResult edit(String username, String nickname, String email, String introContent, String gitAddr);
}
