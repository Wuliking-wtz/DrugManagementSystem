package com.tom.controller;

import com.github.pagehelper.PageHelper;
import com.tom.pojo.Medicine;
import com.tom.pojo.Page;
import com.tom.service.MedicineService;
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
@RequestMapping("/medicine")
public class MedicineController {
    @Autowired
    @Qualifier("medicineServiceImpl")
    MedicineService medicineService;

    @Autowired
    @Qualifier("soldServiceImpl")
    SoldService soldService;


    @RequestMapping("/toSelectMedicine")
    public String toSelectMedicine(HttpServletRequest req, int page) {
        com.github.pagehelper.Page<Object> objects = PageHelper.startPage(page, 20);
        String mno = req.getParameter("mno");
        req.getSession().setAttribute("mno", mno);
        String mname = req.getParameter("mname");
        req.getSession().setAttribute("mname", mname);
        String mmode = req.getParameter("mmode");
        req.getSession().setAttribute("mmode", mmode);
        String mefficacy = req.getParameter("mefficacy");
        req.getSession().setAttribute("mefficacy", mefficacy);
        List<Medicine> medicine;
        if (mno == "")
            mno = null;
        if (mname == "")
            mname = null;
        if (mmode == "")
            mmode = null;
        if (mefficacy == "")
            mefficacy = null;
        medicine = medicineService.selectByQuery(mno != null ? Integer.parseInt(mno) : null,
                mname, mmode, mefficacy);
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
        List<Page> medicine_pages = new ArrayList<>();
        for (int i = temp; i <= Math.min(count, temp + 4); i++) {
            Page page1;
            if (i == page) {
                page1 = new Page(i, 1);
            } else {
                page1 = new Page(i, 0);
            }
            medicine_pages.add(page1);
        }
        req.getSession().setAttribute("medicine_pages", medicine_pages);
        req.getSession().setAttribute("medicine_count", count);
        req.getSession().setAttribute("medicines", medicine);
        return "showMedicine";
    }

    @RequestMapping("/toAddMedicine")
    public String toAddMedicine() {
        return "addMedicine";
    }

    @ResponseBody
    @RequestMapping("/addMedicine")
    public String addClient(Medicine medicine) {
        int sum = medicineService.insertMedicine(medicine);
        return String.valueOf(sum);
    }

    @RequestMapping("/toUpdateMedicine")
    public String toUpdateMedicine(HttpServletRequest req, int mno) {
        Medicine medicine = medicineService.selectByMno(mno);
        req.getSession().setAttribute("updateMedicineMessage", medicine);
        return "updateMedicine";
    }

    @ResponseBody
    @RequestMapping("/updateMedicine")
    public String updateMedicine(Medicine medicine) {
        int sum = medicineService.updateMedicineByMno(medicine);
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
            int sum = medicineService.deleteMedicineByMno(Integer.parseInt(deleteList[i]));
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
        medicineService.export(request, response);
    }
}
