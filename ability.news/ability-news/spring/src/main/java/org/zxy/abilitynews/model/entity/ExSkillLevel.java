package org.zxy.abilitynews.model.entity;

import lombok.Data;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:06
 */
public class ExSkillLevel extends SkillLevel{
    private String skillKey;

    private String skillDescContent;

    public String getSkillKey() {
        return skillKey;
    }

    public void setSkillKey(String skillKey) {
        this.skillKey = skillKey;
    }

    public String getSkillDescContent() {
        return skillDescContent;
    }

    public void setSkillDescContent(String skillDescContent) {
        this.skillDescContent = skillDescContent;
    }
}
