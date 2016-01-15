<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<head>
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
<link rel='stylesheet'
	href='webjars/bootstrap/3.2.0/css/bootstrap.min.css'>
<title>Login Page</title>
</head>
<body onload='document.loginForm.username.focus();'>
<jsp:include page="header.jsp" />
	<div class="panel-body" align="center">
		<div class="container " style="margin-top: 10%; margin-bottom: 10%;">
			<div class="panel panel-default" style="max-width: 35%;" align="left">
				<div class="panel-heading form-group">
					<b><font color="#333">Login Form</font> </b>
				</div>
				<div class="panel-body">
					<c:if test="${not empty error}">
						<div class="alert alert-danger">
							${error}
							${sessionScope.SPRING_SECURITY_LAST_EXCEPTION.message}
						</div>
					</c:if>
					<c:if test="${not empty msg}">
						<div class="alert alert-info">
							${msg}
						</div>
					</c:if>
					<form name="loginForm" action="<c:url value='/j_spring_security_check' />" method='POST'>
						<div class="form-group">
							<label for="inputEmail1">E-mail</label> 
							<input type="text" class="form-control" name="username"
								id="inputEmail1" placeholder="Digite seu e-mail"
								required="required">
						</div>
						<div class="form-group">
							<label for="txtPass">Senha</label> <input
								type="password" class="form-control" name="password"
								id="txtPass" placeholder="Senha" required="required">
						</div>
						<button type="submit" style="width: 100%; font-size: 1.1em;"
							class="btn btn-large btn btn-default btn-lg btn-block">
							<b>Login</b>
						</button>
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</form>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="footer.jsp" />
</body>
</html>