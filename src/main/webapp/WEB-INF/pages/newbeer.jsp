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
<link rel='stylesheet' href='${context}/static/css/bootstrap.min.css'>
<link rel='stylesheet' href='${context}/static/css/jquery.datetimepicker.css'>
<script type="text/javascript" src="${context}/static/js/jquery.js"></script>
<script type="text/javascript" src="${context}/static/js/jquery.datetimepicker.full.js"></script>
<script type="text/javascript" src="${context}/static/js/bootstrap.min.js"></script>
<script>
jQuery(function() {
	$( "#datepicker").datetimepicker({
		inline: true,
		format:'d/m/Y H:i',
		minDate: new Date()
	});
});
</script>
<TITLE>Nova Grade</TITLE>
</HEAD>
<BODY>
	<div class="container-fluid">
		<div>
			<jsp:include page="header.jsp" />
			<div class="panel-body" align="center">
				<div class="container " style="margin-top: 10%; margin-bottom: 10%; max-width: 360px; min-width: 200px;">
					<sec:authorize access="hasRole('ROLE_NORMAL') or hasRole('ROLE_ADMIN')">
						
						<form name="newbeer" action="save" method='POST' class="form">
							<c:choose>
								<c:when test="hasRole('ROLE_ADMIN')">
									Seleciona usu�rio pagador!
								</c:when>
								<c:otherwise>
								<label for="user">Usu�rio</label> 
								<select class="form-control" name="user">
									<option id="user" value="${name}">${name}</option>
								</select>
								</c:otherwise>
							</c:choose>
							<div>
								<label for="reasonIn">Motivo da Grade</label> 
								<textarea class="form-control" name="reason" id="reasonIn"></textarea>
							</div>
							<div>
								<input id="datepicker" type="text" name="dateToPay">
							</div>
							<div>
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
</BODY>
</HTML>