package com.SnapKart.models;

import javax.persistence.*;


@Entity(name="CART_PRODUCT")
public class CartProduct {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @ManyToOne
    @JoinColumn(name="cart_id")
    private Cart cart;

//    @ManyToOne
//    @JoinTable(name="product_id")
//    private Product product;

    @ManyToOne
    @JoinColumn(name="product_id")
    private Product product;

    private int quantity;

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public CartProduct(int id, Cart cart, Product product, int quantity) {
        this.id = id;
        this.cart = cart;
        this.product = product;
        this.quantity = quantity;
    }

    public CartProduct() {
        product = null;
    }

    public CartProduct(Cart cart, Product product) {
        this.cart=cart;
        this.product = product;
        this.quantity=1;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
