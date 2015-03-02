<%@ page import="bzu.idata.Sheet" %>
<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="dataentry"/>
		<g:set var="entityName" value="${message(code: 'sheet.label', default: 'Sheet')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
<theme:zone name="title">
	<g:set var="subtitle"><span class="fa-plus-square text-warning"></span> 添加表单</g:set>
	<g:render template="/entry/pageHeader" model="[entryInstance:sheetInstance.entry, subtitle:subtitle]" />
</theme:zone>
<theme:zone name="secondary-navigation">
	<ul class="pager pull-left">
		<g:render template="/entry/entry_operations" model="[entryInstance: sheetInstance.entry]"></g:render>
		<g:render template="/entry/sheets-navigation" model="[entryInstance: sheetInstance.entry]"/>
	</ul>

</theme:zone>

<theme:zone name="body">
<span class="clearfix"></span>
<div class="row">
	<div class="span11">
	<ui:displayMessage/>
	<g:hasErrors bean="${sheetInstance}">
	<ul class="alert alert-error" role="alert">
		<g:eachError bean="${sheetInstance}" var="error">
		<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
		</g:eachError>
	</ul>
	</g:hasErrors>
	
	<ui:form action="save" >
		<g:render template="form"/>
		<ui:actions>
			<g:submitButton name="create" class="btn btn-large btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
		</ui:actions>
	</ui:form>
	</div>
</div>
</theme:zone>
	</body>
</html>
