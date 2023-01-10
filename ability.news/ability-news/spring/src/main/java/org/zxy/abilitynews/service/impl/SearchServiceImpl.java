package org.zxy.abilitynews.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.enums.SearchTypeEnum;
import org.zxy.abilitynews.model.dto.SearchDto;
import org.zxy.abilitynews.model.dto.SearchTypeDto;
import org.zxy.abilitynews.model.entity.ExArticle;
import org.zxy.abilitynews.model.mapper.SearchMapper;
import org.zxy.abilitynews.service.SearchService;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:26
 */
@Service
public class SearchServiceImpl implements SearchService {
    @Autowired
    SearchMapper searchMapper;

    /*
     * @description 根据条件查询文章
     * @author Xingyu Zhou 
     * @param [query]
     * @updateTime 2021/7/25 23:00
     * @return org.zxy.abilitynews.component.CommonResult
     */
    @Override
    public CommonResult getByQuery(String query) {
        if (StringUtils.isEmpty(query)) {
            query = "";
        }
        SearchDto searchDto = new SearchDto();

        List<ExArticle> exArticles = searchMapper.get(query);

        setCommonFiled(query, searchDto, exArticles);
        return new CommonResult(searchDto);
    }

    /*
     * @description 为dto赋值，共有属性
     * @author Xingyu Zhou
     * @param [query, searchDto, articles]
     * @updateTime 2021/7/25 23:00
     * @return void
     */
    @Override
    public void setCommonFiled(String query, SearchDto searchDto, List<ExArticle> articles) {
        searchDto.setQuery(query);
        searchDto.setArticles(articles);

        List<SearchTypeDto> searchTypeDtos = null;

        //TODO从缓存中获取查询类型
        Object o = null;

        try {
            if (o == null) {
                // 说明缓存中没有数据  没有数据的话 我们需要从类中获取。
                // 查询类型
                searchTypeDtos = new ArrayList<>();
                for (SearchTypeEnum value : SearchTypeEnum.values()) {
                    SearchTypeDto typeDto = new SearchTypeDto();
                    typeDto.setKey(value.getContent());
                    typeDto.setValue(value + "");
                    searchTypeDtos.add(typeDto);
                }

                //TODO 查询完成后 存入缓存中
            } else {
                searchTypeDtos = (List<SearchTypeDto>) o;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        searchDto.setTypeDto(searchTypeDtos);
    }
}
