package br.com.equipejr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.com.equipejr.dao.NextBeerDAO;

@Controller
public class PayedBeerController {

	@Autowired
	NextBeerDAO nextBeerDAO;

	@RequestMapping(value = "/payed", method = RequestMethod.GET)
	public ModelAndView defaultPage() {
		ModelAndView model = new ModelAndView();
		model.setViewName("payed");

		model.addObject("allPayedBeers", nextBeerDAO.getAllPayedBeers());
		return model;

	}
}
