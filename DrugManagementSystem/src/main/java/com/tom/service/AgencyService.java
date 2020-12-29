package com.tom.service;

import com.tom.pojo.Agency;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface AgencyService {
    Agency selectByAno(Integer ano);

    List<Agency> selectAll();

    List<Agency> selectByQuery(Integer ano,String aname);

    int insertAgency(Agency agency);

    int updateAgencyByAno(Agency agency);

    int deleteAgencyByAno(int ano);

    void export(HttpServletRequest request, HttpServletResponse response);
}
