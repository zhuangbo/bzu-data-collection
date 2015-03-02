package bzu.idata

import grails.plugins.springsecurity.Secured;

import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.dao.DataIntegrityViolationException

import bzu.utils.UserAgentUtils;

@Secured(['ROLE_USER','ROLE_POST'])
class SheetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService
	def entryService

	@Secured(['ROLE_POST'])
    def create() {
		// 只有作者可以修改表单
		def eid = params.long('entry.id')
		if(!eid || !(isAuthor(Entry.get(eid)))) {
			displayFlashMessage(text:"只有项目发布者本人可以添加表单", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}
		
        [sheetInstance: new Sheet(params)]
    }
	
	private boolean isAuthor(Entry entryInstance) {
		entryService.isAuthor(entryInstance, (Long)(springSecurityService.principal.id))
	}
	private boolean isAuthor(Sheet sheetInstance) {
		entryService.isAuthor(sheetInstance, (Long)(springSecurityService.principal.id))
	}

	@Secured(['ROLE_POST'])
    def save() {
		// 只有作者可以修改表单
		def eid = params.long('entry.id')
		if(!eid || !(isAuthor(Entry.get(eid)))) {
			redirect controller:'errors', action:'forbidden'
			return
		}
        def sheetInstance = new Sheet(params)
		// 简化表头表格
		sheetInstance.tableHeader = HtmlTableUtil.simplifyHtmlTable(sheetInstance.tableHeader)
		
        if (!sheetInstance.save(flush: true)) {
            render(view: "create", model: [sheetInstance: sheetInstance])
            return
        }
		
        flash.message = message(code: 'default.created.message', args: [message(code: 'sheet.label', default: 'Sheet'), "【${sheetInstance.name}】"])
		displayFlashMessage(text:flash.message, type:'info')
        redirect(action: "show", id: sheetInstance.id)
    }

    def show(Long id, int max) {
        def sheetInstance = Sheet.get(id)
        if (!sheetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheet.label', default: 'Sheet'), id])
			displayFlashMessage(text:flash.message, type:'error')
            redirect(controller: "errors", action:'notFound')
            return
        }
		// 必须对当前用户可见或作者本人
		if(! isVisible(sheetInstance)) {
			redirect(controller: "errors", action:'notFound')
			return
		}
		
		def now = new Date()
		// 产生若干随机数保护敏感的链接
		session.DATADELMSK = BCrypt.gensalt(1)
		session.DATADELMSKTIME = new Date(now.time + 5*60*1000) // 5分钟后过期
		// 查询数据列表
		// 对作者显示所有，对一般用户仅显示用户提交的记录
		def query = Data.where { sheet.id==id }
		def dataTotal = query.count()
		if(! isAuthor(sheetInstance)) {
			query = query.where { submitter.id==springSecurityService.principal.id }
		}
		if(params.q) {
			displayMessage(text:"搜索 “${params.q}” 的结果：", type:'info')
			query = query.where { text =~ "%${params.q}%" }
		}
		
		cache validFor: 20  // 缓存 20 秒
		
		params.max = Math.min(max ?: 10, 100)
        [sheetInstance: sheetInstance, dataList: query.list(params), dataCount: query.count(), dataTotal: dataTotal]
    }
	
	private boolean isVisible(Sheet sheetInstance){
		def user = springSecurityService.currentUser
		entryService.isVisible(sheetInstance, user) || entryService.isAuthor(sheetInstance, user)
	}

	@Secured(['ROLE_POST'])
    def edit(Long id) {
        def sheetInstance = Sheet.get(id)
        if (!sheetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheet.label', default: 'Sheet'), id])
			displayFlashMessage(text:flash.message, type:'error')
            redirect(controller: "errors", action:'notFound')
            return
        }
		// 只有作者可以修改表单
		if(! isAuthor(sheetInstance)) {
			displayFlashMessage(text:"只有项目发布者本人可以修改表单", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}
		
        [sheetInstance: sheetInstance]
    }

	@Secured(['ROLE_POST'])
    def update(Long id, Long version) {
        def sheetInstance = Sheet.get(id)
        if (!sheetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheet.label', default: 'Sheet'), id])
			displayFlashMessage(text:flash.message, type:'error')
            redirect(controller: "errors", action:'notFound')
            return
        }
		// 只有作者可以修改表单
		if(! isAuthor(sheetInstance)) {
			displayFlashMessage(text:"只有项目发布者本人可以更新表单", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}

        if (version != null) {
            if (sheetInstance.version > version) {
                sheetInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'sheet.label', default: 'Sheet')] as Object[],
                          "Another user has updated this Sheet while you were editing")
                render(view: "edit", model: [sheetInstance: sheetInstance])
                return
            }
        }

        sheetInstance.properties = params
		// 简化表头表格
		sheetInstance.tableHeader = HtmlTableUtil.simplifyHtmlTable(sheetInstance.tableHeader)
		
        if (!sheetInstance.save(flush: true)) {
            render(view: "edit", model: [sheetInstance: sheetInstance])
            return
        }
		
        flash.message = message(code: 'default.updated.message', args: [message(code: 'sheet.label', default: 'Sheet'), "【${sheetInstance.name}】"])
		displayFlashMessage(text:flash.message, type:'info')
        redirect(action: "show", id: sheetInstance.id)
    }

	@Secured(['ROLE_POST'])
    def delete(Long id) {
        def sheetInstance = Sheet.get(id)
        if (!sheetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheet.label', default: 'Sheet'), id])
			displayFlashMessage(text:flash.message, type:'error')
            redirect(controller: "errors", action:'notFound')
            return
        }
		// 只有作者可以修改表单
		if(! isAuthor(sheetInstance)) {
			displayFlashMessage(text:"只有项目发布者本人可以删除表单", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}

        try {
			def eid = sheetInstance.entry.id
            sheetInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'sheet.label', default: 'Sheet'), "【${sheetInstance.name}】"])
			displayFlashMessage(text:flash.message, type:'info')
            redirect(controller: "entry", action: 'show', id: eid)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'sheet.label', default: 'Sheet'), "【${sheetInstance.name}】"])
    		displayFlashMessage(text:flash.message, type:'error')
            redirect(action: "show", id: id)
        }
    }
	
	// 提交数据
	def submitDatum(Long id, String text) {
		def sheetInstance = Sheet.get(id)
		if (!sheetInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheet.label', default: 'Sheet'), id])
			displayFlashMessage(text:flash.message, type:'error')
            redirect(controller: "errors", action:'notFound')
			return
		}
		// 必须对当前用户可见
		if(! isVisible(sheetInstance)) {
			displayFlashMessage(text:"当前用户不可查看", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}
		// 项目已经开始，没有关闭，且未结束
		def status = sheetInstance.entry.status
		if(status != Entry.STATUS_OK) {
			displayFlashMessage(text:"该项目${status}，不能提交数据。", type:'error')
			redirect action:'show', id:id
			return
		}
		// 检查记录限制
		Long uid = (Long)(springSecurityService.principal.id)
		int limit = sheetInstance.rowMax
		int ncount = 0 // FIX: 20141111 下面用到此变量
		if(limit > 0) { // FIX: 20141110 用 0 表示无限制
			ncount = Data.where { sheet.id==id && submitter.id==uid }.count() // FIX: 20141101
			if(ncount >= limit) {
				displayFlashMessage(text:"您已经达到提交数据数量的上限，必须删除部分数据后才可以继续提交。", type:'error')
				redirect action:'show', id:id
				return
			}
		}
		
		def user = springSecurityService.currentUser
		int ns = 0  // 提交成功的
		int ne = 0  // 保存失败的
		int ni = 0  // 达到上限后忽略的
		
		// 从 HTML 文本中取出表格中的数据
		// FIX: v1.5 20141221 导入数据为 HTML 格式
		text.findAll(/(?ms)<table.*?<\/table>/) { table->
			int rowspan = 1 // 初始化合并行数
			def data = new StringBuilder()
			// 分离出表格中的各行
			table.findAll(/(?ms)<tr.*?<\/tr>/) { tr->
				// 检查记录个数限制
				if(limit > 0 && ncount+ns < limit) { // FIX: 20141110 用 0 表示无限制
					// 分离出表格中各个单元格
					def tds = tr.findAll(/(?ms)<td.*?<\/td>/) { td->
						def buf = new StringBuilder('<td')
						// 提取需要保留的属性 rowspan
						td.find(/(?ms)<td.*?rowspan\s*=\s*['"]\s*(\S+)\s*['"].*?>/)
						{
							def val = it[1].toInteger()
							if(val > 1) buf.append(" rowspan=\"${val}\"")
							if(val > rowspan) rowspan = val
						}
						// 提取需要保留的属性 colspan
						td.find(/(?ms)<td.*?colspan\s*=\s*['"]\s*(\S+)\s*['"].*?>/)
						{
							def val = it[1].toInteger()
							if(val > 1) buf.append(" colspan=\"${val}\"")
						}
						// 提取单元格内容
						def t = ''
						td.find(/(?ms)>(.*)</) {
							// 清除单元格内部的标记，保留换行，将空白符替换为空格，去掉两端的空白
							t = it[1].replaceAll(/<br>\s*?<\/br>|<br\s?\/>|<br>|<p><\/p>|<p>/,'\n').
										replaceAll(/<[^>]*?>/,'').
											replaceAll(/&ensp;|&emsp;|&nbsp;/, ' ').
												trim()
						}
						
						// 重新组合为精简的单元格
						buf.append(">${t}</td>")
						// 返回精简后的单元格
						buf.toString()
					}.join("")
					// 返回精简后的行
					data.append("<tr>${tds}</tr>")
					
					// 一条记录结束时保存到数据库
					if(--rowspan == 0) {
						// 读取完成一条记录，保存到数据库
						try {
							if(new Data(sheet:sheetInstance, text:data, submitter:user).save()) {
								++ns  // 提交成功
							} else {
								++ne  // 保存失败
							}
						} catch (Exception ex) {
							++ne  // 保存失败
						}
						// 准备读下一条记录
						rowspan = 1 // 初始化合并行数
						data.setLength(0) // 清空数据
					}
				} else {
					++ni  // 已达上限，忽略
				}
			}
		}
		
		displayFlashMessage(text:"成功提交 ${ns} 条记录${ne ?'，保存失败 '+ ne + ' 条记录' : ''}${ni ? '，丢弃 '+ni+' 条记录' : ''}。", type:"${ni||ne||!ns ? 'error' : 'info'}")
		redirect action:'show', id:id
	}
	
	def deleteDatum(Long id) {
		if(!id || !params.mask || !session.DATADELMSK ||  !session.DATADELMSKTIME || !springSecurityService.loggedIn) {
			displayFlashMessage(text:"非法的访问请求", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}
		def now = new Date()
		if(session.DATADELMSKTIME < now || session.DATADELMSK != params.mask) {
			displayFlashMessage(text:"页面内容已过期，请重试。", type:'error')
			redirect action:'show', id:id
			return
		}
		def ids = params.ids
		if(!ids || ids.size()==1) {
			displayFlashMessage(text:"未找到待删除的数据。", type:'error')
			redirect action:'show', id:id
			return
		}
        def sheetInstance = Sheet.get(id)
        if (!sheetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheet.label', default: 'Sheet'), id])
			displayFlashMessage(text:flash.message, type:'error')
            redirect(controller: "errors", action:'notFound')
            return
        }
		// 项目已经开始，没有关闭，且未结束
		def status = sheetInstance.entry.status
		if(status != Entry.STATUS_OK) {
			displayFlashMessage(text:"该项目${status}，不能删除数据。", type:'error')
			redirect action:'show', id:id
			return
		}
		// 只有提交者本人可以删除数据
		def user = springSecurityService.currentUser
		ids = ids.collect { it.toLong() }
		int rows = Data.where { (id in ids) && (submitter==user) }.deleteAll()
		
		displayFlashMessage(text:"成功删除 ${rows} 条数据。", type:'info')
		redirect action:'show', id:id
	}
	
	def export(Long id) {
        def sheetInstance = Sheet.get(id)
        if (!sheetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheet.label', default: 'Sheet'), id])
			displayFlashMessage(text:flash.message, type:'error')
            redirect(controller: "errors", action:'notFound')
            return
        }
		// 只有发布者本人可以导出数据
		if(! isAuthor(sheetInstance)) {
			displayFlashMessage(text:"只有项目发布者本人可以导出表单", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}
		
		[sheetInstance: sheetInstance]
	}
	
	def exportExcel(Long id) {
        def sheetInstance = Sheet.get(id)
        if (!sheetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'sheet.label', default: 'Sheet'), id])
			displayFlashMessage(text:flash.message, type:'error')
            redirect(controller: "errors", action:'notFound')
            return
        }
		// 只有发布者本人可以导出数据
		if(! isAuthor(sheetInstance)) {
			displayFlashMessage(text:"只有项目发布者本人可以导出表单", type:'error')
			redirect controller:'errors', action:'forbidden'
			return
		}

		def wb = new HSSFWorkbook()
		entryService.export(sheetInstance, wb, params)
		def datetime = new Date().format('yyyyMMddHHmmss')
		def filename = "Entry-${sheetInstance.entry.id}-Sheet-${sheetInstance.id}-${datetime}.xls"
		String agent = request.getHeader("User-Agent")
		String attachmentWithFilename = UserAgentUtils.makeAttachmentFilename(filename, agent)
		response.setContentType("application/vnd.ms-excel")
		response.setHeader("Content-disposition", attachmentWithFilename)
		// 输出
		wb.write(response.outputStream)
		response.outputStream.close()  // 避免页面无法访问的问题
	}
}
