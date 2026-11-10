package myplugin;
import com.nomagic.magicdraw.plugins.Plugin;
import javax.swing.*;
public class MyPlugin extends Plugin
{
    @Override
    public void init()
    {
        //JOptionPane.showMessageDialog(null, "My Plugin init");
    	System.out.println("****Plugin Running!***");
    	System.out.println("****init!***");
    	System.out.println("****Plugin Running!***");
    }
    @Override
    public boolean close()
    {
        //JOptionPane.showMessageDialog( null, "My Plugin close");
    	System.out.println("****Plugin Running!***");
    	System.out.println("****close!***");
    	System.out.println("****Plugin Running!***");
        return true;
    }
    @Override
    public boolean isSupported()
    {
        //plugin can check here for specific conditions
        //if false is returned plugin is not loaded.
    	System.out.println("****Plugin Running!***");
    	System.out.println("****isSupported!***");
    	System.out.println("****Plugin Running!***");
        return true;
    }
}