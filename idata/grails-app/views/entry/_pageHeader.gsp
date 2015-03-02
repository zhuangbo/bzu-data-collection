<%@ page import="bzu.idata.Entry" %>
<div class="row-fluid">
	<div class="span8">
		<h2><span class="fa fa-newspaper-o"></span> ${entryInstance?.title} <small>${subtitle}</small></h2>
	</div>
	<div class="span4">
		<div class="row-fluid">
			<div class="span12">
<div class="row-fluid clearfix">
	<div class="row">
	<div class="span3">
		<span title="作者"><span class="fa fa-user text-info"></span>&nbsp;${entryInstance?.author.realName}</span>
	</div>
	<div class="span3">
		<span title="开始时间 ${entryInstance?.startTime?.format('yyyy-MM-dd HH:mm')}">
			<span class="fa fa-bullhorn text-info"></span>&nbsp;${entryInstance?.startTime.format('M/d')}
		</span>
	</div>
	<div class="span6">
	<div class="span7">
		<span class="text-warning" title="截止时间 ${entryInstance?.endTime?.format('yyyy-MM-dd HH:mm')}">
			<span class="fa fa-clock-o text-warning"></span>&nbsp;${entryInstance?.endTime.format('M/d HH:mm')}
		</span>
	</div>
	<div class="span5">
		<span class="text-${entryInstance?.status==Entry.STATUS_OK ? 'info' : 'error'}"><span class="fa fa-bell"></span>&nbsp;${entryInstance?.status}</span>
	</div>
	</div>
	</div>
	<div class="row">
	<div class="span7">
		<span title="适用于"><span class="fa fa-group text-info"></span>&nbsp;
				${entryInstance.visibility==Entry.VISIBILITY_ALL?'任何人':''}
				${entryInstance.visibility==Entry.VISIBILITY_DEPARTMENT?g.message(code:'department.'+entryInstance.department):''}
				${entryInstance.visibility==Entry.VISIBILITY_USERNAME?'指定用户':''}
		</span>
	</div>
	<div class="span4">
		<g:set var="entryurl">${createLink(controller:'entry', action:'show', id:entryInstance.id, absolute:'true')}</g:set>
		<div class="input-append pull-right">
			<input type="text" id="sharelink" class="input-small" readonly="true" value="${entryurl}" title="本项目网址" style="width:70px;"/>
			<button id="copysharelink" type="button" class="zclip btn fa fa-share-alt" data-zclip-text="${entryurl}" title="复制网址，分享本项目" style="color:#3A87AD;"></button>
		</div>
	</div>
	</div>
	</div>
</div>
		</div>
	</div>
</div>
