import bzu.security.Role
import bzu.security.User
import bzu.security.UserRole

class BootStrap {
	
	def grailsApplication

    def init = { servletContext ->
		// 初始化权限
		grailsApplication.config.app.roles.each {
			if(Role.findByAuthority(it)==null) {
				new Role(authority: it).save(true)
			}
		}
		// 初始化系统管理员
		def admin = grailsApplication.config.app.admin.default
		if(User.findByUsername(admin.username) == null) {
			def u = new User(admin)
			u.enabled = true
			u.save(true)
			UserRole.create(u, Role.findByAuthority('ROLE_ADMIN'), true)
		}
    }
    def destroy = {
    }
}
