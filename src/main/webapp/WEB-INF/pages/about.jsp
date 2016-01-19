<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
	<link rel='stylesheet' href='/proximagrade/static/css/bootstrap.min.css'>
	<script type="text/javascript" src="/proximagrade/static/js/jquery.js" ></script>
	<script type="text/javascript" src="/proximagrade/static/js/bootstrap.min.js"></script>
<TITLE>About</TITLE>
</HEAD>
<BODY>
	<div class="container-fluid">
		<div>
			<jsp:include page="header.jsp" />
			<div class="panel-body" align="center">
				<div class="container " style="margin-top: 10%; margin-bottom: 10%;">
					<sec:authorize
						access="hasRole('ROLE_NORMAL') or hasRole('ROLE_ADMIN')">
						<h2>Miss�o: tornar o controle de grade mais transparente e preciso.</h2>
						<hr>
						<h1>Regras</h1>
						<h2>S�o motivos para autom�tico cadastro de novas grades:</h2>
						<ul>
						<li>Promo��o no emprego;</li>
						<li>Mudan�a de emprego;</li>
						<li>Fechamento de novo projeto autonomo;</li>
						</ul>
						<h2>Cobran�a de juros</h2>
						<p>Pedente defini��o dos crit�rios de cobran�a de juros.</p>
					</sec:authorize>
				</div>
			</div>
			<jsp:include page="footer.jsp" />
		</div>
	</div>
</BODY>
</HTML>
