package com.tom.controller;

import com.github.pagehelper.PageHelper;
import com.tom.pojo.Sold;
import com.tom.pojo.Page;
import com.tom.service.SoldService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/sold")
public class SoldController {
    @Autowired
    @Qualifier("soldServiceImpl")
    SoldService soldService;

    public void setSoldService(SoldService soldService) {
        this.soldService = soldService;
    }

    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        CustomDateEditor editor = new CustomDateEditor(df, true);//true表示允许为空，false反之
        binder.registerCustomEditor(Date.class, editor);
    }

    @RequestMapping("/toSelectSold")
    public String toSelectSold(HttpServletRequest req, int page) {
        com.github.pagehelper.Page<Object> objects = PageHelper.startPage(page, 20);
        String id = req.getParameter("id");
        req.getSession().setAttribute("id", id);
        String cno = req.getParameter("cno");
        req.getSession().setAttribute("cno", cno);
        String ano = req.getParameter("ano");
        req.getSession().setAttribute("ano", ano);
        List<Sold> sold;
        if (id == "")
            id = null;
        if (cno == "")
            cno = null;
        if (ano == "")
            ano = null;
        sold = soldService.selectByQuery(id != null ? Integer.parseInt(id) : null,
                cno != null ? Integer.parseInt(cno) : null,
                ano != null ? Integer.parseInt(ano) : null);
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
        List<Page> sold_pages = new ArrayList<>();
        for (int i = temp; i <= Math.min(count, temp + 4); i++) {
            Page page1;
            if (i == page) {
                page1 = new Page(i, 1);
            } else {
                page1 = new Page(i, 0);
            }
            sold_pages.add(page1);
        }
        req.getSession().setAttribute("sold_pages", sold_pages);
        req.getSession().setAttribute("sold_count", count);
        req.getSession().setAttribute("solds", sold);
        return "showSold";
    }

    @RequestMapping("/toAddSold")
    public String toAddSold() {
        return "addSold";
    }

    @ResponseBody
    @RequestMapping("/addSold")
    public String addClient(Sold sold) {
        int sum = soldService.insertSold(sold);
        return String.valueOf(sum);
    }

    @RequestMapping("/toUpdateSold")
    public String toUpdateSold(HttpServletRequest req, int id) {
        Sold sold = soldService.selectById(id);
        req.getSession().setAttribute("updateSoldMessage", sold);
        return "updateSold";
    }

    @ResponseBody
    @RequestMapping("/updateSold")
    public String updateSold(Sold sold) {
        int sum = soldService.updateSoldById(sold);
        return String.valueOf(sum);
    }

    @ResponseBody
    @RequestMapping("/batchDelete")
    public String batchDelete(HttpServletRequest req, String[] deleteList) {
        List<String> list = new ArrayList<>();
        String flag = "0";
        for (int i = 0; i < deleteList.length; i++) {
            int sum = soldService.deleteSoldById(Integer.parseInt(deleteList[i]));
            if (sum == 0) {
                if (flag == "0")
                    flag = deleteList[i];
                else {
                    flag += "," + deleteList[i];
                }
            }
            list.add(deleteList[i]);
        }
        req.getSession().setAttribute("unSuccessList", list);
        return flag;
    }
    /**
     * 导出报表
     * @return
     */
    @RequestMapping("/export")
    @ResponseBody
    public void export(HttpServletRequest request, HttpServletResponse response) throws Exception {
        soldService.export(request, response);
    }
}
