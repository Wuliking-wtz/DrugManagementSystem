package com.tom.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Medicine {
    private int mno;
    private String mname;
    private String mmode;
    private String mefficacy;

}
