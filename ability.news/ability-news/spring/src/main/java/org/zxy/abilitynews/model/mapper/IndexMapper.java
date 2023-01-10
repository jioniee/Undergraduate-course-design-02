package org.zxy.abilitynews.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.zxy.abilitynews.model.entity.ArticleWithBLOB;

import java.util.List;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 15:12
 */
@Mapper
public interface IndexMapper {

    @Select("SELECT * FROM article WHERE status = 1 ORDER BY read_count DESC LIMIT 0 , 3")
    List<ArticleWithBLOB> getArticle();
}
