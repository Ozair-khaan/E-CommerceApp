package com.jtspringproject.JtSpringProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.jtspringproject.JtSpringProject.models.Cart;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;

@Repository
public class cartDao {
    @Autowired
    private SessionFactory sessionFactory;

    @Autowired
    private DataSource dataSource;

    public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }

    @Transactional
    public Cart addCart(Cart cart) {
        this.sessionFactory.getCurrentSession().save(cart);
        return cart;
    }

//    @Transactional
//    public List<Cart> getCarts() {
//        return this.sessionFactory.getCurrentSession().createQuery("from CART").list();
//    }

    @Transactional
    public List<Cart> getCarts() {
        // Query using the entity name "CART" defined in your Cart entity
        return this.sessionFactory.getCurrentSession()
                .createQuery("from CART")
                .list();
    }

    @Transactional
    public Cart getCartByCustomerId(int customerId) {
        return (Cart) this.sessionFactory.getCurrentSession()
                .createQuery("from CART c where c.customer.id = :customerId")
                .setParameter("customerId", customerId)
                .uniqueResult();
    }

//    @Transactional
//    public List<Cart> getCartsByCustomerID(Integer customer_id) {
//        String hql = "from CART where CART.customer_id = :customer_id";
//        return this.sessionFactory.getCurrentSession()
//                .createQuery(hql, Cart.class)
//                .setParameter("customer_id", customer_id)
//                .list();
//    }

    @Transactional
    public void updateCart(Cart cart) {
        this.sessionFactory.getCurrentSession().update(cart);
    }

    @Transactional
    public void deleteCart(Cart cart) {
        this.sessionFactory.getCurrentSession().delete(cart);
    }

    public void addToCart(int userId, int productId) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = dataSource.getConnection();

            // First, check if this product already exists in the user's cart
            String checkQuery = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // If it exists, update the quantity (e.g., increment by 1)
                int currentQty = rs.getInt("quantity");
                rs.close();
                ps.close();

                String updateQuery = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
                ps = conn.prepareStatement(updateQuery);
                ps.setInt(1, currentQty + 1);
                ps.setInt(2, userId);
                ps.setInt(3, productId);
                ps.executeUpdate();
            } else {
                // If not, insert a new row with quantity = 1
                rs.close();
                ps.close();

                String insertQuery = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
                ps = conn.prepareStatement(insertQuery);
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ps.setInt(3, 1);
                ps.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                }
            }
        }
    }
}
