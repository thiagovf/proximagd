package br.com.equipejr.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.com.equipejr.email.SenderEmail;

@Controller
public class ContactController {
	@RequestMapping(value = "/contact", method = RequestMethod.GET)
	public ModelAndView adminPage() {

		ModelAndView model = new ModelAndView();
		model.setViewName("contact");
		return model;

	}
	
	@RequestMapping(value = "/mailme", method = RequestMethod.GET)
	public ModelAndView mailme() {
		List<String> mails = new ArrayList<String>();
		mails.add("thiagu.vf@gmail.com");
		SenderEmail.sendNewNextBeer(mails);
		return null;
	}
	
}
