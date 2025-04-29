package com.SnapKart.repo;

import com.SnapKart.models.Cart;
import com.SnapKart.models.CartProduct;
import com.SnapKart.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartProductRepository extends JpaRepository<CartProduct, Integer> {
    List<CartProduct> findByCart(Cart cart);
    Optional<CartProduct> findByCartAndProduct(Cart cart, Product product);
}
