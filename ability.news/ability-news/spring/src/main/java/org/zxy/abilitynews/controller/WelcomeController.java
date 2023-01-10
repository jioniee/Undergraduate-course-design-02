package org.zxy.abilitynews.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class WelcomeController {

    @RequestMapping(value = "/")
    public String welcome(HttpServletRequest request) {
        Object user = request.getAttribute("user");
        request.setAttribute("flag", user != null);
        return "welcome";
    }
}
