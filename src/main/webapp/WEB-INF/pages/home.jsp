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
<link rel='stylesheet'
	href='webjars/bootstrap/3.2.0/css/bootstrap.min.css'>

<TITLE>Home</TITLE>
</HEAD>
<BODY>
	<div class="container-fluid">
		<div>
			<jsp:include page="header.jsp" />
			<div class="panel-body" align="center">
				<div class="container " style="margin-top: 10%; margin-bottom: 10%;">
					<sec:authorize
						access="hasRole('ROLE_NORMAL') or hasRole('ROLE_ADMIN')">
						<c:choose>
							<c:when test="${hasBeersWithoutDate}">
								<div align="left">
								<p>"Um homem que não paga o que deve é um devedor."<small> (autor desconhecido)</small></p> 
									<strong>Pague a grade, seu caba!</strong>
								</div>
							</c:when>
							<c:when test="${hasBeersWithoutDate and not empty nextBeers}">
								<div align="left">
								Opa, grade a vista!!
								</div> 
							</c:when>
							<c:otherwise>
								<div align="left">
								Você é um ótimo pagador. Estamos grato pelo seu empenho!
								</div>
							</c:otherwise>
						</c:choose>
						<c:if test="${not empty nextBeers}">
						<div align="left">
						<h3>Suas próximas grades</h3>
						</div>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>Devedor</th>
										<th>Data do Registro</th>
										<th>Motivo da Grade</th>
										<th>Email</th>
										<th>Previsão Pagamento</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${nextBeers}" var="nextBeer">
									<tr>
										<td>${nextBeer.payer.name}</td>
										<fmt:formatDate value="${nextBeer.date.time}" pattern="dd/MM/yyyy" var="date" />
										<td>${date}</td>
										<td>${nextBeer.motivation}</td>
										<td>${nextBeer.payer.email}</td>
										<c:choose>
											<c:when test="${not empty nextBeer.dateToPay}">
												<fmt:formatDate value="${nextBeer.dateToPay.time}" pattern="dd/MM/yyyy" var="dateToPay" />
												<td>${dateToPay}</td>
											</c:when>
											<c:otherwise>
												<td>Agendar pagamento</td>
											</c:otherwise>
										</c:choose>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						</c:if>
						<c:if test="${not empty allNextBeers}">
						<div>
						<h3 align="left">Grades a serem pagas</h3>
						</div>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>Devedor</th>
										<th>Data do Registro</th>
										<th>Motivo da Grade</th>
										<th>Email</th>
										<th>Previsão Pagamento</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${allNextBeers}" var="nextBeer">
									<tr>
										<td>${nextBeer.payer.name}</td>
										<fmt:formatDate value="${nextBeer.date.time}" pattern="dd/MM/yyyy" var="date" />
										<td>${date}</td>
										<td>${nextBeer.motivation}</td>
										<td>${nextBeer.payer.email}</td>
										<c:choose>
											<c:when test="${not empty nextBeer.dateToPay}">
												<fmt:formatDate value="${nextBeer.dateToPay.time}" pattern="dd/MM/yyyy" var="dateToPay" />
												<td>${dateToPay}</td>
											</c:when>
											<c:otherwise>
												<td>Cobre o mancebo!</td>
											</c:otherwise>
										</c:choose>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						</c:if>
						
					</sec:authorize>
				</div>
			</div>
			<jsp:include page="footer.jsp" />
		</div>
	</div>
</BODY>
</HTML>
