package io.cameorestservice.cameo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledTasks {

	@Autowired
	private CameoManager cameoManager;

	@Scheduled(fixedRate = 30000)
	public void reportCurrentTime() {
		int procsRemoved = cameoManager.removeCompleteProcesses();
		System.out.println("Total processes removed by scheduled task: " + procsRemoved);
		
		//We should also maybe add a task to cleanup old json output files
	}
}
