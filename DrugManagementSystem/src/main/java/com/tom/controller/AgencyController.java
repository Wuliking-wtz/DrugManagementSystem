package com.tom.controller;

import com.github.pagehelper.PageHelper;
import com.tom.pojo.Agency;
import com.tom.pojo.Page;
import com.tom.service.AgencyService;
import com.tom.service.SoldService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/agency")
public class AgencyController {
    @Autowired
    @Qualifier("agencyServiceImpl")
    AgencyService agencyService;

    @Autowired
    @Qualifier("soldServiceImpl")
    SoldService soldService;

    @RequestMapping("/toSelectAgency")
    public String toSelectAgency(HttpServletRequest req, int page) {
        com.github.pagehelper.Page<Object> objects = PageHelper.startPage(page, 20);
        String ano = req.getParameter("ano");
        req.getSession().setAttribute("ano", ano);
        String aname = req.getParameter("aname");
        req.getSession().setAttribute("aname", aname);
        List<Agency> agency;
        if (ano == "")
            ano = null;
        if (aname == "")
            aname = null;
        agency = agencyService.selectByQuery(ano != null ? Integer.parseInt(ano) : null, aname);
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
        List<Page> agency_pages = new ArrayList<>();
        for (int i = temp; i <= Math.min(count, temp + 4); i++) {
            Page page1;
            if (i == page) {
                page1 = new Page(i, 1);
            } else {
                page1 = new Page(i, 0);
            }
            agency_pages.add(page1);
        }
        req.getSession().setAttribute("agency_pages", agency_pages);
        req.getSession().setAttribute("agency_count", count);
        req.getSession().setAttribute("agencys", agency);
        return "showAgency";
    }

    @RequestMapping("/toAddAgency")
    public String toAddAgency() {
        return "addAgency";
    }

    @ResponseBody
    @RequestMapping("/addAgency")
    public String addClient(Agency agency) {
        int sum = agencyService.insertAgency(agency);
        return String.valueOf(sum);
    }

    @RequestMapping("/toUpdateAgency")
    public String toUpdateAgency(HttpServletRequest req, int ano) {
        Agency agency = agencyService.selectByAno(ano);
        req.getSession().setAttribute("updateAgencyMessage", agency);
        return "updateAgency";
    }

    @ResponseBody
    @RequestMapping("/updateAgency")
    public String updateAgency(Agency agency) {
        int sum = agencyService.updateAgencyByAno(agency);
        return String.valueOf(sum);
    }

    @ResponseBody
    @RequestMapping("/batchDelete")
    public String batchDelete(HttpServletRequest req, String[] deleteList) {
        List<String> list = new ArrayList<>();
        String flag = "0";
        for (int i = 0; i < deleteList.length; i++) {
            if (soldService.selectByCno(Integer.parseInt(deleteList[i])) > 0) {
                if (flag == "0")
                    flag = deleteList[i];
                else {
                    flag += "," + deleteList[i];
                }
                continue;
            }
            int sum = agencyService.deleteAgencyByAno(Integer.parseInt(deleteList[i]));
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
        agencyService.export(request, response);
    }
}
