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

		return (User) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<String> getAllUserMails() {
		manager = factory.createEntityManager();
		Query query = manager.createQuery("select u.email from User as u order by u.email");

		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<String> getAllNeverPromised() {
		manager = factory.createEntityManager();

		StringBuilder hql = new StringBuilder();

		/* 
		 * SELECT U.NAME FROM USER U WHERE U.ID NOT IN (SELECT NB.PAYER_ID FROM
		 * NEXT_BEER NB) AND U.ENABLED = 1;
		 */
		hql.append(" select u.name from User as u where u.id not in (select nb.payer.id ");
		hql.append(" from NextBeer as nb) and u.enabled = 1 order by u.email ");

		Query query = manager.createQuery(hql.toString());
		return query.getResultList();
	}
}
