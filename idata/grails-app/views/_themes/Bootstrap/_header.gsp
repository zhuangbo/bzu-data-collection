<!--[if lt IE 7 ]>
<div style="border:1px solid red; padding:10px 20px; margin:10px; background-color:#ffd; color:red; z-index:10000;">您当前使用的 IE 浏览器版本太低，严重影响浏览效果，甚至某些功能无法使用。推荐使用 <a href="http://www.google.cn/intl/zh-CN/chrome/" target="_blank">谷歌（Chrome）</a>，<a href="http://www.firefox.com.cn/" target="_blank">火狐（FireFox）</a>，IE 11/10 等浏览器。</div>
<![endif]-->
<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
			<a class="brand" href="${createLink(uri:'/')}"><i class="fa fa-cloud-upload text-success"></i> iData</a>
            <theme:layoutZone name="navigation"/>
            <div class="pull-right">
            <theme:layoutZone name="admin-navigation"/>
            <theme:layoutZone name="user-navigation"/>
			<theme:layoutZone name="navigation-search"/>
            <theme:layoutZone name="help-navigation"/>
            </div>
        </div>
    </div>
</div>
<div id="help-dialogs">
	<g:render template="/help/dialogs"></g:render>
</div>
