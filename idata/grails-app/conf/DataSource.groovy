dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:~/db/iDataDevDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
		grails.dbconsole.urlRoot = '/admin/dbconsole'
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
    production {
//		dataSource {
//			dbCreate = "update"
//			url = "jdbc:h2:~/db/iDataProdDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
//			pooled = true
//			properties {
//			   maxActive = -1
//			   minEvictableIdleTimeMillis=1800000
//			   timeBetweenEvictionRunsMillis=1800000
//			   numTestsPerEvictionRun=3
//			   testOnBorrow=true
//			   testWhileIdle=true
//			   testOnReturn=true
//			   validationQuery="SELECT 1"
//			}
//		}

        dataSource {
			driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "123456"
			
			dbCreate = "update"
            url = "jdbc:mysql://127.0.0.1/idata_prod"
            pooled = true
            properties {
               validationQuery="SELECT 1"
			   maxActive = 40
			   maxIdle = 40
			   minIdle = 1
			   initialSize = 5
			   minEvictableIdleTimeMillis = 60 * 1000 * 15
			   timeBetweenEvictionRunsMillis = 60 * 1000 * 15
			   numTestsPerEvictionRun = 3
			   testOnBorrow = true
			   testWhileIdle = true
			   testOnReturn = false
			   validationQuery = "SELECT 1"
            }
        }
    }
}
