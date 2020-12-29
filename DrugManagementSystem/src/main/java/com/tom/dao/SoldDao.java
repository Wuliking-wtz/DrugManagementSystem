package com.tom.dao;

import com.tom.pojo.Sold;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SoldDao {
    Sold selectById(@Param("id") Integer id);

    List<Sold> selectAll();

    List<Sold> selectByQuery(@Param("id") Integer id,
                             @Param("cno") Integer cno,
                             @Param("ano") Integer ano);

    int selectByCno(@Param("cno") Integer cno);

    int selectByMno(@Param("mno") Integer mno);

    int selectByAno(@Param("ano") Integer ano);

    int insertSold(Sold sold);

    int updateSoldById(Sold sold);

    int deleteSoldById(int id);
}
