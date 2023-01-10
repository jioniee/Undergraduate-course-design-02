package org.zxy.abilitynews.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zxy.abilitynews.component.CommonResult;
import org.zxy.abilitynews.enums.SystemState;
import org.zxy.abilitynews.model.dto.UserInfoDto;
import org.zxy.abilitynews.model.entity.ExSkillLevel;
import org.zxy.abilitynews.model.entity.User;
import org.zxy.abilitynews.model.entity.UserElseInfo;
import org.zxy.abilitynews.model.mapper.MyInfoMapper;
import org.zxy.abilitynews.service.MyInfoService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/25 22:06
 */
@Service
public class MyInfoServiceImpl implements MyInfoService {

    @Autowired
    MyInfoMapper myInfoMapper;

    @Override
    public CommonResult index(HttpServletRequest request) {
        Object o = request.getAttribute("user");
        if (o == null)
            return new CommonResult(SystemState.USER_NO_LOGIN.getVALUE(), SystemState.USER_NO_LOGIN.getKEY(), null);

        UserInfoDto userInfoDto = new UserInfoDto();

        User user = (User) o;

        UserElseInfo userElseInfo = myInfoMapper.getUserInfoByUserName(user.getUsername());

        List<ExSkillLevel> skillLevels = myInfoMapper.getSkillLevelsByUserName(user.getUsername());

        userInfoDto.setUser(user);
        userInfoDto.setUserElseInfo(userElseInfo);
        userInfoDto.setSkillLevels(skillLevels);

        //TODO 存入缓存

        return new CommonResult(SystemState.SUCCESS.getVALUE(), SystemState.SUCCESS.getKEY(), userInfoDto);
    }

    @Override
    public CommonResult edit(String username, String nickname, String email, String introContent, String gitAddr) {
        Integer i = null;
        Integer B = null;
        try {
            i = myInfoMapper.updateUser(username, nickname, email);
            B = myInfoMapper.updateElseUser(username, introContent, gitAddr);
        } catch (Exception e) {
            return new CommonResult(100, "未知错误", null);
        }

        if (i == 0 || B == 0) return new CommonResult(100, "未知错误", null);

        return new CommonResult(200, "修改成功", null);
    }

}
