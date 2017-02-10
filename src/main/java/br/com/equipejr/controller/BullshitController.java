package br.com.equipejr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.com.equipejr.dao.UserDAO;

@Controller
public class BullshitController {

	@Autowired
	UserDAO userDAO;

	@RequestMapping(value = "/bullshit", method = RequestMethod.GET)
	public ModelAndView defaultPage() {
		ModelAndView model = new ModelAndView();
		model.setViewName("bullshit");

		model.addObject("allNeverPromised", userDAO.getAllNeverPromised());
		return model;

	}
}
