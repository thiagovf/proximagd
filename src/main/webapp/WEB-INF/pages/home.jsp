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
<c:set var="context" value="${pageContext.request.contextPath}" />
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
	<link rel='stylesheet' href='${context}/static/css/bootstrap.min.css'>
	<link rel='stylesheet' href='${context}/static/css/jquery.datetimepicker.css'>
	<link rel='stylesheet' href='${context}/static/css/home.css'>
	<script type="text/javascript" src="${context}/static/js/jquery.js" ></script>
	<script type="text/javascript" src="${context}/static/js/jquery.datetimepicker.full.js"></script>
	<script type="text/javascript" src="${context}/static/js/bootstrap.min.js"></script>
	<script language="JavaScript" src="${context}/static/js/countdown.js"></script>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCI_bhav_kkwMeVjmacrrNLf2Wc8FT8VT8&callback=initMap">
	</script>
<script>

function showDatepicker(id){
	jQuery("#agendar" + id).hide();
	jQuery("#datepicker" + id).show();
	jQuery("#calendar" + id).show();
	jQuery("#saveTheDate" + id).show();
	$( "#datepicker"+id ).datetimepicker({
		format:'d/m/Y H:i',
		minDate: new Date(),
		value: new Date()
 	});
	$('#datepicker'+id).datetimepicker('show');

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
		console.log("don't do it!");
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
				<div class="col-xs-12">
					<sec:authorize
						access="hasRole('ROLE_NORMAL') or hasRole('ROLE_ADMIN')">
						<div class="col-lg-12">
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
								DisplayFormat = "Faltam %%D%% Dias, %%H%% Horas, %%M%% Minutos, %%S%% Segundos para pr�xima grade!";
								FinishMessage = "� hoje, menino!";
							</script>
							<script language="JavaScript" src="static/js/countdown.js"></script>
							</h2>
						</c:if>
						<c:choose>
							<c:when test="${hasBeersWithoutDate}">
								<div align="left">
								<p>"Um homem que n�o paga o que deve � um devedor."<small> (autor desconhecido)</small></p> 
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
								Voc� � um �timo pagador. Estamos grato pelo seu empenho!
								</div>
							</c:otherwise>
						</c:choose>
						<c:if test="${not empty nextBeers}">
						<div align="left">
						<h3>Suas pr�ximas grades</h3>
						</div>
						<jsp:useBean id="now" class="br.com.equipejr.auxi.CalendarUtil"/> 
						<div align="left">
							<table class="table-condensed">
								<thead>
									<tr>
										<th>Data do Registro</th>
										<th>Motivo da Grade</th>
										<th>Previs�o Pagamento</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${nextBeers}" var="nextBeer">
									<tr>
										<fmt:formatDate value="${nextBeer.date.time}" pattern="dd/MM/yyyy HH:mm" var="date" />
										<td>${date}</td>
										<td>${nextBeer.motivation}</td>
										
										<c:choose>
											<c:when test="${not empty nextBeer.dateToPay and now.daysBetweenDates(nextBeer.dateToPay) > 14}">
												<fmt:formatDate value="${nextBeer.dateToPay.time}" pattern="dd/MM/yyyy HH:mm" var="dateToPay" />
												<td>
												<form action="nextBeer/save" method="POST">
													<div id="agendar${nextBeer.id}">${dateToPay}
														<a href="javascript:void(0)"  onclick="showDatepicker(${nextBeer.id})" class="glyphicon glyphicon-pencil"></a>
													</div>
													<input id="datepicker${nextBeer.id}" type="text" style="display:none;" name="date">
													<input type="text" style="display:none;" name="id" value="${nextBeer.id}">
													
													<a href='javascript:void(0)' id="calendar${nextBeer.id}" style="display:none;" onclick="$('#datepicker${nextBeer.id}').datetimepicker('show');" 
														class="glyphicon glyphicon-calendar" title="Calend�rio!">
													</a>
													<button id="saveTheDate${nextBeer.id}" style="display:none;"
														class="glyphicon glyphicon-floppy-disk" title="Save the date!">
													</button>
												</form>
												</td>
											</c:when>
											<c:when test="${not empty nextBeer.dateToPay}">
												<fmt:formatDate value="${nextBeer.dateToPay.time}" pattern="dd/MM/yyyy HH:mm" var="dateToPay" />
												<td>${dateToPay}</td>
											</c:when>
											<c:otherwise>
												<td id="dateToPay${nextBeer.id}">
												<form action="nextBeer/save" method="POST">
													<a href="javascript:void(0)" id="agendar${nextBeer.id}" onclick="showDatepicker(${nextBeer.id})">Agendar Grade!</a>
													<input id="datepicker${nextBeer.id}" type="text" style="display:none;" name="date">
													<input type="text" style="display:none;" name="id" value="${nextBeer.id}">
													
													<a href='javascript:void(0)' id="calendar${nextBeer.id}" style="display:none;" onclick="$('#datepicker${nextBeer.id}').datetimepicker('show');" 
														class="glyphicon glyphicon-calendar" title="Calend�rio!">
													</a>
													<button id="saveTheDate${nextBeer.id}" style="display:none;"
														class="glyphicon glyphicon-floppy-disk" title="Save the date!">
													</button>
												</form>
												</td>
											</c:otherwise>
										</c:choose>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						</c:if>
						</div>

						<c:if test="${not empty allNextBeers}">
						<div class="col-lg-12">
							<div class="col-lg-6">
								<div>
								<h3 align="left">Grades a serem pagas</h3>
								</div>
								<div class="table-responsive" style="min-width: 200px;">
									<table class="table">
										<thead>
											<tr>
												<th>Devedor</th>
												<th>Data do Registro</th>
												<th>Motivo da Grade</th>
												<th>Email</th>
												<th>Previs�o Pagamento</th>
												<th></th>
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
												<td>
												<c:choose>
													<c:when test="${not empty nextBeer.lat}">
														<a href='javascript:void(0)' class="glyphicon glyphicon-map-marker" title="Mostrar no Mapa" onclick="reloadMap('${nextBeer.lat}','${nextBeer.lng}');"></a>
													</c:when>
												</c:choose>
												</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							<div class="col-lg-6">
								<h3 align="left">Onde vai ser?</h3>
								<br />
								<div id="map-canvas" style="height: 300px; min-width: 200px"></div>
							</div>
						</div>
						</c:if>
					</sec:authorize>
				</div>
				</div>
				</div>
			</div>
<script>
var map;
var markers = [];
function initialize() {
	var mapOptions = {
		zoom: 12,
		center: new google.maps.LatLng( -3.79096804186333,-38.50090965628624)
	};
	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}
function setMapOnAll(map) {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(map);
	}
}
google.maps.event.addDomListener(window, 'load', initialize);
function reloadMap(lat, lng) {
	setMapOnAll(null);
	var marker = new google.maps.Marker({
		position: new google.maps.LatLng(lat,lng), 
		map: map,
		zoom: 8,
		title:"-no futuro, o nome do local aparecer� aqui. Hoje, perdoe, t� faltando!"
	});
	console.log("Yahoo" + lat + lng);
	markers.push(marker);
}
</script>
			<jsp:include page="footer.jsp" />
		</div>
	</div>
</BODY>
</HTML>
