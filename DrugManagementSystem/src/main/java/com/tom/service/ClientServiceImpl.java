package com.tom.service;

import com.tom.dao.ClientDao;
import com.tom.dao.ExcelUtil;
import com.tom.pojo.Agency;
import com.tom.pojo.Client;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.List;

public class ClientServiceImpl implements ClientService {
    ClientDao clientDao;

    public void setClientDao(ClientDao clientDao) {
        this.clientDao = clientDao;
    }

    @Override
    public Client selectByCno(Integer cno) {
        return clientDao.selectByCno(cno);
    }

    @Override
    public List<Client> selectAll() {
        return clientDao.selectAll();
    }

    @Override
    public List<Client> selectByQuery(Integer cno, String cname, String caddress) {
        return clientDao.selectByQuery(cno, cname, caddress);
    }

    @Override
    public int insertClient(Client client) {
        return clientDao.insertClient(client);
    }

    @Override
    public int updateClientByCno(Client client) {
        return clientDao.updateClientByCno(client);
    }

    @Override
    public int deleteClientByCno(int cno) {
        return clientDao.deleteClientByCno(cno);
    }

    public void export(HttpServletRequest request, HttpServletResponse response) {
        //获取数据
        List<Client> list = clientDao.selectAll();

        //excel标题
        String[] title = {"编号", "姓名", "性别", "地址", "电话", "备注"};

        //excel文件名
        String fileName = "顾客信息报表.xls";


        //sheet名
        String sheetName = "表1";

        String[][] content = new String[list.size()][title.length];
        for (int i = 0; i < list.size(); i++) {
            content[i][0] = String.valueOf(list.get(i).getCno());
            content[i][1] = list.get(i).getCname();
            content[i][2] = list.get(i).getCsex();
            content[i][3] = list.get(i).getCaddress();
            content[i][4] = list.get(i).getCphone();
            content[i][5] = list.get(i).getCremark();
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
