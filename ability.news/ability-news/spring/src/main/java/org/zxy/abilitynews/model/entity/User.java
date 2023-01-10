package org.zxy.abilitynews.model.entity;

import lombok.Data;
import lombok.ToString;

import java.util.Date;

@Data
@ToString
public class User {
    private Integer id;

    private String username;

    private String nickname;

    private String password;

    private String email;

    private String img;

    private Integer status;

    private Date createTime;

    private String retain1;

    private String retain2;

    private String retain3;
}
