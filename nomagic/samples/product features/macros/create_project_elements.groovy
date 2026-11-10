import com.nomagic.magicdraw.core.Application
import com.nomagic.magicdraw.core.Project
import com.nomagic.magicdraw.core.project.ProjectDescriptor
import com.nomagic.magicdraw.core.project.ProjectDescriptorsFactory
import com.nomagic.magicdraw.core.project.ProjectsManager
import com.nomagic.uml2.ext.magicdraw.auxiliaryconstructs.mdmodels.Model
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Class
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package
import com.nomagic.uml2.impl.ElementsFactory

ProjectsManager projectsManager = Application.getInstance().getProjectsManager();

projectsManager.createProject();

String filename = "mymodel.mdzip";
String dir = System.getProperty("user.home", ".");

File fi = new File(dir, filename);

Application.getInstance().getGUILog().log("Create project: " + fi.getAbsolutePath());

Project project = projectsManager.getActiveProject();
ProjectDescriptor projectDescriptor = ProjectDescriptorsFactory.createLocalProjectDescriptor(project, fi);

Model model = project.getPrimaryModel();

ElementsFactory factory = project.getElementsFactory();

Package pack = factory.createPackageInstance();
pack.setName("p1");
pack.setOwner(project.getPrimaryModel());

for (int i = 1; i < 10; ++i) {
	Class clazz = factory.createClassInstance();
	clazz.setName("c" + java.lang.Integer.toString(i));
	clazz.setOwner(pack);
}

projectsManager.saveProject(projectDescriptor, true);
//projectsManager.closeProject();
