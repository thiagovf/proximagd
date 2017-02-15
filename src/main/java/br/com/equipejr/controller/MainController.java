package br.com.equipejr.controller;

import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.com.equipejr.dao.NextBeerDAO;
import br.com.equipejr.entity.NextBeer;

@Controller
public class MainController {

	@Autowired
	private NextBeerDAO nextBeerDAO;
	
	@RequestMapping(value = { "/", "/welcome**" }, method = RequestMethod.GET)
	@Transactional
	public ModelAndView defaultPage() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		ModelAndView model = new ModelAndView();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			model.addObject("nextBeers", nextBeerDAO.getBeers(userDetail.getUsername()));
			model.addObject("hasBeersWithoutDate", nextBeerDAO.hasBeersWithoutDate(userDetail.getUsername()));
			model.setViewName("homeLogged");
		} else {
			model.setViewName("home");
		}
		NextBeer nextestBeer = nextBeerDAO.getNextBeer();
		Calendar today = Calendar.getInstance();
		today.set(Calendar.HOUR_OF_DAY, 23);
		today.set(Calendar.MINUTE, 59);
		if (nextestBeer != null && today.before(nextestBeer.getDateToPay())) {
			model.addObject("dateToPayNextBeers", nextestBeer.getDateToPay());
		}
		model.addObject("allNextBeers", nextBeerDAO.getAllNextBeers());
		
		
		return model;

	}

	@RequestMapping(value = "/admin**", method = RequestMethod.GET)
	public ModelAndView adminPage() {

		ModelAndView model = new ModelAndView();
		model.addObject("title", "Spring Security Login Form - Database Authentication");
		model.addObject("message", "This page is for ROLE_ADMIN only!");
		model.setViewName("admin");
		return model;

	}

	@RequestMapping(value = {"/login"}, method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Usuário e/ou senha inválido!");
		}

		if (logout != null) {
			model.addObject("msg", "Você se deslogou com sucesso.");
		}
		model.setViewName("login");

		return model;

	}

	// for 403 access denied page
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {

		ModelAndView model = new ModelAndView();

		// check if user is login
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			model.addObject("username", userDetail.getUsername());
		}

		model.setViewName("403");
		return model;

	}

}