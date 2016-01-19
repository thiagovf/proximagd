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
	<link rel='stylesheet' href='/proximagrade/static/css/jquery.datetimepicker.css'>
	<script type="text/javascript" src="/proximagrade/static/js/jquery.js" ></script>
	<script type="text/javascript" src="/proximagrade/static/js/jquery.datetimepicker.full.js"></script>
	<script type="text/javascript" src="/proximagrade/static/js/bootstrap.min.js"></script>
	<script language="JavaScript" src="/proximagrade/static/js/countdown.js"></script>
<script>
jQuery(function() {
	$( "#datepicker" ).change(function(){
		console.log(this.value);
	})
});

function showDatepicker(id){
	jQuery("#agendar" + id).hide();
	jQuery("#datepicker" + id).show();
	jQuery("#saveTheDate" + id).show();
	$( "#datepicker"+id ).datetimepicker({
		 format:'d/m/Y H:i',
		 minDate: new Date()
 	});
	
}
function saveTheDate(id) {
	if ($( "#datepicker" + id ).val() != '') {
		var date = jQuery("#datepicker"+id).val();
		$.ajax({
			type: "POST",
			url: "nextBeer/saveTheDate",
			dataType: "json", 
			data:{id, date}
		}).complete(function(data) {
			//jQuery("#agendar" + id).hide();
			//jQuery("#datepicker" + id).hide();
			//jQuery("#saveTheDate" + id).hide();
			//jQuery("#dateToPay" + id).html(date);
			window.location.reload(true);
		});
	} else {
		console.log("don't do it, folks!");
	}
}
</script>
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
						<c:if test="${dateToPayNextBeers != null}">
							<h2 id="cntdwn">
							<fmt:formatDate value="${dateToPayNextBeers.time}" pattern="MM/dd/yyyy hh:mm a" var="dateToPayNextBeer" />
							<input id="next" type="hidden" value="${dateToPayNextBeer}" />
							<script language="JavaScript">
								//TargetDate = "12/31/2020 5:00 AM";
								TargetDate = jQuery('#next').val();
								BackColor = "palegreen";
								ForeColor = "navy";
								CountActive = true;
								CountStepper = -1;
								LeadingZero = true;
								DisplayFormat = "Faltam %%D%% Dias, %%H%% Horas, %%M%% Minutos, %%S%% Segundos para próxima grade!";
								FinishMessage = "É hoje, menino!";
							</script>
							<script language="JavaScript" src="static/js/countdown.js"></script>
							</h2>
						</c:if>
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
						<div align="left">
							<table class="table-condensed">
								<thead>
									<tr>
										<th>Data do Registro</th>
										<th>Motivo da Grade</th>
										<th>Previsão Pagamento</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${nextBeers}" var="nextBeer">
									<tr>
										<fmt:formatDate value="${nextBeer.date.time}" pattern="dd/MM/yyyy HH:mm" var="date" />
										<td>${date}</td>
										<td>${nextBeer.motivation}</td>
										<c:choose>
											<c:when test="${not empty nextBeer.dateToPay}">
												<fmt:formatDate value="${nextBeer.dateToPay.time}" pattern="dd/MM/yyyy HH:mm" var="dateToPay" />
												<td>${dateToPay}</td>
											</c:when>
											<c:otherwise>
												<td id="dateToPay${nextBeer.id}">
												<a href="#" id="agendar${nextBeer.id}" onclick="showDatepicker(${nextBeer.id})">Agendar Grade!</a>
												<input id="datepicker${nextBeer.id}" type="text" style="display:none;" value="">
												<button id="saveTheDate${nextBeer.id}" style="display:none;" onclick="saveTheDate('${nextBeer.id}')" 
													class="glyphicon glyphicon-floppy-saved" title="Save the date!">
												</button>
												</td>
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
										<fmt:formatDate value="${nextBeer.date.time}" pattern="dd/MM/yyyy HH:mm" var="date" />
										<td>${date}</td>
										<td>${nextBeer.motivation}</td>
										<td>${nextBeer.payer.email}</td>
										<c:choose>
											<c:when test="${not empty nextBeer.dateToPay}">
												<fmt:formatDate value="${nextBeer.dateToPay.time}" pattern="dd/MM/yyyy HH:mm" var="dateToPay" />
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
