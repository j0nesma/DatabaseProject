package project;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;
import javax.swing.event.InternalFrameEvent;
import javax.swing.event.InternalFrameListener;

public class TableFrame extends JInternalFrame implements ActionListener{
	static int openFrameCount = 0;
	static final int xOffset = 30, yOffset = 30;
    public TableFrame(String s){
        super(s,true,true,true,true);
        setLocation(xOffset*openFrameCount, yOffset*openFrameCount);
        
    }

    public void actionPerformed(ActionEvent e) {
      System.out.println("Action ="+e.getActionCommand());
    }
        

}