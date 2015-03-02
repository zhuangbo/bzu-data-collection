<%@ page import="bzu.security.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" maxlength="20" required="" value="${userInstance?.username}"/>
</div>

<g:if test="${actionName in ['create','save'] || userInstance?.username==sec.username().toString()}">
<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:passwordField name="password" maxlength="80" required="" value="${userInstance?.password}"/>
</div>
</g:if>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'realName', 'error')} required">
	<label for="realName">
		<g:message code="user.realName.label" default="Real Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="realName" maxlength="20" required="" value="${userInstance?.realName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'department', 'error')} required">
	<label for="department">
		<g:message code="user.department.label" default="Department" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="department" from="${grailsApplication.config.app.departments + (actionName=='create'?[]:['00'])}" noSelection="['':'--请选择--']" required="" value="${userInstance?.department}" valueMessagePrefix="department"/>
</div>

<div>
<h3>账号管理</h3>
<hr />
<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
		
	</label>
	<g:checkBox name="enabled" value="${userInstance?.enabled}" /> <label for="enabled" style="color:blue; text-align:left;">选中使账号激活，允许登录</label>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountExpired', 'error')} ">
	<label for="accountExpired">
		<g:message code="user.accountExpired.label" default="Account Expired" />
		
	</label>
	<g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" /> <label for="accountExpired" style="color:red; text-align:left;">选中使账号过期，不能登录</label>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountLocked', 'error')} ">
	<label for="accountLocked">
		<g:message code="user.accountLocked.label" default="Account Locked" />
		
	</label>
	<g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" /> <label for="accountLocked" style="color:red; text-align:left;">选中使账号锁定，不能登录</label>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')} ">
	<label for="passwordExpired">
		<g:message code="user.passwordExpired.label" default="Password Expired" />
		
	</label>
	<g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" /> <label for="passwordExpired" style="color:red; text-align:left;">选中使密码过期，不能登录</label>
</div>
</div>

<div>
<h3>权限管理</h3>
<hr />
<div class="fieldcontain">
	<label for="ROLE_USER"><g:message code="role.ROLE_USER" default="用户" />权限</label>
	<g:checkBox name="ROLE_USER" value="${ROLE_USER}" /> <label for="ROLE_USER" style="color:blue; text-align:left; width:60%;">分配用户权限，允许提交数据</label>
</div>
<div class="fieldcontain">
	<label for="ROLE_POST"><g:message code="role.ROLE_POST" default="发布" />权限</label>
	<g:checkBox name="ROLE_POST" value="${ROLE_POST}" /> <label for="ROLE_POST" style="color:blue; text-align:left; width:60%;">分配发布权限，允许发布数据采集</label>
</div>
<div class="fieldcontain">
	<label for="ROLE_ADMIN"><g:message code="role.ROLE_ADMIN" default="管理" />权限</label>
	<g:checkBox name="ROLE_ADMIN" value="${ROLE_ADMIN}" /> <label for="ROLE_ADMIN" style="color:blue; text-align:left; width:60%;">分配管理权限，允许管理用户</label>
</div>

</div>