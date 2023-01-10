package org.zxy.abilitynews.enums;

public enum SearchTypeEnum {


    DEFAULT("默认"),
    PIG_LIKE("最高点赞"),
    PIG_READ_COUNT("最高浏览"),
    NEW_CREATE("最新发布");

    private String content;

    SearchTypeEnum(String content) {
        this.content = content;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
