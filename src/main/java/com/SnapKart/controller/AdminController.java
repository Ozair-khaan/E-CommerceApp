package com.SnapKart.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.SnapKart.models.Cart;
import com.SnapKart.services.cartService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.SnapKart.models.Category;
import com.SnapKart.models.Product;
import com.SnapKart.models.User;
import com.SnapKart.services.categoryService;
import com.SnapKart.services.productService;
import com.SnapKart.services.userService;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    //private static final Logger logger= LoggerFactory.getLogger(AdminController.class);

    private final userService userService;
    private final categoryService categoryService;
    private final productService productService;
    private final cartService cartService;

    @Autowired
    public AdminController(userService userService, categoryService categoryService, productService productService, cartService cartService) {
        this.userService = userService;
        this.categoryService = categoryService;
        this.productService = productService;
        this.cartService = cartService;
    }

    @GetMapping("/index")
    public String index(Model model) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        model.addAttribute("username", username);
        return "index";
    }

    @GetMapping("login")
    public ModelAndView adminlogin(@RequestParam(required = false) String error) {
        ModelAndView mv = new ModelAndView("adminlogin");
        if ("true".equals(error)) {
            mv.addObject("msg", "Invalid username or password. Please try again.");
        }
        return mv;
    }

    @GetMapping(value = {"/", "Dashboard"})
    public ModelAndView adminHome(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        ModelAndView mv = new ModelAndView("adminHome");
        mv.addObject("admin", authentication.getName());
        //logger.info("Redirecting to adminHome jsp");
        return mv;
    }

    @GetMapping("categories")
    public ModelAndView getcategory() {
        ModelAndView mView = new ModelAndView("categories");
        List<Category> categories = this.categoryService.getCategories();
        mView.addObject("categories", categories);
        return mView;
    }

    @PostMapping("/categories")
    public String addCategory(@RequestParam("categoryname") String category_name) {
        System.out.println(category_name);

        Category category = this.categoryService.addCategory(category_name);
        if (category.getName().equals(category_name)) {
            return "redirect:categories";
        } else {
            return "redirect:categories";
        }
    }

    @GetMapping("categories/delete")
    public String removeCategoryDb(@RequestParam("id") int id) {
        this.categoryService.deleteCategory(id);
        return "redirect:/admin/categories";
    }

    @GetMapping("categories/update")
    public String updateCategory(@RequestParam("categoryid") int id, @RequestParam("categoryname") String categoryname) {
        Category category = this.categoryService.updateCategory(id, categoryname);
        return "redirect:/admin/categories";
    }


    //	 --------------------------Remaining --------------------
    @GetMapping("products")
    public ModelAndView getproduct() {
        ModelAndView mView = new ModelAndView("products");

        List<Product> products = this.productService.getProducts();

        if (products.isEmpty()) {
            mView.addObject("msg", "No products are available");
        } else {
            mView.addObject("products", products);
        }
        return mView;
    }

    @GetMapping("products/add")
    public ModelAndView addProduct() {
        ModelAndView mView = new ModelAndView("productsAdd");
        List<Category> categories = this.categoryService.getCategories();
        mView.addObject("categories", categories);
        return mView;
    }

    @RequestMapping(value = "products/add", method = RequestMethod.POST)
    public String addProduct(@RequestParam("name") String name, @RequestParam("categoryid") int categoryId, @RequestParam("price") int price, @RequestParam("weight") int weight, @RequestParam("quantity") int quantity, @RequestParam("description") String description, @RequestParam("productImage") String productImage) {
        System.out.println(categoryId);
        Category category = this.categoryService.getCategory(categoryId);
        Product product = new Product();
        product.setId(categoryId);
        product.setName(name);
        product.setCategory(category);
        product.setDescription(description);
        product.setPrice(price);
        product.setImage(productImage);
        product.setWeight(weight);
        product.setQuantity(quantity);
        this.productService.addProduct(product);
        return "redirect:/admin/products";
    }

    @GetMapping("products/update/{id}")
    public ModelAndView updateproduct(@PathVariable("id") int id) {

        ModelAndView mView = new ModelAndView("productsUpdate");
        Product product = this.productService.getProduct(id);
        List<Category> categories = this.categoryService.getCategories();

        mView.addObject("categories", categories);
        mView.addObject("product", product);
        return mView;
    }

    @PostMapping(value = "products/update/{id}")
    public String updateProduct(@PathVariable("id") int id, @RequestParam("name") String name, @RequestParam("categoryid") Category categoryId, @RequestParam("price") int price, @RequestParam("weight") int weight, @RequestParam("quantity") int quantity, @RequestParam("description") String description, @RequestParam("productImage") String productImage) {

        //this.productService.updateProduct(id, name);
        //this.categoryService.updateCategory(id, categoryId);
        Product product = this.productService.getProduct(id);
        if (product == null) {
            throw new RuntimeException("Product not found with ID : " + id);
        }
        product.setName(name);
        product.setCategory(categoryId);
        product.setPrice(price);
        product.setWeight(weight);
        product.setQuantity(quantity);
        product.setDescription(description);
        product.setImage(productImage);
        this.productService.updateProduct(product);
        return "redirect:/admin/products";
    }

    @GetMapping("products/delete")
    public String removeProduct(@RequestParam("id") int id) {
        this.productService.deleteProduct(id);
        return "redirect:/admin/products";
    }

    @PostMapping("products")
    public String postproduct() {
        return "redirect:/admin/categories";
    }

    @GetMapping("customers")
    public ModelAndView getCustomerDetail() {
        ModelAndView mView = new ModelAndView("displayCustomers");
        List<User> users = this.userService.getUsers();
        mView.addObject("customers", users);
        return mView;
    }


    @GetMapping("profileDisplay")
    public String profileDisplay(Model model) {
        String displayusername, displaypassword, displayemail, displayaddress;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommjava", "root", "");
            PreparedStatement stmt = con.prepareStatement("select * from users where username = ?" + ";");

            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            stmt.setString(1, username);

            ResultSet rst = stmt.executeQuery();

            if (rst.next()) {
                int userid = rst.getInt(1);
                displayusername = rst.getString(2);
                displayemail = rst.getString(3);
                displaypassword = rst.getString(4);
                displayaddress = rst.getString(5);
                model.addAttribute("userid", userid);
                model.addAttribute("username", displayusername);
                model.addAttribute("email", displayemail);
                model.addAttribute("password", displaypassword);
                model.addAttribute("address", displayaddress);
            }
        } catch (Exception e) {
            System.out.println("Exception:" + e);
        }
        System.out.println("Hello");
        return "updateProfile";
    }

    @RequestMapping(value = "updateuser", method = RequestMethod.POST)
    public String updateUserProfile(@RequestParam("userid") int userid, @RequestParam("username") String username, @RequestParam("email") String email, @RequestParam("password") String password, @RequestParam("address") String address) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommjava", "root", "");

            PreparedStatement pst = con.prepareStatement("update users set username= ?,email = ?,password= ?, address= ? where uid = ?;");
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setString(4, address);
            pst.setInt(5, userid);
            int i = pst.executeUpdate();

            Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
                    username,
                    password,
                    SecurityContextHolder.getContext().getAuthentication().getAuthorities());

            SecurityContextHolder.getContext().setAuthentication(newAuthentication);
        } catch (Exception e) {
            System.out.println("Exception:" + e);
        }
        return "redirect:index";
    }

}
