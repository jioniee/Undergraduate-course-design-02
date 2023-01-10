package org.zxy.abilitynews.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zxy.abilitynews.service.SearchService;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 18:27
 */
@Controller
@RequestMapping(value = "/logs/search")
public class SearchController {

    @Autowired
    SearchService searchService;

    @RequestMapping("/index")
    public String index(String query, HttpServletRequest request) {

        // 存入Request
        request.setAttribute("result", searchService.getByQuery(query));
        return "search";
    }
}
