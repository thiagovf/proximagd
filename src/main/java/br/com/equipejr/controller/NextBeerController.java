package br.com.equipejr.controller;

import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.equipejr.dao.NextBeerDAO;

@Controller
@RequestMapping("/nextBeer")
public class NextBeerController {

	@Autowired
	private NextBeerDAO nextBeerDAO;

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	@Transactional
	public ModelAndView saveTheDate(
			@RequestParam(value="id", required=true) Long id,
			@RequestParam(value="date", required=true)
			@DateTimeFormat(pattern="dd/MM/yyyy HH:mm") Calendar date) {
		nextBeerDAO.update(id, date);
//		UserDAOImpl userDAO = new UserDAOImpl();
//		NextBeer nxt = nextBeerDAO.getNextBeer(id);
//		try {
//			SenderEmail.sendSaveTheDate(userDAO.getAllUserMails(), nxt);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		ModelAndView model = new ModelAndView("redirect:/welcome");
		return model;
	}
}
