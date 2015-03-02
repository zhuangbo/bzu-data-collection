<!-- 出错信息帮助 -->
<div id="help-errors" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			错误
		</h3>
	</div>
	<div class="modal-body">
		<blockquote class="lead text-error">
		遇到某种错误。
		</blockquote>
		<dl class="dl-horizontal">
			<dt>页面不存在 <span class="fa fa-unlink fa-lg text-error"></span></dt>
			<dd>请求的页面不存在，或请求的对象已被删除。</dd>
			<dt>拒绝访问 <span class="fa fa-ban fa-lg text-error"></span></dt>
			<dd>访问请求被拒绝，可能因为你无权执行该操作。</dd>
			<dt>服务器错误 <span class="fa fa-frown-o fa-lg text-error"></span></dt>
			<dd>很可惜，程序出错了。使用不当也可能引发程序错误。</dd>
		</dl>
	</div>
	<g:render template="/help/modal-footer"/>
</div>
