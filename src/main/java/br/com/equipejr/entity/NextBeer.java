package br.com.equipejr.entity;

import java.util.Calendar;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="next_beer")
public class NextBeer {

	@Id
	@GeneratedValue
	private Long id;
	
	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Calendar date;
	
	@Temporal(TemporalType.DATE)
	private Calendar dateToPay;
	
	@Column(nullable = false)
	private Boolean paid;
	
	@Column(nullable = false)
	private String motivation;
	
	@ManyToOne(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	private User payer;

	public Calendar getDate() {
		return date;
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

}
