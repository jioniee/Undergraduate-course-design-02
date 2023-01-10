package org.zxy.abilitynews.model.entity;


import javax.validation.constraints.NotBlank;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 15:08
 */
public class ArticleWithBLOB extends Article{
    @NotBlank(message = "文章内容不能为空")
    private String content;

    private String imgLists;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setImgLists(String imgLists) {
        this.imgLists = imgLists;
    }

    public String getImgLists() {
        return imgLists;
    }
}
