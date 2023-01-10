package org.zxy.abilitynews.model.entity;

import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 14:41
 */
@Data
public class Article {
    private Integer id;

    private String cover;

    private String authorNumber;

    @NotBlank(message = "文章标题不能为空")
    @Length(max = 254, message = "文章长度过长")
    private String title;

    @NotNull(message = "请选择是否公开")
    @Min(value = 1)
    @Max(value = 2)
    private Integer ifPublic;

    @Min(value = 1)
    @Max(value = 2)
    private Integer status;

    private Date createTime;

    private Date updateTime;

    @NotNull(message = "请选择来源")
    @Min(value = 1)
    @Max(value = 999999999)
    private Integer sourceId;

    private String readCount;

    private String like;
}
