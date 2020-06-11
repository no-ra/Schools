/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nora.schools;

import java.sql.SQLException;

/**
 *
 * @author Nora
 */
public class User {
    private String username;
    private int id;
    private String firstname;
    private String lastname;
    private int usertype;
    
    public User(int id, String username, String firstname, String lastname, int usertype){
        this.id = id;
        this.username = username;
        this.firstname = firstname;
        this.lastname = lastname;
        this.usertype = usertype;
    }
    
    
    public void save() throws ClassNotFoundException, SQLException {
    }
        
    public String getUsername(){
        return this.username;
    }
    
    public String getFirstName(){
        return this.firstname;
    }
    
    public int getUserId(){
        return this.id;
    }
    
    public boolean isTeacher(){
        return this.usertype == 1;
    }
    
    public String getFullName(){
        return firstname + " " + lastname;
    }
}
