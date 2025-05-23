package com.SnapKart.controller;

import com.SnapKart.models.Product;
import com.SnapKart.models.User;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.SnapKart.repo.UserRepository;
import com.SnapKart.services.PurchaseService;
import com.SnapKart.services.cartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.SnapKart.services.userService;
import com.SnapKart.services.productService;

@Controller
public class UserController {

    private final userService userService;
    private final productService productService;
    private final cartService cartService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PurchaseService purchaseService;

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

    @RequestMapping(value = "newUserRegister", method = RequestMethod.POST)
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

    @PostMapping("/addToCart")
    public ResponseEntity<String> addToCart(@RequestBody Map<String, Object> newProduct, HttpSession session) {
        // Retrieve current cart from session (if exists)
        List<Map<String, Object>> cartItems = (List<Map<String, Object>>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }

        boolean productExists = false;

        for (Map<String, Object> item : cartItems) {
            if (item.get("name").equals(newProduct.get("name"))) {

                int currentQuantity = ((Number) item.get("quantity")).intValue();
                int additionalQuantity = ((Number) newProduct.get("quantity")).intValue();
                int newQuantity = currentQuantity + additionalQuantity;
                item.put("quantity", newQuantity);
                double unitPrice = ((Number) newProduct.get("price")).doubleValue();
                item.put("price", unitPrice * newQuantity);
                productExists = true;
                break;
            }
        }

        if (!productExists) {
            cartItems.add(newProduct);
        }

        session.setAttribute("cartItems", cartItems);
        return new ResponseEntity<>("Cart updated successfully", HttpStatus.OK);
    }

    @GetMapping("showCart")
    public String showCart(Model model, HttpSession session) {

        List<Map<String, Object>> cartItems = (List<Map<String, Object>>) session.getAttribute("cartItems");

        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }
        model.addAttribute("cartItems", cartItems);
        return "cart";
    }

    //purchase functionality code
//    @PostMapping
//    public String processPurchase(HttpSession session) {
//        // Retrieve cart items from session
//        List<Map<String, Object>> cartItems = (List<Map<String, Object>>) session.getAttribute("cartItems");
//
//        if (cartItems == null || cartItems.isEmpty()) {
//            // Redirect to cart page with an error message if the cart is empty
//            return "redirect:/showCart?error=empty";
//        }
//
//        // Call the business logic to process the purchase
//        boolean purchaseSuccessful = purchaseService.processPurchase(cartItems);
//
//        if (purchaseSuccessful) {
//            // Clear the cart after successful purchase
//            session.removeAttribute("cartItems");
//            // Redirect to a confirmation page
//            return "redirect:/purchaseConfirmation";
//        } else {
//            // Redirect to cart page with an error message if purchase fails
//            return "redirect:/showCart?error=purchaseFailed";
//        }
//    }

    @PostMapping("/purchase")
    public String purchase(HttpSession session, Model model) {
        // Retrieve cart items from session
        List<Map<String, Object>> cartItems = (List<Map<String, Object>>) session.getAttribute("cartItems");

        if (cartItems == null || cartItems.isEmpty()) {
            model.addAttribute("message", "Your cart is empty. Nothing to purchase.");
            return "purchaseConfirmation";
        }

        double totalAmount = 0.0;

        // Ensure price consistency and calculate total amount
        for (Map<String, Object> item : cartItems) {
            Object priceObj = item.get("price");
            double price = (priceObj instanceof Integer) ? ((Integer) priceObj).doubleValue() : (double) priceObj;

            item.put("price", price); // Ensure price is always Double
            int quantity = (int) item.get("quantity");
            totalAmount += price * quantity;
        }

        // Store purchased items in request scope
        model.addAttribute("purchasedItems", cartItems);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("message", "Thank you for your purchase! Your order has been successfully processed.");

        // Clear the cart after purchase
        session.removeAttribute("cartItems");

        return "purchaseConfirmation"; // Redirect to purchase confirmation page
    }
}