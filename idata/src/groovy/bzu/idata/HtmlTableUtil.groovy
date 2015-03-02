package bzu.idata

/**
 * 从包含表格的 HTML 代码中分离出简化的表格代码
 */
class HtmlTableUtil {
	
	/**
	 * 从 HTML 代码中抽取出所有（简化的）表格
	 * @param html HTML 代码
	 * @param attrs 保留单元格的某些属性
	 * @return 一个字符串的列表，依次包含各个表格代码
	 */
	public static List<String> simplifyHtmlAllTables(String html, Map attrs=[rowspan:1, colspan:1, width:0]) {
		// 分离出各个表格
		def tables = html.findAll(/(?ms)<table.*?<\/table>/) { table->
			// 抽取表格
			extractTable(table, attrs)
		}
		// 返回精简后的各个表格（包含所有表格的 List）
		tables
	}

	/**
	 * 从 HTML 代码中抽取出第一个（简化的）表格
	 * @param html HTML 代码
	 * @param attrs 保留单元格的某些属性
	 * @return 第一表格的代码
	 */
	public static String simplifyHtmlTable(String html, Map attrs=[rowspan:1, colspan:1, width:0]) {
		// 分离出第一个表格
		def tableHtml = html.find(/(?ms)<table.*?<\/table>/) { table->
			// 抽取表格
			extractTable(table, attrs)
		}
		// 返回精简后的表格（字串）
		tableHtml
	}
	
	private static String extractTable(String table, Map attrs) {
		// 取出表格宽度
		int width = extractTableWidth(table)
		// 抽取 <colgroup> 中定义的列宽
		def colgroup = extractColgroup(table)
		// 简化表格中的行
		def trs = simplifyRows(table, attrs)
		// 返回精简后的表格
		"<table${width>0?' width=\"'+width+'\"':''}>${colgroup?colgroup:''}${trs}</table>"
	}
	
	public static String extractColgroup(String table) {
		// 抽取 <colgroup> 中定义的列宽
		def cols = []
		table.find(/(?ms)<colgroup>.*<\/colgroup>/) { colgroup->
			colgroup.findAll(/<col[^>]*width="(\d+)"[^>]*>/) {
				cols << it[1].toInteger()
			}
		}
		def colgroup = ''
		if(cols) {
			colgroup = "<colgroup>" + cols.collect {
				"<col width=\"${it}\">"
			}.join('') + "</colgroup>"
		}
		return colgroup
	}
	
	private static int extractTableWidth(String table) {
		int width = 0
		table.find(/(?ms)<table.*?width\s*=\s*['"]\s*(\d+)\s*['"].*?>/) {
			width = it[1].toInteger()
		}
		return width
	}

	public static String simplifyRows(String table, Map attrs) {
		// 分离出表格中的各行
		table.findAll(/(?ms)<tr.*?<\/tr>/) { tr->
			// 简化表格中的单元格
			def tds = simplifyCells(tr, attrs)
			// 返回精简后的行
			"<tr>${tds}</tr>"
		}.join("")
	}

	/**
	 * 简化一行中各单元格内容
	 * @param tr 数据行
	 * @param attrs 默认的单元格属性，如：[rowspan:1, colspan:1, width:0]
	 * @return 精简后的各单元格
	 */
	public static String simplifyCells(String tr, Map attrs) {
		// 分离出表格中各个单元格
		tr.findAll(/(?ms)<td.*?<\/td>/) { td->
			def buf = new StringBuilder('<td')
			// 提取需要保留的属性
			attrs.each { attr, val->
				td.find(/(?ms)<td.*?${attr}\s*=\s*['"]\s*(\S+)\s*['"].*?>/)
				{
					if(it[1]!=val.toString()) buf += " ${attr}=\"${it[1]}\""
				}
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
			buf += ">${t}</td>"
			// 返回精简后的单元格
			buf.toString()
		}.join("")
	}
}
