package com.tom.service;

import com.tom.pojo.Client;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface ClientService {

    Client selectByCno(Integer cno);

    List<Client> selectAll();

    List<Client> selectByQuery(Integer cno,String cname,String caddress);

    int insertClient(Client client);

    int updateClientByCno(Client client);

    int deleteClientByCno(int cno);

    void export(HttpServletRequest request, HttpServletResponse response);
}
