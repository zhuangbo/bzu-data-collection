package bzu.security.auth


import java.net.URL;

import org.apache.commons.logging.LogFactory;
import org.codehaus.groovy.grails.commons.GrailsApplication;
import org.springframework.security.authentication.AuthenticationServiceException
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.authentication.dao.AbstractUserDetailsAuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;

import bzu.security.Role;
import bzu.security.User;
import bzu.security.UserRole;
import bzu.security.UserService;

/**
 * 实现基于DAO和Web门户的用户验证。
 * 如果通过DAO方式验证失败后，继续尝试利用Web门户进行验证。
 * 
 * @author 庄波
 *
 */
class DaoAndWebPortalAuthenticationProvider extends AbstractUserDetailsAuthenticationProvider {
	
    private static final log = LogFactory.getLog(this)
	
	DaoAuthenticationProvider daoAuthenticationProvider
	UserService userService

	/**
	 * 如果通过DAO方式验证失败后，继续尝试利用Web门户进行验证。
	 */
	@Override
	protected void additionalAuthenticationChecks(UserDetails userDetails,
			UsernamePasswordAuthenticationToken authentication)
			throws AuthenticationException {
		try {
			// 尝试进行正常的DAO验证密码
			daoAuthenticationProvider.additionalAuthenticationChecks(userDetails, authentication)
		} catch (AuthenticationException authEx) {
			// 正常的DAO方式验证密码失败
			try {
				// 尝试登录门户网站验证密码
				if(userService.webPortalAuthentication(userDetails.username, authentication.credentials.toString())) {
					// 网络验证成功，更新密码
					userService.updateUserPassword(userDetails.username, authentication.credentials.toString())
				} else {
					// 网络验证失败，继续抛出异常
					throw authEx
				}
			} catch (IOException networkEx) {
				// 网络故障，无法访问门户网站
				throw new AuthenticationServiceException(messages.getMessage("WebPortal.service.unavailable"), networkEx)
			}
		}
	}

	@Override
	protected UserDetails retrieveUser(String username,
			UsernamePasswordAuthenticationToken authentication)
			throws AuthenticationException {
		return daoAuthenticationProvider.retrieveUser(username, authentication);
	}
}
