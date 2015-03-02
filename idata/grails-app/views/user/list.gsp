<%@ page import="bzu.security.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li style="float:right">
					<g:form action="list" method="get" style="display:inline;">
					<g:textField name="q" value="${params.q}"/>
					<input type="submit" value="查询"></input>
					</g:form>
				</li>
			</ul>
		</div>
		<div id="list-user" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" />
						<g:sortableColumn property="realName" title="${message(code: 'user.realName.label', default: 'Real Name')}" />
						<g:sortableColumn property="department" title="${message(code: 'user.department.label', default: 'Department')}" />
						<th>状态</th>
						<th>权限</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${userInstanceList}" status="i" var="userInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
						<td>${fieldValue(bean: userInstance, field: "realName")}</td>
						<td><g:message code="department.${userInstance.department}"/></td>
						<td>${userInstance.accountExpired ? '过期' : userInstance.accountLocked ? '锁定' : userInstance?.passwordExpired ? '过期' : ! userInstance.enabled ? '停用' : '正常'}</td>
						<td>${userInstance.authorities.collect{[ROLE_USER:'用户',ROLE_POST:'发布',ROLE_ADMIN:'管理'][it.authority]}}</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${userInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
