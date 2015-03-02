package bzu.idata

import java.util.Date;
import java.util.Set;

// 表单
class Sheet {
	public static final int ROW_MAX_NO_LIMIT = 0 // 提交数据记录数不限
	
	Entry entry
	String name
	String description
	String remarks
	String tableHeader
	Date dateCreated
	Date lastUpdated
	int rowMax = 5
	
	Set<Data> datum
	
	static belongsTo = [entry: Entry]
	static hasMany = [datum: Data]
	
    static constraints = {
		entry nullable: false
		name nullable: false, blank: false
		description nullable: true, blank: true, widget: 'textarea'
		remarks nullable: true, blank: true, widget: 'textarea'
		tableHeader nullable: false, blank: false, maxSize: 32760, widget: 'textarea'
		rowMax nullable: false, min: 0
		dateCreated ()
		lastUpdated ()
    }
	
	static mapping = {
		sort 'id'
		datum sort:'id'
		tableHeader sqlType:'varchar', length:32760
	}
	
	String toString() {
		name
	}
}
