package br.com.equipejr.controller;

import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.equipejr.dao.NextBeerDAO;
import br.com.equipejr.dao.UserDAO;
import br.com.equipejr.email.SenderEmail;
import br.com.equipejr.entity.NextBeer;

@Controller
@RequestMapping("/nextBeer")
public class NextBeerController {

	@Autowired
	NextBeerDAO nextBeerDAO;

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public ModelAndView saveTheDate(
			@RequestParam(value="id", required=true) Long id,
			@RequestParam(value="date", required=true)
			@DateTimeFormat(pattern="dd/MM/yyyy HH:mm") Calendar date) {
		nextBeerDAO.update(id, date);
		UserDAO userDAO = new UserDAO();
		NextBeer nxt = nextBeerDAO.getNextBeer(id);
		try {
			SenderEmail.sendSaveTheDate(userDAO.getAllUserMails(), nxt);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ModelAndView model = new ModelAndView("redirect:/welcome");
		return model;
	}
}
