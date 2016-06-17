package br.com.equipejr.dao;

import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import br.com.equipejr.entity.NextBeer;

//@Repository(value = "nextBeerDAO")
@Component
public class NextBeerDAO {

//	private EntityManagerFactory factory = Persistence.createEntityManagerFactory("equipePU");
//	@Autowired
//	SessionFactory sessionFactory;
	@PersistenceContext
	private EntityManager entityManager;

	@SuppressWarnings("unchecked")
	public List<NextBeer> getBeers(String email) {
		Query query = entityManager.createQuery("select n from User as u left join u.nextBeers as n where u.email = :email and n.paid = false order by n.dateToPay");
		query.setParameter("email", email);
		return query.getResultList();
	}

	public boolean hasBeersWithoutDate(String email) {
		boolean hasBeersWithoutDate = false;
		Query query = entityManager.createQuery("select n from User as u left join u.nextBeers as n where u.email = :email and n.paid = false and n.dateToPay is null ");
		query.setParameter("email", email);
		if (query.getResultList().size() > 0) {
			hasBeersWithoutDate = true;
		}
		return hasBeersWithoutDate;
	}
	
	@SuppressWarnings("unchecked")
	public List<NextBeer> getAllNextBeers() {
		Query query = entityManager.createQuery("select n from NextBeer as n left join fetch n.payer as u where n.paid = false order by n.dateToPay");
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<NextBeer> getAllPayedBeers() {
		Query query = entityManager.createQuery("select n from NextBeer as n left join fetch n.payer as u where n.paid = true order by n.dateToPay");
		return query.getResultList();
	}

	public NextBeer getNextBeer(Long id) {
		Query query = entityManager.createQuery("select n from NextBeer as n where n.id = :id ");
		query.setParameter("id", id);
		try {
			return (NextBeer)query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

	public NextBeer getNextBeer() {
		Query query = entityManager.createQuery("select n from NextBeer as n where n.dateToPay is not null order by n.dateToPay ");
		query.setMaxResults(1);
		try {
			return (NextBeer)query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}
	
	@Transactional
	public NextBeer update(Long id, Calendar dateToPay) {
		NextBeer nextBeer = entityManager.find(NextBeer.class, id);
		nextBeer.setDateToPay(dateToPay);
		entityManager.merge(nextBeer);
		return nextBeer;
	}
	
	@Transactional
	public void save(NextBeer nextBeer) {
		entityManager.persist(nextBeer);
	}
}
