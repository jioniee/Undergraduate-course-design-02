package org.zxy.abilitynews.model.dto;

import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:06
 */
@Data
public class BlogPageDto {
    private Integer id;

    private String authorNumber;

    @NotBlank(message = "文章标题不能为空")
    @Length(max = 254, message = "文章长度过长")
    private String title;

    private Date createTime;

    @NotBlank(message = "文章内容不能为空")
    private String content;
}
