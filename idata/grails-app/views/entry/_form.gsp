<%@ page import="bzu.idata.Entry" %>

<ui:fieldGroup>
<g:set var="createSave" value="${actionName in ['create','save']}"/>
<div class="control-group ">
	<label for="title" class="control-label"><g:message code="entry.title.label" default="Title" /> *</label>
	<div class="controls">
		<input id="title" class="input-xlarge span${createSave?4:6}" required="" name="title" size="250" value="${entryInstance?.title}" type="text" placeHolder="数据采集项目的标题（必填的）"/>
		<g:eachError bean="${entryInstance}" field="title">
		<ul class="alert alert-error"><li><g:message error="${it}"/></li></ul>
		</g:eachError>
		<a href="#" id="detail" class="btn" title="显示/隐藏更多描述">更多描述 &gt;&gt;</a>
	</div>
</div>
<div id="divDetail" class="hide">
<div class="control-group">
	<label for="description" class="control-label"><g:message code="entry.description.label" default="Description"/></label>
	<div class="controls">
		<g:textArea name="description" rows="3" maxlength="250" value="${entryInstance?.description}" class="span${createSave?4:6}" placeHolder="项目说明（250字以内，可选的）"/>
	</div>
</div>
<div class="control-group">
	<label for="referenceUrl" class="control-label"><g:message code="entry.referenceUrl.label" default="Reference URL"/></label>
	<div class="controls">
		<g:field type="url" name="referenceUrl" size="250" value="${entryInstance?.referenceUrl}" class="span${createSave?4:6}" placeHolder="参考网址（如：详细通知的链接，可选的）"/>
	</div>
</div>
<div class="control-group">
	<label for="remarks" class="control-label"><g:message code="entry.remarks.label" default="Remarks" /></label>
	<div class="controls">
		<g:textArea name="remarks" maxlength="250" rows="2" value="${entryInstance?.remarks}" class="span${createSave?4:6}" placeHolder="注意事项（250字以内，可选的）"/>
	</div>
</div>
</div>
<jq:jquery>
var divDetail = $("#divDetail");
	$("#detail").click(function(){
		divDetail.toggle('slow');
		return false;
	});
</jq:jquery>
</ui:fieldGroup>
<ui:fieldGroup>
<div class="control-group">
	<label for="visibility" class="control-label"><g:message code="entry.visibility.label" default="Visibility"/> *</label>
	<div class="controls">
		<g:select name="visibility" from="${entryInstance.constraints.visibility.inList}" required="" value="${entryInstance?.visibility}" valueMessagePrefix="entry.visibility"/>
	</div>
</div>
<div id="divDepartment" class="control-group">
	<label for="department" class="control-label"><g:message code="entry.department.label" default="Department"/> *</label>
	<div class="controls">
		<g:select name="department" from="${grailsApplication.config.app.departments}" noSelection="['':'--请选择--']" required="" value="${entryInstance?.department}" valueMessagePrefix="department"/>
		<g:eachError bean="${entryInstance}" field="department">
		<ul class="alert alert-error"><li><g:message error="${it}"/></li></ul>
		</g:eachError>		
	</div>
</div>
<div id="divSubmitters" class="control-group">
	<label for="submitters" class="control-label"><g:message code="entry.submitters.label" default="Submitters" /> *</label>
	<div class="controls">
		<g:textArea name="submitters" rows="2" maxlength="65535" value="${entryInstance?.submitters}" class="span${createSave?4:6}" 
			title="多个用户名之间要间隔开（空格或逗号均可）。"/>
		<g:eachError bean="${entryInstance}" field="submitters">
		<ul class="alert alert-error"><li><g:message error="${it}"/></li></ul>
		</g:eachError>
	</div>
</div>
<jq:jquery>
var visibility = $("#visibility");
var divSubmitters = $("#divSubmitters");
var divDepartment = $("#divDepartment");
var submitters = $("#submitters");
var department = $("#department");

function ch() {
	var val = visibility.val();
	if('D'==val) {
		divDepartment.show();
		department.attr({required:""});
		divSubmitters.hide();
		submitters.removeAttr('required');
	} else if('U'==val) {
		divDepartment.hide();
		department.removeAttr('required');
		divSubmitters.show();
		submitters.attr({required:""});
	} else {
		divDepartment.hide();
		department.removeAttr('required');
		divSubmitters.hide();
		submitters.removeAttr('required');
	}
}

visibility.change(ch);

ch();
</jq:jquery>
</ui:fieldGroup>
<ui:fieldGroup>
<link rel="stylesheet" href="${resource(dir: 'css/datetimepicker/css', file: 'datepicker.css')}">
<div class="control-group">
	<label for="startTime" class="control-label"><g:message code="entry.startTime.label" default="Start Time"/> *</label>
	<div class="controls">
		<div class="input-prepend">
		<span class="add-on"><i class="fa fa-calendar"></i></span>
		<input type="text" size="16" id="startTime" name="startTime" value="${entryInstance?.startTime?.format('yyyy-MM-dd')}" readonly required="" class="form_datetime" style="width:90px;" title="开始时间"/>
		</div>
		<div class="input-prepend">
		<span class="add-on"><i class="fa fa-clock-o"></i></span>
		<input type="text" size="5" name="startHHmm" value="${entryInstance?.startTime?.format('HH:mm') ?: '00:00'}" style="width:45px" title="开始时刻"/>
		</div>
		<g:eachError bean="${entryInstance}" field="startTime">
		<ul class="alert alert-error"><li><g:message error="${it}"/></li></ul>
		</g:eachError>
	</div>
</div>
<div class="control-group">
	<label for="endTime" class="control-label"><g:message code="entry.endTime.label" default="End Time"/> *</label>
	<div class="controls">
		<div class="input-prepend">
		<span class="add-on"><i class="fa fa-calendar"></i></span>
		<input type="text" size="16" id="endTime" name="endTime" value="${entryInstance?.endTime?.format('yyyy-MM-dd')}" readonly required="" class="form_datetime" style="width:90px;" title="结束时间"/>
		</div>
		<div class="input-prepend">
		<span class="add-on"><i class="fa fa-clock-o"></i></span>
		<input type="text" size="5" name="endHHmm" value="${entryInstance?.endTime?.format('HH:mm') ?: '23:59'}" style="width:45px" title="结束时刻"/>
		</div>
		<g:eachError bean="${entryInstance}" field="endTime">
		<ul class="alert alert-error"><li><g:message error="${it}"/></li></ul>
		</g:eachError>
	</div>
</div>
<script src="${resource(dir: 'css/datetimepicker/js', file: 'bootstrap-datepicker.js')}"></script>
<script src="${resource(dir: 'css/datetimepicker/js/locales', file: 'bootstrap-datepicker.zh-CN.js')}"></script>		
<jq:jquery>
$(".form_datetime").datepicker({format: 'yyyy-mm-dd', autoclose:true, language:'zh-CN', todayHighlight:true});
</jq:jquery>
</ui:fieldGroup>
<ui:fieldGroup>
<div class="control-group">
	<label for="closed" class="control-label"><g:message code="entry.closed.label" default="Closed" /> *</label>
	<div class="controls">
		<g:checkBox name="closed" value="${entryInstance?.closed}" />
		<span class="text-warning">关闭项目即不再允许提交数据</span>
	</div>
</div>
</ui:fieldGroup>

