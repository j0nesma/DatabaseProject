/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import java.awt.event.MouseEvent;
/**
 *
 * @author Matt
 */
public class DTable extends JTable {
    
    public DTable(DefaultTableModel dm){
        super(dm);
        this.getModel().addTableModelListener(new TableModelListener() {
      public void tableChanged(TableModelEvent e) {
         System.out.println("source = "+e.getSource());
      }
     });
        this.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(MouseEvent evt) {
                TableMouseClicked(evt);
            }
        });
    }
    
    public void TableMouseClicked(MouseEvent event){
        System.out.println("mouse clicked = "+ event.getSource());
        
    }
    
    public void DropColumn(){
        
    }
    
    public void DropRow(){
        
    }
    
    
}
