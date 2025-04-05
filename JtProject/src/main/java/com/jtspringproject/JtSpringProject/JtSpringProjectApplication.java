package com.jtspringproject.JtSpringProject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(exclude = HibernateJpaAutoConfiguration.class)
@EntityScan(basePackages = "com.jtspringproject.JtSpringProject.models")
@EnableJpaRepositories("com.jtspringproject.JtSpringProject.repo")
public class JtSpringProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(JtSpringProjectApplication.class, args);
	}

}
