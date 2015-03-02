<!-- 首页帮助 -->
<div id="help-home" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			首页
		</h3>
	</div>
	<div class="modal-body">
		<blockquote class="lead text-info">
			iData 数据采集系统的主页。
		</blockquote>
		<p>未登录时显示系统简介；登录后，您可以了解到最新的数据采集项目，您参与的和您发布的项目。</p>
		<dl class="dl-horizontal">
			<dt>新项目</dt>
			<dd>最近发布的数据采集项目，至多列出最近 10 项。</dd>
			<dt>我参与</dt>
			<dd>您曾经提交数据的项目，至多列出最近 10 项。</dd>
			<dt>我发布</dt>
			<dd>您曾经发布的数据采集项目，至多列出最近 10 项</dd>
		</dl>
	</div>
	<g:render template="/help/modal-footer"/>
</div>
