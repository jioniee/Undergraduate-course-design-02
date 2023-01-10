package org.zxy.abilitynews.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.model.entity.ArticleWithBLOB;
import org.zxy.abilitynews.service.BLogsService;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:06
 */
@Controller
@RequestMapping(value = "/acl")
public class BlogsController {

    @Autowired
    private BLogsService bLogsService;

    /*
     * @description 打开写博客的窗口
     * @author Xingyu Zhou
     * @param [request]
     * @updateTime 2021/7/28 22:22
     * @return java.lang.String
     */
    @RequestMapping("/open/write")
    @SuppressWarnings("all")
    public String openWrite(HttpServletRequest request) throws Exception {
        CommonResult init = bLogsService.init(request);
        request.setAttribute("result", init);
        return "writeBlogs/writeBlogs";
    }

    /*
     * @description 上传图片
     * @author Xingyu Zhou
     * @param [request, file, token]
     * @updateTime 2021/8/8 16:25
     * @return SystemResult
     */
    @RequestMapping("/upload")
    @ResponseBody
    public CommonResult upload(HttpServletRequest request, MultipartFile file,
                               @NotBlank(message = "加载失败,请重新打开页面") String token) throws Exception {

        // 调用上传
        CommonResult upload = bLogsService.upload(request, file, token);
        return upload;
    }

    /*
     * @description 保存草稿
     * @author Xingyu Zhou
     * @param [request, token, content]
     * @updateTime 2021/8/8 16:25
     * @return SystemResult
     */
    @RequestMapping("/save/draft")
    @ResponseBody
    public CommonResult draft(HttpServletRequest request,
                              @NotBlank(message = "加载失败,请重新打开页面") String token,
                              @NotBlank(message = "请填写内容") String content) throws Exception {

        CommonResult systemResult = bLogsService.saveDraft(request, token, content);
        return systemResult;
    }

    /*
     * @description 显示确认发布的窗口
     * @author Xingyu Zhou 
     * @param [request, token]
     * @updateTime 2021/8/8 16:26 
     * @return java.lang.String
     */
    @RequestMapping("/confirm/release")
    public String confirmRelease(HttpServletRequest request,
                                 @NotBlank(message = "加载失败,请重新打开页面") String token) throws Exception {

        request.setAttribute("result", bLogsService.initConfirmRelease());
        request.setAttribute("token", token);
        return "writeBlogs/ConfirmRelease";
    }

    /*
     * @description 写博客
     * @author Xingyu Zhou
     * @param [request, token, bLogsArticle]
     * @updateTime 2021/8/8 16:26
     * @return SystemResult
     */
    @RequestMapping("/write/logs")
    @ResponseBody
    public CommonResult writeLogs(HttpServletRequest request,
                                  @NotBlank(message = "加载失败,请重新打开页面") String token,
                                  @Validated ArticleWithBLOB bLogsArticle) throws Exception {
        CommonResult systemResult = bLogsService.writeLogs(bLogsArticle, token, request);
        return systemResult;
    }
}
