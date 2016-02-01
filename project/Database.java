/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project;

/**
 *
 * @author Matt
 */
import java.sql.*;
import java.io.*;
public class Database{

	protected Connection con;
	protected Statement stmt = null;
	private static final String MYSQL_DATABASE_LOCATION = "jdbc:mysql://localhost:3306/";
	private static final String MYSQL_DRIVER = "com.mysql.jdbc.Driver";
	public String dbName = null;
	private final String user = "root";
	private final String password = "root";

	private Connection getConnection(){
            try {
		con = DriverManager.getConnection(MYSQL_DATABASE_LOCATION+dbName, user, password);
		con.setAutoCommit(false);
	    }catch (Exception e) {
		    // handle any errors
		    System.out.println("ERROR IN GETTING CONNECTION : "+ e);
		}
	    return con;
	}

	private void open(){
// "open" the database : actually really setting up the connection and obtaining the metadata about the server
// makes sure that database file is present before trying to establish connection
// otherwise SQLite will create a new, empty database with the name provided
		String file = ("C://Users//Matt//Documents//FYP//Programing//create_and_load.sql");
// creates schema Database with table - schemainfo
		try {
			Class.forName(MYSQL_DRIVER);
			con  = getConnection();
    	} catch ( Exception e) {
      		notify("Db.Open",e);
    	};

    	try{
    	System.out.println("Db_open");
    	ScriptRunner runner = new ScriptRunner(con,false,false);
		runner.runScript(new BufferedReader(new FileReader(file)));
		}catch(Exception e){
			System.out.println("reading in error"+e);
		}
		int count = 0;
		System.out.println("exiting.....");
	}

	private void close(){
		try{
			con.commit();
			con.close();
		}catch (Exception e){
        	notify("Db.close",e);
    	}
	}

	public void notify(String message, Exception e)
	  {
	    System.out.println(message+" : "+e);
	    e.printStackTrace();
	    System.exit(0); // ZERO tolelrance!!
	}

	 public Database(String _dbName){
		dbName = _dbName; // pick up the name of the database to be used
		System.out.println("Db.constructor ["+dbName+"]");
		open();
    }



}