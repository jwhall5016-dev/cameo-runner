import os
import sys
from com.nomagic.actions import AMConfigurator
from com.nomagic.magicdraw.actions import ActionsConfiguratorsManager
from com.nomagic.magicdraw.actions import MDAction
from com.nomagic.magicdraw.actions import MDActionsCategory


# Action for menu item, it can be created by passing name to the constructor.
# Script with passed name and .py extension is invoked when executing action .
class ExampleAction( MDAction ):
	def __init__(self, name):
		MDAction.__init__( self,"", name, None, None )

	def actionPerformed(self, event):
		filename = pluginDescriptor.getPluginDirectory().getAbsolutePath()+os.sep+self.getName()+".py"
		try:
			execfile( filename )
		except :
			print "exception when trying to execute script:", filename, sys.exc_info()[0]
	

	
# Configurator adds new menu item to First menu in main menu
class MainMenuConfigurator( AMConfigurator):
	
	def configure( self,manager ):
		try:
			category=MDActionsCategory( "", "" )
			category.addAction( ExampleAction("ScriptAction") )
			manager.getCategories().get(0).addAction( category )
		except:
			print "exception"
	
# Script starts here
print "Starting script, descriptor", pluginDescriptor
ActionsConfiguratorsManager.getInstance().addMainMenuConfigurator( MainMenuConfigurator() )