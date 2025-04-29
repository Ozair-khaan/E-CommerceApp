package com.SnapKart.Auth;

import com.SnapKart.models.User;
import com.SnapKart.services.userService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private userService userService; // Service to fetch user details

    public CustomAuthenticationSuccessHandler(userService userService){
        this.userService=userService;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        String username = authentication.getName();
        // Fetch the user from your database
        User user = userService.getUserByUsername(username);
        // Store the userId in the session
        request.getSession().setAttribute("userId", user.getId());
        // Redirect to the home page (or any target URL)
        response.sendRedirect("/");
    }
}
