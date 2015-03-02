<ul class="nav">
	<li class="${controllerName=='home'?'active':''}"><g:link controller="home">
		<i class="fa fa-home"></i> 首页</g:link>
	</li>
	<li class="${controllerName=='entry' && actionName=='list' ? 'active' : ''}">
		<g:link controller="entry" action="list"><i class="fa fa-th-list"></i> 项目</g:link>
	</li>
</ul>
		