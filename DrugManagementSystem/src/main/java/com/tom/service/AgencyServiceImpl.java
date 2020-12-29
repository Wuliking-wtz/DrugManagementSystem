package com.tom.service;

import com.tom.dao.AgencyDao;
import com.tom.dao.ExcelUtil;
import com.tom.pojo.Agency;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.List;

public class AgencyServiceImpl implements AgencyService {
    @Autowired
    @Qualifier("agencyDao")
    AgencyDao agencyDao;

    public void setAgencyDao(AgencyDao agencyDao) {
        this.agencyDao = agencyDao;
    }

    @Override
    public Agency selectByAno(Integer ano) {
        return agencyDao.selectByAno(ano);
    }

    @Override
    public List<Agency> selectAll() {
        return agencyDao.selectAll();
    }

    @Override
    public List<Agency> selectByQuery(Integer ano, String aname) {
        return agencyDao.selectByQuery(ano, aname);
    }

    @Override
    public int insertAgency(Agency agency) {
        return agencyDao.insertAgency(agency);
    }

    @Override
    public int updateAgencyByAno(Agency agency) {
        return agencyDao.updateAgencyByAno(agency);
    }

    @Override
    public int deleteAgencyByAno(int ano) {
        return agencyDao.deleteAgencyByAno(ano);
    }

    public void export(HttpServletRequest request, HttpServletResponse response) {
        //获取数据
        List<Agency> list = agencyDao.selectAll();

        //excel标题
        String[] title = {"编号", "姓名", "性别", "电话", "备注"};

        //excel文件名
        String fileName = "经办人信息报表.xls";


        //sheet名
        String sheetName = "表1";

        String[][] content = new String[list.size()][title.length];
        for (int i = 0; i < list.size(); i++) {
            content[i][0] = String.valueOf(list.get(i).getAno());
            content[i][1] = list.get(i).getAname();
            content[i][2] = list.get(i).getAsex();
            content[i][3] = list.get(i).getAphone();
            content[i][4] = list.get(i).getAremark();
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
