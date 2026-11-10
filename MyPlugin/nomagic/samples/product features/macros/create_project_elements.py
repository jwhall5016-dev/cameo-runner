from java.io import File
from com.nomagic.magicdraw.core import Application
from com.nomagic.magicdraw.core import Project
from com.nomagic.magicdraw.core.project import ProjectsManager
from com.nomagic.magicdraw.core.project import ProjectDescriptorsFactory
from java.lang import Integer
from java.lang import System

projectsManager = Application.getInstance().getProjectsManager();

projectsManager.createProject();

filename = "mymodel.mdzip";
dir = System.getProperty("user.home", ".");
fi = File(dir, filename);

Application.getInstance().getGUILog().log("Create project: " + fi.getAbsolutePath());

project = projectsManager.getActiveProject();
projectDescriptor = ProjectDescriptorsFactory.createLocalProjectDescriptor(project, fi);

model = project.getModel();

factory = project.getElementsFactory();

pack = factory.createPackageInstance();
pack.setName("p1");
pack.setOwner(project.getModel());

for i in range(10):
	clazz = factory.createClassInstance();
	clazz.setName("c" + Integer.toString(i));
	clazz.setOwner(pack);

projectsManager.saveProject(projectDescriptor, True);
# projectsManager.closeProject();
