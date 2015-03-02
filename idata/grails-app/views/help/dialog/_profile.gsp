<!-- 用户信息帮助 -->
<div id="help-profile" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			用户信息
		</h3>
	</div>
	<div class="modal-body">
		<div class="tabbable" id="tabs-profile">
			<ul class="nav nav-tabs">
				<li class=" ${actionName=='index'?'active':''}">
					<a href="#panel-profile-main" data-toggle="tab">个人信息</a>
				</li>
				<li>
					<a href="#panel-profile-roles" data-toggle="tab">关于权限</a>
				</li>
				<li class=" ${actionName=='changePassword'?'active':''}">
					<a href="#panel-profile-change-password" data-toggle="tab">修改密码</a>
				</li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane ${actionName=='index'?'active':''}" id="panel-profile-main">
					<blockquote class="lead text-info">
						查看您的个人信息
					</blockquote>
					<dl class="dl-horizontal">
						<dt>用户名、姓名、单位</dt>
						<dd>您的用户名、真实姓名和所在单位。</dd>
						<dt>权限</dt>
						<dd>权限分为三种：用户、发布和管理。不同的权限决定了你可以执行不同的操作。详情参见 <a href="#panel-profile-roles" data-toggle="tab">关于权限</a>。</dd>
					</dl>
				</div>
				<div class="tab-pane" id="panel-profile-roles">
					<g:render template="/help/dialog/roles"></g:render>
				</div>
				<div class="tab-pane ${actionName=='changePassword'?'active':''}" id="panel-profile-change-password">
					<blockquote class="lead text-info">
						修改登录密码
					</blockquote>
					<dl class="dl-horizontal">
						<dt>当前密码</dt>
						<dd>您现在登录系统时使用的密码。</dd>
						<dt>新密码</dt>
						<dd>拟修改后的新密码。</dd>
						<dt>重复新密码</dt>
						<dd>重复输入一次新密码。</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
	<g:render template="/help/modal-footer"/>
</div>
