<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<link rel="shortcut icon"
	href="${context}/static/images/cf3e30d6-35e7-4f52-bfd9-f28a938f24d4.jpg">
	

<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${context}/welcome">
				<img src="${context}/static/images/beer.jpg" alt="" height="50" width="60">
			</a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="${context}/welcome">Home</a></li>
				<li><a href="${context}/about">Sobre</a></li>
				<li><a href="${context}/contact">Contato</a></li>
				<li><a href="${context}/newbeer/register" style="color:white">«Ofereça uma grade»</a></li>
			</ul>
			<sec:authorize access="hasRole('ROLE_NORMAL') or hasRole('ROLE_ADMIN')">
				<div align="right">
					<div style="color:white">
						<sec:authorize access="hasRole('ROLE_NORMAL') and !hasRole('ROLE_ADMIN')">
						[ROLE_NORMAL]
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_ADMIN')">
						[ROLE_ADMIN]
						</sec:authorize>
					</div>
					<!-- For login user -->
					<c:url value="/j_spring_security_logout" var="logoutUrl" />
					<form action="${logoutUrl}" method="post" id="logoutForm">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</form>
					<script>
						function formSubmit() {
							document.getElementById("logoutForm").submit();
						}
					</script>
					<c:if test="${pageContext.request.userPrincipal.name != null}">
						<h5 style="color: gray;">
							Usuário: ${pageContext.request.userPrincipal.name} | <a
								href="javascript:formSubmit()"> Logout</a>
						</h5>
					</c:if>
				</div>
			</sec:authorize>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container -->
</nav>