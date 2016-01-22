package br.com.equipejr.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "USER_ROLES")
public class Role {
	
	@Id
	@GeneratedValue
	@Column(name="user_role_id")
	private Long id;
	
	@Column(name="role", nullable=false)
	private String description;

	public String getDescription() {
		return description;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	

}
