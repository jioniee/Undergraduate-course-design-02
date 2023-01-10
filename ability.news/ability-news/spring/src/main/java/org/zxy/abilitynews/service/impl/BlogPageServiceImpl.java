package org.zxy.abilitynews.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.model.dto.BlogPageDto;
import org.zxy.abilitynews.model.entity.ArticleWithBLOB;
import org.zxy.abilitynews.model.mapper.BlogMapper;
import org.zxy.abilitynews.service.BlogPageService;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:06
 */
@Service
public class BlogPageServiceImpl implements BlogPageService {
    @Autowired
    BlogMapper blogMapper;

    //get the corresponding article according to the id of the Dto
    @Override
    public void getArticle(BlogPageDto blogPageDto) {
        int id = blogPageDto.getId();
        ArticleWithBLOB article = blogMapper.getArticle(id);
        blogPageDto.setAuthorNumber(article.getAuthorNumber());
        blogPageDto.setContent(article.getContent());
        blogPageDto.setTitle(article.getTitle());
    }

    @Override
    public CommonResult init(Integer id) {
        BlogPageDto blogPageDto = new BlogPageDto();
        blogPageDto.setId(id);
        getArticle(blogPageDto);
        if (StringUtils.isEmpty(blogPageDto.getContent()))
            return new CommonResult(100, "未知错误", null);
        return new CommonResult(blogPageDto);
    }
}
