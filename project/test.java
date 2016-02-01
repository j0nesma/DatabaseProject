/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Matt
 */
public class test {
    private static Refactor r = new Refactor();
    private static DatabaseHandler d = new DatabaseHandler("imdb");
    
    public static void main(String[] args){
        System.out.println("running");
        System.out.println("Test = "+test);
    }
}
