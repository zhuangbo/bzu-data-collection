<blockquote>
<g:if test="${sheetInstance?.description || sheetInstance?.remarks}">
	<g:if test="${sheetInstance?.description}"><p><strong>简介</strong> ${sheetInstance?.description}</p></g:if>
	<g:if test="${sheetInstance?.remarks}"><p class="text-warning"><strong>注意</strong> ${sheetInstance?.remarks}</p></g:if>
</g:if>
</blockquote>
