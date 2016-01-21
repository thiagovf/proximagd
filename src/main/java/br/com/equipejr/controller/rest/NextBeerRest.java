package br.com.equipejr.controller.rest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/nextBeer")
public class NextBeerRest {

//	@RequestMapping(value = "/saveTheDate", method = RequestMethod.POST)
//	public void saveTheDate(
//			@RequestParam(value="id", required=false) Long id,
//			@RequestParam(value="date", required=false)
//			@DateTimeFormat(pattern="dd/MM/yyyy HH:mm") Calendar date) {
//		NextBeerDAO nextBeerDAO = new NextBeerDAO();
//		nextBeerDAO.update(id, date);
////		UserDAO userDAO = new UserDAO();
////		NextBeer nxt = nextBeerDAO.getNextBeer(id);
////		SenderEmail.sendSaveTheDate(userDAO.getAllUserMails(), nxt);
//	}
	
}
