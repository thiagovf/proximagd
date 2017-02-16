package br.com.equipejr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.equipejr.dao.NextBeerDAO;
import br.com.equipejr.entity.NextBeer;

@Controller
public class OldBeerController {

	@Autowired
	private NextBeerDAO nextBeerDAO;

	@RequestMapping(value = "/oldbeer", method = RequestMethod.GET)
	@Transactional
	public ModelAndView defaultPage(@RequestParam(value="id", required=true) Long id) {
		ModelAndView model = new ModelAndView();
		model.setViewName("oldBeer");

		NextBeer oldBeer = nextBeerDAO.getNextBeer(id);
		if (oldBeer != null) {
			model.addObject("oldBeer", oldBeer);
		}

		return model;

	}
}
