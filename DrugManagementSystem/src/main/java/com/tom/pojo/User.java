package com.tom.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String account;
    private String password;
    private String type;

    public User(String account, String password) {
        this.account = account;
        this.password = password;
        this.type = "general";
    }
}
