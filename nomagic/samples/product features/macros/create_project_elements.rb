require 'java'
File = java.io.File;
Application = com.nomagic.magicdraw.core.Application
Project = com.nomagic.magicdraw.core.Project
ProjectsManager = com.nomagic.magicdraw.core.project.ProjectsManager
ProjectDescriptorsFactory = com.nomagic.magicdraw.core.project.ProjectDescriptorsFactory
System = java.lang.System
SessionManager = com.nomagic.magicdraw.openapi.uml.SessionManager;

projectsManager = Application.getInstance().getProjectsManager();


projectsManager.createProject();

filename = "mymodel.mdzip";
dir = System.getProperty("user.home", ".");
fi = File.new(dir, filename);
Application.getInstance().getGUILog().log("Create project: " + fi.getAbsolutePath());
project = projectsManager.getActiveProject();
projectDescriptor = ProjectDescriptorsFactory.createLocalProjectDescriptor(project, fi);

model = project.getModel();

factory = project.getElementsFactory();

SessionManager.getInstance().createSession("create 1000 elements")
pack = factory.createPackageInstance();
pack.setName("p1");
pack.setOwner(project.getModel());

for i in 1...10
	clazz = factory.createClassInstance();
	clazz.setName("c" + java.lang.Integer.toString(i));
	clazz.setOwner(pack);
end

SessionManager.getInstance().closeSession()

projectsManager.saveProject(projectDescriptor, true);
# projectsManager.closeProject();
