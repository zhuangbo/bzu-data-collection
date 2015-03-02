package bzu.idata

import grails.plugins.springsecurity.Secured;

@Secured(['ROLE_ADMIN'])
class ManageController {

    def index() {
		cache validFor: 1800  // 缓存 30 分钟
	}
}
