package bzu.security


class SignupController {
	
    static allowedMethods = [signup: "POST"]
	
	def userService

    def index() {
		cache validFor: 1800  // 缓存 30 分钟
		[userInstance: new User(params)]
	}
	
	def signup() {
        def userInstance = new User(params)
		userInstance.enabled = true   // 注册后处于激活状态
		
		// 用户名已存在，则不能注册
		if(User.findByUsername(userInstance.username)) {
			displayMessage(text:"该用户名已经注册，请不要重复注册。", type:"error")
			render(view: "index", model: [userInstance: userInstance])
			return
		}
		
		// Web 验证身份
		try {
			if(!userService.webPortalAuthentication(userInstance.username, userInstance.password)) {
				// 不能通过验证
				displayMessage(text:"对不起，您不是本校教职工。", type:"error")
	            render(view: "index", model: [userInstance: userInstance])
	            return
			}
		} catch (IOException e) {
			// 网络故障
			displayMessage(text:"暂无法验证您的身份，请稍后重试。", type:"error")
            render(view: "index", model: [userInstance: userInstance])
            return
		}
		
		// 注册用户
		if (!userInstance.save(flush: true)) {
			displayMessage(text:"注册失败，请不要重复注册。", type:"error")
			render(view: "index", model: [userInstance: userInstance])
			return
		}
		
		// 注册成功，分配USER权限
		UserRole.create(userInstance, Role.findByAuthority('ROLE_USER'))
		
		displayFlashMessage(text:"注册成功，您现在可以登录系统。", type:"info")
        redirect(controller: "login")
	}
}
