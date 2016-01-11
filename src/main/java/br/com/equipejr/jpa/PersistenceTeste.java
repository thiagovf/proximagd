package br.com.equipejr.jpa;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class PersistenceTeste {
	public static void main(String[] args) {
		EntityManagerFactory factory = Persistence.createEntityManagerFactory("equipePU");

		factory.close();
	}
}
