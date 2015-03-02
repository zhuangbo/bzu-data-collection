<!-- 后台管理帮助 -->
<div id="help-manage" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			系统管理
		</h3>
	</div>
	<div class="modal-body">
		<div class="tabbable" id="tabs-user">
			<ul class="nav nav-tabs">
				<li class="${actionName=='index'?'active':''}">
					<a href="#panel-manage-users-main" data-toggle="tab">用户管理</a>
				</li>
				<li>
					<a href="#panel-manage-users-roles" data-toggle="tab">关于权限</a>
				</li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane ${actionName=='index'?'active':''}" id="panel-manage-users-main">
					<blockquote class="lead text-info">
						用户的浏览、查询、新建、修改、删除、授权、停用
					</blockquote>
					<dl class="dl-horizontal">
						<dt>浏览、查询</dt>
						<dd>可以浏览查看系统中所有用户的基本信息，在右上角搜索框中输入用户名、姓名进行搜索。</dd>
						<dt>新建用户</dt>
						<dd>手动添加用户，密码可随机设置，用户登录时直接使用个人门户密码即可。</dd>
						<dt>修改、删除</dt>
						<dd>可以修改用户名、用户状态等信息，必要时也可以删除。通常，对不再使用的账号，作停用处理即可。</dd>
						<dt>权限</dt>
						<dd>可以为用户分配不同权限。新注册用户自动分配用户权限。各类权限详情参见 <a href="#panel-manage-users-roles" data-toggle="tab">关于权限</a>。</dd>
					</dl>
				</div>
				<div class="tab-pane" id="panel-manage-users-roles">
					<g:render template="/help/dialog/roles"></g:render>
				</div>
			</div>
		</div>
	</div>
	<g:render template="/help/modal-footer"/>
</div>
