package com.tom.dao;

import com.tom.pojo.Agency;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AgencyDao {
    Agency selectByAno(@Param("ano") Integer ano);

    List<Agency> selectAll();

    List<Agency> selectByQuery(@Param("ano")Integer ano,
                               @Param("aname")String aname);

    int insertAgency(Agency agency);

    int updateAgencyByAno(Agency agency);

    int deleteAgencyByAno(int ano);
}
