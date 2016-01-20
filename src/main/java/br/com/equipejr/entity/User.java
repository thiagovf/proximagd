package br.com.equipejr.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="USER")
public class User {

	@Id
	@GeneratedValue
	private Long id;
	
	@Column(nullable = false)
	private String name;
	
	@Column(nullable = false)
	private String email;
	
	@Column(nullable = false)
	private String password;
	
	@Column(nullable = false)
	private boolean enabled;
	
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL, mappedBy="payer")
	private List<NextBeer> nextBeers;
	
	@OneToOne(fetch=FetchType.LAZY)
	private Role role;
	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return email;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
