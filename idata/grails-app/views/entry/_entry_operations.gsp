		<!-- 项目列表 -->
		<li><g:link controller="entry" action="list" title="所有项目"><span class="fa fa-lg fa-th-list"></span></g:link></li>
		<!-- 返回项目 -->
		<li><g:link controller="entry" action="show" id="${entryInstance.id}" title="项目概况"><span class="fa fa-lg fa-newspaper-o"></span></g:link></li>
		<g:if test="${!(controllerName=='entry' && actionName=='show')}">
		</g:if>
<idata:ifAuthor entry="${entryInstance}">
		<!-- 导出数据 -->
		<li><g:link controller="entry" action="export" id="${entryInstance.id}" title="导出数据"><span class="fa fa-lg fa-cloud-download"></span></g:link>
	<sec:ifAnyGranted roles="ROLE_POST">
		<!-- 编辑项目 -->
		<li><g:link controller="entry" action="edit" id="${entryInstance.id}" title="编辑项目"><span class="fa fa-lg fa-pencil text-warning"></span></g:link></li>
		<!-- 新建表单 -->
		<li><g:link controller="sheet" action="create" params="['entry.id':entryInstance.id]" title="添加表单"><span class="fa fa-lg fa-plus-square text-warning"></span></g:link></li>
	</sec:ifAnyGranted>
</idata:ifAuthor>
