package bzu.idata

class IDataTagLib {
	
	static namespace = "idata"
	
	def springSecurityService
	def entryService
	
	/**
	 * 当前用户信息
	 * @attr field
	 */
	def user = { attrs ->
		if(springSecurityService.loggedIn) {
			def field = attrs.field
			
			if(field==null) {
				out << springSecurityService.currentUser.toString()
			} else if(field=='password') {
				out << '****************'
			} else if(field=='realName') {
				out << springSecurityService.currentUser.realName
			} else if(field=='department') {
				out << springSecurityService.currentUser.department
			} else if(field=='authorities') {
				out << springSecurityService.currentUser.authorities.collect{
					[ROLE_USER:'用户',ROLE_POST:'发布',ROLE_ADMIN:'管理'][it.authority]
				}
			} else if(field=='accountExpired') {
				out << springSecurityService.currentUser.accountExpired
			} else if(field=='accountLocked') {
				out << springSecurityService.currentUser.accountLocked
			} else if(field=='passwordExpired') {
				out << springSecurityService.currentUser.passwordExpired
			} else {
				out << sec.loggedInUserInfo(field:field)
			}
		}
	}
	
	/**
	 * 若当前用户是特定对象的作者则输出
	 * @attr entry
	 * @attr sheet
	 */
	def ifAuthor = { attrs, body->
		def entry = attrs.remove('entry')
		def sheet = attrs.remove('sheet')
		
		if(!entry && !sheet || entry && sheet && sheet.entry.id!=entry.id) {
			throw new Exception('不能同时指定 entry 和 sheet')
		}
		
		def uid = springSecurityService.principal.id
		if(entry && entryService.isAuthor(entry, uid) || sheet && entryService.isAuthor(sheet, uid)) {
			out << body()
		}
	}
	
	/**
	 * 如果当前用户是数据的提交者则输出
	 * @attr data REQUIRED
	 */
	def ifSubmitter = { attrs, body->
		def data = attrs.remove('data')
		def uid = springSecurityService.principal.id
		if(data?.submitter?.id==uid) {
			out << body()
		}
	}

}
