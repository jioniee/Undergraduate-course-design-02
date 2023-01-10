package org.zxy.abilitynews.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.model.entity.User;
import org.zxy.abilitynews.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 用户操作的Controller
 */
@Controller
@RequestMapping(value = "/logs/user")
public class UserController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/login")
    @ResponseBody
    public CommonResult login(String userName, String passWord, HttpServletRequest request, HttpServletResponse response) throws Exception {
        CommonResult login = userService.login(userName, passWord, response, request);
        return login;
    }


    @RequestMapping(value = "/register")
    @ResponseBody
    public CommonResult register(User user) {
        CommonResult register = userService.register(user);
        return register;
    }
}
