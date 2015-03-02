<html>
<head>
	<theme:layout name="dialog" />
	<title>修改密码</title>
</head>

<body>

	<theme:zone name="title">
		<h1><i class="fa fa-key"></i> 修改密码</h1>
	</theme:zone>
	
	<theme:zone name="body">
		<ui:displayMessage/>
		<ui:form action="updatePassword" method="post">
		<div class="control-group ">
			<label for="oldPassword" class="control-label">当前密码 *</label>
			<div class="controls">
				<input id="oldPassword" class="input-xlarge" required="" name="oldPassword" value="" type="password">
			</div>
		</div>
		<div class="control-group ">
			<label for="newPassword" class="control-label">新密码 *</label>
			<div class="controls">
				<input id="newPassword" class="input-xlarge" required="" name="newPassword" value="" type="password">
			</div>
		</div>
		<div class="control-group ">
			<label for="repeatNewPassword" class="control-label">重复新密码 *</label>
			<div class="controls">
				<input id="repeatNewPassword" class="input-xlarge" required="" name="repeatNewPassword" value="" type="password">
			</div>
		</div>
		<div class="form-actions">
			<button type="submit" class="btn btn btn-large btn-primary btn-null">修改密码</button>
		</div>
		</ui:form>
	</theme:zone>

</body>
</html>