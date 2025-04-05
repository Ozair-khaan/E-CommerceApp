package com.jtspringproject.JtSpringProject.services;

import java.util.List;

import com.jtspringproject.JtSpringProject.models.Cart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtspringproject.JtSpringProject.dao.productDao;
import com.jtspringproject.JtSpringProject.dao.cartDao;
import com.jtspringproject.JtSpringProject.models.Product;

import javax.transaction.Transactional;

@Service
public class productService {
    @Autowired
    private productDao productDao;

    @Autowired
    private cartDao cartDao;

    public List<Product> getProducts() {
        return this.productDao.getProducts();
    }

    public Product addProduct(Product product) {
        return this.productDao.addProduct(product);
    }

    public Product getProduct(int id) {
        return this.productDao.getProduct(id);
    }

    public void updateProduct(Product product) {
        //product.setId(id);
        this.productDao.updateProduct(product);
    }

    public boolean deleteProduct(int id) {
        return this.productDao.deletProduct(id);
    }

    @Transactional
    public Cart getCartByCustomerId(int customerId) {
        return cartDao.getCartByCustomerId(customerId);
    }

    @Transactional
    public List<Cart> getAllCarts() {
        return cartDao.getCarts();
    }

}
