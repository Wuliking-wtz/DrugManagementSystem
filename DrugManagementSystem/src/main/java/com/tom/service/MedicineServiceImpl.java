package com.tom.service;

import com.tom.dao.ExcelUtil;
import com.tom.dao.MedicineDao;
import com.tom.pojo.Agency;
import com.tom.pojo.Medicine;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.List;

public class MedicineServiceImpl implements MedicineService {

    @Autowired
    @Qualifier("medicineDao")
    MedicineDao medicineDao;

    public void setMedicineDao(MedicineDao medicineDao) {
        this.medicineDao = medicineDao;
    }

    @Override
    public Medicine selectByMno(Integer mno) {
        return medicineDao.selectByMno(mno);
    }

    @Override
    public List<Medicine> selectAll() {
        return medicineDao.selectAll();
    }

    @Override
    public List<Medicine> selectByQuery(Integer mno, String mname, String mmode, String mefficacy) {
        return medicineDao.selectByQuery(mno, mname, mmode, mefficacy);
    }

    @Override
    public int insertMedicine(Medicine medicine) {
        return medicineDao.insertMedicine(medicine);
    }

    @Override
    public int updateMedicineByMno(Medicine medicine) {
        return medicineDao.updateMedicineByMno(medicine);
    }

    @Override
    public int deleteMedicineByMno(int mno) {
        return medicineDao.deleteMedicineByMno(mno);
    }

    public void export(HttpServletRequest request, HttpServletResponse response) {
        //获取数据
        List<Medicine> list = medicineDao.selectAll();

        //excel标题
        String[] title = {"编号", "名字", "服用方法", "功效"};

        //excel文件名
        String fileName = "药品信息报表.xls";


        //sheet名
        String sheetName = "表1";

        String[][] content = new String[list.size()][title.length];
        for (int i = 0; i < list.size(); i++) {
            content[i][0] = String.valueOf(list.get(i).getMno());
            content[i][1] = list.get(i).getMname();
            content[i][2] = list.get(i).getMmode();
            content[i][3] = list.get(i).getMefficacy();
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
