package br.com.equipejr.controller;

import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.equipejr.dao.NextBeerDAO;
import br.com.equipejr.dao.UserDAO;
import br.com.equipejr.entity.NextBeer;
import br.com.equipejr.entity.User;

@Controller
@RequestMapping("/newbeer")
public class NewBeerController {

	@Autowired
	NextBeerDAO nextBeerDAO;
	
	@Autowired
	UserDAO userDAO;
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public ModelAndView requestNewBeer() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String name = auth.getName();
		ModelAndView model = new ModelAndView();
		if (auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
			model.addObject("names", userDAO.getAllUserMails());
		} else {
			model.addObject("name", name);
		}
		model.setViewName("newbeer");
		return model;

	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public ModelAndView saveNewBeer(
			@RequestParam(value="reason", required=true) String reason,
			@RequestParam(value="user", required=true) String email,
			@RequestParam(value="dateToPay", required=true) @DateTimeFormat(pattern="dd/MM/yy HH:mm") Calendar dateToPay,
			@RequestParam(value="checkDate", required=true) Boolean checkDate) {
		NextBeer nextBeer = new NextBeer();
		if (checkDate && dateToPay == null) {
			nextBeer.setDateToPay(Calendar.getInstance());
		} else if (checkDate) {
			nextBeer.setDateToPay(dateToPay);
		}
		nextBeer.setDate(Calendar.getInstance());
		nextBeer.setMotivation(reason);
		nextBeer.setPaid(false);

		User user = userDAO.getUser(email);
		nextBeer.setPayer(user);

		nextBeerDAO.save(nextBeer);
		
//		SenderEmail.sendNewNextBeer(userDAO.getAllUserMails(), nextBeer);
		ModelAndView model = new ModelAndView();
		model.setViewName("thanks");
		return model;
	}

}
