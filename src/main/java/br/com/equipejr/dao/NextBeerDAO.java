package br.com.equipejr.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import br.com.equipejr.entity.NextBeer;

@Repository(value = "nextBeerDAO")
public class NextBeerDAO {

	private EntityManagerFactory factory = Persistence.createEntityManagerFactory("equipePU");
	private EntityManager manager;
//	@Autowired
//	SessionFactory sessionFactory;
//	@Autowired
//	private EntityManager entityManager;

	@SuppressWarnings("unchecked")
	public List<NextBeer> getBeers(String email) {
		manager = factory.createEntityManager();
		Query query = manager.createQuery("select n from User as u left join u.nextBeers as n where u.email = :email and n.paid = false ");
		query.setParameter("email", email);
		return query.getResultList();
	}

	public boolean hasBeersWithoutDate(String email) {
		boolean hasBeersWithoutDate = false;
		manager = factory.createEntityManager();
		Query query = manager.createQuery("select n from User as u left join u.nextBeers as n where u.email = :email and n.paid = false and n.dateToPay is null ");
		query.setParameter("email", email);
		if (query.getFirstResult() != 0) {
			hasBeersWithoutDate = true;
		}
		return hasBeersWithoutDate;
	}
	
	@SuppressWarnings("unchecked")
	public List<NextBeer> getAllNextBeers() {
		manager = factory.createEntityManager();
		Query query = manager.createQuery("select n from User as u left join u.nextBeers as n where n.paid = false ");
		return query.getResultList();
	}
}
