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
<script type="text/javascript" src="${context}/static/js/jquery.js"></script>
<script type="text/javascript" src="${context}/static/js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript" src="${context}/static/js/bootstrap.min.js"></script>
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCI_bhav_kkwMeVjmacrrNLf2Wc8FT8VT8&callback=initMap">
</script>

<sec:authorize access="hasRole('ROLE_ADMIN')">
<script>
jQuery(function() {
	$( "#datepicker").datetimepicker({
		inline: true,
		format:'d/m/Y H:i',
		minDate: new Date()
	});
});
</script>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_NORMAL') and !hasRole('ROLE_ADMIN')">

<script>
jQuery(function() {
	$( "#datepicker").datetimepicker({
		inline: true,
		format:'d/m/Y H:i',
		minDate: new Date(),
		value: new Date()
	});
});
</script>
</sec:authorize>

<TITLE>Nova Grade</TITLE>
</HEAD>
<BODY>
	<div class="container-fluid">
		<div>
			<jsp:include page="header.jsp" />
			<div class="panel-body" align="center">
				<div class="container " style="margin-top: 10%; margin-bottom: 10%; min-width: 200px;">
					<sec:authorize access="hasRole('ROLE_NORMAL') or hasRole('ROLE_ADMIN')">
						
						<form name="newbeer" action="save" method='POST' class="form">
							<div class="col-lg-6">
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<label for="user">Usuário</label> 
									<select class="form-control" name="user" >
										<option value="Selecione um usuário"> Selecione um usuário </option>
										<c:forEach items="${names}" var="email">
											<option value="${email}">${email}</option>
										</c:forEach>
									</select>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_NORMAL') and !hasRole('ROLE_ADMIN')">
									<label for="user">Usuário</label> 
									<select class="form-control" name="user">
										<option id="user" value="${name}">${name}</option>
									</select>
								</sec:authorize>
								<div>
									<label for="reasonIn">Motivo da Grade</label> 
									<textarea class="form-control" name="reason" id="reasonIn"></textarea>
								</div>
								<div>
									<label class="col-lg-12" for="datepicker">Previsão de Data</label> 
									<input class="col-lg-12" id="datepicker" type="text" name="dateToPay" >
								</div>
							</div>
							<div class="col-lg-6">
								<label>Selecione o local da grade</label> 
								<div id="map-canvas" style="height: 300px; min-width: 200px"></div>
								<input type="hidden" name="lat" id="lat">
								<input type="hidden" name="lng" id="lng">
							</div>
							<div class="col-lg-12">
							<hr />
								<button type="submit" class="btn btn-success btn-group-lg" >Salvar</button>
								<a href="${context}/welcome" class="btn btn-danger" >Cancelar</a>
							</div>
						</form>
					</sec:authorize>
				</div>
			</div>
			<jsp:include page="footer.jsp" />
		</div>
	</div>
<script>
var map;
function initialize() {
	var markers = [];
	var mapOptions = {
		zoom: 18,
		center: new google.maps.LatLng( -3.79096804186333,-38.50090965628624)
	};
	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	var marker = new google.maps.Marker({
		position: new google.maps.LatLng(-3.79096804186333,-38.50090965628624), 
		map: map, 
		title:"Casa do Seu Marcos!"
	});
	jQuery('#lat').val(-3.79096804186333);
	jQuery('#lng').val(-38.50090965628624);
	markers.push(marker);
  /*  marker.addListener('click', function() {
	  console.log("yahoo");
	    map.setZoom(8);
	    map.setCenter(marker.getPosition());
	  });*/
	map.addListener('click', function(event) {
		setMapOnAll(null);
		var marker = new google.maps.Marker({
			
			position: new google.maps.LatLng(event.latLng.lat(), event.latLng.lng()), 
			map: map, 
			title:"Próxima Grade!"
		}); 
		markers.push(marker);
		jQuery('#lat').val(event.latLng.lat());
		jQuery('#lng').val(event.latLng.lng());
	});
	function setMapOnAll(map) {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(map);
		}
	}
}

google.maps.event.addDomListener(window, 'load', initialize);
</script>
</BODY>
</HTML>
