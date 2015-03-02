<!-- 数据采集项目帮助 -->
<div id="help-entry" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			数据采集项目
		</h3>
	</div>
	<div class="modal-body">
		<div class="tabbable" id="tabs-user">
			<ul class="nav nav-tabs">
				<li class="${actionName in ['index','list']?'active':''}">
					<a href="#panel-entry-list" data-toggle="tab"><span class="fa fa-th-list"></span> 项目列表</a>
				</li>
				<li class="${actionName in ['create','save']?'active':''}">
					<a href="#panel-entry-create" data-toggle="tab"><span class="fa fa-magic"></span> 新建项目</a>
				</li>
				<li class="${actionName in ['show']?'active':''}">
					<a href="#panel-entry-show" data-toggle="tab"><span class="fa fa-newspaper-o"></span> 项目概况</a>
				</li>
				<li class="${actionName in ['export', 'exportExcel']?'active':''}">
					<a href="#panel-entry-export" data-toggle="tab"><span class="fa fa-cloud-download"></span> 导出数据</a>
				</li>
				<li class="${actionName in ['edit','update']?'active':''}">
					<a href="#panel-entry-edit" data-toggle="tab"><span class="fa fa-pencil"></span> 编辑项目</a>
				</li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane ${actionName in ['index','list']?'active':''}" id="panel-entry-list">
					<blockquote class="lead text-info">
						与用户有关的数据采集项目列表。
					</blockquote>
					<dl class="dl-horizontal">
						<dt>用户相关</dt>
						<dd>这里列出的项目包括当前用户可见的和/或当前用户发布的所有项目。</dd>
						<dt>排序</dt>
						<dd>点击相应的列标题，可以对项目列表按标题、开始和结束时间进行排序。</dd>
						<dt>项目搜索</dt>
						<dd>在位于导航栏上的搜索框内输入关键字，可以按项目名称搜索。</dd>
						<dt>新建项目</dt>
						<dd>点击 <span class="fa fa-lg fa-magic text-warning"></span> 创建新的数据采集项目。</dd>
					</dl>
				</div>
				<div class="tab-pane ${actionName in ['create','save']?'active':''}" id="panel-entry-create">
					<blockquote class="lead text-info">
						创建新的数据采集项目。
					</blockquote>
					<dl class="dl-horizontal">
						<dt>发布权限</dt>
						<dd>必须具备发布权限，才可以创建并发布项目。<span class="badge badge-warning">发布</span></dd>
						<dt>标题</dt>
						<dd>项目标题，是一个项目最主要的标识，必填。</dd>
						<dt>更多描述</dt>
						<dd>点击“更多描述”，可以填写可选的项目信息。</dd>
						<dt>适用范围</dt>
						<dd>表明本项目面向的用户，包括：所有人、指定单位和指定用户三种情形。</dd>
						<dt>指定单位</dt>
						<dd>适用范围选择“指定单位”，此时需要点选指定的单位。其作用是限定指定单位的用户才能够访问该项目。</dd>
						<dt>指定用户</dt>
						<dd>适用范围选择“指定用户”，填写允许访问的用户名。<br/>
							<span class="text-warning"><span class="fa fa-lg fa-exclamation-circle text-error"></span> 多个用户名之间一定要间隔开，否则可能导致误判。</span>
						</dd>
						<dt>开始时间</dt>
						<dd>设定项目开始允许用户提交数据的时间，在此之前不允许用户提交数据。</dd>
						<dt>结束时间</dt>
						<dd>设定项目允许用户提交数据的最晚时间，在此之后不允许用户提交数据。</dd>
						<dt>关闭项目</dt>
						<dd>关闭项目意味着立即停止用户提交数据。</dd>
					</dl>
				</div>
				<div class="tab-pane ${actionName in ['show']?'active':''}" id="panel-entry-show">
					<blockquote class="lead text-info">
						查看数据采集项目概要。
					</blockquote>
					<dl class="dl-horizontal">
						<dt>项目概况</dt>
						<dd>展示项目基本信息，包括：
							<span class="fa fa-user text-info"></span> 作者，
							<span class="fa fa-bullhorn text-info"></span> 发布时间，
							<span class="fa fa-clock-o text-warning"></span> 截止时间，
							<span class="fa fa-group text-info"></span> 适用范围，
							<span class="fa fa-share-alt text-info"></span> 复制网址，
							以及其他详细描述。</dd>
						<dt>项目导航</dt>
						<dd>
							<span class="fa fa-lg fa-th-list text-info"></span> —— 返回项目列表；<br/>
							<span class="fa fa-lg fa-newspaper-o text-info"></span> —— 查看项目概况；<br/>
							<span class="fa fa-lg fa-cloud-download text-info"></span> —— 导出项目数据到 Excel 文件；<span class="badge badge-warning">作者</span><br/>
							<span class="fa fa-lg fa-pencil text-warning"></span> —— 编辑项目信息；<span class="badge badge-warning">作者</span><span class="badge badge-warning">发布</span><br/>
							<span class="fa fa-lg fa-plus-square text-warning"></span> —— 添加表单；<span class="badge badge-warning">作者</span><span class="badge badge-warning">发布</span><br/>
							<span class="fa fa-lg fa-table text-info"></span> —— 对应项目中的各个表单；<br/>
							<span class="fa fa-lg fa-cloud-upload text-info"></span> —— 向当前表单提交数据；<br/>
							<span class="fa fa-lg fa-pencil-square-o text-warning"></span> —— 修改当前表单。<span class="badge badge-warning">作者</span><span class="badge badge-warning">发布</span>
						</dd>
						<dt>项目中的表单</dt>
						<dd>一个项目可以包含若干个表单，类似于一个 Excel 文件包含多个工作表（sheet）一样。不同的表单（工作表）中的内容、格式不尽相同。</dd>
					</dl>
				</div>
				<div class="tab-pane ${actionName in ['export', 'exportExcel']?'active':''}" id="panel-entry-export">
					<blockquote class="lead text-info">
						将项目数据导出到 Excel 文件。
					</blockquote>
					<dl class="dl-horizontal">
						<dt>作者本人</dt>
						<dd>只有作者才能导出数据。<span class="badge badge-warning">作者</span></dd>
						<dt>导出格式</dt>
						<dd>导出数据采用 Excel 文件格式，每个表单对应一个工作表。为方便备份，文件名中包含导出时间。</dd>
						<dt>全部导出</dt>
						<dd class="text-warning">目前仅支持导出全部数据，若需筛选、合并，您可以在导出之后在 Excel 中作进一步处理。</dd>
						<dt>数据排序</dt>
						<dd>可以指定导出数据的排序方式。当然，您也可以在导出数据之后在 Excel 中进行排序。</dd>
						<dt>附加字段</dt>
						<dd>导出时附加在每条数据后面的信息，可以包括：提交者，提交者所在单位（代码，名称），提交时间。</dd>
					</dl>
				</div>
				<div class="tab-pane ${actionName in ['edit','update']?'active':''}" id="panel-entry-edit">
					<blockquote class="lead text-info">
						编辑修改项目信息。
					</blockquote>
					<dl class="dl-horizontal">
						<dt>作者本人</dt>
						<dd>只有作者才能编辑本人发布的项目。<span class="badge badge-warning">作者</span></dd>
						<dt>编辑项目</dt>
						<dd>可以修改项目信息，如标题、详细描述、适用范围、开始、结束时间等。详细情况参见 <a href="#panel-entry-create" data-toggle="tab"><span class="fa fa-magic"></span> 新建项目</a>。</dd>
						<dt>关闭项目</dt>
						<dd>选中“关闭”，可以禁止用户提交数据。</dd>
						<dt>删除项目</dt>
						<dd><span class="badge badge-important">警告</span> 删除项目意味着同时删除所有表单以及各个表单中的所有数据，慎重适用，及时导出数据进行备份。</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
	<g:render template="/help/modal-footer"/>
</div>
