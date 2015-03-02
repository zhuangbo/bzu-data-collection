<%@ page import="bzu.idata.Sheet" %>

<ui:fieldGroup>

<input type="hidden" name="entry.id" value="${sheetInstance?.entry?.id}">

<div class="control-group">
	<label for="name" class="control-label"><g:message code="sheet.name.label" default="Name" /> *</label>
	<div class="controls">
		<input type="text" name="name" value="${sheetInstance?.name}" required="" class="span6">
		<g:eachError bean="${sheetInstance}" field="name">
		<ul class="alert alert-error"><li><g:message error="${it}"/></li></ul>
		</g:eachError>
		<a href="#" id="detail" class="btn" title="显示/隐藏更多描述">更多描述 &gt;&gt;</a>
	</div>
</div>

<div id="divDetail" class="hide">
<div class="control-group">
	<label for="description" class="control-label"><g:message code="sheet.description.label" default="Description" /></label>
	<div class="controls">
		<g:textArea name="description" class="span6" rows="3" maxlength="250" value="${sheetInstance?.description}" placeHolder="表单说明（250字以内，可选的）"/>
	</div>
</div>

<div class="control-group">
	<label for="remarks" class="control-label"><g:message code="sheet.remarks.label" default="Remarks" /></label>
	<div class="controls">
		<g:textArea name="remarks" class="span6" rows="2" maxlength="250" value="${sheetInstance?.remarks}" placeHolder="注意事项（250字以内，可选的）"/>
	</div>
</div>
</div>
<jq:jquery>
var divDetail = $("#divDetail");
$("#detail").click(function(){
		divDetail.toggle('slow');
		return false;
	});
</jq:jquery>

<div class="control-group">
	<label for="tableHeader" class="control-label"><g:message code="sheet.tableHeader.label" default="Table Header" /> *</label>
	<style type="text/css">.table-header {width:100%; height:180px; border:1px solid #ccc;}</style>
	<div class="controls">
		<p class="alert alert-success">请从 Excel 中复制表头，粘贴在下面，系统将保留表头的基本格式。</p>
		<g:textArea id="tableHeader" name="tableHeader" required="" class="table-header" maxlength="65535" value="${sheetInstance?.tableHeader}"/>
		<g:hasErrors bean="${sheetInstance}" field="tableHeader">
		<ul class="alert alert-error"><li>请填写表头。</li></ul>
		</g:hasErrors>
	</div>
</div>
<script type="text/javascript" src="${resource(dir:'js/ret',file:'jquery.ret.js')}"></script>
<script type="text/javascript">
    $('#tableHeader').rte("${resource(dir:'css',file:'tblheader.css')}");
</script>

<div class="control-group">
	<label for="rowMax" class="control-label"><g:message code="sheet.rowMax.label" default="Row Max" /> *</label>
	<div class="controls">
		<g:field name="rowMax" type="number" min="0" max="10000" value="${sheetInstance.rowMax}" required=""/>
		<g:hasErrors bean="${sheetInstance}" field="rowMax">
		<ul class="alert alert-error"><li>请填写不小于零的数字。</li></ul>
		</g:hasErrors>
	</div>
</div>
</ui:fieldGroup>
