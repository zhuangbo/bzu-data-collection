package bzu.security

class ErrorsController {

    def forbidden() {
	}
    def notFound() {
		cache validFor: 1800  // 缓存 30 分钟
	}
    def serverError() {
		cache validFor: 1800  // 缓存 30 分钟
	}
}
