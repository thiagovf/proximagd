package br.com.equipejr.dao;

import java.util.List;

import br.com.equipejr.entity.User;

public interface UserDAO {

	public User getUser(String email);

	public List<String> getAllUserMails();

	public List<String> getAllNeverPromised();

}
