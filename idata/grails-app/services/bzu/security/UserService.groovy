package bzu.security

import grails.plugins.springsecurity.Secured
import java.io.IOException;

import org.springframework.transaction.annotation.Transactional;

class UserService {
	
	static transactional = false

	def grailsApplication
	def springSecurityService
	
	User getCurrentUser() {
		springSecurityService.currentUser
	}
	
	// 通过门户网站验证用户名和密码
	@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
	def boolean webPortalAuthentication(String username, String password) throws IOException {
		try {
			// 尝试登录门户网站验证密码
			log.info "尝试登录门户网站验证用户 ${username}"
			def loginUrl = grailsApplication.config.webPortal.login.url
			def loginSuccess = grailsApplication.config.webPortal.login.success
			return (new URL(String.format(loginUrl, username, password)).text.indexOf(loginSuccess) != -1)
		} catch (IOException networkEx) {
			// 网络故障，无法访问门户网站
			throw networkEx
		}
	}

	// 更新用户密码
	// 忘记密码时，直接使用门户网站密码登录，系统自动更新密码
	@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
	@Transactional
	def updateUserPassword(String username, String password) {
		User user = User.findByUsername(username)
		if(user) {
			user.password = password
			user.save(flush:true)
			log.info "更新用户密码 ${username}"
		}
	}
}
