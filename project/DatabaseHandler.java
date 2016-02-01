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
import javax.swing.table.DefaultTableModel;
import java.util.*;
public class DatabaseHandler extends Database {

    public DatabaseHandler(String dbName){
	super(dbName);
    }
    
    public String[] getTableNames(){
	int count = 0; int n=0;
	String[] tables;
	try{
            DatabaseMetaData dbmd = con.getMetaData();
            ResultSet rs = dbmd.getTables(null, null, "%", null);
            while (rs.next()){
		count++;
            }
            System.out.println("number of count =" + count);
            tables = new String[count];
            rs = dbmd.getTables(null, null, "%", null);
            while (rs.next()) {
	  	tables[n] = rs.getString(3);
	  	System.out.println(tables[n]);
	  	n++;
            }
	}catch (SQLException ex) {
	    // handle any errors
	    System.out.println("SQLException: " + ex.getMessage());
	    System.out.println("SQLState: " + ex.getSQLState());
	    System.out.println("VendorError: " + ex.getErrorCode());
	    tables = new String[count];
	}catch (Exception e){
		System.out.println("Get Fields error:"+e);
		e.printStackTrace();
		tables = new String[count];
	}
	return tables;
    }

    public DefaultTableModel getTable(String s){ 
	ResultSet rs = null;
	Vector<String> columnNames = new Vector<String>();
	Vector<Vector<Object>> data = new Vector<Vector<Object>>();
	try{
            Statement stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT * FROM "+s);
	}catch(Exception e){
            System.out.println("GetTable error:"+e);
	}
	try{
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
	    for (int column = 1; column <= columnCount; column++) {
	    	System.out.println(metaData.getColumnName(column));
	        columnNames.add(metaData.getColumnName(column));
	    }
	    // data of the table
	    while (rs.next()) {
	        Vector<Object> vector = new Vector<Object>();
	        for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
	            vector.add(rs.getObject(columnIndex));
	        }
	        data.add(vector);
	    }
	    }catch(Exception e){
	    	System.out.println("Error making table -" +e);
	    }
    return new DefaultTableModel(data, columnNames);
}
    public int noOfTables(){
        int count = 0;
        System.out.println("getting number");
        try{
            DatabaseMetaData md = con.getMetaData();
            ResultSet rs = md.getTables(null, null, "%", null);
            while (rs.next()) {
              count++;
            }
        }catch(Exception e){
            System.out.println("error in noOfTables "+e);
        }
        System.out.println("returning "+count);
        return count;
    }

public Connection getConnection(){
    return con;
}
}
