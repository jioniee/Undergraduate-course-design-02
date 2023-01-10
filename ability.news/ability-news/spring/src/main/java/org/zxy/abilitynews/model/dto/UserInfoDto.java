package org.zxy.abilitynews.model.dto;

import lombok.Data;
import org.zxy.abilitynews.model.entity.ExSkillLevel;
import org.zxy.abilitynews.model.entity.User;
import org.zxy.abilitynews.model.entity.UserElseInfo;

import java.util.List;

@Data
public class UserInfoDto {
    /*
     * @description 用户主信息
     * @author Xingyu Zhou 
     * @param 
     * @updateTime 2021/7/26 12:17 
     * @return 
     */
    private User user;

    /*
     * @description 用户的其他信息
     * @author Xingyu Zhou 
     * @param 
     * @updateTime 2021/7/26 12:19 
     * @return 
     */
    private UserElseInfo userElseInfo;

    /*
     * @description 掌握的技能
     * @author Xingyu Zhou 
     * @param 
     * @updateTime 2021/7/26 14:38
     * @return 
     */
    private List<ExSkillLevel> skillLevels;
}
