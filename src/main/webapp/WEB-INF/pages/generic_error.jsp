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
<title>Sorry, it's my fault!</title>
</HEAD>
<BODY>
	<div class="container-fluid">
		<div>
			<jsp:include page="header.jsp" />
			<div class="panel-body" align="center">
				<div class="container " style="margin-top: 10%; margin-bottom: 10%;">
					<img alt="fail" src="${context}/static/images/564817.png" height="40px" width="40px">
					Desculpe-nos. Ocorreu um erro. 
					<p>Entre em contato com um administrador, caso não consiga realizar a operação.</p>
				</div>
			</div>
			<jsp:include page="footer.jsp" />
		</div>
	</div>
</BODY>
</HTML>