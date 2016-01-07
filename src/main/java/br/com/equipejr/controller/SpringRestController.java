package br.com.equipejr.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/hello")
public class SpringRestController {
	@RequestMapping(value = "/{name}", method = RequestMethod.GET)
	public String hello(@PathVariable String name) {
		String result = "Hello 007" + name;
		return result;
	}
}