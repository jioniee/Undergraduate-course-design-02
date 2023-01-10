package org.zxy.abilitynews.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.zxy.abilitynews.model.entity.ExArticle;

import java.util.List;

@Mapper
public interface SearchMapper {

    @Select("SELECT * FROM (\n" +
            "SELECT  a.id , a.title , a.update_time , a.`like`, a.author_number , a.read_count  FROM article a\n" +
            "WHERE a.title LIKE '%${query}%' AND a.if_public = 1 AND a.status = 1" +
            ") a1 , (\n" +
            "\tSELECT nickname , username FROM user\n" +
            ") a2 WHERE a1.author_number = a2.username")
    List<ExArticle> get(@Param("query") String query);
}
