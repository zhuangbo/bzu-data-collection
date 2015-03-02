package bzu.security

import grails.plugins.springsecurity.Secured;
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

@Secured(['IS_AUTHENTICATED_REMEMBERED'])
class ProfileController {
	
	static allowedMethods = [updatePassword:'post']
	
	def springSecurityService
	
	// 显示个人信息
    def index() {
		[user: springSecurityService.currentUser]
	}
	
	// 修改密码
	def changePassword() {
		cache validFor: 1800  // 缓存 30 分钟
	}
	def updatePassword(String oldPassword, String newPassword, String repeatNewPassword) {
		// 检查参数（非空，密码重复正确）
		if(!oldPassword || !newPassword || !repeatNewPassword || newPassword!=repeatNewPassword) {
			displayMessage(text:'请正确输入原密码，并输入新密码且重复一次。', type:'error')
			render view:'changePassword'
			return
		}

		// 检查旧密码
		def user = springSecurityService.currentUser
		if(! springSecurityService.passwordEncoder.isPasswordValid(user.password, oldPassword, null)) {
			displayMessage(text:'请正确输入原密码，并输入新密码且重复一次。', type:'error')
			render view:'changePassword'
			return
		}
		
		// 修改新密码
		user.password = newPassword
		if(! user.save()) {
			displayMessage(text:'数据保存失败，修改密码不成功。', type:'error')
			render view:'changePassword'
			return
		}
		
		// 修改成功
		displayFlashMessage(text:'成功修改为新密码。', type:'info')
		redirect action:'index'
	}
}
