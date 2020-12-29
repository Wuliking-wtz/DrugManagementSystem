package com.tom.service;

import com.tom.pojo.Medicine;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface MedicineService {
    Medicine selectByMno(Integer mno);

    List<Medicine> selectAll();

    List<Medicine> selectByQuery(Integer mno, String mname,String mmode,String mefficacy);

    int insertMedicine(Medicine medicine);

    int updateMedicineByMno(Medicine medicine);

    int deleteMedicineByMno(int mno);

    void export(HttpServletRequest request, HttpServletResponse response);
}
