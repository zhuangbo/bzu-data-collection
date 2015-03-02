<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<theme:layout name="dialog" />
	<title>服务器错误</title>
</head>
	<body>
		<theme:zone name="body">

<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<p class="text-error lead"><span class="fa fa-frown-o fa-4x"></span> 服务器在执行过程中遇到错误。</p>
			<blockquote>
			<p class="text-warning lead"><span class="fa fa-hand-o-right fa-lg"></span> 真遗憾，竟然程序出错了！</p>
			<p class="text-warning">如果这种情况持续发生，请报告 <a href="#help-contact" data-toggle="modal"><i class="fa fa-envelope"></i> 开发人员</a>，以便对程序进行改进。谢谢您的支持和帮助。</p>
			</blockquote>
		</div>
	</div>
</div>

<g:if env="development">
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
		<g:renderException exception="${exception}" />
		</div>
	</div>
</div>
</g:if>
	
		</theme:zone>
	</body>
</html>
