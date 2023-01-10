package org.zxy.abilitynews.service;

import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.model.dto.IndexDto;
import org.zxy.abilitynews.model.entity.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface UserService {
    /**
     * 用户登录功能
     * @param username
     * @param password
     * @param response
     * @param request
     * @return 登陆结果
     * @throws Exception
     */
    CommonResult login(String username, String password, HttpServletResponse response, HttpServletRequest request) throws Exception;

    /**
     * 用户登录功能
     * @param username
     * @param password
     * @param response
     * @param request
     * @param requireMd5 是否需要md5加密
     * @return 登陆结果
     * @throws Exception
     */
    CommonResult login(String username, String password, HttpServletResponse response, HttpServletRequest request, Boolean requireMd5) throws Exception;

    /*
     * @description 校验用户名和密码是否符合规则（长度）
     * @author Xingyu Zhou
     * @param [userName, passWord]
     * @updateTime 2021/7/22 23:07
     * @return org.zxy.abilitynews.component.CommonResult
     */
    CommonResult checkUserInfo(String username, String password, Boolean requireMd5);
    
    /*
     * @description 校验用户注册的信息，并填充默认的一些数据
     * @author Xingyu Zhou 
     * @param [bLogsUser]
     * @updateTime 2021/7/22 23:09 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    CommonResult checkRegisterInfo(User user);

    CommonResult register(User user);

    void writeToDto(IndexDto dto, User user);
}
