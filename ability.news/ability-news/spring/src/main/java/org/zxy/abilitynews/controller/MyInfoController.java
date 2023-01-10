package org.zxy.abilitynews.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.model.dto.IndexDto;
import org.zxy.abilitynews.model.dto.UserInfoDto;
import org.zxy.abilitynews.service.MyInfoService;
import org.zxy.abilitynews.service.impl.UserServiceImpl;
import org.zxy.abilitynews.utils.CookieUtils;
import org.zxy.abilitynews.utils.JsonUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:06
 */
@Controller
@RequestMapping("/acl/my/info")
public class MyInfoController {
    // 注入我的信息Service
    @Autowired
    private MyInfoService myInfoService;

    /**
     * 显示我的信息
     *
     * @param request
     * @return
     */
    @RequestMapping("/index")
    public String index(HttpServletRequest request) {
        CommonResult index = myInfoService.index(request);
        request.setAttribute("result", index);
        return "MyInfo/index";
    }

    @RequestMapping("/")
    public String editPage(HttpServletRequest request) {
        CommonResult index = myInfoService.index(request);
        request.setAttribute("result", index.getData());
        return "MyInfo/edit";
    }

    @RequestMapping(value = "/edit")
    @ResponseBody
    public CommonResult edition(String nickname, String email, String introContent, String gitAddr, HttpServletRequest request) {
        String cookieValue = CookieUtils.getCookieValue(request, UserServiceImpl.USER_CACHE_KEY, true);
        IndexDto userInfoDto = JsonUtils.jsonToPojo(cookieValue, IndexDto.class);
        if (userInfoDto == null) return new CommonResult(100, "未知错误", null);
        String username = userInfoDto.getUsername();
        CommonResult commonResult = myInfoService.edit(username, nickname, email, introContent, gitAddr);
        return commonResult;
    }
}
