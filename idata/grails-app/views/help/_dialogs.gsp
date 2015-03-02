
<g:if test="${controllerName in ['home','login','signup','profile','manage','entry','sheet','errors']}">
	<g:render template="/help/dialog/${controllerName}"></g:render>
</g:if>

<!-- 关于对话框 -->
<div id="help-about" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			关于——iData v<g:meta name="app.version"/>
		</h3>
	</div>
	<div class="modal-body">
		<div class="hero-unit">
			<h1><i class="fa fa-cloud-upload text-success"></i> iData <small>V <g:meta name="app.version"/></small></h1>
			<p class="text-warning">一个实用、易用、通用的数据采集平台，帮助您快速、高效、规范地收集并汇总所需数据。</p>
		</div>

		<div class="container-fluid">
			<div class="row-fluid">
				<div class="row" style="overflow:hidden;height:80px;">
				<div class="span7" style="overflow-x:hidden;overflow-y:scroll;height:80px;">
					<p align="center"><em>技术注记</em></p>
					<ul>
						<li><small>系统基于 <a href="http://grails.org/" target="_blank">Grails</a> v<g:meta name="app.grails.version"/> 和 <a href="http://www.bootcss.com/" target="_blank">Bootstrap</a> v2.2.1。</small></li>
						<li><small>推荐使用 <a href="http://www.google.cn/intl/zh-CN/chrome/" target="_blank">Chrome</a>，<a href="http://www.firefox.com.cn/" target="_blank">FireFox</a>，IE 11。</small></li>
						<li><small>部分图标由 <a href="http://fontawesome.io/" target="_blank">Font Awesome</a> 提供。</small></li>
						<li><small>Grails 基于最流行的 Java 框架 <a href="http://spring.io/" target="_blank">Spring</a> 、<a href="http://hibernate.org/" target="_blank">Hibernate</a>以及 <a href="http://www.sitemesh.org/" target="_blank">SiteMeth</a>。</small></li>
						<li><small>系统以插件形式使用了 <a href="http://grails.org/plugin/spring-security-core" target="_blank">Spring Security</a> 安全框架。</small></li>
						<li><small>导出 Excel 文件采用了 <a href="http://poi.apache.org/" target="_blank">Apache POI</a>。</small></li>
					</ul>
				</div>
				<div class="span5" style="overflow-x:hidden;overflow-y:scroll;height:80px;">
					<p align="center"><em>开发团队</em></p>
					<ul>
						<li><a href="mailto:sdzhuangbo@126.com">庄波</a>-设计，编码，测试</li>
						<li>不断更新中......</li>
					</ul>
					 
				</div>
				</div>
			</div>
		</div>
	</div>
	<g:render template="/help/modal-footer"/>
</div>

<!-- 联系我们 -->
<div id="help-contact" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">
			联系我们
		</h3>
	</div>
	<div class="modal-body">
		<h4 class="text-success">开发人员</h4>
		<p>» 系统开发，技术问题，功能改进</p>
		<blockquote class="text-info">
		<address><strong>庄波</strong><br /><abbr title="电子邮件">E-mail：</abbr>sdzhuangbo@126.com</address>
		</blockquote>
	</div>
	<g:render template="/help/modal-footer"/>
</div>
