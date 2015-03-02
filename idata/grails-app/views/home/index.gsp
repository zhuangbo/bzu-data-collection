<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="home"/>
		<title>欢迎使用iData数据采集平台</title>
	</head>
	<body>
<theme:zone name="banner">
</theme:zone>
<theme:zone name="body">
	<ui:displayMessage/>
	<div class="hero-unit">
		<h1><i class="fa fa-cloud-upload text-success"></i> iData <small>V <g:meta name="app.version"/></small></h1>
		<p class="text-warning">一个实用、易用、通用的数据采集平台，帮助您快速、高效、规范地收集并汇总所需数据。</p>
<sec:ifNotLoggedIn>
		<p class="clear">您可以：</p>
		<ul class="text-info">
			<li>方便地创建并分发表格</li>
			<li>方便地提交数据</li>
			<li>随时导出 Excel 文件</li>
		</ul>
		<p>您还在用“电子邮件+Excel”收集和汇总数据吗？快来试试吧。</p>
		<p>现在就 <g:link class="btn btn-large btn-success" controller="signup"><i class="fa fa-edit"></i> 注册 &raquo;</g:link> <g:link class="btn btn-primary btn-large" controller="login"><i class="fa fa-lock"></i> 登录 &raquo;</g:link></p>
</sec:ifNotLoggedIn>
	</div>
<sec:ifLoggedIn>
<sec:ifNotGranted roles="ROLE_USER,ROLE_POST">
	<p class="alert alert-error">抱歉，您现在还没有用户权限，不能查看和提交数据，请联系管理员分配适当的权限。</p>
</sec:ifNotGranted>
</sec:ifLoggedIn>
</theme:zone>

<theme:zone name="panel1">
<sec:ifAnyGranted roles="ROLE_USER,ROLE_POST">
<!-- 我能访问的项目 -->
<div class="row-fluid">
<div class="span12">
	<div class="panel panel-default span12">
		<ul class="pager pull-right"><li title="更多项目"><g:link controller="entry" action="list"><span class="fa fa-lg fa-th-list"></span></g:link></li></ul>
		<div class="panel-heading">
			<h4 class="panel-title muted"><span class="fa fa-newspaper-o fa-2x text-info"></span> 新项目</h4>
		</div>
		<div class="panel-body">
		<table class="table table-hover table-condensed">
		<g:each in="${lastEntryList}" var="entry">
			<tr>
				<td><g:link controller="entry" action="show" id="${entry.id}" class="span10">${entry.title}</g:link>
				<span class="pull-right span2">${entry.startTime.format('MM/dd')}</span>
				</td>
			</tr>
		</g:each>
		</table>
		</div>
	</div>
</div>
</div>
</sec:ifAnyGranted>
</theme:zone>
<theme:zone name="panel2">
<sec:ifAnyGranted roles="ROLE_USER,ROLE_POST">
<!-- 我提交的项目 -->
<div class="row-fluid">
<div class="span12">
	<div class="panel panel-default span12">
		<ul class="pager pull-right"><li title="更多项目"><g:link controller="entry" action="list"><span class="fa fa-lg fa-th-list"></span></g:link></li></ul>
		<div class="panel-heading">
			<h4 class="panel-title muted"><span class="fa fa-comments-o fa-2x text-success"></span> 我参与</h4>
		</div>
		<div class="panel-body">
		<table class="table table-hover table-condensed">
		<g:each in="${submitEntryList}" var="entry">
			<tr>
				<td><g:link controller="entry" action="show" id="${entry.id}" class="span10">${entry.title}</g:link>
				<span class="span2 pull-right">${entry.startTime.format('MM/dd')}</span>
				</td>
			</tr>
		</g:each>
		</table>
		</div>
	</div>
</div>
</div>
</sec:ifAnyGranted>
</theme:zone>
<theme:zone name="panel3">
<sec:ifAnyGranted roles="ROLE_USER,ROLE_POST">
<!-- 我发布的项目 -->
<div class="row-fluid">
<div class="span12">
	<div class="panel panel-default span12">
<sec:ifAnyGranted roles="ROLE_POST">
		<ul class="pager pull-right clearfix"><li title="发起新的数据采集项目"><g:link controller="entry" action="create"><span class="fa fa-lg fa-magic text-warning"></span></g:link></li></ul>
</sec:ifAnyGranted>
		<div class="panel-heading">
			<h4 class="panel-title muted"><span class="fa fa-bullhorn fa-2x text-error"></span> 我发布</h4>
		</div>
		<div class="panel-body">
		<table class="table table-hover table-condensed">
		<g:each in="${postEntryList}" var="entry">
			<tr>
				<td><g:link controller="entry" action="show" id="${entry.id}" class="span10">${entry.title}</g:link>
				<span class="span2 pull-right">${entry.startTime.format('MM/dd')}</span>
				</td>
			</tr>
		</g:each>
		</table>
		</div>
	</div>
</div>
</div>
</sec:ifAnyGranted>
</theme:zone>
	
	</body>
</html>
