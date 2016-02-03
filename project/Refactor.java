/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project;

import java.sql.*;

/**
 * @author Matt
 */
public class Refactor {
    
    public static void DeleteTable(String tableName, Connection con){
        System.out.println("Dropping table "+ tableName);
        ResultSet rs;
        try{
            DatabaseMetaData meta = con.getMetaData();
            rs = meta.getImportedKeys(null, null, tableName);
            while(rs.next()){
                String fkTable = rs.getString("FKTABLE_NAME");
                String fkColumn = rs.getString("FKCOLUMN_NAME");
                DeleteColumn(fkTable, fkColumn, con);
            }
        }catch(Exception e){
            System.out.println("Error in DropTable getting imported keys - "+ e);
        }
        String sql = "DROP TABLE "+tableName;
        try{    
            Statement stmt = con.createStatement();
            stmt.executeUpdate(sql);
        }catch(Exception e){
            System.out.println("Error in DropTable Dropping table "+ e);
        }
        
    }
    
    public static void DeleteColumn(String tableName, String columnName, Connection con){
        System.out.println("Deleting Column " +columnName+ " from " +tableName);
// create temp table
        try{
            Statement stmt = con.createStatement();
            stmt.executeUpdate("DROP TABLE IF EXISTS temp");
            ResultSet res = stmt.executeQuery("SELECT * FROM "+ tableName);
            ResultSetMetaData rsmd = res.getMetaData();
            int columnsNumber = rsmd.getColumnCount();
            
            DatabaseMetaData meta = con.getMetaData();
            ResultSet columns = meta.getColumns(null, null, tableName, null);
            String[] columnNames = new String[columnsNumber-1];
            String[] full = new String[columnsNumber-1];
            int count =0;
            //gets the columns of the table
            while(columns.next()){
            String tempColName = columns.getString("COLUMN_NAME");
                if(tempColName.equals(columnName)){
                }else{
                    String type = columns.getString("TYPE_NAME");
                    String size = columns.getString("COLUMN_SIZE");
                    columnNames[count] = tempColName;
                    full[count]= tempColName +" "+type+"("+size+")";
                    System.out.println("Name = "+columnNames[count]);
                    //find out which one is the primary key
                    count++;
                }
                
            }
            //create a temp table
            String columnString = " ";
            String names = " ";
            for(int n=0; n<full.length-1;n++){
                columnString = columnString+full[n]+",";
                names = names+columnNames[n]+",";
            }
            names = names + columnNames[columnNames.length-1];
            columnString = columnString + full[full.length-1];
            String sql = "CREATE TABLE temp ("+columnString+");";
            System.out.println("Column String = "+columnString);
            System.out.println("sql = "+ sql);
            stmt.executeUpdate(sql);
            
            //import all the values into the table 
            sql = "INSERT INTO temp SELECT "+names+" FROM "+ tableName+";";
            stmt.executeUpdate(sql);
            //Drop the table
            sql = "DROP TABLE "+ tableName;
            stmt.executeUpdate(sql);
            //Rename the table
            sql = "RENAME TABLE temp TO "+ tableName;
            stmt.executeUpdate(sql);
            sql = "SELECT * FROM "+ tableName;
            ResultSet rs = stmt.executeQuery(sql);
            rsmd = rs.getMetaData();
            columnsNumber = rsmd.getColumnCount();
            System.out.println("PRINTING OUT VALUES");
            while(rs.next()){
                for (int i = 1; i <= columnsNumber; i++) {
                 if (i > 1) System.out.print(",  ");
                 String columnValue = rs.getString(i);
                 System.out.print(columnValue + " " + rsmd.getColumnName(i));
                }
                System.out.println();
            }
        }catch(Exception e){
            System.out.println("Error in DropColumn "+ e);
            e.printStackTrace();
        }  
    }

    public static void DeleteRow(String primaryKeyValue, String tableName, Connection con){
        //get the primary key
        ResultSet rs = null;
        String pk = null;
        try{
            Statement stmt = con.createStatement();
            DatabaseMetaData meta = con.getMetaData();
            rs = meta.getPrimaryKeys(null, null,tableName);
            while(rs.next()){
                System.out.println("Primary Key = "+ rs.getString("COLUMN_NAME"));
                pk = rs.getString("COLUMN_NAME");
            }
            String sql = "DELETE FROM "+ tableName + " WHERE "+pk +"="+primaryKeyValue+";";
            stmt.executeUpdate(sql);
            System.out.println(sql);
        }catch(Exception e){
            System.out.println("ERROR in DeleteRow - "+ e);
        }
        //get the table's structure
        //get the primary key
        //DELETE * FROM WHERE primaryKey == primaryKeyValue;
    }
      
    
    public static void AddTable(String tableName, String[] colName, String[]colType, Connection con){
        String sql = "CREATE TABLE "+tableName+"(";
        if(colName.length == colType.length){
            for(int x=0; x<colName.length; x++){sql+=" "+colName[x]+" "+colType[x]+",";}
            System.out.println(sql);
        } else {
            //ERRRRRRRRRRRRRRRROOOOOOOOOOOOOOOOOOOOOOOOOOOOOORRRRRR;
        }
        
        
    }
    
    public static void AddColumn(String tableName, String columnName, String columnType, Connection con){
        try{
            Statement stmt = con.createStatement();
            stmt.executeUpdate("ALTER TABLE "+tableName+"ADD"+columnName + " "+columnType);
        }catch(Exception e){
            
        }
    }
    
    public static void AddRow(String tableName,String[] columns ,String[][] rowInfo, Connection con){
        String sql ="INSERT INTO "+tableName+"(";
        for(int x=0; x<columns.length; x++){sql += columns[x]+", ";}
        sql+=") VALUES";
        for(int n=0; n<rowInfo.length;n++){
            sql += "(";
            for(int m=0; m<rowInfo[n].length;m++){
                if(m!=0){sql+=",";}
                sql+=rowInfo[n][m];
            }
            sql += ")";
        }
        try{
            Statement stmt = con.createStatement();
            stmt.executeUpdate(sql);
        }catch(Exception e){
            System.out.println("ERROR in addrow: "+e);
        }
    }
    
   
    public static void MergeTable(String tableName1, String tableName2, Connection con){
        //Joining tables which have a relation
        try{
            DatabaseMetaData meta = con.getMetaData();
            ResultSet rs = meta.getColumns(null, null, tableName2, null);
            int count=0;
            while(rs.next()){
                count++;
            }
            String[] columnNames = new String[count];
            String[] type = new String[count];
            rs = meta.getColumns(null, null, tableName2, null);
            count=0;
            while(rs.next()){
                columnNames[count] = rs.getString("COLUMN_NAME");
                type[count] = rs.getString("TYPE_NAME");
                count++;
            }
            for(int x=0; x<columnNames.length; x++){AddColumn(tableName1,columnNames[x],type[x],con);}
            //insert values in
            //delete other table
        }catch(Exception e){
            System.out.println("ERROR in MergeTable 1:"+e);
        }
    }
    
    public static void MergeTable(){
        
    }
    
    public static void MergeColumn(String tableName, String NewColumn,String col1, String col2, Connection con){
        String col1Type = getType(col1, tableName,con);
        String col2Type = getType(col2, tableName,con);
        String type = "VARCHAR";
        if(col1Type.equals(col2Type)){type = col1Type;}
        AddColumn(tableName, NewColumn,type, con);
        String sql = "SELECT "+col1+", "+col2+" FROM "+tableName;
        ResultSet rs = null;
        try{
            Statement stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            int count =0;
            while(rs.next()){ count++;}
            String[] concat = new String[count];
            count=0;
            while(rs.next()){
                 String col1value = rs.getString(col1);//THis may have to be changed for a switch case if they have int instead
                 String col2value = rs.getString(col2);
                 concat[count] = col1value+" "+col2value;
                 count++;
            }
            sql = "INSERT INTO "+tableName+"("+NewColumn+")VALUES";
            for(int x=0; x<concat.length; x++){sql+="("+concat[x]+")";}
            DeleteColumn(tableName,col1,con);
            DeleteColumn(tableName,col2,con);
        }catch(Exception e){
            System.out.println("ERROR MergeColum: "+e);
        }
    }
    
    
    public static void AddCalculatedColumn(){
        
    }
    
    public static void RenameTable(String originalTable, String newName, Connection con){
        String sql ="ALTER TABLE "+originalTable+" RENAME TO "+ newName;
        try{
            Statement stmt = con.createStatement();
            stmt.executeUpdate(sql);
        }catch(Exception e){
            System.out.println("ERROR IN RENAMETABLE: "+e);
        }
    }
    //NOT FINISHED
    public static void RenameColumn( String oldName, String newName, String tableName, Connection con){
        System.out.println("Renameing for " + tableName);
        System.out.println(oldName);
        try{
            Statement stmt = con.createStatement();
            ResultSet rs=null;
            ResultSet primary=null;
            
            //RECURSIVE CALL FOR ALL THE TIMES THE COLUMN IS CALLED ON OTHER TABLES.
            DatabaseMetaData meta = con.getMetaData();
            rs = meta.getExportedKeys(con.getCatalog(),null,tableName);
            primary = meta.getPrimaryKeys(con.getCatalog(), null, tableName);
            primary.next();
            String pk  = primary.getString("COLUMN_NAME");
            if(pk.equals(oldName)){
                while (rs.next()) {
                    String fkTableName = rs.getString("FKTABLE_NAME");
                    String fkColumnName = rs.getString("FKCOLUMN_NAME");
                    System.out.println("getExportedKeys(): fkTableName="+fkTableName);
                    System.out.println("getExportedKeys(): fkColumnName="+fkColumnName);                    
                    RenameColumn(fkColumnName, newName, fkTableName, con);
                }
            }
            // find out if value is a foriegn key
            ResultSet foreign =meta.getImportedKeys(con.getCatalog(), pk, tableName);
            while(foreign.next()){
                String fk = foreign.getString("FKCOLUMN_NAME");
                if(fk.equals(oldName)){
                    System.out.println("This is a foriegn key");
                    String tableRefer = foreign.getString("PKTABLE_NAME");
                    System.out.println(oldName+" References "+tableRefer);
                }
            }
            //if so make a boolean true so that the constraint can be added on to it.
            //get same datatype as oldName
            
            String sql = "SELECT * FROM "+tableName+";";
            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            ResultSetMetaData rsMetaData = rs.getMetaData();
            int numberOfColumns = rsMetaData.getColumnCount();
            System.out.println(numberOfColumns);
            String type = null;
            for(int i=1; i<numberOfColumns; i++){
                if(rsMetaData.getColumnName(i).equals(oldName)){
                    System.out.println("Match with "+ rsMetaData.getColumnName(i));
                    type = rsMetaData.getColumnTypeName(i)+"("+rsMetaData.getColumnDisplaySize(i)+")";
                }
            }

            if(!type.equals(null)){
                sql = "ALTER TABLE "+tableName+" ADD "+ newName +" "+type+";";
                stmt.executeUpdate(sql);
                sql = "UPDATE "+tableName+ " SET " + newName + "="+ oldName;
                System.out.println(sql);
                stmt.executeUpdate(sql);
                sql = "ALTER TABLE "+ tableName+ " DROP COLUMN "+ oldName;
                stmt.executeUpdate(sql);
            }
            sql = "SELECT * FROM "+tableName+";";
            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            rsMetaData = rs.getMetaData();
            numberOfColumns = rsMetaData.getColumnCount();
            System.out.println(numberOfColumns);
            type = null;
            for(int i=1; i<=numberOfColumns; i++){
                System.out.println(rsMetaData.getColumnName(i));
            }
        }catch(Exception e){
            System.out.println("ERROR IN RenameColumn - "+e);
            e.printStackTrace();
        }
    }
    
       
    public static void SplitTable(String newTableName, String[] columnToBeSplit, String OTable, Connection con){
        String[] type = new String[columnToBeSplit.length];
        // need to add primary key to new table.
        for(int x=0; x<type.length; x++){type[x]=getType(columnToBeSplit[x], OTable, con);}
        AddTable(newTableName,columnToBeSplit,type,con);
        String sql ="UPDATE "+newTableName+"SET ";
        for(int x=0; x<columnToBeSplit.length; x++){sql+=columnToBeSplit[x]+"="+columnToBeSplit[x]+"."+OTable;}
        System.out.println(sql);
        try{
            Statement stmt = con.createStatement();
            stmt.executeUpdate(sql);
        }catch(Exception e){
            System.out.println("ERROR in splitTable:"+e);
        }
        
        for(int x=0; x<columnToBeSplit.length; x++){DeleteColumn(OTable,columnToBeSplit[x],con);}
        
    }
    public static void moveColumn(String originalTable, String destinationTable, String colName, Connection con){
        String type = getType(colName, originalTable, con);
        AddColumn(destinationTable, colName, type,con);
        String sql  = "INSERT INTO "+ destinationTable + "("+colName+") SELECT "+colName+" FROM "+originalTable;
        try{
            Statement s = con.createStatement();
            s.executeUpdate(sql);
        } catch (Exception e){
            System.out.println("ERROR IN moveColumn: "+e);
        }
        DeleteColumn(originalTable, colName, con);
    }
    private static String getType(String colName, String tableName, Connection con){
        String type = null;
        ResultSet rs = null;
        try{
            DatabaseMetaData meta = con.getMetaData();
            rs=meta.getColumns(null, null,tableName, colName);
            while(rs.next()){
                type = rs.getString("TYPE_NAME");
                type += " ("+rs.getString("COLUMN_SIZE")+")";
                System.out.println("type = "+type);
            }
        }catch(Exception e){
            System.out.println("error "+e);
            e.printStackTrace();
        }
        return type;
    }
    
    //split by position
    public static void SplitColumn(String tableName,String columnName,String[] splitColumn, String splitByAscii, Connection con){
        //create the splitcolumns
        String type = getType(columnName,tableName,con);
        for(int x=0; x<splitColumn.length; x++){AddColumn(tableName,splitColumn[x],type,con);}
        String sql = "SELECT "+columnName+"FROM"+tableName;
        ResultSet rs = null;
        try{
            Statement stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            int count = 0;
            while (rs.next()) {
                count++;
            }
            String[][] values = new String[count][splitColumn.length]; 
            rs = stmt.executeQuery(sql);
            count = 0;
            while(rs.next()){
                String s = rs.getString(columnName);
                values[count]=s.split(splitByAscii);
                count++;
            }
            sql ="INSERT INTO "+tableName+"(";
            for(int x=0; x<splitColumn.length; x++){sql += splitColumn[x]+", ";}
            sql+=") VALUES";
            for(int n=0; n<values.length;n++){
                sql += "(";
                for(int m=0; m<values[n].length;m++){
                    if(m!=0){sql+=",";}
                    sql+=values[n][m];
                }
                sql += ")";
            }
            System.out.println(sql);
            stmt.executeUpdate(sql);
        }catch(Exception e){
            System.out.println("ERROR in SplitColumn(ASCII)"+e);
        }
        DeleteColumn(tableName,columnName,con);
        //loop through the values and split the values.
        
    }
    
    public static void SplitColumn(String tableName,String columnName,String[] splitColumn, int splitByPosition, Connection con){
        //create the splitcolumns
        String type = getType(columnName,tableName,con);
        for(int x=0; x<splitColumn.length; x++){AddColumn(tableName,splitColumn[x],type,con);}
        String sql = "SELECT "+columnName+"FROM"+tableName;
        ResultSet rs = null;
        try{
            Statement stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            int count = 0;
            while (rs.next()) {
                count++;
            }
            String[][] values = new String[count][splitColumn.length]; 
            rs = stmt.executeQuery(sql);
            count = 0;
            int position = 0;
            int point = 0;
            while(rs.next()){
                String s = rs.getString(columnName);
                while(position<s.length()){
                    values[count][point]=s.substring(position,position+position);
                    position =+ position;
                }
            }
            sql ="INSERT INTO "+tableName+"(";
            for(int x=0; x<splitColumn.length; x++){sql += splitColumn[x]+", ";}
            sql+=") VALUES";
            for(int n=0; n<values.length;n++){
                sql += "(";
                for(int m=0; m<values[n].length;m++){
                    if(m!=0){sql+=",";}
                    sql+=values[n][m];
                }
                sql += ")";
            }
            System.out.println(sql);
            stmt.executeUpdate(sql);
        }catch(Exception e){
            System.out.println("ERROR in SplitColumn(ASCII)"+e);
        }
        DeleteColumn(tableName,columnName,con);
        //loop through the values and split the values.
        
    }
  
    //?
}
