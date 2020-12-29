package com.tom.service;

import com.tom.dao.UserLoginDao;
import com.tom.pojo.User;

import java.util.List;

public class UserLoginServiceImpl implements UserLoginService {
    private UserLoginDao userLoginDao;

    public void setUserLoginDao(UserLoginDao userLoginDao) {
        this.userLoginDao = userLoginDao;
    }

    /*根据账号查找*/
    public User selectUserByAccount(String account) {
        return userLoginDao.selectUserByAccount(account);
    }

    public List<User> selectUserAll() {
        return userLoginDao.selectUserAll();
    }

    @Override
    public int updateUser(User user) {
        return userLoginDao.updateUser(user);
    }

    @Override
    public int insertUser(User user) {
        return userLoginDao.insertUser(user);
    }
}
