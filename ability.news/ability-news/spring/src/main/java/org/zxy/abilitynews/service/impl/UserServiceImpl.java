package org.zxy.abilitynews.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.enums.UserStatus;
import org.zxy.abilitynews.model.dto.IndexDto;
import org.zxy.abilitynews.model.entity.User;
import org.zxy.abilitynews.model.mapper.UserMapper;
import org.zxy.abilitynews.service.UserService;
import org.zxy.abilitynews.utils.CookieUtils;
import org.zxy.abilitynews.utils.JsonUtils;
import org.zxy.abilitynews.utils.MD5Utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/21 23:23
 */
@Service
public class UserServiceImpl implements UserService {

    @Value("${USER_DEFAULT_IMAGE}")
    private String USER_DEFAULT_IMAGE;

    //写入cookie和缓存的key
    public final static String USER_CACHE_KEY = "USER_KEY";

    //单例写锁
    private final static Lock USER_REGISTER_LOCK = new ReentrantLock(true);

    @Autowired
    UserMapper userMapper;

    @Override
    public CommonResult login(String username, String password, HttpServletResponse response, HttpServletRequest request) throws Exception {
        return login(username, password, response, request, true);
    }

    @Override
    public CommonResult login(String username, String password, HttpServletResponse response, HttpServletRequest request, Boolean requireMd5) throws Exception {
        //校验是否符合规则
        CommonResult commonResult = checkUserInfo(username, password, requireMd5);
        if (commonResult.getCode() != 200) return commonResult;

        //查询是否存在用户
        User user = userMapper.get(username);
        if (user == null) return new CommonResult(100, "用户名或密码错误", null);

        //判断密码
        password = requireMd5 ? MD5Utils.md5(password) : password;
        if (!user.getPassword().equals(password)) return new CommonResult(100, "用户名或密码错误", null);

        //将数据写入dto
        IndexDto dto = new IndexDto();
        writeToDto(dto, user);

        //TODO 写入缓存

        //写入cookie
        CookieUtils.setCookie(request, response, USER_CACHE_KEY, JsonUtils.objectToJson(dto), 60 * 60 * 24 * 7, true);
        dto.setPassword(null);
        return new CommonResult(dto);
    }
    
    /*
     * @description 判断账号密码是否符合规则
     * @author Xingyu Zhou 
     * @param [username, password]
     * @updateTime 2021/7/24 15:05 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    @Override
    public CommonResult checkUserInfo(String username, String password, Boolean requireMd5) {
        // 校验用户名
        if (StringUtils.isEmpty(username) || username.length() < 5 || username.length() > 12) {
            return new CommonResult(100, "用户名的长度为5~12位", null);
        }
        if (requireMd5 && (StringUtils.isEmpty(password) || password.length() < 6 || password.length() > 15)) {
            return new CommonResult(100, "密码的长度为6到15位", null);
        }
        return new CommonResult(200);
    }

    /*
     * @description 检查注册信息是否符合规则并填充其他信息。
     * @author Xingyu Zhou 
     * @param [user]
     * @updateTime 2021/7/22 23:32 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    @Override
    public CommonResult checkRegisterInfo(User user) {
        if (user == null) return new CommonResult(100, "请输入账号密码", null);
        CommonResult checkUserInfo = checkUserInfo(user.getUsername(), user.getPassword(), true);
        if (checkUserInfo.getCode() != 200)
            return checkUserInfo;
        if (userMapper.get(user.getUsername()) != null) return new CommonResult(100, "用户名已存在", null);
        user.setCreateTime(new Date());
        user.setImg(USER_DEFAULT_IMAGE);
        user.setStatus(UserStatus.WHITELIST.getValue());
        user.setPassword(MD5Utils.md5(user.getPassword()));
        return new CommonResult(200);
    }
    
    /*
     * @description 注册用户
     * @author Xingyu Zhou 
     * @param [user]
     * @updateTime 2021/7/24 15:04 
     * @return org.zxy.abilitynews.component.CommonResult
     */
    @Override
    public CommonResult register(User user) {
        USER_REGISTER_LOCK.lock();
        try {
            CommonResult commonResult = checkRegisterInfo(user);
            if (commonResult.getCode() != 200) return commonResult;
            userMapper.insert(user);
        } catch (Exception e) {
            e.printStackTrace();
            return new CommonResult(100, "未知错误", null);
        } finally {
            USER_REGISTER_LOCK.unlock();
        }
        return new CommonResult(200);
    }

    /*
     * @description 将user数据写入dto
     * @author Xingyu Zhou
     * @param [dto, user]
     * @updateTime 2021/7/24 15:05
     * @return void
     */
    @Override
    public void writeToDto(IndexDto dto, User user) {
        dto.setImg(user.getImg());
        dto.setUsername(user.getUsername());
        dto.setPassword(user.getPassword());
        dto.setNickname(user.getNickname());
    }
}
