<g:if test="${controllerName=='sheet' && actionName=='show'}">
	<!-- 搜索数据 -->
	<ul class="nav">
		<li>
		<form class="form-search navbar-search">
		<div class="input-append">
			<input name="q" value="${params?.q}" class="input-medium search-query" type="text" data-toggle="tooltip" title="在提交数据中搜索" placeholder="搜索表单数据"/>
			<button type="submit" class="btn">搜索</button>
		</div>
		</form>
		</li>
	</ul>
</g:if>
<g:else>
	<!-- 搜索项目 -->
	<ul class="nav">
		<li>
		<form action="${createLink(controller:'entry', action:'list')}" class="form-search navbar-search">
		<div class="input-append">
			<input name="q" value="${params?.q}" class="input-medium search-query" type="text" data-toggle="tooltip" title="搜索数据采集项目" placeholder="搜索项目"/>
			<button type="submit" class="btn">搜索</button>
		</div>
		</form>
		</li>
	</ul>
</g:else>