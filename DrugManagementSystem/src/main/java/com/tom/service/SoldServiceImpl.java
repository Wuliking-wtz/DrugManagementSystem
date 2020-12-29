package com.tom.service;

import com.tom.dao.ExcelUtil;
import com.tom.dao.SoldDao;
import com.tom.pojo.Medicine;
import com.tom.pojo.Sold;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.List;

public class SoldServiceImpl implements SoldService {
    @Autowired
    @Qualifier("soldDao")
    SoldDao soldDao;

    public void setSoldDao(SoldDao soldDao) {
        this.soldDao = soldDao;
    }

    @Override
    public Sold selectById(Integer id) {
        return soldDao.selectById(id);
    }

    @Override
    public List<Sold> selectAll() {
        return soldDao.selectAll();
    }

    @Override
    public int selectByCno(Integer cno) {
        return soldDao.selectByCno(cno);
    }

    @Override
    public int selectByMno(Integer mno) {
        return soldDao.selectByMno(mno);
    }

    @Override
    public int selectByAno(Integer ano) {
        return soldDao.selectByAno(ano);
    }

    @Override
    public List<Sold> selectByQuery(Integer id, Integer cno, Integer ano) {
        return soldDao.selectByQuery(id, cno, ano);
    }

    @Override
    public int insertSold(Sold sold) {
        return soldDao.insertSold(sold);
    }

    @Override
    public int updateSoldById(Sold sold) {
        return soldDao.updateSoldById(sold);
    }

    @Override
    public int deleteSoldById(int id) {

        return soldDao.deleteSoldById(id);
    }

    public void export(HttpServletRequest request, HttpServletResponse response) {
        //获取数据
        List<Sold> list = soldDao.selectAll();

        //excel标题
        String[] title = {"订单编号", "顾客症状", "顾客编号", "药品编号", "经办人编号"};

        //excel文件名
        String fileName = "订单信息报表.xls";


        //sheet名
        String sheetName = "表1";

        String[][] content = new String[list.size()][title.length];
        for (int i = 0; i < list.size(); i++) {
            content[i][0] = String.valueOf(list.get(i).getMno());
            content[i][1] = list.get(i).getCsymptom();
            content[i][2] = list.get(i).getCno();
            content[i][3] = list.get(i).getMno();
            content[i][4] = list.get(i).getAno();
        }

        //创建HSSFWorkbook
        HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

        //响应到客户端
        try {
            ExcelUtil.setResponseHeader(response, fileName);
            OutputStream os = response.getOutputStream();
            wb.write(os);
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
