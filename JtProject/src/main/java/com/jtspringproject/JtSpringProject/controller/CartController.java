package com.jtspringproject.JtSpringProject.controller;

import com.jtspringproject.JtSpringProject.services.cartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class CartController {

    @Autowired
    private cartService cartService;

    @GetMapping("/addtocart")
    public String addProductToCart(@RequestParam("id") int productId, HttpSession session) {

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {

            return "redirect:/login";
        }

        cartService.addToCart(userId, productId);
        
        return "redirect:/cartDisplay";
    }

}
