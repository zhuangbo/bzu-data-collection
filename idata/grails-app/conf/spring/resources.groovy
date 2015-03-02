// Place your Spring DSL code here
beans = {
	daoAndWebPortalAuthenticationProvider(bzu.security.auth.DaoAndWebPortalAuthenticationProvider) {
		daoAuthenticationProvider = ref("daoAuthenticationProvider")
		userService = ref("userService")
	}
}
