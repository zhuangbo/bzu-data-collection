<ul class="nav">
	<sec:ifNotLoggedIn>
 	<li class="${controllerName=='signup'?'active':''}"><g:link controller="signup" action="index"><i class="fa fa-edit"></i> 注册</g:link></li>
 	<li class="${controllerName=='login'?'active':''}"><g:link controller="login" action="auth"><i class="fa fa-lock"></i> 登录</g:link></li>
	</sec:ifNotLoggedIn>
	<sec:ifLoggedIn>
	<li class="dropdown ${controllerName=='profile'?'active':''}">
		 <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="fa fa-user"></i> <idata:user/> <strong class="caret"></strong></a>
		 <ul class="dropdown-menu">
		 	<li><g:link controller="profile" action="index"><i class="fa fa-user"></i> 我的信息</g:link></li>
		 	<li><g:link controller="profile" action="changePassword"><i class="fa fa-key"></i> 修改密码</g:link></li>
			<li class="divider"></li>
		 	<li><g:link controller="logout" action="index"><i class="fa fa-power-off"></i> 安全退出</g:link></li>
	 	</ul>
	</li>
	</sec:ifLoggedIn>
</ul>
