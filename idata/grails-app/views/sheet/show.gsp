<%@page import="bzu.idata.Entry"%>
<%@ page import="bzu.idata.Sheet" %>
<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="dataentry"/>
		<g:set var="entityName" value="${message(code: 'sheet.label', default: 'Sheet')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'tblheader.css')}">
		<style type="text/css"> #datum table {margin-left: auto; margin-right: auto;} </style>
	</head>
	<body>
<theme:zone name="title">
	<g:set var="subtitle"><span class="fa fa-table"></span> ${sheetInstance.name}</g:set>
	<g:render template="/entry/pageHeader" model="[entryInstance:sheetInstance.entry, subtitle:subtitle]"/>
</theme:zone>
<theme:zone name="secondary-navigation">
	<ul class="pager pull-left">
		<g:render template="/entry/entry_operations" model="[entryInstance: sheetInstance.entry]"></g:render>
		<g:render template="/entry/sheets-navigation" model="[entryInstance:sheetInstance.entry, currentSheet:sheetInstance]"/>
	</ul>
</theme:zone>
<theme:zone name="body">
<span class="clearfix"></span>
<div class="row-fluid">
	<div class="span11">
	<ui:displayMessage/>

	<g:render template="intro" bean="sheetInstance"/>
	
<g:form method="post">

	<div id="datum" style="overflow:auto; text-align: center;">
	<style type="text/css"> tr.tbl-header { font-weight:bold; color: #08C; } </style>
		<!-- 表头 -->
		${sheetInstance.tableHeader.replaceAll(/<tbody>|<\/tbody>|<\/table>/, '').replaceAll('<tr','<tr class="tbl-header"')}
		<!-- 表格数据 -->
		<g:each in="${dataList}" var="d">
			${d.text.startsWith('<tr><td') ? d.text.find('<tr><td.*?>') : '<tr><td>'}
			<!-- 对当前用户提交数据显示删除标识 -->
			<idata:ifSubmitter data="${d}">
				<g:if test="${sheetInstance.entry.status==Entry.STATUS_OK}">
					<g:set var="checkbox"><g:checkBox name="ids" value="${d.id}" checked="${false}" class="ids pull-left" title="选择"/></g:set>
				</g:if>
				<g:else>
					<g:set var="checkbox"><span class="fa fa-square-o pull-left text-warning" title="${sheetInstance.entry.status} 不能删除"></span></g:set>
				</g:else>
				${checkbox}
			</idata:ifSubmitter>
			<!-- 数据内容 -->
			${d.text.startsWith('<tr><td') ? d.text.replaceFirst('<tr><td.*?>', '') : d.text.replaceAll('\t','</td><td>')+'</td></tr>'}
		</g:each>
		<!-- 表尾 -->
		${"</table>"}
	</div>
		<ui:paginate class=" pagination-centered" action="show" id="${sheetInstance.id}" total="${dataCount}"/>

<g:if test="${sheetInstance.entry.status==Entry.STATUS_OK}">
<jq:jquery>
	$('.ids').click(function(){
		if($(this).attr('checked')=='checked') {
			$(this).parent().parent().addClass('text-error')
		} else {
			$(this).parent().parent().removeClass('text-error')
		}
	});
	$('td').first().prepend( '<input type="checkbox" id="checkAll" name="checkAll" value="0" class="pull-left" title="全选/取消"/>' );
	$('#checkAll').click(function(){
		if($(this).attr('checked')=='checked') {
			$('.ids').attr('checked', 'checked').parent().parent().addClass('text-error');
		} else {
			$('.ids').removeAttr('checked').parent().parent().removeClass('text-error');
		}
	});
</jq:jquery>
</g:if>
	
	<hr/>
	
<g:if test="${sheetInstance.entry.status==Entry.STATUS_OK}">
	<div id="submit-datum" name="submit-datum">
		<g:hiddenField name="id" value="${sheetInstance?.id}" />
		
		<style type="text/css">.frameCss {width:100%; height:120px; border:1px solid #f66;}</style>
		<p class="alert alert-success">请从 Excel 中复制数据，粘贴在下面，然后提交。</p>
		<textarea id="text" name="text" class="frameCss" rows="5" ></textarea>
		<script type="text/javascript" src="${resource(dir:'js/ret',file:'jquery.ret.js')}"></script>
		<script type="text/javascript">
		    $('#text').rte("${resource(dir:'css',file:'tblheader.css')}");
		</script>

		<g:if test="${sheetInstance?.rowMax}">
		<p class="alert alert-error"><strong><span class="fa fa-exclamation-triangle text-error"></span> 限制</strong> 本表限制每个用户至多提交 ${sheetInstance?.rowMax} 条数据。</p>
		</g:if>
		
		<div class="form-actions">
			<g:actionSubmit value="提交数据" action="submitDatum" class="btn btn-large btn-primary"/>
			<a href="#confirm-delete" class="btn btn-large btn-warning offset1" data-toggle="modal">删除数据</a>
		</div>
	</div>
</g:if>
<g:else>
	<p class="alert alert-error"><span class="fa fa-exclamation-circle"></span> 此项目${sheetInstance.entry.status}，不再接受提交数据。</p>
</g:else>

<div id="confirm-delete" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header text-error">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			删除数据
		</h3>
	</div>
	<div class="modal-body">
		<p class="text-error lead"><span class="fa fa-2x fa-exclamation-triangle"></span> 您确定要删除选定的数据吗？</p>
	</div>
	<div class="modal-footer footer-info">
		<g:hiddenField name="ids" value="0"/>
		<g:hiddenField name="mask" value="${session.DATADELMSK}"/>
		<g:actionSubmit class="btn btn-large btn-danger" action="deleteDatum" value="继续删除数据" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
		<button class="btn btn-large btn-primary" data-dismiss="modal" aria-hidden="true">取消</button>
	</div>
</div>

</g:form>

	</div>
</div>
</theme:zone>
	</body>
</html>
