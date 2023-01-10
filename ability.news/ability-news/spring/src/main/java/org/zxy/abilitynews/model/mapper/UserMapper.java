package org.zxy.abilitynews.model.mapper;

import org.apache.ibatis.annotations.*;
import org.zxy.abilitynews.model.entity.User;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/21 23:26
 */
@Mapper
public interface UserMapper {

    @Select("SELECT * FROM user WHERE username = #{username}")
    User get(String username);

    @Insert("INSERT INTO USER" +
            "(username, nickname, password, email, img, status, create_time)" +
            "VALUES(#{username}, #{nickname}, #{password}, #{email}, #{img}, #{status}, #{createTime})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    void insert(User user);

}
