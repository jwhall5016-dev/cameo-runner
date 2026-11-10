package io.cameorestservice.cameo;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class CameoRestAPIApp {

	
	public static void main(String[] args) {
		SpringApplication.run(CameoRestAPIApp.class, args);

	}

}
