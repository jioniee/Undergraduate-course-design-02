package org.zxy.abilitynews.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.zxy.abilitynews.model.entity.ExSkillLevel;
import org.zxy.abilitynews.model.entity.UserElseInfo;

import java.util.List;

@Mapper
@SuppressWarnings("all")
public interface MyInfoMapper {
    @Select("SELECT * FROM user_else_info WHERE username = #{username}")
    UserElseInfo getUserInfoByUserName(String username);

    @Select("SELECT sl.* , s.key `skill_key`, s.skill_desc_content FROM `skill_level` sl , skill s WHERE sl.skill_id = s.id" +
            " AND username = #{username}")
    List<ExSkillLevel> getSkillLevelsByUserName(String username);

    @Update("UPDATE user SET nickname = #{nickname}, email = #{email} WHERE username = #{username}")
    Integer updateUser(String username, String nickname, String email);

    @Update("UPDATE user_else_info SET intro_content = #{introContent}, git_addr = #{gitAddr} WHERE username = #{username}")
    Integer updateElseUser(String username, String introContent, String gitAddr);
}
