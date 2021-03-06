<%@ page import="bzu.idata.Entry" %>
<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="dataentry"/>
		<g:set var="entityName" value="${message(code: 'entry.label', default: 'Entry')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
	
<theme:zone name="title">
	<g:set var="subtitle"><i class="fa fa-pencil text-warning"></i> 编辑项目</g:set>
	<g:render template="pageHeader" model="[entryInstance:entryInstance, subtitle:subtitle]" />
</theme:zone>
<theme:zone name="secondary-navigation">
	<ul class="pager pull-left">
		<g:render template="/entry/entry_operations" model="[entryInstance: entryInstance]"></g:render>
		<g:render template="sheets-navigation" model="[entryInstance:entryInstance]"/>
	</ul>
</theme:zone>

<theme:zone name="body">
<span class="clearfix"></span>
<div class="row">
<div class="span11">
	<ui:displayMessage/>
	<g:hasErrors bean="${entryInstance}">
	<ul class="alert alert-error" role="alert">
		<g:eachError bean="${entryInstance}" var="error">
		<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
		</g:eachError>
	</ul>
	</g:hasErrors>

			<ui:form method="post" >
				<g:hiddenField name="id" value="${entryInstance?.id}" />
				<g:hiddenField name="version" value="${entryInstance?.version}" />
				<g:render template="form"/>
				<ui:actions>
					<g:actionSubmit class="btn btn-large btn-primary span2" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<a href="#confirm-delete" class="btn btn-large btn-warning offset1" data-toggle="modal">删除</a>
				</ui:actions>
				
<div id="confirm-delete" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header text-error">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			删除数据采集项目
		</h3>
	</div>
	<div class="modal-body">
		<p class="text-error lead"><span class="fa fa-2x fa-exclamation-triangle"></span> <strong>注意</strong> 删除数据采集项目，会同时删除项目中的所有表单，以及该项目中用户提交的所有数据。删除后无法恢复。</p>
		<blockquote>
		<p class="text-warning"><span class="fa fa-lg fa-exclamation-circle"></span> 建议在删除项目之前导出数据，保留数据，做好备份。</p>
		</blockquote>
	</div>
	<div class="modal-footer footer-info">
		 <g:actionSubmit class="btn btn-large btn-danger" action="delete" value="继续删除项目" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
		 <button class="btn btn-large btn-primary" data-dismiss="modal" aria-hidden="true">取消</button>
	</div>
</div>
			</ui:form>

</div>
</div>
</theme:zone>
	</body>
</html>
