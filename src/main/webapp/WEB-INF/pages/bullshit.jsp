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
	src="${context}/static/js/bootstrap.min.js"></script>
<TITLE>Lista de Eunucos</TITLE>
</HEAD>
<BODY>
	<div class="container-fluid">
		<div>
			<jsp:include page="header.jsp" />
			<div class="panel-body" align="center">
				<div class="container " style="margin-top: 10%; margin-bottom: 10%;">
					<div class="col-xs-12 col-lg-12">
						<div class="col-lg-8">
							<div>
								<h3 align="left">Galera que nunca nem prometeu grade.</h3>
								<h4>Lamentável</h4>
							</div>
							<div class="table-responsive" style="min-width: 100px;">
								<table class="table">
									<thead>
										<tr>
											<th>Lista de Eunucos</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${allNeverPromised}" var="neverPromised">
											<tr>
												<td>${neverPromised}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="footer.jsp" />
		</div>
	</div>
</BODY>
</HTML>
