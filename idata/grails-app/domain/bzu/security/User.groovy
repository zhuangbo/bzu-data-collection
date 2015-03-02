package bzu.security

import grails.util.Holders;

class User {

	transient springSecurityService

	String username
	String password
	String realName
	String department	// 部门编号
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static constraints = {
		username nullable: false, blank: false, unique: true, maxSize: 20
		realName nullable: false, blank: false, maxSize: 20
		department nullable: false, blank: false, maxSize: 2, inList: (Holders.config.app.departments + ['00'])
		enabled ()
		accountExpired ()
		accountLocked ()
		passwordExpired ()
		password blank: false, maxSize: 80
	}

	static mapping = {
		password column: '`password`'
		version false
		cache true
		sort 'username'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
	
	String toString() {
		"${realName}[${username}]"
	}
}
