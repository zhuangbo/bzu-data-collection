<%@page import="bzu.idata.Entry"%>
<g:set var="copyTableHeader"><style type="text/css">td{text-align:center;vertical-align:middle;}</style>${currentSheet?.tableHeader?.replace('<table','<table border="1" cellspacing="0" cellpadding="0"')}</g:set>
	<g:set var="curId" value="${currentSheet?.id}"/>
	<g:each in="${entryInstance.sheets}">
		<g:if test="${curId==it.id}">
			<li class="active" title="当前表单">
	<g:if test="${actionName=='show'}">
				<span class="text-success">
				<g:if test="${params.dq}"><g:link controller="sheet" action="show" id="${it.id}"><span class="fa fa-lg fa-table muted"></span> ${it.name}</g:link></g:if>
				<g:else><span class="fa fa-lg fa-table"></span> ${it.name}</g:else>
				<g:if test="${dataTotal}"><span class="text-warning" title="记录数">(<g:if test="${dataCount}">${dataCount}/</g:if>${dataTotal})</span></g:if>
					<!-- 复制表头 -->
					<button id="copytableheader" class="zclip btn btn-mini" data-zclip-text="${copyTableHeader.encodeAsHTML()}" title="复制表头到剪贴板，可粘贴到Excel中 ：）"><span class=" fa fa-lg fa-external-link text-info"></span></button>
				<g:if test="${entryInstance.status==Entry.STATUS_OK}">
					<a id="start-submit-datum" href="#submit-datum" title="提交数据"><span class="fa fa-lg fa-cloud-upload"></span></a>
				</g:if>
				<g:else>
					<span class="fa fa-lg fa-cloud-upload text-error" title="项目${entryInstance.status}"></span>
				</g:else>
			<idata:ifAuthor entry="${entryInstance}">
					<!-- 导出表单 -->
					<g:link controller="sheet" action="export" id="${sheetInstance.id}" title="导出该表单"><span class="fa fa-lg fa-cloud-download text-success"></span></g:link>
				<sec:ifAnyGranted roles="ROLE_POST">
					<!-- 修改表单 -->
					<g:link controller="sheet" action="edit" id="${sheetInstance.id}" title="修改表单"><span class="fa fa-lg fa-pencil-square-o text-warning"></span></g:link>
				</sec:ifAnyGranted>
			</idata:ifAuthor>
				</span>
	</g:if>
				<g:if test="${actionName in ['edit','export']}">
				<g:link controller="sheet" action="show" id="${it.id}" title="返回表单"><span class="fa fa-lg fa-table muted"></span> ${it.name}
					<span class="fa fa-lg fa-external-link muted"></span>
					<span class="fa fa-lg fa-cloud-upload muted"></span>
					<span class="fa fa-lg fa-cloud-download muted"></span>
					<span class="fa fa-lg fa-pencil-square-o muted"></span>
				</g:link>
				</g:if>
			</li>
		</g:if><g:else>
			<li title="查看表单"><g:link controller="sheet" action="show" id="${it.id}"><span class="fa fa-table muted"></span> ${it.name}</g:link></li>
		</g:else>
	</g:each>
	<g:if test="${entryInstance.sheets.empty()}">
		<li><span class="text-warning"><span class="fa fa-lg fa-exclamation-circle"></span> 尚未添加表单</span></li>
	</g:if>

</span>
<script src="${resource(file:'jquery.zeroclipboard.min.js', dir:'js')}"></script>
<jq:jquery>
$("body")
	.on("copy", ".zclip", function(/* ClipboardEvent */ e) {
		e.clipboardData.clearData();
		e.clipboardData.setData("text/plain", $(this).data("zclip-text"));
		e.preventDefault();
	});
$("#sharelink").click(function(){ this.select(); });
</jq:jquery>
