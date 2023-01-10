package org.zxy.abilitynews.model.dto;

import lombok.Data;
import org.zxy.abilitynews.model.entity.ArticleWithBLOB;

import java.util.List;

/**
 * @author Xingyu Zhou
 * @description: 首页需要展示的数据
 * @date 2021/7/22 23:22
 */
@Data
public class IndexDto {
    private String username;

    private String nickname;

    private String password;

    private String img;

    private Boolean isLogin;

    private List<ArticleWithBLOB> articleWithBLOBs;
}
