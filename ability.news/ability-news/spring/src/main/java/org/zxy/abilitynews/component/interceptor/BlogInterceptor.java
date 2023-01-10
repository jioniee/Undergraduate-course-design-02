package org.zxy.abilitynews.component.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.enums.SystemState;
import org.zxy.abilitynews.model.dto.IndexDto;
import org.zxy.abilitynews.model.entity.User;
import org.zxy.abilitynews.model.mapper.UserMapper;
import org.zxy.abilitynews.service.UserService;
import org.zxy.abilitynews.service.impl.UserServiceImpl;
import org.zxy.abilitynews.utils.CookieUtils;
import org.zxy.abilitynews.utils.JsonUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/24 23:55
 */
public class BlogInterceptor implements HandlerInterceptor {
    @Autowired
    UserService userService;

    @Autowired
    UserMapper userMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取cookie
        String cookieValue = CookieUtils.getCookieValue(request, UserServiceImpl.USER_CACHE_KEY, true);

        //校验系统状态，是否登陆成功或是否cookie被清除
        CommonResult systemResult = checkUserIfLogin(cookieValue, request);

        //判断是否登录
        if (!systemResult.getCode().equals(SystemState.SUCCESS.getVALUE())) {
            return true;
        }

        IndexDto cookieData = (IndexDto) systemResult.getData();

        User cacheData = null;

        //TODO: 从缓存中取出user,判断是否为空，然后与数据库进行比对
        if (cacheData == null) {
            CommonResult login = userService.login(cookieData.getUsername(), cookieData.getPassword(), response, request, false);
            if (login.getCode() == 200) {
                IndexDto dto = (IndexDto) login.getData();
                cacheData = userMapper.get(cookieData.getUsername());
            } else {
                cacheData = null;
            }
        }

        if (cacheData == null || !cookieData.getPassword().equals(cacheData.getPassword())) {
            // 不等于的话 我们需要清空Cookie
            CookieUtils.deleteCookie(request, response, UserServiceImpl.USER_CACHE_KEY);
            return true;
        }
        request.setAttribute("user", cacheData);
        return true;
    }

    private CommonResult checkUserIfLogin(String userCookieInfo, HttpServletRequest request) {

        if (StringUtils.isEmpty(userCookieInfo)) {
            // 为空说明没有登录
            return new CommonResult(SystemState.USER_NO_LOGIN.getVALUE(), "用户没有登录", null);
        }

        // 用户登录了
        IndexDto userInfoDto = null;
        try {
            userInfoDto = JsonUtils.jsonToPojo(userCookieInfo, IndexDto.class);
        } catch (Exception e) {
            return new CommonResult(SystemState.USER_EDIT_COOKIE.getVALUE(), "请勿修改Cookie信息", null);
        }

        // 用户cookie中无数据，说明cookie被清除，用户没有登录
        if (userInfoDto == null) {
            return new CommonResult(SystemState.USER_NO_LOGIN.getVALUE(), "用户没有登录", null);
        }

        // 登录成功 返回数据
        return new CommonResult(SystemState.SUCCESS.getVALUE(), SystemState.SUCCESS.getKEY(), userInfoDto);

    }
}
