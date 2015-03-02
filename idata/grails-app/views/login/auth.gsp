<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<theme:layout name="dialog" />
<title>登录</title>
</head>
<body>
	<theme:zone name="title">
		<h1><i class="fa fa-lock"></i> 登录</h1>
	</theme:zone>
	<theme:zone name="body">
		<ui:form action="${postUrl}" method="POST" autocomplete="off">
			<ui:displayMessage/>
			
				<div class="control-group">
					 <label class="control-label" for="j_username"><g:message code="springSecurity.login.username.label"/>:</label>
					<div class="controls">
						<input type="text" name="j_username" id="j_username" required />
					</div>
				</div>
				<div class="control-group">
					 <label class="control-label" for="j_password"><g:message code="springSecurity.login.password.label"/>:</label>
					<div class="controls">
						<input type="password" name="j_password" id="j_password" required/>
					</div>
				</div>
			
				<div class="control-group">
					<div class="controls">
						 <label for="remember_me" class="checkbox"><input type="checkbox" class="chk" name="${rememberMeParameter}" id="remember_me" <g:if test="${hasCookie}">checked="checked"</g:if>/> <g:message code="springSecurity.login.remember.me.label"/></label>
						 <br />
						<input class="btn btn-large btn-primary span2" type="submit" id="submit" value="${message(code: "springSecurity.login.button")}"/>
					</div>
				</div>
		</ui:form>
<jq:jquery>
$('#j_username').focus();
</jq:jquery>
	</theme:zone>
</body>
</html>
