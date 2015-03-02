
<%@ page import="bzu.idata.Entry" %>
<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="dataentry"/>
		<g:set var="entityName" value="${message(code: 'entry.label', default: 'Entry')}" />
		<title>${entryInstance?.title}</title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'tblheader.css')}">		
	</head>
	<body>
	
<theme:zone name="title">
	<g:set var="subtitle"><i class="fa fa-newspaper-o"></i> 项目概况</g:set>
	<g:render template="pageHeader" model="[entryInstance:entryInstance, subtitle:subtitle]" />
</theme:zone>
<theme:zone name="secondary-navigation">
	<ul class="pager pull-left">
		<g:render template="/entry/entry_operations" model="[entryInstance: entryInstance]"></g:render>
		<g:render template="/entry/sheets-navigation" model="[entryInstance:entryInstance]"/>
	</ul>

</theme:zone>
<theme:zone name="body">
<span class="clearfix"></span>
	<ui:displayMessage/>
	<div class="row">
		<div class="span11">
		
		<g:render template="intro" bean="entryInstance"></g:render>

		</div>
</theme:zone>
	</body>
</html>
