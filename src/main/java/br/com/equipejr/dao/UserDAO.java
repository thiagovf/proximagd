package br.com.equipejr.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import br.com.equipejr.entity.User;

@Repository(value = "userDAO")
public class UserDAO {

	private EntityManagerFactory factory = Persistence.createEntityManagerFactory("equipePU");
	private EntityManager manager;
	
	public User getUser(String email) {
		manager = factory.createEntityManager();
		Query query = manager.createQuery("select u from User as u where u.email = :email ");
		query.setParameter("email", email);
		
		return (User)query.getSingleResult();
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getAllUserMails() {
		manager = factory.createEntityManager();
		Query query = manager.createQuery("select u.email from User as u ");
		
		return query.getResultList();
	}
}
