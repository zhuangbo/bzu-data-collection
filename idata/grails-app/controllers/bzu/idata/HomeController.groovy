package bzu.idata

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils;
import org.codehaus.groovy.grails.web.servlet.HttpHeaders;

import bzu.security.User;
import grails.plugins.springsecurity.Secured;

@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
class HomeController {

	def springSecurityService
	def entryService
	
    def index() {
		
		if(springSecurityService.loggedIn && SpringSecurityUtils.ifAnyGranted("ROLE_USER,ROLE_POST")) {
			User user = springSecurityService.currentUser
			def query = Entry.where {
					visibility==Entry.VISIBILITY_ALL ||
					author.id == user.id ||
					(visibility==Entry.VISIBILITY_DEPARTMENT && department==user.department) ||
					(visibility==Entry.VISIBILITY_USERNAME && submitters =~ "%${user.username}%")
			}
			// 最新项目：最近发布的数据采集项目，至多列出最近 10 项。
			def qlastEntryList = query.sort("endTime", "desc").max(10)
			// 我参与：用户曾经提交数据的项目，至多列出最近 10 项。
			def hql = "select d.sheet.entry from bzu.idata.Data d where d.submitter.id=? group by d.sheet.entry order by d.sheet.entry.endTime desc"
			def submitEntryList = Entry.executeQuery(hql, [user.id], [max:10])
			// 我发布：用户曾经发布的数据采集项目，至多列出最近 10 项
			def qpostEntryList = Entry.where { author.id == user.id }.sort("endTime", "desc").max(10)
			
			cache validFor: 5

			[lastEntryList: qlastEntryList.list(), submitEntryList: submitEntryList, postEntryList: qpostEntryList.list()]
		}
	}
}
