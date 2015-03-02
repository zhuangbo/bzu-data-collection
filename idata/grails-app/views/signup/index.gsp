<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<theme:layout name="dialog"/>
	<title>注册</title>
</head>
<body>

	<theme:zone name="title">
		<h1><i class="fa fa-edit"></i> 注册</h1>
	</theme:zone>
	<theme:zone name="body">
		<g:form action="signup" method="post" class="form-horizontal">
			
		<ui:displayMessage/>

			<div class="control-group">
				 <label class="control-label" for="username">用户名:</label>
				<div class="controls">
					<input type="text" name="username" id="username" value="${userInstance.username}" required  placeholder="您的教师号（或学号）" title="填写您的教师号（或学号）"/>
				</div>
			</div>

			<div class="control-group">
				 <label class="control-label" for="password">密码:</label>
				<div class="controls">
					<input type="password" name="password" id="password" value="${userInstance.password}" required placeholder="您的校内门户密码" title="填写您的校内门户密码"/>
				</div>
			</div>

			<div class="control-group">
				 <label class="control-label" for="realName">姓名:</label>
				<div class="controls">
					<input type="text" name="realName" id="realName" value="${userInstance.realName}" required  placeholder="您的真实姓名" title="填写您的真实姓名"/>
				</div>
			</div>

			<div class="control-group">
				 <label class="control-label" for="department">系院:</label>
				<div class="controls">
					<g:select name="department" from="${grailsApplication.config.app.departments}" noSelection="['':'--请选择--']" required="" value="${userInstance?.department}" valueMessagePrefix="department" title="选择您所在单位"/>
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<input type="submit" class="btn btn-large btn-primary span2" value="注册"/>
				</div>
			</div>
		</g:form>
<jq:jquery>
$('#username').focus();
</jq:jquery>
	</theme:zone>
</body>
</html>
