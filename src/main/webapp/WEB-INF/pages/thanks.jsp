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
<META http-equiv="refresh" content="5;URL=${context}/welcome">
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
	<link rel='stylesheet' href='${context}/static/css/bootstrap.min.css'>
	<script type="text/javascript" src="${context}/static/js/jquery.js" ></script>
	<script type="text/javascript" src="${context}/static/js/bootstrap.min.js"></script>
<TITLE>Obrigado!</TITLE>
<script type="text/javascript">
function startTimer(duration, display) {
    var timer = duration, minutes, seconds;
    setInterval(function () {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.text(minutes + ":" + seconds);

        jQuery('#seconds').html(timer);
        if (--timer < 0) {
            timer = duration;
        }
    }, 1000);
}

jQuery(function ($) {
    var fiveSeconds = 5,
    	display = $('#time');
    startTimer(fiveSeconds, display);
});
</script>
</HEAD>
<BODY>
	<div class="container-fluid">
		<div>
			<jsp:include page="header.jsp" />
			<div class="panel-body" align="center">
				<div class="container " style="margin-top: 10%; margin-bottom: 10%;">
					<sec:authorize
						access="hasRole('ROLE_NORMAL') or hasRole('ROLE_ADMIN')">
						<h2>Equipe Jr. agradece seu empenho e proatividade!</h2>
						<h4>Redirecionando para página principal em <b id="seconds"></b> segundos!</h4>
					</sec:authorize>
				</div>
			</div>
			<jsp:include page="footer.jsp" />
		</div>
	</div>
</BODY>
</HTML>
