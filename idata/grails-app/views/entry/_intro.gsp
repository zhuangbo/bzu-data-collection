<%@page import="bzu.idata.Entry"%>
<blockquote>
<g:if test="${entryInstance?.description || entryInstance?.referenceUrl || entryInstance?.remarks}">
	<g:if test="${entryInstance?.description}"><p><strong>简介</strong> ${entryInstance?.description}</p></g:if>
	<g:if test="${entryInstance?.referenceUrl}"><p><strong>参考</strong> <a href="${entryInstance?.referenceUrl}" target="_blank">
		${entryInstance?.referenceUrl?.length()<32 ? entryInstance?.referenceUrl : entryInstance?.referenceUrl[0..31]+'...'}</a></p>
	</g:if>
	<g:if test="${entryInstance?.remarks}"><p class="text-warning"><strong>注意</strong> ${entryInstance?.remarks}</p></g:if>
</g:if>
<g:else>
<p class="text-warning"><span class="fa fa-exclamation-circle"></span> 没有描述信息</p>
<idata:ifAuthor entry="${entryInstance}">
<p class="text-warning"><span class="fa fa-pencil"></span> 编辑项目可填写更多描述。</p>
</idata:ifAuthor>
</g:else>
<g:if test="${entryInstance?.status!=Entry.STATUS_OK}">
	<p class="text-error"><span class="fa fa-exclamation-circle"></span> 此项目${entryInstance?.status}，不再接受提交数据。</p>
</g:if>
</blockquote>
