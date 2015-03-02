<%@ page import="bzu.idata.Entry" %>
<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="dialog"/>
		<g:set var="entityName" value="${message(code: 'entry.label', default: 'Entry')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
<theme:zone name="title">
	<h1><i class="fa fa-magic"></i> <g:message code="default.create.label" args="[entityName]" /></h1>
</theme:zone>
<theme:zone name="body">
	<ui:displayMessage/>
	<g:hasErrors bean="${entryInstance}">
	<ul class="alert alert-error" role="alert">
		<g:eachError bean="${entryInstance}" var="error">
		<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
		</g:eachError>
	</ul>
	</g:hasErrors>
	
	<ui:form action="save" method="post">
		<g:render template="form"/>
		<ui:actions>
		<g:submitButton name="create" class="btn btn-large btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
		</ui:actions>
	</ui:form>
</theme:zone>
	</body>
</html>
