package br.com.equipejr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import br.com.equipejr.pojo.User;

@Controller
public class RootController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root() {
		return "snoop";
	}
	
	@RequestMapping(value = "/home", method = RequestMethod.POST)
	public String login(
			 @RequestParam(value="txtUserName", required=true) String email,
			 @RequestParam(value="txtPass", required=true) String pass,
			 ModelMap model) {
		User user = new User();
		user.setEmail(email);
		model.addAttribute("message", "Hello, " + email);
		model.addAttribute("user", user);
		return "home";
	}
}