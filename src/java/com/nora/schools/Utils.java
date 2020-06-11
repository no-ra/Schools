/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nora.schools;

import java.sql.*;
/**
 *
 * @author Nora
 */
public class Utils {
    public static boolean isNullOrEmpty(String str){
        return str == null || str.equals("");
    }
    
    public static int parseInt(String value){
        try{
            return Integer.parseInt(value);
        } catch (NumberFormatException ex) {
            return 0;
        }
    }
    
    public static Date stringToSqlDate(String input){
        String[] parts = input.split("-");
        String date = parts[2] + "-" + parts[1] + "-" + parts[0];
        int day = Integer.parseInt(parts[0]);
        int month = Integer.parseInt(parts[1]);
        int year = Integer.parseInt(parts[2]);
        return Date.valueOf(date);
    }
}
