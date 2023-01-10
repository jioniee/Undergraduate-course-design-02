package org.zxy.abilitynews.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.service.BlogPageService;
import org.zxy.abilitynews.service.IndexService;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 13:42
 */
@Controller
@RequestMapping("/logs")
public class IndexController {

    @Autowired
    private IndexService indexService;

    @Autowired
    private BlogPageService blogPageService;

    @RequestMapping(value = "/index")
    public String index (HttpServletRequest request) throws Exception {
        request.setAttribute("result", indexService.index(request));
        return "index";
    }

    /*
     * @description 打开文章详细界面
     * @author Xingyu Zhou
     * @param [id, request]
     * @updateTime 2021/8/8 21:13
     * @return java.lang.String
     */
    @RequestMapping(value = "/get/{id}")
    public String get(@PathVariable("id") @NotBlank(message = "请重试") Integer id, HttpServletRequest request) throws Exception {
        CommonResult result = blogPageService.init(id);
        request.setAttribute("result", indexService.index(request));
        request.setAttribute("blog", result);
        return "blog-single";
    }
}
