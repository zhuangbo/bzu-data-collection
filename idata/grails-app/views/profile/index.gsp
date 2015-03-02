<html>
<head>
	<theme:layout name="dialog" />
	<title>用户信息</title>
</head>

<body>

	<theme:zone name="title">
		<h1><i class="fa fa-user"></i> 用户信息 <small>${user.toString()}</small></h1>
	</theme:zone>
	
	<theme:zone name="body">
	<ui:displayMessage/>
	<div class="lead">
		<table>
			<tr>
				<td class="span2">用户名</td>
				<td class="span4 text-success">${user.username}</td>
			</tr>
			<tr>
				<td class="span2">姓名</td>
				<td class="span4 text-success">${user.realName}</td>
			</tr>
			<tr>
				<td class="span2">单位</td>
				<td class="span4 text-success"><g:message code="department.${user.department}"/></td>
			</tr>
			<tr>
				<td class="span2">权限</td>
				<td class="span4 text-success">${user.authorities.collect{[ROLE_USER:'用户',ROLE_POST:'发布',ROLE_ADMIN:'管理'][it.authority]}}</td>
			</tr>
		</table>
	</div>
	<ui:form>
	<ui:actions>
		<g:link class="btn btn-large" action="changePassword">修改密码</g:link>
		<g:link class="btn btn-large btn-warning" controller="logout">安全退出</g:link>
	</ui:actions>
	</ui:form>
	</theme:zone>

</body>
</html>
