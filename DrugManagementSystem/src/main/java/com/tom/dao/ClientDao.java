package com.tom.dao;

import com.sun.org.glassfish.gmbal.ParameterNames;
import com.tom.pojo.Client;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ClientDao {

    Client selectByCno(@Param("cno") Integer cno);

    List<Client> selectAll();

    List<Client> selectByQuery(@Param("cno")Integer cno,
                               @Param("cname")String name,
                               @Param("caddress")String caddress);

    int insertClient(Client client);

    int updateClientByCno(Client client);

    int deleteClientByCno(int cno);
}
