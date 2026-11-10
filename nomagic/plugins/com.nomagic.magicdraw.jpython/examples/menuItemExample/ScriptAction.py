#
# Code checks if there is open project in magic draw and displays result in message dialog.
#
from com.nomagic.magicdraw.core import Application
from com.nomagic.magicdraw.ui.dialogs import MDDialogParentProvider
from javax.swing import JOptionPane

project = Application.getInstance().getProject()

if project == None:
	message = "There is no project."
else:
	message = "There is project: "+project.getName()

JOptionPane.showMessageDialog( MDDialogParentProvider.getProvider().getDialogParent(),message)