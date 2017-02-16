package br.com.equipejr.dao.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.equipejr.dao.NextBeerDAO;
import br.com.equipejr.entity.NextBeer;

@Service
public class NextBeerDAOImpl implements NextBeerDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<NextBeer> getBeers(String email) {
		StringBuilder queryStr = new StringBuilder();
		queryStr.append(" select n from User as u ");
		queryStr.append(" left join u.nextBeers as n ");
		queryStr.append(" where u.email = :email and n.paid = false order by n.dateToPay desc");

		Query query = sessionFactory.getCurrentSession().createQuery(queryStr.toString());
		query.setParameter("email", email);

		return query.list();
	}

	public boolean hasBeersWithoutDate(String email) {
		boolean hasBeersWithoutDate = false;

		StringBuilder queryStr = new StringBuilder();
		queryStr.append(" select n from User as u left join u.nextBeers as n ");
		queryStr.append(" where u.email = :email and n.paid = false and n.dateToPay is null ");

		Query query = sessionFactory.getCurrentSession().createQuery(queryStr.toString());
		query.setParameter("email", email);

		if (query.list().size() > 0) {
			hasBeersWithoutDate = true;
		}

		return hasBeersWithoutDate;
	}

	@SuppressWarnings("unchecked")
	public List<NextBeer> getAllNextBeers() {
		StringBuilder queryStr = new StringBuilder();
		queryStr.append(" select n from NextBeer as n left join fetch n.payer as u ");
		queryStr.append(" where n.paid = false ");
		queryStr.append(" order by case when n.dateToPay is null then 1 else 0 end, n.dateToPay desc ");

		Query query = sessionFactory.getCurrentSession().createQuery(queryStr.toString());

		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<NextBeer> getAllPayedBeers() {
		StringBuilder queryStr = new StringBuilder();
		queryStr.append(" select n from NextBeer as n left join fetch n.payer as u ");
		queryStr.append(" where n.paid = true ");
		queryStr.append(" order by case when n.dateToPay is null then 1 else 0 end, n.dateToPay desc ");

		Query query = sessionFactory.getCurrentSession().createQuery(queryStr.toString());

		return query.list();
	}

	@SuppressWarnings("unchecked")
	public NextBeer getNextBeer(Long id) {
		NextBeer nextBeer = null;

		Query query = sessionFactory.getCurrentSession().createQuery("select n from NextBeer as n where n.id = :id ");
		query.setParameter("id", id);

		List<NextBeer> listNextBeers = query.list();
		if (listNextBeers != null && !listNextBeers.isEmpty()) {
			nextBeer = listNextBeers.get(0);
		}

		return nextBeer;
	}

	@SuppressWarnings("unchecked")
	public NextBeer getNextBeer() {
		NextBeer nextBeer = null;

		StringBuilder queryStr = new StringBuilder();
		queryStr.append(" select n from NextBeer as n ");
		queryStr.append(" where n.dateToPay is not null and n.dateToPay > :now");
		queryStr.append(" order by n.dateToPay ");

		Query query = sessionFactory.getCurrentSession().createQuery(queryStr.toString());
		query.setTimestamp("now", new Date());

		List<NextBeer> listNextBeers = query.list();
		if (listNextBeers != null && !listNextBeers.isEmpty()) {
			nextBeer = listNextBeers.get(0);
		}

		return nextBeer;
	}

	public NextBeer update(Long id, Calendar dateToPay) {
		NextBeer nextBeer = (NextBeer) sessionFactory.getCurrentSession().get(NextBeer.class, id);
		nextBeer.setDateToPay(dateToPay);
		save(nextBeer);
		return nextBeer;
	}

	public void save(NextBeer nextBeer) {
		sessionFactory.getCurrentSession().save(nextBeer);
	}
}
