package io.cameorestservice.cameo;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;
import io.cameorestservice.plugin.CameoRunner;


@Service
public class CameoManager {
	
	//Concurrent dictionary to track still-running processes
	private ConcurrentHashMap<String, Process> processes = new ConcurrentHashMap<String, Process>();
	
	
	public String getJsonOutput(String processKey) {
		//check if process is still running - if so no json output will be ready
		Process proc = processes.get(processKey);
		if(proc != null && proc.isAlive()) {
			return "process is still running please wait";
		}
		
		try {
			//Maybe we should delete the json after we know the requested received the download
			String tempDir = System.getProperty("java.io.tmpdir");
			String json = new String(Files.readAllBytes(Paths.get(tempDir, processKey+".json")));
			return json;
		}
		catch (Exception ex) {
			return "error retriving json output";
		}
	}
	
	
	public int removeCompleteProcesses() {
		//cleanup old process entries 
		int processesRemoved = 0;
		Iterator<ConcurrentHashMap.Entry<String, Process>> iterator = processes.entrySet().iterator();

        while (iterator.hasNext()) {
        	ConcurrentHashMap.Entry<String, Process> entry = iterator.next();
            String key = entry.getKey();
            Process proc = entry.getValue();
            if(!proc.isAlive()) {
            	processes.remove(key);
                System.out.println("process key: " + key + "was removed");
                processesRemoved = processesRemoved +1;
            }

        }
        
        return processesRemoved;
	}
	
	public String startSecondJVM(byte[] mbseFile, String packageName) throws Exception {
		boolean isDebug = true;

		try 
		{
			String processKey = UUID.randomUUID().toString();
			String tempDir = System.getProperty("java.io.tmpdir");
			File tempMbseFile = new File(tempDir,processKey +".mdzip");
			File tempJsonOutputFile = new File(tempDir,processKey +".json");
			Files.write(tempMbseFile.toPath(), mbseFile);
			
		    String separator = System.getProperty("file.separator");
		    String classpath = System.getProperty("java.class.path");
		    System.out.println("Starting CameoRunner with classpath: " +classpath);
		    System.out.println("Startup class is: " + CameoRunner.class.getName());
		    String path = System.getProperty("java.home")
			    + separator + "bin" + separator + "java";
		    System.out.println("Starting CameoRunner with execution path: " +path);
		    List<String> command = new ArrayList<String>();
	        command.add(path);
	        command.add("-cp");
	        command.add(classpath);
	        command.add(CameoRunner.class.getName());
	        command.add(tempMbseFile.toPath().toString());
	        command.add(tempJsonOutputFile.toPath().toString());
	        command.add(packageName);
	        command.add(String.valueOf(isDebug));
	        ProcessBuilder processBuilder = new ProcessBuilder(command).inheritIO();
		    Process process = processBuilder.start();
		 
		    processes.put(processKey, process);
		    return processKey;
		    //int status = process.waitFor();
		}
		catch(Exception ex) {
		    System.out.println("Exception setting up cameo runner jvm: " + ex.getMessage());
		    return "error has occurred launching cameo";
		}
	 }
}
