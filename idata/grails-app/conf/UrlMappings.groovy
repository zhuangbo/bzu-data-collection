class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}
		
		// 主页
		"/"(controller:"home", action:'index')
		// 登录
		"/login"(controller:'login', action:'auth')
		// 注册
		"/signup"(controller:'signup', action:'index')
		// entry
		"/e"(controller:'entry', action:'list')
		"/e/index"(controller:'entry', action:'list')
		"/e/create"(controller:'entry', action:'create')
		"/e/save"(controller:'entry', action:'save')
		"/e/$id"(controller:'entry', action:'show')
		"/e/$id/$action"(controller:'entry')
		// sheet
		"/s/create"(controller:'sheet', action:'create')
		"/s/save"(controller:'sheet', action:'save')
		"/s/$id"(controller:'sheet', action:'show')
		"/s/$id/$action"(controller:'sheet')
		"/s/$eid-$sid/rm/$id"(controller:'sheet', action:'delData')
		
		// 错误处理页面
		"500"(controller:'errors', action:'serverError')
		"403"(controller:'errors', action:'forbidden')
		"405"(controller:'errors', action:'forbidden')
		"400"(controller:'errors', action:'notFound')
	}
}
