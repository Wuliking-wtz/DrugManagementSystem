package com.tom.dao;

import com.tom.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserLoginDao {

    /*根据账号查找*/
    User selectUserByAccount(@Param("account") String account);

    List<User> selectUserAll();

    int updateUser(User user);

    int insertUser(User user);
}
