package com.tom.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Sold {
    private int id;
    private String csymptom;
    private String cno;
    private String mno;
    private String ano;

    private Date cdate;
}
