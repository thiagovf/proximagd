<!-- 
Mostra detalhes da grade registrada possibilitando que seja adicionado os 
participantes e salve-a como grade-paga, podendo mudar a hora que foi paga.
-->
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
	<script type="text/javascript" src="${context}/static/js/jquery.js" ></script>
	<script type="text/javascript" src="${context}/static/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCI_bhav_kkwMeVjmacrrNLf2Wc8FT8VT8"></script>
<TITLE>${oldBeer.payer.name}-${oldBeer.motivation}</TITLE>
</HEAD>
<BODY>
	<div class="container-fluid">
	<div>
		<jsp:include page="header.jsp" />
		<div class="panel-body" align="center">
				<div class="container " style="margin-top: 10%; margin-bottom: 10%;">
				<div class="row">
					<div class="col-xs-5 col-sm-8">
						<div class="col-xs-12 text-left">
							<label>Pagador:</label> 
							${oldBeer.payer.name}
						</div>
						<div class="col-xs-12 text-left">
							<label>Motivo da Grade:</label> 
							${oldBeer.motivation}
						</div>
						<div class="col-xs-7 text-left">
							<c:choose>
							<c:when test="${not empty oldBeer.dateToPay}">
								<label>Data do pagamento:</label> 
								<fmt:formatDate value="${oldBeer.dateToPay.time}" pattern="dd/MM/yyyy HH:mm" var="dateToPay" />
								${dateToPay}
							</c:when>
							<c:otherwise>grade não tem data definida.</c:otherwise>
							</c:choose>
						</div>
						<div class="col-xs-12 text-left">
							<label>Onde foi:</label> 
							<br />
							<div id="map-canvas" style="height: 200px; min-width: 300px"></div>
						</div>
					</div>
					<div class="col-xs-7 col-sm-4 text-left">
						<label class="col-xs-12 col-sm-12 text-left">Quem foi:</label> 
						<c:forEach items="${oldBeer.werePresent}" var="user">
							${user.name};
						</c:forEach>
					</div>
				</div>
				</div>
			<jsp:include page="footer.jsp" />
		</div>
	</div>
	</div>
<script>
var map;
var markers = [];
function initialize() {
	var mapOptions = {
		zoom: 18,
		center: new google.maps.LatLng( ${oldBeer.lat},${oldBeer.lng})
	};
	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	var marker = new google.maps.Marker({
		position: new google.maps.LatLng(${oldBeer.lat},${oldBeer.lng}), 
		map: map,
		zoom: 18,
		title:"-no futuro, o nome do local aparecerá aqui. Hoje, perdoe, tá faltando!"
	});
}
google.maps.event.addDomListener(window, 'load', initialize);
function reloadMap(lat, lng) {
	setMapOnAll(null);
	var marker = new google.maps.Marker({
		position: new google.maps.LatLng(lat,lng), 
		map: map,
		zoom: 18,
		title:"-no futuro, o nome do local aparecerá aqui. Hoje, perdoe, tá faltando!"
	});
	markers.push(marker);
	map.setCenter(new google.maps.LatLng(lat, lng));
}
</script>
</BODY>
</HTML>
