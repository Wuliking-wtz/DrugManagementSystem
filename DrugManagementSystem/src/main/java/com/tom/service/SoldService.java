package com.tom.service;

import com.tom.pojo.Sold;
import org.apache.ibatis.annotations.Param;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface SoldService {
    Sold selectById(Integer id);

    List<Sold> selectAll();

    int selectByCno(Integer cno);

    int selectByMno(Integer mno);

    int selectByAno(Integer ano);

    List<Sold> selectByQuery(Integer id, Integer cno, Integer ano);

    int insertSold(Sold sold);

    int updateSoldById(Sold sold);

    int deleteSoldById(int id);

    void export(HttpServletRequest request, HttpServletResponse response);
}
