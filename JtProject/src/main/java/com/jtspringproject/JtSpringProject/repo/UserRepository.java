package com.jtspringproject.JtSpringProject.repo;

import com.jtspringproject.JtSpringProject.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    // Find a user by their username
    User findByUsername(String username);
}
