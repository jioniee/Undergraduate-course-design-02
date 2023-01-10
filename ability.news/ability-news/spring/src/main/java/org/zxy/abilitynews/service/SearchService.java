package org.zxy.abilitynews.service;

import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.model.dto.SearchDto;
import org.zxy.abilitynews.model.entity.ExArticle;

import java.util.List;

public interface SearchService {
    /*
     * @description 根据条件查询文章
     * @author Xingyu Zhou 
     * @param [query]
     * @updateTime 2021/7/25 18:30 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    CommonResult getByQuery(String query);

    /*
     * @description 设置公共字段
     * @author Xingyu Zhou
     * @param [query, bLogsSearchDto, bLogsArticles]
     * @updateTime 2021/7/25 22:12
     * @return void
     */
    void setCommonFiled(String query, SearchDto bLogsSearchDto, List<ExArticle> bLogsArticles);
}
