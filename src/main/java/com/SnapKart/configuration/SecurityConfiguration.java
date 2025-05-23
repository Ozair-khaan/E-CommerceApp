package com.SnapKart.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.SnapKart.models.User;
import com.SnapKart.services.userService;

@Configuration
public class SecurityConfiguration {
	
	userService UserService;

	public SecurityConfiguration(userService UserService) {
		this.UserService = UserService;
	}

	@Configuration
	@Order(1)
	public static class AdminConfigurationAdapter{
		
		@Bean
		SecurityFilterChain adminFilterChain(HttpSecurity http) throws Exception {
            http.antMatcher("/admin/**") 
                   .authorizeHttpRequests(requests -> requests
            		 .requestMatchers(new AntPathRequestMatcher("/admin/login")).permitAll()
                     .requestMatchers(new AntPathRequestMatcher("/admin/**")).hasRole("ADMIN")
                    )
                    .formLogin(login -> login
                            .loginPage("/admin/login")
                            .loginProcessingUrl("/admin/loginvalidate")
                            .successHandler((request, response, authentication) -> {
                                response.sendRedirect("/admin/"); // Redirect on success
                            })
                            .failureHandler((request, response, exception) -> {
                                response.sendRedirect("/admin/login?error=true"); // Redirect on failure
                            }))
                    
                    .logout(logout -> logout.logoutUrl("/admin/logout")
                            .logoutSuccessUrl("/admin/login")
                            .deleteCookies("JSESSIONID"))
                    .exceptionHandling(exception -> exception
                            .accessDeniedPage("/403")  // Custom 403 page
                        );
            http.csrf(csrf -> csrf.disable());
			return http.build();
		}
	}
	
	@Configuration
	@Order(2)
	public static class UserConfigurationAdapter{
		
//		@Bean
//		SecurityFilterChain userFilterChain(HttpSecurity http) throws Exception {
//            http.authorizeHttpRequests(requests -> requests
//            		.antMatchers("/login", "/register", "/newuserregister" ,"/test", "/test2").permitAll()
//                    .antMatchers("/**").hasRole("USER"))
//                    .formLogin(login -> login
//                            .loginPage("/login")
//                            .loginProcessingUrl("/userloginvalidate")
//                            .successHandler((request, response, authentication) -> {
//                                response.sendRedirect("/"); // Redirect on success
//                            })
//                            .failureHandler((request, response, exception) -> {
//                                response.sendRedirect("/login?error=true"); // Redirect on failure
//                            }))
//
//                    .logout(logout -> logout.logoutUrl("/logout")
//                            .logoutSuccessUrl("/login")
//                            .deleteCookies("JSESSIONID"))
//                    .exceptionHandling(exception -> exception
//                            .accessDeniedPage("/403")  // Custom 403 page
//                        );
//
//            http.csrf(csrf -> csrf.disable());
//			return http.build();
//		}

		@Bean
		public SecurityFilterChain userFilterChain(HttpSecurity http) throws Exception {
			http
					.authorizeRequests()
					.antMatchers("/icons/**", "/images/**", "/css/**", "/js/**").permitAll() // Allow public access to static files
					.antMatchers("/login", "/register", "/newUserRegister").permitAll()
					.antMatchers("/**").hasRole("USER") // Protect all other endpoints
					.and()
					.formLogin()
					.loginPage("/login")
					.loginProcessingUrl("/userloginvalidate")
					.defaultSuccessUrl("/", true)
					.failureUrl("/login?error=true")
					.and()
					.logout()
					.logoutUrl("/logout")
					.logoutSuccessUrl("/login")
					.deleteCookies("JSESSIONID")
					.and()
					.exceptionHandling()
					.accessDeniedPage("/403") // Custom 403 error page
					.and()
					.csrf().disable(); // Disable CSRF for testing

			return http.build();
		}

	}


	
	@Bean
	UserDetailsService userDetailsService() {
		return username -> {
			User user = UserService.getUserByUsername(username);
			if(user == null) {
	            throw new UsernameNotFoundException("User with username " + username + " not found.");
			}
			String role =  user.getRole().equals("ROLE_ADMIN") ? "ADMIN":"USER"; 
			
			return org.springframework.security.core.userdetails.User
					.withUsername(username)
					.passwordEncoder(input->passwordEncoder().encode(input))
					.password(user.getPassword())
					.roles(role)
					.build();
		};
	}

	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
