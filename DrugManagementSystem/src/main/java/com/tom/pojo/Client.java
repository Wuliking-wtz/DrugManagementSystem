package com.tom.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Client {
    private int cno;
    private String cname;
    private int cage;
    private String csex;
    private String caddress;
    private String cphone;
    private String cremark;

}
