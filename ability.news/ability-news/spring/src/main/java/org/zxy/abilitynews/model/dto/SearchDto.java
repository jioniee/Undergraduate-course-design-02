package org.zxy.abilitynews.model.dto;

import lombok.Data;
import org.zxy.abilitynews.model.entity.ExArticle;

import java.util.List;


/**
 * 博客搜索页面需要的数据
 */
@Data
public class SearchDto {

    // 查询的条件
    private String query;

    // 查询的类型
    private List<SearchTypeDto> typeDto;

    // 文章的信息
    private List<ExArticle> articles;

}
