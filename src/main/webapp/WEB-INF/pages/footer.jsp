<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel-footer" align="center">
	<sec:authorize access="hasRole('ROLE_NORMAL') or hasRole('ROLE_ADMIN')">
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
			<h5>
				Usuário: ${pageContext.request.userPrincipal.name} | <a
					href="javascript:formSubmit()"> Logout</a>
			</h5>
		</c:if>
	</sec:authorize>
	<font style="color: #111">Copyright @2016 <a
		href="http://proximagrade-equipejr.rhcloud.com/">Equipe Jr.</a>, Todos
		os direitos reservados.
	</font>
	<script type="text/javascript"
		src="webjars/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="webjars/jquery/2.1.1/jquery.min.js"></script>
	
</div>