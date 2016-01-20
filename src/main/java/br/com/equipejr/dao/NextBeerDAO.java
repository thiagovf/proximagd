package br.com.equipejr.dao;

import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
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
		Query query = manager.createQuery("select n from User as u left join u.nextBeers as n where u.email = :email and n.paid = false order by n.dateToPay");
		query.setParameter("email", email);
		return query.getResultList();
	}

	public boolean hasBeersWithoutDate(String email) {
		boolean hasBeersWithoutDate = false;
		manager = factory.createEntityManager();
		Query query = manager.createQuery("select n from User as u left join u.nextBeers as n where u.email = :email and n.paid = false and n.dateToPay is null ");
		query.setParameter("email", email);
		if (query.getResultList().size() > 0) {
			hasBeersWithoutDate = true;
		}
		return hasBeersWithoutDate;
	}
	
	@SuppressWarnings("unchecked")
	public List<NextBeer> getAllNextBeers() {
		manager = factory.createEntityManager();
		Query query = manager.createQuery("select n from User as u left join u.nextBeers as n where n.paid = false order by n.dateToPay");
		return query.getResultList();
	}

	public NextBeer getNextBeer(Long id) {
		manager = factory.createEntityManager();
		Query query = manager.createQuery("select n from NextBeer as n where n.id = :id ");
		query.setParameter("id", id);
		try {
			return (NextBeer)query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

	public NextBeer getNextBeer() {
		manager = factory.createEntityManager();
		Query query = manager.createQuery("select n from NextBeer as n where n.dateToPay is not null order by n.dateToPay ");
		query.setMaxResults(1);
		try {
			return (NextBeer)query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}
	
	public NextBeer update(Long id, Calendar dateToPay) {
		manager = factory.createEntityManager();
		NextBeer nextBeer = manager.find(NextBeer.class, id);
		manager.getTransaction().begin();
		nextBeer.setDateToPay(dateToPay);
		manager.getTransaction().commit();
		return nextBeer;
	}
	
	public void save(NextBeer nextBeer) {
		manager = factory.createEntityManager();
		manager.persist(nextBeer);
	}
}
