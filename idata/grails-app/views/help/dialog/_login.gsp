<!-- 登录帮助 -->
<div id="help-login" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			登录
		</h3>
	</div>
	<div class="modal-body">
		<blockquote class="lead text-info">
			请输入您的用户名和密码登录系统。
		</blockquote>
		<dl class="dl-horizontal">
			<dt>用户名</dt>
			<dd>通常是您的教师号（或学号），或者管理员分配的账号。</dd>
			<dt>密码</dt>
			<dd>通常是你在校内门户使用的密码，或者是管理员设定的密码。</dd>
			<dt>两周内免登录</dt>
			<dd>在两周的时间内，让浏览器记住用户名和密码，从而自动登录。</dd>
			<dt>访问被拒绝</dt>
			<dd>您的访问请求需要特定的权限，而您现在不具备该权限。</dd>
		</dl>
	</div>
	<g:render template="/help/modal-footer"/>
</div>
