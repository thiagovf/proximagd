<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
<link rel='stylesheet'
	href='webjars/bootstrap/3.2.0/css/bootstrap.min.css'>

<TITLE>Login</TITLE>
</HEAD>
<BODY>
	<div class="container-fluid">
		<div>
			<jsp:include page="header.jsp" />
			<div class="panel-body" align="center">
				<div class="container " style="margin-top: 10%; margin-bottom: 10%;">
					<div class="panel panel-success" style="max-width: 35%;" align="left">
						<div class="panel-heading form-group">
							<b><font color="white">Login Form</font> </b>
						</div>
						<div class="panel-body">
							<form action="home" method="post">
								<div class="form-group">
									<label for="inputEmail1">E-mail</label> 
									<input type="text" class="form-control" name="txtUserName"
										id="inputEmail1" placeholder="Digite seu e-mail"
										required="required">
								</div>
								<div class="form-group">
									<label for="txtPass">Senha</label> <input
										type="password" class="form-control" name="txtPass"
										id="txtPass" placeholder="Senha" required="required">
								</div>
								<button type="submit" style="width: 100%; font-size: 1.1em;"
									class="btn btn-large btn btn-success btn-lg btn-block">
									<b>Login</b>
								</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="footer.jsp" />
		</div>
	</div>
</BODY>
</HTML>