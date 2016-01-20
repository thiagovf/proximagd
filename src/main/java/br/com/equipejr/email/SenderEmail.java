package br.com.equipejr.email;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import br.com.equipejr.entity.NextBeer;

public class SenderEmail {

	private static Properties props;
	private static Session session;
	private static SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm");
	private static void init() {
		props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");
		
		session = Session.getDefaultInstance(props,
				new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("equipe.junior","coelhofelpudo");
			}
		});
	}
	public static void sendNewNextBeer(List<String> emails, NextBeer nxt){
		init();

		try {

			StringBuilder sb = new StringBuilder();
			for(String email : emails) {
				sb.append(email);
				sb.append(",");
			}
			sb.deleteCharAt(sb.lastIndexOf(","));
			
			StringBuilder messageSB = new StringBuilder();
			messageSB.append("Caro amigo,\n\n");
			messageSB.append("Nosso amigo ");
			messageSB.append(nxt.getPayer().getName());
			messageSB.append(" se dispoes voluntariamente a pagar uma grade ");
			messageSB.append("na data ").append(format.format(nxt.getDateToPay().getTime())).append(".");
			messageSB.append("\n\n Motivo: ").append(nxt.getMotivation());
			messageSB.append("\n\n Contamos com sua presença, ");
			messageSB.append("\n\n Equipe Jr. ");
			
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("equipe.junior@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(sb.toString()));
			message.setSubject("Nova grade");
			message.setText(messageSB.toString());
			Transport.send(message);

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	
	public static void sendSaveTheDate(List<String> emails, NextBeer nxt) {
		init();

		try {

			StringBuilder sb = new StringBuilder();
			for(String email : emails) {
				sb.append(email);
				sb.append(",");
			}
			sb.deleteCharAt(sb.lastIndexOf(","));
			
			StringBuilder messageSB = new StringBuilder();
			messageSB.append("Caro amigo,");
			messageSB.append("\n\nNosso amigo ");
			messageSB.append(nxt.getPayer().getName());
			messageSB.append(" resolveu agendar a grade que devia para a data ");
			messageSB.append(format.format(nxt.getDateToPay().getTime())).append(".");
			messageSB.append("\n\n Motivo: ").append(nxt.getMotivation());
			messageSB.append("\n\n Contamos com sua presença, ");
			messageSB.append("\n\n Equipe Jr. ");
			
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("equipe.junior@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(sb.toString()));
			message.setSubject("Nova grade");
			message.setText(messageSB.toString());
			Transport.send(message);

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
		
	}
}
