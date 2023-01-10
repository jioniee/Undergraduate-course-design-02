package org.zxy.abilitynews.model.entity;

import lombok.Data;

import java.util.Date;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:06
 */
@Data
public class SkillLevel {
    private Integer id;

    private Integer skillKeyId;

    private String skillLevel;

    private String username;

    private Date createTime;

    private Date updateTime;
}
