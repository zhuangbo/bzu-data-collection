		<g:if env="development"><link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css"></g:if>

		<g:if env="development">
			<g:renderException exception="${exception}" />
		</g:if>
