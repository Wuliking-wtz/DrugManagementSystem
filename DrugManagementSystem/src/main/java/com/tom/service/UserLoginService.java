package com.tom.service;

import com.tom.pojo.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface UserLoginService {
    /*根据账号查找*/
    User selectUserByAccount(String account);

    List<User> selectUserAll();

    int updateUser(User user);

    int insertUser(User user);
}
