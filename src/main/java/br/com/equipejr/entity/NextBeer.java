package br.com.equipejr.entity;

import java.util.Calendar;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "NEXT_BEER")
public class NextBeer {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	private Long id;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar date;

	@Temporal(TemporalType.TIMESTAMP)
	private Calendar dateToPay;

	@Column(nullable = false)
	private Boolean paid;

	@Column(nullable = false)
	private String motivation;

	@Column(nullable = false, columnDefinition = "Varchar(255) default ''")
	private String lat;

	@Column(nullable = false, columnDefinition = "Varchar(255) default ''")
	private String lng;

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.DETACH)
	private User payer;

	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinTable(name = "NEXT_BEER_USER", 
			joinColumns = {@JoinColumn(name = "next_beer_id", nullable = false, updatable = false) }, 
			inverseJoinColumns = {@JoinColumn(name = "user_id", nullable = false, updatable = false) })
	private List<User> werePresent;

	public Calendar getDate() {
		return date;
	}

	public void setDateToPay(Calendar dateToPay) {
		this.dateToPay = dateToPay;
	}

	public Calendar getDateToPay() {
		return dateToPay;
	}

	public User getPayer() {
		return payer;
	}

	public String getMotivation() {
		return motivation;
	}

	public Long getId() {
		return id;
	}

	public Boolean getPaid() {
		return paid;
	}

	public void setPaid(Boolean paid) {
		this.paid = paid;
	}

	public void setDate(Calendar date) {
		this.date = date;
	}

	public void setMotivation(String motivation) {
		this.motivation = motivation;
	}

	public void setPayer(User payer) {
		this.payer = payer;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	public List<User> getWerePresent() {
		return werePresent;
	}

	public void setWerePresent(List<User> werePresent) {
		this.werePresent = werePresent;
	}

}
