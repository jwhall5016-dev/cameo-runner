//This extends the NoMagic CommandLine which allows us to launch MagicDraw in headless mode
//we do not run this directly but instead rely on CameoParser (Service) to run this in a secondary JVM
//to keep separation of this app side of this microservice that manages MagicDraw's resources which shut down
//after file parse completion 
package io.cameorestservice.plugin;


import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.nomagic.magicdraw.commandline.CommandLine;
import com.nomagic.magicdraw.core.Application;
import com.nomagic.magicdraw.core.Project;
import com.nomagic.magicdraw.core.project.ProjectDescriptor;
import com.nomagic.magicdraw.core.project.ProjectDescriptorsFactory;
import com.nomagic.magicdraw.core.project.ProjectsManager;
import com.nomagic.magicdraw.uml.BaseElement;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.NamedElement;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
//import myplugin.MyPlugin;

public class CameoRunner extends CommandLine
{
    public static String tempMDZIPFilePath;
    public static String folderToParse;
    public static String tempJSONFilePath;
    public static String hostname;
    public static int port;
    public static boolean isDebug = false;
    public static Project project;
    public static String modelName;

    public static void main(String[] args) throws InstantiationException
    {
		System.out.println("CameoRunner Starting");
		if (args.length < 3)
		{
		    System.out.println("missing arguments cannot launch cameo runner");
		    System.exit(0);
		}
		else
		{ 
		    tempMDZIPFilePath = args[0];
		    tempJSONFilePath = args[1];
		    folderToParse = args[2];
			isDebug = Boolean.parseBoolean(args[3]);
	
		    String[] launchArgs = { "-verbose"};
		    new CameoRunner().launch(launchArgs);
		}
    }

    protected static void run()
    {
		String edition = com.nomagic.magicdraw.license.utils.LicenseUtils.getEdition();
		boolean isFloating = com.nomagic.magicdraw.license.utils.LicenseUtils.isFloating();
		boolean isDemo = com.nomagic.magicdraw.license.utils.LicenseUtils.isDemoVersion();
		System.out.println("*****************************************************");
		System.out.println("*** CameoRunner Launched Edition: " + edition + "***");
		System.out.println("*** Floating License Version: " + String.valueOf(isFloating) + "***");
		System.out.println("*** Demo Version: " + String.valueOf(isDemo) + "***");
		System.out.println("*****************************************************");
		try {
	
		    // load project
		    String packageName = folderToParse;
		    File fileToLoad = new File(tempMDZIPFilePath);
		    ProjectDescriptor descriptor = ProjectDescriptorsFactory.createProjectDescriptor(fileToLoad.toURI());
		    ProjectsManager projectsManager = Application.getInstance().getProjectsManager();
		    projectsManager.loadProject(descriptor, true);
	
		    project = Application.getInstance().getProject();
	
		    Collection<BaseElement> elements = project.getAllElements();
		    Package primaryModel = project.getPrimaryModel();
		    modelName = primaryModel.getHumanName();
		    Iterator<BaseElement> elementIterator = elements.iterator();
		    
		    //Test running a custom plugin
		    /*MyPlugin testplugin = new MyPlugin();
		    testplugin.init();
		    testplugin.close();
		    testplugin.isSupported();*/
	
		    //Find initial parent element specified by user and then recursively sort through children
		    //If no parent with the spec'd name is found then return a message stating the failure
		    while( elementIterator.hasNext())
		    {
				BaseElement element = elementIterator.next();
		
				if(element instanceof NamedElement)
				{
				    String elementName = element.getHumanName();
		
				    if(elementName.endsWith(packageName)) 
				    {
						CameoElement cameoElement = CameoElement.processElement(element);
						Collection<BaseElement> reduceElements = new ArrayList<BaseElement>(elements);
						reduceElements.remove(element);
						cameoElement.children = findChildren(cameoElement, reduceElements);
						ObjectMapper objectMapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
						String jsonData = objectMapper.writeValueAsString(cameoElement);
						//System.out.println("Model JSON Output");
						//System.out.println(jsonData);
						cleanupAndWriteOutput(tempMDZIPFilePath, tempJSONFilePath, jsonData);
						return;
				    }
				}
		    }
		    
		    //Send back a message that the package/folder couldn't be found in the model
		    //RabbitConnection.publishJSON(modelName, "No Package: " + packageName + " Found", hostname, port, isDebug);
		    String errorMessage = "No Package: " + packageName + " Found";
		    cleanupAndWriteOutput(tempMDZIPFilePath, tempJSONFilePath, errorMessage);
	}
	catch(Exception ex) {
	    StringWriter sw = new StringWriter();
	    ex.printStackTrace(new PrintWriter(sw));
	    String stackTrace = sw.toString();
	    System.out.println(stackTrace);
	    String errorMessage = "Error parsing: " + stackTrace;
	    
	    try {
	    	cleanupAndWriteOutput(tempMDZIPFilePath, tempJSONFilePath, errorMessage);
	    }
	    catch (Exception fileWriteException) {
	    	System.out.println("Error writing message to file "+ fileWriteException.getMessage());
	    }
	    
	    System.exit(1);
	}
    }

    public static List<CameoElement> findChildren(CameoElement parent, Collection<BaseElement> elements)
    {
	List<CameoElement> children = new ArrayList<CameoElement>();
	Iterator<BaseElement> elementIterator = elements.iterator();

	try {

	    while( elementIterator.hasNext())
	    {
		BaseElement element = elementIterator.next();
		BaseElement elementParent = element.getObjectParent();
		if(elementParent != null
			&& elementParent.getID().equalsIgnoreCase(parent.id)
			)
		{
		    CameoElement cameoElement = CameoElement.processElement(element);
		    Collection<BaseElement> reduceElements = new ArrayList<BaseElement>(elements);
		    reduceElements.remove(element);

		    //We don't necessarily care about all elements types and their children
		    if(element instanceof NamedElement) 
		    {
			cameoElement.children = findChildren(cameoElement, reduceElements);
		    }

		    children.add(cameoElement);
		}

	    }
	    return children;
	}
	catch(Exception ex) {
		    StringWriter sw = new StringWriter();
		    ex.printStackTrace(new PrintWriter(sw));
		    String stackTrace = sw.toString();
		    System.out.println(stackTrace);
		    //RabbitConnection.publishJSON( modelName, "Error Parsing Children of: " + parent.id + " " + parent.name + " " + stackTrace, hostname, port, isDebug);
		    System.exit(1);
		    return children;
		}
    }
    
    private static void cleanupAndWriteOutput(String tempMDZIPFilePath, String outputJsonPathString, String outPut) throws IOException {
    	//Delete mdzip file after it has been parsed to save space
    	Charset charset = Charset.forName("ASCII");
    	Path outputJsonPath = Paths.get(outputJsonPathString);
    	Files.write(outputJsonPath, outPut.getBytes(charset));
    	Path mdzipPath = Paths.get(tempMDZIPFilePath);
    	Files.deleteIfExists(mdzipPath);
    }

    @Override
    protected byte execute() {
    	// TODO Auto-generated method stub
		run();
		return 0;
    }
}