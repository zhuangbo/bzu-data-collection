
<%@ page import="bzu.idata.Entry" %>
<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="report"/>
		<g:set var="entityName" value="${message(code: 'entry.label', default: 'Entry')}" />
		<title>数据采集项目</title>
	</head>
	<body>

<theme:zone name="title">
	<h1><i class="fa fa-th-list"></i> 数据采集项目</h1>
</theme:zone>
<theme:zone name="secondary-navigation">
	<sec:ifAnyGranted roles="ROLE_POST">
	<ul class="pager pull-left">
		<!-- 新建项目 -->
		<li>
			<g:link controller="entry" action="create"><span class="fa fa-lg fa-magic text-warning"></span> 新建项目</g:link>
		</li>
	</ul>
	</sec:ifAnyGranted>
</theme:zone>
<theme:zone name="body">
<span class="clearfix"></span>
	<ui:displayMessage/>
	<ui:table>
		<thead>
			<tr>
				<g:sortableColumn property="title" title="${message(code: 'entry.title.label', default: 'Title')}" />
				<th><g:message code="entry.author.label" default="Author" /></th>
				<th><g:message code="entry.visibility.label" default="Visibility"/></th>
				<g:sortableColumn property="startTime" title="${message(code: 'entry.startTime.label', default: 'Start Time')}" />
				<g:sortableColumn property="endTime" title="${message(code: 'entry.endTime.label', default: 'End Time')}" />
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${entryInstanceList}" status="i" var="entryInstance">
			<tr>
				<td><g:link action="show" id="${entryInstance.id}">${fieldValue(bean: entryInstance, field: "title")}</g:link></td>
				<td>${entryInstance.author.realName}</td>
				<td>
				${entryInstance.visibility==Entry.VISIBILITY_ALL?'任何人':''}
				${entryInstance.visibility==Entry.VISIBILITY_DEPARTMENT?g.message(code:'department.'+entryInstance.department):''}
				${entryInstance.visibility==Entry.VISIBILITY_USERNAME?'指定用户':''}
				</td>
				<td title="${entryInstance.startTime.format('yyyy-MM-dd HH:mm')}"><prettytime:display date="${entryInstance.startTime}"/></td>
				<td title="${entryInstance.endTime.format('yyyy-MM-dd HH:mm')}"><prettytime:display date="${entryInstance.endTime}" format="HH:mm" showTime="true"/></td>
				<td>${entryInstance.status}</td>
			</tr>
		</g:each>
		</tbody>
	</ui:table>
</theme:zone>
<theme:zone name="pagination">
	<center>
	<ui:paginate total="${entryInstanceTotal}" params="${params}"/>
	</center>
</theme:zone>
	</body>
</html>
