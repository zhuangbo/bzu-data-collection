package bzu.security

import grails.plugins.springsecurity.Secured;

import org.springframework.dao.DataIntegrityViolationException

@Secured(['ROLE_ADMIN'])
class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		def query = User.where{}
		String q = params.q
		if(q) {
			def qLike = "%${q}%"
			query = query.where { username =~ qLike || realName =~ qLike }
		}
		params.sort = params.sort ?: 'username'
		params.order = params.order ?: 'asc'
		
		cache validFor: 20
		
        [userInstanceList: query.list(params), userInstanceTotal: query.count()]
    }

    def create() {
        def userInstance = new User(params)
		userInstance.enabled = true
		
		cache validFor: 1800  // 缓存 30 分钟
		
        [userInstance: userInstance, ROLE_USER: true, ROLE_POST: false, ROLE_ADMIN: false]
    }

    def save() {
        def userInstance = new User(params)
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }
		
		// 分配权限
		if(params.ROLE_USER) {
			UserRole.create(userInstance, Role.findByAuthority('ROLE_USER'), true)
		}
		if(params.ROLE_POST) {
			UserRole.create(userInstance, Role.findByAuthority('ROLE_POST'), true)
		}
		if(params.ROLE_ADMIN) {
			UserRole.create(userInstance, Role.findByAuthority('ROLE_ADMIN'), true)
		}

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def show(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }
		
        [userInstance: userInstance]
    }

    def edit(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }
		
		def roles = userInstance.authorities.collect { it.authority }
		
        [userInstance: userInstance, ROLE_USER: 'ROLE_USER' in roles, ROLE_POST: 'ROLE_POST' in roles, ROLE_ADMIN: 'ROLE_ADMIN' in roles]
    }

    def update(Long id, Long version) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }
		
		// 更新权限
		def authOld = userInstance.authorities
		def authNew = []
		if(params.ROLE_USER) authNew << Role.findByAuthority('ROLE_USER')
		if(params.ROLE_POST) authNew << Role.findByAuthority('ROLE_POST')
		if(params.ROLE_ADMIN) authNew << Role.findByAuthority('ROLE_ADMIN')
		boolean changed = false
		// 删除旧权限
		authOld.each { role->
			if(!(role in authNew)) {
				UserRole.remove(userInstance, role)
				changed = true
			}
		}
		// 增加新权限
		authNew.each { role->
			if(!(role in authOld)) {
				UserRole.create(userInstance, role)
				changed = true
			}
		}
		// 若修改自己的权限，则需要重新认证
		if(changed && userInstance.id == springSecurityService.currentUser.id) {
			springSecurityService.reauthenticate(userInstance.username)
		}

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def delete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "show", id: id)
        }
    }
}
