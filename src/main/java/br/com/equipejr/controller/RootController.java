package br.com.equipejr.controller;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import br.com.equipejr.entity.User;

@Controller
public class RootController {
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("equipePU");
	EntityManager manager;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root() {
		User u = new User();
		u.setName("yahoo");
		u.setEmail("test");
		manager = factory.createEntityManager();
		manager.getTransaction().begin();    
		manager.persist(u);
		manager.getTransaction().commit();  
//		factory.close();
//		manager.close();
		return "snoop";
	}
	
	@RequestMapping(value = "/home", method = RequestMethod.POST)
	public String login(
			 @RequestParam(value="txtUserName", required=true) String email,
			 @RequestParam(value="txtPass", required=true) String pass,
			 ModelMap model) {
		User encontrada = manager.find(User.class, 1L);
		User user = new User();
		user.setEmail(email);
		model.addAttribute("message", "Hello, " + encontrada.getEmail());
		model.addAttribute("user", user);
		return "home";
	}
}