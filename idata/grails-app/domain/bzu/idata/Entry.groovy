package bzu.idata

import java.util.Date;
import java.util.Set;

import bzu.security.User
import grails.util.Holders;

// 数据采集项目
class Entry {
	public static final char VISIBILITY_ALL = 'A';
	public static final char VISIBILITY_DEPARTMENT = 'D';
	public static final char VISIBILITY_USERNAME = 'U';
	
	public static final String STATUS_OK = '正常';
	public static final String STATUS_CLOSED = '已关闭';
	public static final String STATUS_ENDED = '已结束';
	public static final String STATUS_BEFORE = '未开始';
	
	String title
	User author
	String visibility
	String department
	String submitters
	String description
	String referenceUrl
	String remarks
	Date startTime = new Date()
	Date endTime
	boolean closed
	Date dateCreated
	Date lastUpdated
	
	Set<Sheet> sheets
	
	static hasMany = [sheets: Sheet]

	static constraints = {
		title nullable: false, blank: false
		author nullable: false
		visibility nullable: false, blank:false, maxSize: 1, inList: ['A','D','U']
		department nullable: true, blank: true, maxSize: 2, inList: Holders.config.app.departments, validator: { val, obj->
			obj.visibility==VISIBILITY_DEPARTMENT ? val!=null : val==null
		}
		submitters nullable: true, blank: true, maxSize: 2**16-1, validator: { val, obj->
			obj.visibility==VISIBILITY_USERNAME ? val!=null : val==null
		}
		description nullable: true, blank: true, widget: 'textarea'
		referenceUrl nullable: true, blank: true, url: true
		remarks nullable: true, blank: true, widget: 'textarea'
		startTime nullable: false
		endTime nullable: false, validator: { val, obj->
			val > obj.startTime
		}
		closed nullable: false
		dateCreated ()
		lastUpdated ()
	}
	
	static mapping = {
		cache true
		department index:'department_idx'
		startTime index:'start_time_idx'
		endTime index:'end_time_idx'
		closed index:'colosed_idx'
		dateCreated index:'date_created_idx'
		lastUpdated index:'last_updated_idx'
		sort id:'desc'
		sheets sort:'id'
	}
	
	static transients = ['status']

	String toString() {
		title
	}
	
	String getStatus() {
		def now = new Date()
		if(endTime < now) STATUS_ENDED
		else if(startTime > now) STATUS_ENDED
		else if(closed) STATUS_CLOSED
		else STATUS_OK
	}
}
