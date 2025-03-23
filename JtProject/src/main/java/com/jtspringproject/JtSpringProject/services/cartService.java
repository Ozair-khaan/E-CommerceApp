package com.jtspringproject.JtSpringProject.services;

import com.jtspringproject.JtSpringProject.dao.cartDao;
import com.jtspringproject.JtSpringProject.models.Cart;
import com.jtspringproject.JtSpringProject.models.CartProduct;
import com.jtspringproject.JtSpringProject.models.Product;
import com.jtspringproject.JtSpringProject.models.User;
import com.jtspringproject.JtSpringProject.repo.CartProductRepository;
import com.jtspringproject.JtSpringProject.repo.CartRepository;
import com.jtspringproject.JtSpringProject.repo.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class cartService {

    @Autowired
    private cartDao cartDao;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CartProductRepository cartProductRepository;

    public Cart addCart(Cart cart) {
        return cartDao.addCart(cart);
    }

    //    public Cart getCart(int id)
//    {
//        return cartDao.getCart(id);
//    }
//    public List<Cart> getCarts() {
//        return this.cartDao.getCarts();
//    }

    public void updateCart(Cart cart) {
        cartDao.updateCart(cart);
    }

    public void deleteCart(Cart cart) {
        cartDao.deleteCart(cart);
    }

    //    pubiic List<Cart> getCartByUserId(int customer_id){
//        return cartDao.getCartsByCustomerID(customer_id);
//    }
//    public Cart getCartProducts(int custId) {
//        return cartDao.getCartByCustomerId(custId);
//    }

    @Transactional
    public Cart getCartByCustomerId(int customerId) {
        return cartDao.getCartByCustomerId(customerId);
    }

    @Transactional
    public List<Cart> getAllCarts() {
        return cartDao.getCarts();
    }

    public void addToCart(int userId, int productId) {
        // Delegate the actual persistence logic to the DAO
        cartDao.addToCart(userId, productId);
    }


    //with using newly created repo operation
//    public void addToCart1(int productId, User currentUser) {
//        // 1) Find or create the user’s Cart
//        Cart cart = cartRepository.findByCustomerId(currentUser.getId());
//        if (cart == null) {
//            cart = new Cart();
//            cart.setCustomer(currentUser);
//            cart = cartRepository.save(cart);
//        }
//
//        // 2) Get the product from DB
//        Product product = productRepository.findById(productId)
//                .orElseThrow(() -> new RuntimeException("Product not found with id " + productId));
//
//        // 3) Create and save a CartProduct entry
//        //    (If you want to avoid duplicates, see the note below.)
//        CartProduct cartProduct = new CartProduct(cart, product);
//        cartProductRepository.save(cartProduct);
//    }


    public void addToCart(int productId, User currentUser) {
        // ... find the cart ...
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        //for cart.getId()
        Cart cart = cartRepository.findByCustomerId(currentUser.getId());

        // Check if already in the cart
        Optional<CartProduct> existing = cartProductRepository
                .findAll()
                .stream()
                .filter(cp -> cp.getCart().getId() == cart.getId()
                        && cp.getProduct().getId() == productId)
                .findFirst();

        if (existing.isPresent()) {
            // increment quantity
            CartProduct cp = existing.get();
            cp.setQuantity(cp.getQuantity() + 1);
            cartProductRepository.save(cp);
        } else {
            // new row
            CartProduct cartProduct = new CartProduct(cart, product);
            cartProduct.setQuantity(1);
            cartProductRepository.save(cartProduct);
        }
    }

    // Optionally: a method to retrieve cart items for display
    public List<CartProduct> getCartProducts(User currentUser) {
        Cart cart = cartRepository.findByCustomerId(currentUser.getId());
        if (cart == null) {
            return Collections.emptyList();
        }
        // Return all cart products for that cart
        return cartProductRepository
                .findAll()
                .stream()
                .filter(cp -> cp.getCart().getId() == cart.getId())
                .collect(Collectors.toList());
    }

}
