package com.tom.controller;

import com.github.pagehelper.PageHelper;
import com.tom.pojo.Client;
import com.tom.pojo.Page;
import com.tom.service.ClientService;
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
@RequestMapping("/client")
public class ClientController {
    @Autowired
    @Qualifier("clientServiceImpl")
    ClientService clientService;

    @Autowired
    @Qualifier("soldServiceImpl")
    SoldService soldService;

    @RequestMapping("/toSelectClient")
    public String toSelectClient(HttpServletRequest req, int page) {
        com.github.pagehelper.Page<Object> objects = PageHelper.startPage(page, 20);
        String cno = req.getParameter("cno");
        req.getSession().setAttribute("cno", cno);
        String cname = req.getParameter("cname");
        req.getSession().setAttribute("cname", cname);
        String caddress = req.getParameter("caddress");
        req.getSession().setAttribute("caddress", caddress);
        List<Client> clients;
        if (cno == "")
            cno = null;
        if (cname == "")
            cname = null;
        if (caddress == "")
            caddress = null;
        clients = clientService.selectByQuery(cno != null ? Integer.parseInt(cno) : null,
                cname, caddress);
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
        List<Page> client_pages = new ArrayList<>();
        for (int i = temp; i <= Math.min(count, temp + 4); i++) {
            Page page1;
            if (i == page) {
                page1 = new Page(i, 1);
            } else {
                page1 = new Page(i, 0);
            }
            client_pages.add(page1);
        }
        req.getSession().setAttribute("client_pages", client_pages);
        req.getSession().setAttribute("client_count", count);
        req.getSession().setAttribute("clients", clients);
        return "showClient";
    }

    @RequestMapping("/toAddClient")
    public String toAddClient() {
        return "addClient";
    }

    @ResponseBody
    @RequestMapping("/addClient")
    public String addClient(Client client) {
        int sum = clientService.insertClient(client);
        return String.valueOf(sum);
    }

    @RequestMapping("/toUpdateClient")
    public String toUpdateClient(HttpServletRequest req, int cno) {
        Client client = clientService.selectByCno(cno);
        req.getSession().setAttribute("updateClientMessage", client);
        return "updateClient";
    }

    @ResponseBody
    @RequestMapping("/updateClient")
    public String updateClient(Client client) {
        int sum = clientService.updateClientByCno(client);
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
            int sum = clientService.deleteClientByCno(Integer.parseInt(deleteList[i]));
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
        clientService.export(request, response);
    }
}
