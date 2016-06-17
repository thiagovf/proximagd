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
<link rel='stylesheet'
	href='${context}/static/css/jquery.datetimepicker.css'>
<link rel='stylesheet' href='${context}/static/css/home.css'>
<script type="text/javascript" src="${context}/static/js/jquery.js"></script>
<script type="text/javascript"
	src="${context}/static/js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript"
	src="${context}/static/js/bootstrap.min.js"></script>
<script language="JavaScript" src="${context}/static/js/countdown.js"></script>
<script type="text/javascript"
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
						<c:if test="${dateToPayNextBeers != null}">
							<h2 id="cntdwn">
								<fmt:formatDate value="${dateToPayNextBeers.time}"
									pattern="MM/dd/yyyy hh:mm a" var="dateToPayNextBeer" />
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
						<c:if test="${not empty allNextBeers}">
							<div class="col-lg-12">
								<div class="col-lg-8">
									<div>
										<h3 align="left">Grades a serem pagas</h3>
									</div>
									<div class="table-responsive" style="min-width: 200px;">
										<table class="table">
											<thead>
												<tr>
													<th>Devedor</th>
													<th class="hidden-xs hidden-sm">Data do Registro</th>
													<th class="hidden-xs hidden-sm">Motivo da Grade</th>
													<th>Previsão Pagamento</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${allNextBeers}" var="nextBeer">
													<tr>
														<td>${nextBeer.payer.name}</td>
														<fmt:formatDate value="${nextBeer.date.time}"
															pattern="dd/MM/yyyy" var="date" />
														<td class="hidden-xs hidden-sm">${date}</td>
														<td class="hidden-xs hidden-sm">${nextBeer.motivation}</td>
														<c:choose>
															<c:when test="${not empty nextBeer.dateToPay}">
																<fmt:formatDate value="${nextBeer.dateToPay.time}"
																	pattern="dd/MM/yyyy HH:mm" var="dateToPay" />
																<td>${dateToPay}</td>
															</c:when>
															<c:otherwise>
																<td style="color:red;">Data não definida.</td>
															</c:otherwise>
														</c:choose>
														<td><c:choose>
																<c:when test="${not empty nextBeer.lat}">
																	<a href='javascript:void(0)'
																		class="glyphicon glyphicon-map-marker"
																		title="Mostrar no Mapa"
																		onclick="reloadMap('${nextBeer.lat}','${nextBeer.lng}');"></a>
																</c:when>
															</c:choose></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<div class="col-lg-4" style="border-left: 3px solid #DAE; height: 336px;">
									<h3 align="left">Onde vai ser?</h3>
									<br />
									<div id="map-canvas" style="height: 200px; min-width: 300px"></div>
								</div>
							</div>
						</c:if>
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
		zoom: 14,
		title:"-no futuro, o nome do local aparecerá aqui. Hoje, perdoe, tá faltand2o!"
	});
	markers.push(marker);
	map.setCenter(new google.maps.LatLng(lat, lng));
}
</script>
		<jsp:include page="footer.jsp" />
	</div>
	</div>
</BODY>
</HTML>
