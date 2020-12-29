package com.tom.controller;

import com.github.pagehelper.PageHelper;
import com.tom.pojo.Page;
import com.tom.pojo.User;
import com.tom.service.UserLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    @Qualifier("userLoginServiceImpl")
    UserLoginService userLoginService;

    @ResponseBody
    @RequestMapping("/login")
    public String login(HttpServletRequest req, String account, String password) {
        System.out.println(account);
        System.out.println(password);
        User user = userLoginService.selectUserByAccount(account);
        if (user != null) {
            if (user.getPassword().equals(password)) {
                req.getSession().setAttribute("user", user);
                return "true";
            }
        }
        return "false";
    }

    @ResponseBody
    @RequestMapping("/toSignUp")
    public String toSignUp(HttpServletRequest req, String account, String password) {

        User user = userLoginService.selectUserByAccount(account);
        if (user != null) {
            return "false";
        } else {
            User user1 = new User(account, password);
            int i = userLoginService.insertUser(user1);
            req.getSession().setAttribute("user", user1);
            if (i != 0) {
                return "true";
            } else {
                return "false";
            }
        }
    }

    /*登录成功后跳转到主页面*/
    @RequestMapping("/toWelcomePage")
    public String toWelcomePage(HttpServletRequest req) {
        return "welcomePage";
    }


    @RequestMapping("/toSelectUser")
    public String toSelectUser(HttpServletRequest req, int page) {
        com.github.pagehelper.Page<Object> objects = PageHelper.startPage(page, 20);
        List<User> users;
        users = userLoginService.selectUserAll();
        int count = objects.getPages();
        int temp;
        if (page - 2 >= 1) {
            temp = page - 2;
        } else if (page - 2 < 1) {
            temp = 1;
        } else if (page + 2 <= count) {
            temp = Math.max(page - 2, 1);
        } else {
            temp = count - 4;
        }
        List<Page> user_pages = new ArrayList<>();
        for (int i = temp; i <= Math.min(count, temp + 4); i++) {
            Page page1;
            if (i == page) {
                page1 = new Page(i, 1);
            } else {
                page1 = new Page(i, 0);
            }
            user_pages.add(page1);
        }
        req.getSession().setAttribute("user_pages", user_pages);
        req.getSession().setAttribute("user_count", count);
        req.getSession().setAttribute("users", users);
        return "showUser";
    }

    @ResponseBody
    @RequestMapping("/updateUser")
    public String updateMedicine(HttpServletRequest req, User user) {
        String oldpassword = req.getParameter("oldpassword");
        if (oldpassword == null) {
            return String.valueOf(userLoginService.updateUser(user));
        } else {
            User user1 = userLoginService.selectUserByAccount(user.getAccount());
            if (user1 == null || !user1.getPassword().equals(oldpassword)) {
                return "-1";
            } else {
                return String.valueOf(userLoginService.updateUser(user));
            }
        }
    }
    @RequestMapping("/showBackground")
    public String showBackground(){
        return "/bg";
    }

}
