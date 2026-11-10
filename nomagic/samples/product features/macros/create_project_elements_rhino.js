importClass(java.io.File);
importClass(com.nomagic.magicdraw.core.Application);
importClass(com.nomagic.magicdraw.core.Project);
importClass(com.nomagic.magicdraw.core.project.ProjectsManager);
importClass(com.nomagic.magicdraw.core.project.ProjectDescriptorsFactory);
importClass(java.lang.System);

var projectsManager = Application.getInstance().getProjectsManager();

projectsManager.createProject();

var filename = "mymodel.mdzip";
var dir = System.getProperty("user.home", ".");
var fi = new File(dir, filename);

Application.getInstance().getGUILog().log("Create project: " + fi.getAbsolutePath());

var project = projectsManager.getActiveProject();
var projectDescriptor = ProjectDescriptorsFactory.createLocalProjectDescriptor(project, fi);

var model = project.getModel();

var factory = project.getElementsFactory();

var pack = factory.createPackageInstance();
pack.setName("p1");
pack.setOwner(project.getModel());

for (i = 1;i<10;++i) {
	var clazz = factory.createClassInstance();
	clazz.setName("c" + java.lang.Integer.toString(i));
	clazz.setOwner(pack);
}

projectsManager.saveProject(projectDescriptor, true);
//projectsManager.closeProject();
