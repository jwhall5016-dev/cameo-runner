package com.nomagic.reportwizard.tools;

import com.nomagic.magicreport.engine.Tool;

/**
 * Hello Tool
 * 
 * @author Siri Chongasamethaworn (siri_c@nomagicasia.com)
 * @since Jun 6, 2008
 */
public class HelloTool extends Tool
{
   /**
    * Return Hello World
    * 
    * @return Hello World
    */
   public String getHello()
   {
      return "Hello World";
   }

   /**
    * Return Hello and your name
    * 
    * @param name your name
    * @return "Hello" + name
    */
   public String getHello(String name)
   {
      return "Hello " + name;
   }
}
