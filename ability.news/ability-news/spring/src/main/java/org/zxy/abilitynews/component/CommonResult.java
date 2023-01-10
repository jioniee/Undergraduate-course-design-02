package org.zxy.abilitynews.component;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CommonResult {
    // 定义jackson对象
    private static final ObjectMapper MAPPER = new ObjectMapper();

    /**
     * 结果代码
     * 200 为操作成功
     * 100 为数据校验异常
     * 404 为找不到路径
     * 500 为程序内部错误
     */
    private Integer code;

    /**
     * 消息
     */
    private String msg;

    /**
     * 响应数据
     */
    private Object data;
    
    /*
     * @description 成功并返回数据
     * @author Xingyu Zhou 
     * @param [data]
     * @updateTime 2021/7/22 23:18
     * @return 
     */
    public CommonResult(Object data) {
        this.code = 200;
        this.msg = "操作成功";
        this.data = data;
    }

    /*
     * @description 构建响应结果
     * @author Xingyu Zhou
     * @updateTime 2021/7/21 22:55
     * @return org.zxy.abilitynews.component.CommonResult
     */
    public static CommonResult build(Integer status, String msg, Object data) {
        return new CommonResult(status, msg, data);
    }

    /*
     * @description 返回成功信息，不带消息，带数据
     * @author Xingyu Zhou
     * @updateTime 2021/7/21 22:56
     * @return org.zxy.abilitynews.component.CommonResult
     */
    public static CommonResult ok(Object data) {
        return new CommonResult(data);
    }

    /*
     * @description 返回成功信息，不带消息、数据
     * @author Xingyu Zhou
     * @updateTime 2021/7/21 22:57
     * @return org.zxy.abilitynews.component.CommonResult
     */
    public static CommonResult ok() {
        return new CommonResult(null);
    }
    
    /*
     * @description 构建响应结果，不带数据
     * @author Xingyu Zhou
     * @updateTime 2021/7/21 22:58 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    public static CommonResult build(Integer status, String msg) {
        return new CommonResult(status, msg, null);
    }

    /*
     * @description 将json结果集转化为SystemResult对象(Object不是集合对象的转化)
     * @author Xingyu Zhou 
     * @param [jsonData, clazz]
     * @updateTime 2021/7/21 23:10
     * @return org.zxy.abilitynews.component.CommonResult
     */
    public static CommonResult formatToPojo(String jsonData, Class<?> clazz) {
        try {
            if (clazz == null) {
                return MAPPER.readValue(jsonData, CommonResult.class);
            }
            JsonNode jsonNode = MAPPER.readTree(jsonData);
            JsonNode data = jsonNode.get("data");
            Object obj = null;
            if (data.isObject()) {
                obj = MAPPER.readValue(data.traverse(), clazz);
            } else if (data.isTextual()) {
                obj = MAPPER.readValue(data.asText(), clazz);
            }
            return build(jsonNode.get("status").intValue(), jsonNode.get("msg").asText(), obj);
        } catch (Exception e) {
            return null;
        }
    }

    /*
     * @description 将json结果集转化为SystemResult对象(没有object对象的转化)
     * @author Xingyu Zhou 
     * @param [json]
     * @updateTime 2021/7/21 23:13 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    public static CommonResult format(String json) {
        try {
            return MAPPER.readValue(json, CommonResult.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /*
     * @description 将json结果集转化为SystemResult对象(Object是集合对象的转化)
     * @author Xingyu Zhou 
     * @param [jsonData, clazz]
     * @updateTime 2021/7/21 23:14 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    public static CommonResult formatToList(String jsonData, Class<?> clazz) {
        try {
            JsonNode jsonNode = MAPPER.readTree(jsonData);
            JsonNode data = jsonNode.get("data");
            Object obj = null;
            if (data.isArray() && data.size() > 0) {
                obj = MAPPER.readValue(data.traverse(),
                        MAPPER.getTypeFactory().constructCollectionType(List.class, clazz));
            }
            return build(jsonNode.get("status").intValue(), jsonNode.get("msg").asText(), obj);
        } catch (Exception e) {
            return null;
        }
    }
}
