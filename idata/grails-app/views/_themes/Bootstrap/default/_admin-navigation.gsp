<sec:ifAnyGranted roles="ROLE_ADMIN">
<ul class="nav">
	<li class="${controllerName=='manage'?'active':''}"><g:link controller="manage"><i class="fa fa-cogs"></i> 系统管理</g:link></li>
</ul>
</sec:ifAnyGranted>