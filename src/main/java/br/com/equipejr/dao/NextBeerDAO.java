package br.com.equipejr.dao;

import java.util.Calendar;
import java.util.List;

import br.com.equipejr.entity.NextBeer;

public interface NextBeerDAO {
	List<NextBeer> getBeers(String email);

	boolean hasBeersWithoutDate(String email);

	List<NextBeer> getAllNextBeers();

	List<NextBeer> getAllPayedBeers();

	NextBeer getNextBeer(Long id);

	NextBeer getNextBeer();

	NextBeer update(Long id, Calendar dateToPay);

	void save(NextBeer nextBeer);
}
