<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<theme:layout name="dialog" />
	<title><g:message code="springSecurity.denied.title" /></title>
</head>
	<body>
		<theme:zone name="body">

<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<p class="text-error lead"><span class="fa fa-ban fa-4x"></span> 对不起，您没有足够的权限执行该操作。</p>
			<p:displayMessage/>
			<blockquote>
				<p class="text-warning lead"><span class="fa fa-hand-o-right fa-lg"></span> 需要特定的权限才能执行，但您暂不具备该权限。</p>
			</blockquote>
		</div>
	</div>
</div>
	
		</theme:zone>
	</body>
</html>
