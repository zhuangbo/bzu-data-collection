package bzu.idata

import grails.plugins.springsecurity.Secured;

import org.springframework.dao.DataIntegrityViolationException

import bzu.security.User;
import bzu.utils.UserAgentUtils;

@Secured(['ROLE_USER','ROLE_POST'])
class EntryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService
	def entryService
	
	// 在 save 和 update 之前进行日期转换
	def beforeInterceptor = [action: this.&resolveDatetime, only: ['save','update']]
	
	private resolveDatetime() {
		params.startTime = "${params.startTime} ${params.startHHmm}"
		params.endTime = "${params.endTime} ${params.endHHmm}"
		params.startTime = params.date('startTime', 'yyyy-MM-dd HH:mm')
		params.endTime = params.date('endTime', 'yyyy-MM-dd HH:mm')
	}

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
		User user = springSecurityService.currentUser
		def query = Entry.where {
			visibility==Entry.VISIBILITY_ALL ||
			author.id == user.id ||
			(visibility==Entry.VISIBILITY_DEPARTMENT && department==user.department) ||
			(visibility==Entry.VISIBILITY_USERNAME && submitters =~ "%${user.username}%")
		}
		if(params.q) {
			displayMessage(text:"搜索 “${params.q}” 的结果：", type:'info')
			query = query.where { title =~ "%${params.q}%" }
		}
		params.sort = params.sort ?: 'endTime'
		params.order = params.order ?: 'desc'
        params.max = Math.min(max ?: 10, 100)
		
        cache validFor: 20
		
        [entryInstanceList: query.list(params), entryInstanceTotal: query.count()]
    }

	@Secured(['ROLE_POST'])
    def create() {
        [entryInstance: new Entry(params)]
    }

	@Secured(['ROLE_POST'])
    def save() {
        def entryInstance = new Entry(params)
		entryInstance.author = springSecurityService.currentUser
		if(entryInstance.visibility!=Entry.VISIBILITY_DEPARTMENT) {
			entryInstance.department = null
		}
		if(entryInstance.visibility!=Entry.VISIBILITY_USERNAME) {
			entryInstance.submitters = null
		}
		
        if (!entryInstance.save(flush: true)) {
            render(view: "create", model: [entryInstance: entryInstance])
            return
        }
		
        flash.message = message(code: 'default.created.message', args: [message(code: 'entry.label', default: 'Entry'), "【${entryInstance.title}】"])
		displayFlashMessage(text:flash.message, type:'info')
        redirect(action: "show", id: entryInstance.id)
    }

    def show(Long id) {
        def entryInstance = Entry.get(id)
        if (!entryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'entry.label', default: 'Entry'), id])
    		displayFlashMessage(text:flash.message, type:'error')
            redirect(action: "list")
            return
        }
		// 是否允许用户查看
		if(! isVisible(entryInstance)) {
			redirect controller:'errors', action:'notFound'
			return
		}
		
        [entryInstance: entryInstance]
    }
	
	private boolean isVisible(Entry entryInstance) {
		def user = springSecurityService.currentUser
		return entryService.isVisible(entryInstance, user) || entryService.isAuthor(entryInstance, user)
	}

	@Secured(['ROLE_POST'])
    def edit(Long id) {
        def entryInstance = Entry.get(id)
        if (!entryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'entry.label', default: 'Entry'), id])
    		displayFlashMessage(text:flash.message, type:'error')
            redirect(action: "list")
            return
        }
		// 只有发布者本人可以修改
		if(! isAuthor(entryInstance)) {
			displayFlashMessage(text:"只有发布者本人可以修改项目", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}
		
        [entryInstance: entryInstance]
    }
	
	private boolean isAuthor(Entry entryInstance) {
		entryService.isAuthor(entryInstance, (Long)(springSecurityService.principal.id))
	}

	@Secured(['ROLE_POST'])
    def update(Long id, Long version) {
        def entryInstance = Entry.get(id)
        if (!entryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'entry.label', default: 'Entry'), id])
    		displayFlashMessage(text:flash.message, type:'error')
            redirect(action: "list")
            return
        }
		// 只有发布者本人可以修改
		if(! isAuthor(entryInstance)) {
			displayFlashMessage(text:"只有发布者本人可以更新项目", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}

        if (version != null) {
            if (entryInstance.version > version) {
                entryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'entry.label', default: 'Entry')] as Object[],
                          "Another user has updated this Entry while you were editing")
                render(view: "edit", model: [entryInstance: entryInstance])
                return
            }
        }

        entryInstance.properties = params
		entryInstance.author = springSecurityService.currentUser // 不能改变作者
		if(entryInstance.visibility!=Entry.VISIBILITY_DEPARTMENT) {
			entryInstance.department = null
		}
		if(entryInstance.visibility!=Entry.VISIBILITY_USERNAME) {
			entryInstance.submitters = null
		}

        if (!entryInstance.save(flush: true)) {
            render(view: "edit", model: [entryInstance: entryInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'entry.label', default: 'Entry'), "【${entryInstance.title}】"])
    	displayFlashMessage(text:flash.message, type:'info')
        redirect(action: "show", id: entryInstance.id)
    }

	@Secured(['ROLE_POST'])
    def delete(Long id) {
        def entryInstance = Entry.get(id)
        if (!entryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'entry.label', default: 'Entry'), id])
    		displayFlashMessage(text:flash.message, type:'error')
            redirect(action: "list")
            return
        }
		// 只有发布者本人可以修改
		if(! isAuthor(entryInstance)) {
			displayFlashMessage(text:"只有发布者本人可以删除项目", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}

        try {
            entryInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'entry.label', default: 'Entry'), "【${entryInstance.title}】"])
    		displayFlashMessage(text:flash.message, type:'info')
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'entry.label', default: 'Entry'), "【${entryInstance.title}】"])
    		displayFlashMessage(text:flash.message, type:'error')
            redirect(action: "show", id: id)
        }
    }
	
	def export(Long id) {
		def entryInstance = Entry.get(id)
		if (!entryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'entry.label', default: 'Entry'), id])
    		displayFlashMessage(text:flash.message, type:'error')
			redirect(action: "list")
			return
		}
		// 只有发布者本人可以导出数据
		if(! isAuthor(entryInstance)) {
			displayFlashMessage(text:"只有发布者本人可以导出数据", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}
		
		[entryInstance: entryInstance]
	}
	
	def exportExcel(Long id) {
		def entryInstance = Entry.get(id)
		if (!entryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'entry.label', default: 'Entry'), id])
    		displayFlashMessage(text:flash.message, type:'error')
			redirect(action: "list")
			return
		}
		// 只有发布者本人可以修改
		if(! isAuthor(entryInstance)) {
			displayFlashMessage(text:"只有发布者本人可以导出数据", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}

		def wb = entryService.export(entryInstance, params)
		def datetime = new Date().format('yyyyMMddHHmmss')
		def filename = "Entry-${entryInstance.id}-${datetime}.xls"
		String agent = request.getHeader("User-Agent")
		String attachmentWithFilename = UserAgentUtils.makeAttachmentFilename(filename, agent)
		response.setContentType("application/vnd.ms-excel")
		response.setHeader("Content-disposition", attachmentWithFilename)
		// 输出
		wb.write(response.outputStream)
		response.outputStream.close()  // 避免页面无法访问的问题
	}
}
