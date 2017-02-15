package br.com.equipejr.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.equipejr.dao.UserDAO;
import br.com.equipejr.entity.User;

@Service
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public User getUser(String email) {
		Query query = sessionFactory.getCurrentSession().createQuery("select u from User as u where u.email = :email ");
		query.setParameter("email", email);

		return (User) query.list().get(0);
	}

	@SuppressWarnings("unchecked")
	public List<String> getAllUserMails() {
		Query query = sessionFactory.getCurrentSession().createQuery("select u.email from User as u order by u.email");

		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<String> getAllNeverPromised() {

		StringBuilder hql = new StringBuilder();

		/*
		 * SELECT U.NAME FROM USER U WHERE U.ID NOT IN (SELECT NB.PAYER_ID FROM
		 * NEXT_BEER NB) AND U.ENABLED = 1;
		 */
		hql.append(" select u.name from User as u where u.id not in (select nb.payer.id ");
		hql.append(" from NextBeer as nb) and u.enabled = 1 order by u.name ");

		Query query = sessionFactory.getCurrentSession().createQuery(hql.toString());
		return query.list();
	}
}
