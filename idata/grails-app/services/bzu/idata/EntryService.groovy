package bzu.idata

import grails.gorm.DetachedCriteria;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress
import org.apache.poi.ss.util.RegionUtil;
import org.springframework.context.MessageSource
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.i18n.SessionLocaleResolver

import bzu.idata.Entry;
import bzu.idata.Sheet;
import bzu.security.User;

class EntryService {
	static transactional = false
	
	SessionLocaleResolver localeResolver
	MessageSource messageSource
	
	boolean isVisible(Entry entry, User user) {
		if(!entry || !user) return false
		return (entry.visibility==Entry.VISIBILITY_ALL  // 对所有人可见
			|| entry.visibility==Entry.VISIBILITY_DEPARTMENT && entry.department==user.department
			|| entry.visibility==Entry.VISIBILITY_USERNAME && entry.submitters.indexOf(user.username)!=-1)
	}
	
	boolean isVisible(Sheet sheet, User user) {
		if(!sheet || !user) return false
		return isVisible(sheet.entry, user)
	}
	
	boolean isAuthor(Entry entry, User user) {
		if(!entry || !user) return false
		return entry.author?.id == user.id
	}
	boolean isAuthor(Entry entry, Long uid) {
		if(!entry || !uid) return false
				return entry.author?.id == uid
	}
	boolean isAuthor(Sheet sheet, User user) {
		if(!sheet || !user) return false
		return isAuthor(sheet.entry, user)
	}
	boolean isAuthor(Sheet sheet, Long uid) {
		if(!sheet || !uid) return false
				return isAuthor(sheet.entry, uid)
	}

	/**
	 * 导出项目为 Excel 工作簿
	 */
	def export(Entry entry, params) {
		Workbook wb = new HSSFWorkbook()
		entry.sheets.each { sheet->
			export(sheet, wb, params)
		}
		// 返回工作簿
		return wb
	}
	
	def export(Sheet sheet, HSSFWorkbook wb, params) {
		// 新建样式（单元格加边框）
		CellStyle cs = wb.createCellStyle();
		cs.setBorderTop(CellStyle.BORDER_THIN)
		cs.setBorderBottom(CellStyle.BORDER_THIN)
		cs.setBorderLeft(CellStyle.BORDER_THIN)
		cs.setBorderRight(CellStyle.BORDER_THIN)
		cs.setAlignment(CellStyle.ALIGN_CENTER);
		cs.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

		// 新建工作表
		def sh = wb.createSheet("${sheet.name}(${sheet.id})")
		// 导出表头
		int i = exportHtmlTable(sheet.tableHeader, wb, sh, cs)
		// 逐条导出数据
		Data.where { sheet==sheet }.list(params).each { data->
			// 检查数据格式：HTML 或 TAB
			if(isHtmlFormat(data.text)) { // HTML 格式
				// 导出 HTML 数据
				int rowStart = i
				i = exportHtmlData(data.text, wb, sh, rowStart, cs)
				// 在记录后面附加提交者、所在单位和提交时间
				attachExtendedFields(sh.getRow(rowStart), data, params)
			} else { // TAB	格式
				// 新建行
				Row row = sh.createRow(i++)
				// 逐个插入单元格，填充数据数据，添加边框
				int j = 0
				data.text.split('\t').each {
					def cell = row.createCell(j++)
					cell.setCellValue(it)
					cell.setCellStyle(cs)
				}
				// 在记录后面附加提交者、所在单位和提交时间
				attachExtendedFields(row, data, params)
			}
		}
	}
	
	private void attachExtendedFields(Row row, Data data, params) {
		def fields = params.extendedFields ?: []
		int j = row.lastCellNum
		if('submitter' in fields) {
			row.createCell(j++).setCellValue(data.submitter.toString())
		}
		if('submitter.department' in fields) {
			row.createCell(j++).setCellValue(data.submitter.department)
		}
		if('submitter.department.name' in fields) {
			row.createCell(j++).setCellValue(messageSource.getMessage(
				"department.${data.submitter.department}",
				[] as Object[], localeResolver.defaultLocale))
		}
		if('lastUpdated' in fields) {
			row.createCell(j++).setCellValue(data.lastUpdated.format('yyyy-MM-dd HH:mm:ss.S'))
		}
	}
	
	private boolean isHtmlFormat(String text) {
		text.startsWith('<tr><td')
	}
	private boolean isTabFormat(String text) {
		! isHtmlFormat(text)
	}

	// 导出表头。根据表头的 HTML 代码 htmlTable，导出到工作簿 wb 中的工作表 sh
	private int exportHtmlTable(String htmlTable, HSSFWorkbook wb, HSSFSheet sh, CellStyle cs) {
		// 记录已合并的单元格
		//   若 cell(i,j) 已被合并，则添加一个元素 k = (i<<10)+j
		//   此后可以检索 k 得知该单元格被合并的情况
		def cellMerged = new HashSet<Integer>()
		def mergedMark = { i, j-> (i<<10) + j}
		def isMerged = { i, j-> cellMerged.contains(mergedMark(i,j)) }
		def setMerged = { i, j-> cellMerged.add(mergedMark(i,j))}
		
		int nrow = htmlTable.count('</tr>')
		for(int i=0; i<nrow; ++i)
			sh.createRow(i);
		
		int i // 行号
		int j // 列号
		// 遍历表格
		htmlTable.find(/(?ms)<table.*?<\/table>/) { table->
			// 设置各列宽度
			boolean columnWidthOk = false
			//-- 获取列宽
			def colWidth = []
			table.find(/(?ms)<colgroup>.*<\/colgroup>/) { colgroup->
				colgroup.findAll(/<col[^>]*width="(\d+)"[^>]*>/) {
					colWidth << it[1].toInteger()
				}
			}
			//-- 设置各列宽度
			if(colWidth) {
				int ncol = colWidth.size()
				for(int k=0; k<ncol; ++k) {
					sh.setColumnWidth(k, colWidth[k] * 38) // *38 转换为 Excel 中的宽度
				}
				columnWidthOk = true
			}
			
			// 逐行分析表格内容
			i = 0
			table.findAll(/(?ms)<tr.*?<\/tr>/) { tr->
				// 创建行
				def row = sh.getRow(i)
				
				// 遍历本行中的单元格
				j = 0
				tr.findAll(/(?ms)<td.*?<\/td>/) { td->
					//// 提取单元格内容及参数
					//-- 提取单元格内容
					def text = ''
					td.find(/(?ms)>([^<]*)</) {
						// 清除单元格内部的标记、空白，将空白符替换为空格，去掉两端的空白
						text = it[1].replaceAll(/<[^>]*>|[\s]*/,'').replaceAll(/&ensp;|&emsp;|&nbsp;/, ' ').trim()
					}
					//-- 提取单元格属性
					def attrs = [rowspan:1, colspan:1]
					if(! columnWidthOk) attrs.width = 0
					attrs.each { attr, val->
						td.find(/(?ms)<td.*?${attr}\s*=\s*['"]\s*(\d+)\s*['"].*?>/)	{
							int v = it[1].toInteger()
							if(v != val) attrs[attr] = v
						}
					}
		
					//// 新建单元格，写入内容
					//-- 找到写入位置（本行下一个未被合并的单元格）
					while(isMerged(i,j)) { ++j }
					//-- 设置列宽（如有必要）
					if(! columnWidthOk && attrs.width>0 && attrs.colspan==1) {
						sh.setColumnWidth(j, attrs.width * 38)
					}
					//-- 写入单元格
					Cell cell = row.createCell(j)
					cell.setCellStyle(cs)
					cell.setCellValue(text)
					
					//-- 创建合并区域
					def region = new CellRangeAddress(i, i+attrs.rowspan-1, j, j+attrs.colspan-1)
					sh.addMergedRegion(region)
					RegionUtil.setBorderTop(CellStyle.BORDER_THIN, region, sh, wb)
					RegionUtil.setBorderBottom(CellStyle.BORDER_THIN, region, sh, wb)
					RegionUtil.setBorderLeft(CellStyle.BORDER_THIN, region, sh, wb)
					RegionUtil.setBorderRight(CellStyle.BORDER_THIN, region, sh, wb)
				
					//// 标记被合并的单元格
					for(int ri = 0; ri<attrs.rowspan; ++ri)
						for(int rj = 0; rj<attrs.colspan; ++rj)
							setMerged(i+ri, j+rj)
					//// 下一个单元格
					++ j
				}
				// 下一行
				++ i
			}
		}
		return i // 返回已导入的行数
	}
	
	// 导出 HTML 格式的数据
	private int exportHtmlData(String htmlData, HSSFWorkbook wb, HSSFSheet sh, int rowStart, CellStyle cs) {
		// 记录已合并的单元格
		//   若 cell(i,j) 已被合并，则添加一个元素 k = (i<<10)+j
		//   此后可以检索 k 得知该单元格被合并的情况
		def cellMerged = new HashSet<Integer>()
		def mergedMark = { i, j-> (i<<10) + j}
		def isMerged = { i, j-> cellMerged.contains(mergedMark(i,j)) }
		def setMerged = { i, j-> cellMerged.add(mergedMark(i,j))}
		
		int nrow = htmlData.count('</tr>')
		for(int i=0; i<nrow; ++i)
			sh.createRow(i+rowStart);
		
		int i // 行号
		int j // 列号
		
		// 逐行分析数据内容
		i = rowStart
		htmlData.findAll(/(?ms)<tr.*?<\/tr>/) { tr->
			// 创建行
			def row = sh.getRow(i)
			
			// 遍历本行中的单元格
			j = 0
			tr.findAll(/(?ms)<td.*?<\/td>/) { td->
				//// 提取单元格内容及参数
				//-- 提取单元格内容
				def text = ''
				td.find(/(?ms)>([^<]*)</) {
					text = it[1]
				}
				//-- 提取单元格属性
				def attrs = [rowspan:1, colspan:1]
				attrs.each { attr, val->
					td.find(/(?ms)<td.*?${attr}\s*=\s*['"]\s*(\d+)\s*["'].*?>/) {
						int v = it[1].toInteger()
						if(v != val) attrs[attr] = v
					}
				}
		
				//// 新建单元格，写入内容
				//-- 找到写入位置（本行下一个未被合并的单元格）
				while(isMerged(i,j)) { ++j }
				//-- 写入单元格
				Cell cell = row.createCell(j)
				cell.setCellStyle(cs)
				cell.setCellValue(text)
				//-- 标记该单元格
				setMerged(i, j)
				
				//-- 如有必须要，创建合并区域
				if(attrs.colspan>1 || attrs.rowspan>1) {
					def region = new CellRangeAddress(i, i+attrs.rowspan-1, j, j+attrs.colspan-1)
					sh.addMergedRegion(region)
					RegionUtil.setBorderTop(CellStyle.BORDER_THIN, region, sh, wb)
					RegionUtil.setBorderBottom(CellStyle.BORDER_THIN, region, sh, wb)
					RegionUtil.setBorderLeft(CellStyle.BORDER_THIN, region, sh, wb)
					RegionUtil.setBorderRight(CellStyle.BORDER_THIN, region, sh, wb)
					RegionUtil
				
					//// 标记被合并的单元格
					for(int ri = 0; ri<attrs.rowspan; ++ri)
						for(int rj = 0; rj<attrs.colspan; ++rj)
							setMerged(i+ri, j+rj)
				}
				//// 下一个单元格
				++ j
			} // end of find all <td>
			// 下一行
			++ i
		} // end of find all <tr>
		return i // 返回下一个导入数据的行号
	}
	
}
