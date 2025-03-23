package com.jtspringproject.JtSpringProject.controller;

import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.CartProduct;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.models.User;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.jtspringproject.JtSpringProject.repo.UserRepository;
import com.jtspringproject.JtSpringProject.services.cartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.jtspringproject.JtSpringProject.services.userService;
import com.jtspringproject.JtSpringProject.services.productService;

@Controller
public class UserController {

    private final userService userService;
    private final productService productService;
    private final cartService cartService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    public UserController(userService userService, productService productService, cartService cartService) {
        this.userService = userService;
        this.productService = productService;
        this.cartService = cartService;
    }

    @GetMapping("/register")
    public String registerUser() {
        return "register";
    }

    @GetMapping("/buy")
    public String buy() {
        return "buy";
    }

    @GetMapping("/login")
    public ModelAndView userlogin(@RequestParam(required = false) String error) {
        ModelAndView mv = new ModelAndView("userLogin");
        if ("true".equals(error)) {
            mv.addObject("msg", "Please enter correct email and password");
        }
        return mv;
    }

    @GetMapping("/")
    public ModelAndView indexPage() {
        ModelAndView mView = new ModelAndView("index");
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        mView.addObject("username", username);
        List<Product> products = this.productService.getProducts();

        if (products.isEmpty()) {
            mView.addObject("msg", "No products are available");
        } else {
            mView.addObject("products", products);
        }
        return mView;
    }

    @GetMapping("/user/products")
    public ModelAndView getproduct() {

        ModelAndView mView = new ModelAndView("uproduct");

        List<Product> products = this.productService.getProducts();

        if (products.isEmpty()) {
            mView.addObject("msg", "No products are available");
        } else {
            mView.addObject("products", products);
        }

        return mView;
    }

    @RequestMapping(value = "newuserregister", method = RequestMethod.POST)
    public ModelAndView newUseRegister(@ModelAttribute User user) {
        // Check if username already exists in database
        boolean exists = this.userService.checkUserExists(user.getUsername());

        if (!exists) {
            System.out.println(user.getEmail());
            user.setRole("ROLE_NORMAL");
            this.userService.addUser(user);

            System.out.println("New user created: " + user.getUsername());
            ModelAndView mView = new ModelAndView("userLogin");
            return mView;
        } else {
            System.out.println("New user not created - username taken: " + user.getUsername());
            ModelAndView mView = new ModelAndView("register");
            mView.addObject("msg", user.getUsername() + " is taken. Please choose a different username.");
            return mView;
        }
    }

    @GetMapping("/profileDisplay")
    public String profileDisplay(Model model, HttpServletRequest request) {

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.getUserByUsername(username);

        if (user != null) {
            model.addAttribute("userid", user.getId());
            model.addAttribute("username", user.getUsername());
            model.addAttribute("email", user.getEmail());
            model.addAttribute("password", user.getPassword());
            model.addAttribute("address", user.getAddress());
        } else {
            model.addAttribute("msg", "User not found");
        }

        return "updateProfile";
    }


    //for Learning purpose of model
    @GetMapping("/test")
    public String Test(Model model) {
        System.out.println("test page");
        model.addAttribute("author", "Ozair Khan");
        model.addAttribute("id", 555);

        List<String> friends = new ArrayList<String>();
        model.addAttribute("f", friends);
        friends.add("Value1");
        friends.add("Value2");

        return "test";
    }

    // for learning purpose of model and view ( how data is pass to view)

    @GetMapping("/test2")
    public ModelAndView Test2() {
        System.out.println("test page");
        //create modelandview object
        ModelAndView mv = new ModelAndView();
        mv.addObject("name", "Ozair Khan");
        mv.addObject("id", 555);
        mv.setViewName("test2");

        List<Integer> list = new ArrayList<Integer>();
        list.add(10);
        list.add(25);
        mv.addObject("marks", list);
        return mv;


    }


//    @GetMapping("cartDisplay")
//    public Object showCart(Model model, HttpSession session) {
//        ModelAndView mmView = new ModelAndView("cartproduct");
//        String username = SecurityContextHolder.getContext().getAuthentication().getName();
//        User user = userService.getUserByUsername(username);
//
//        if (user != null) {
//            model.addAttribute("userid", user.getId());
//            model.addAttribute("username", user.getUsername());
//            model.addAttribute("email", user.getEmail());
//            model.addAttribute("password", user.getPassword());
//            model.addAttribute("address", user.getAddress());
//        } else {
//            model.addAttribute("msg", "User not found");
//        }
//        return mmView;
//    }

    //cart controller method adding here

    @GetMapping("/addtocart")
    public String addToCart(@RequestParam("id") int productId,
                            Principal principal) {
        // 1) Get the currently logged-in user. This depends on your security setup.
        if (principal == null) {
            // If not logged in, redirect to login or show error
            return "redirect:/login";
        }

        // Typically, 'principal.getName()' is the username
        User currentUser = userRepository.findByUsername(principal.getName());
        if (currentUser == null) {
            return "redirect:/login";
        }

        // 2) Add the product to the cart
        cartService.addToCart(productId, currentUser);

        // 3) Redirect back to product page or to a cart page
       // return "redirect:/productDisplay"; // Or wherever your product list is
        return "redirect:/cartDisplay";
    }

    // Display the cart //duplicate entry method, same method is on above in same ctrlr
    @GetMapping("/cartDisplay")
    public String cartDisplay(Model model, Principal principal) {
        if (principal == null) {
            return "redirect:/login";
        }
        User currentUser = userRepository.findByUsername(principal.getName());

        List<CartProduct> cartItems = cartService.getCartProducts(currentUser);
        model.addAttribute("cartItems", cartItems);

        return "cartDisplay"; // name of your JSP/Thymeleaf template
    }


}