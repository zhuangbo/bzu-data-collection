<!-- 表单帮助 -->
<div id="help-sheet" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			数据表单
		</h3>
	</div>
	<div class="modal-body">
		<div class="tabbable" id="tabs-user">
			<ul class="nav nav-tabs">
				<li class="${actionName in ['create','save']?'active':''}">
					<a href="#panel-sheet-create" data-toggle="tab"><span class="fa fa-plus-square"></span> 添加表单</a>
				</li>
				<li class="${actionName in ['show']?'active':''}">
					<a href="#panel-sheet-show" data-toggle="tab"><span class="fa fa-newspaper-o"></span> 查看表单</a>
				</li>
				<li class="${actionName in ['edit','update']?'active':''}">
					<a href="#panel-sheet-edit" data-toggle="tab"><span class="fa fa-pencil"></span> 修改表单</a>
				</li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane ${actionName in ['create','save']?'active':''}" id="panel-sheet-create">
					<blockquote class="lead text-info">
						为当前的数据采集项目添加表单。
					</blockquote>
					<dl class="dl-horizontal">
						<dt>项目作者</dt>
						<dd>只有具有发布权限的项目作者，才可以添加表单。<span class="badge badge-warning">作者</span><span class="badge badge-warning">发布</span></dd>
						<dt>名称</dt>
						<dd>表单名称，类似于 Excel 中工作表的名称。</dd>
						<dt>更多描述</dt>
						<dd>点击“更多描述”，填写可选的表单信息。</dd>
						<dt>表头</dt>
						<dd>从 Excel 中复制表头部分，粘贴在此，提交后显示在数据列表的表头部分。系统自动分析处理，并保留表头的基本格式。</dd>
						<dt>限制</dt>
						<dd>限制每个用户最多能够提交几条数据，默认限制为 5 条记录。<span class="fa fa-lg fa-exclamation-circle text-error"></span> <span class="text-warning">若无限制，请填 0。</span></dd>
					</dl>
				</div>
				<div class="tab-pane ${actionName in ['show']?'active':''}" id="panel-sheet-show">
					<blockquote class="lead text-info">
						查看表单中的数据，提交数据。
					</blockquote>
					<dl class="dl-horizontal">
						<dt>表单信息</dt>
						<dd>展示表单的基本信息，可能包括此表单的简介、说明等。</dd>
						<dt>表单操作</dt>
						<dd>
							<span class="text-success" title="我很丑，可是我很温柔  特别推荐复制表头功能"><span class="fa fa-lg fa-external-link text-info"></span> —— 复制当前表头，以便粘贴到 Excel 中；</span><br/>
							<span class="fa fa-lg fa-cloud-upload text-info"></span> —— 向当前表单提交数据；<br/>
							<span class="fa fa-lg fa-cloud-download text-success"></span> —— 导出当前表单中的数据；<span class="badge badge-warning">作者</span><br/>
							<span class="fa fa-lg fa-pencil-square-o text-warning"></span> —— 修改当前表单。<span class="badge badge-warning">作者</span><span class="badge badge-warning">发布</span>
						</dd>
						<dt>数据列表</dt>
						<dd>列出表单中的数据。项目作者可以查看所有数据，其他人只能看到自己提交的数据。</dd>
						<dt>删除数据</dt>
						<dd>在数据列表中，对当前用户提交的数据，会显示一个 <span class="fa fa-lg fa-times text-error"></span>，单击后可以删除对应的一条数据。</dd>
						<dt>提交数据</dt>
						<dd>一般用户只要能够查看项目，均可提交数据。点击 <span class="fa fa-lg fa-cloud-upload text-info"></span> 跳转到列表下方开始提交数据。提交数据时，<span class="text-info">先从 Excel 中复制数据，然后粘贴再提交</span>。系统自动从表格中提取出待提交的数据。</dd>
						<dt>不能提交</dt>
						<dd><span class="fa fa-lg fa-exclamation-circle text-error"></span> <span class="text-warning">若项目已关闭、过期或尚未开始，则不能提交数据。</span></dd>
					</dl>
				</div>
				<div class="tab-pane ${actionName in ['edit','update']?'active':''}" id="panel-sheet-edit">
					<blockquote class="lead text-info">
						编辑修改表单信息。
					</blockquote>
					<dl class="dl-horizontal">
						<dt>项目作者</dt>
						<dd>必须具有发布权限的项目作者，才能够编辑表单。<span class="badge badge-warning">作者</span><span class="badge badge-warning">发布</span></dd>
						<dt>名称</dt>
						<dd>表单名称，类似于 Excel 中工作表的名称。</dd>
						<dt>更多描述</dt>
						<dd>点击“更多描述”，填写可选的表单信息。</dd>
						<dt>表头</dt>
						<dd>从 Excel 中复制表头部分，粘贴在此，提交后显示在数据列表的表头部分。系统自动分析处理，并保留表头的基本格式。</dd>
						<dt>限制</dt>
						<dd>限制每个用户最多能够提交几条数据，默认限制为 5 条记录。<span class="fa fa-lg fa-exclamation-circle text-error"></span> <span class="text-warning">若无限制，请填 0。</span></dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
	<g:render template="/help/modal-footer"/>
</div>
