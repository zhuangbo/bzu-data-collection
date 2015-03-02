package bzu.idata

import bzu.security.User
import java.util.Date;

// 提交数据（行）
class Data {
	Sheet sheet
	String text
	User submitter
	Date dateCreated
	Date lastUpdated
	
	static belongsTo = [sheet: Sheet]
	
	static constraints = {
		sheet nullable: false
		text nullable: false, blank: false, maxSize:65520
		submitter nullable: false
		dateCreated ()
		lastUpdated ()
	}
	
	static mapping = {
		sort 'id'
		text sqlType:'varchar', length:65520
	}
}
