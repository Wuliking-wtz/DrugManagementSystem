package com.tom.dao;

import com.tom.pojo.Agency;
import com.tom.pojo.Medicine;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MedicineDao {
    Medicine selectByMno(@Param("mno") Integer mno);

    List<Medicine> selectAll();

    List<Medicine> selectByQuery(@Param("mno") Integer mno,
                                 @Param("mname") String mname,
                                 @Param("mmode") String mmode,
                                 @Param("mefficacy")String mefficacy);

    int insertMedicine(Medicine medicine);

    int updateMedicineByMno(Medicine medicine);

    int deleteMedicineByMno(int mno);
}
