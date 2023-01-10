package org.zxy.abilitynews.enums;


public enum UserStatus {
    WHITELIST("白名单", 0),
    BLACKLIST("黑名单", 1);

    private String key;
    private Integer value;

    UserStatus(String key, Integer value) {
        this.key = key;
        this.value = value;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public void setValue(Integer value) {
        this.value = value;
    }

    public Integer getValue() {
        return value;
    }

    public String getKey() {
        return key;
    }
}
