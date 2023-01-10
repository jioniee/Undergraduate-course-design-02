package org.zxy.abilitynews.model.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.zxy.abilitynews.model.entity.ArticleSource;
import org.zxy.abilitynews.model.entity.ArticleWithBLOB;


import java.util.List;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:06
 */
@Mapper
public interface BlogMapper {

    /**
     * 获取所有的来源
     *
     * @return
     */
    @Select("SELECT * FROM source")
    List<ArticleSource> getAll();

    /**
     * 插入文章的信息
     * @param article
     */
    @Insert("INSERT INTO article (cover,author_number,title," +
            "content,img_lists,if_public,create_time,update_time,source_id,read_count," +
            "`like`,status) VALUES (#{a.cover},#{a.authorNumber},#{a.title}," +
            "#{a.content},#{a.imgLists},#{a.ifPublic}" +
            ",#{a.createTime},#{a.updateTime},#{a.sourceId},#{a.readCount}" +
            ",#{a.like} , #{a.status})")
    void insert(@Param("a") ArticleWithBLOB article);

    @Select("SELECT * FROM article WHERE id = #{id}")
    ArticleWithBLOB getArticle(Integer id);
}
