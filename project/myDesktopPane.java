/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JDesktopPane;

/**
 *
 * @author Matt
 */
public class myDesktopPane extends JDesktopPane implements ActionListener {
    
    public myDesktopPane(){
        super();
        JButton dropTable = new JButton("test");
        dropTable.addActionListener(this);
        add(dropTable);
        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
