// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
    all:           '*/*',
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'bzu.security.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'bzu.security.UserRole'
grails.plugins.springsecurity.authority.className = 'bzu.security.Role'

// Security of password
grails.plugins.springsecurity.password.algorithm = 'bcrypt'
grails.plugins.springsecurity.password.bcrypt.logrounds = 7
grails.plugins.springsecurity.dao.reflectionSaltSourceProperty = 'username'
grails.plugins.springsecurity.logout.afterLogoutUrl = '/logout/success'

// 界面主题
plugin.platformUi.theme.default = 'Bootstrap'

plugin.platformCore.site.name="iData"
plugin.platformCore.organization.name='滨州学院'

// for DaoAndWebPortalAuthenticationProvider
webPortal.login.url = "http://portal.bzu.edu.cn/loginAction.do?userName=%s&userPass=%s"
webPortal.login.success = "<script>window.top.location.href=\"/index_jg.jsp\"</script>"

// roles
app.roles = ['ROLE_USER', 'ROLE_ADMIN', 'ROLE_POST'] // 用户/管理/发布

// default administrator
app.admin.default = [
	username:'administrator',
	password:'1qaz@WSX',
	realName:'管理员',
	department:'00',
	]

// 部门（编号）列表，部门名称见 i18n
app.departments = [
	'01',	// 政法系
	'02',	// 中文系
	'03',	// 外语系
	'04',	// 历史系
	'05',	// 教师教育学院
	'06',	// 经济管理系
	'07',	// 数学系
	'08',	// 光电工程系
	'09',	// 机电工程系
	'10',	// 化学工程系
	'11',	// 信息工程系
	'12',	// 生命科学系
	'13',	// 建筑工程系
	'14',	// 资源环境系
	'15',	// 体育系
	'16',	// 音乐系
	'17',	// 美术系
	'18',	// 电气工程系
	'19',	// 飞行学院
	'20',	// 继续教育学院（远程教育中心）
	'22',	// 初等教育学院
	'23',	// 计划财务处
	'24',	// 办公室
	'25',	// 网络与现代教育技术中心
	'26',	// 党委统战部
	'27',	// 发展规划处
	'28',	// 国际交流与合作处
	'29',	// 后勤管理处
	'30',	// 学报编辑部
	'31',	// 基建处
	'32',	// 纪委
	'33',	// 组织部
	'34',	// 宣传部
	'35',	// 审计处
	'36',	// 继续教育学院
	'37',	// 离退休工作处
	'38',	// 保卫处
	'39',	// 实训中心
	'66',	// 安全文化研究中心
	'77',	// 大学英语教学部
	'80',	// 公共
	'81',	// 服务地方工作办公室
	'85',	// 图书馆
	'86',	// 工会
	'87',	// 黄河三角洲文化研究所
	'88',	// 孙子研究院
	'89',	// 国有资产管理处
	'90',	// 黄河三角洲生态环境研究中心
	'91',	// 科研处
	'92',	// 人事处
	'93',	// 学生工作处（武装部）
	'94',	// 招生就业处
	'95',	// 团委
	'96',	// 外聘
	'97',	// 校内机关
	'98',	// 教务处
	'99',	// 社科基础教学部
]
