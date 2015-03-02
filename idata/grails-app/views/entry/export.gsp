
<%@ page import="bzu.idata.Entry" %>
<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="dataentry"/>
		<title>${entryInstance?.title}</title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'tblheader.css')}">		
	</head>
	<body>
	
<theme:zone name="title">
	<g:set var="subtitle"><i class="fa fa-cloud-download"></i> 导出数据</g:set>
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
	<div class="row">
		<div class="span11">
	<ui:displayMessage/>
		
		<blockquote>
			<h3>导出数据</h3>
			<p class="text-warning"><strong>注意</strong> 目前仅支持导出全部数据，如需合并汇总，请在导出之后在 Excel 中处理。</p>
		</blockquote>
		
		<ui:form>
			<ui:input type="hidden" name="id" value="${entryInstance?.id}"/>
			<ui:field name="sort" label="排序">
				<ui:fieldInput>
					<g:select name="sort" from="['默认','提交人','提交时间']" keys="['id','submitter','dateCreated']"/>
				</ui:fieldInput>
			</ui:field>
			<ui:field name="order" label="顺序">
				<ui:fieldInput>
					<g:select name="order" from="['升序','降序']" keys="['asc','desc']"/>
				</ui:fieldInput>
			</ui:field>
			<div class="control-group">
				<label class="control-label">附加字段</label>
				<div class="controls">
					<label><input id="extendedFields" name="extendedFields" value="submitter" class="input-xlarge" type="checkbox" checked="checked" > 提交者</label>
					<label><input id="extendedFields" name="extendedFields" value="submitter.department" class="input-xlarge" type="checkbox" checked="checked"> 所在单位代码</label>
					<label><input id="extendedFields" name="extendedFields" value="submitter.department.name" class="input-xlarge" type="checkbox" checked="checked"> 所在单位名称</label>
					<label><input id="extendedFields" name="extendedFields" value="lastUpdated" class="input-xlarge" type="checkbox" checked="checked"> 提交时间</label>
				</div>
			</div>
			<ui:actions>
				<g:actionSubmit class="btn btn-large btn-primary" action="exportExcel" value="导出数据"/>
			</ui:actions>
		</ui:form>

		</div>
</theme:zone>
	</body>
</html>
