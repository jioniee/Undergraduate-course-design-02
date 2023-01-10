package org.zxy.abilitynews.model.entity;

import lombok.Data;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:04
 */
public class ExArticle extends Article{
    private String nickname;

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
}
