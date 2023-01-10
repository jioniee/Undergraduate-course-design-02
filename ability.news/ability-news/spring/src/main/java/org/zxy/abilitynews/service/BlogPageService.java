package org.zxy.abilitynews.service;

import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.model.dto.BlogPageDto;

public interface BlogPageService {
    void getArticle(BlogPageDto blogPageDto);

    CommonResult init(Integer id);
}
