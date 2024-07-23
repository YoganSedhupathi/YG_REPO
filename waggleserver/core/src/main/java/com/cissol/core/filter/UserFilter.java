package com.cissol.core.filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.cissol.core.servlet.InitProjectServlet;
import com.cissol.core.util.CurrentTenantUtil;
import com.cissol.core.util.DatabaseUtil;
import com.cissol.core.util.TenantInfo;
import com.tomcat.auth.*;


//import com.tomcat.auth.TomcatUserPrincipal;
//import com.tomcat.auth.UserPrincipalInterface;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UserFilter implements Filter {

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;

		// Get the IP address of client machine.
		String ipAddress = request.getRemoteAddr();
		String host = request.getRemoteHost();
		String loginId = (String) request.getSession().getAttribute("LOGIN_ID");
		String userToken = "";
		boolean authToken = false;
		boolean isAuthenticated = true;
//        System.out.println("Login ID <s>: "+loginId);
		if (loginId == null || "".equals(loginId)) {
			loginId = request.getRemoteUser();
			// System.out.println("Login ID <d>: "+loginId);
			if (loginId == null) {
				loginId = "";
				userToken = request.getHeader("Authorization");
				if (userToken == null) {
					userToken = "";
					// userToken=request.getParameter("token");
				} else {
					userToken = userToken.replace("Bearer ", "");
				}
				System.out.println("Token: " + userToken);
			}
			request.getSession().setAttribute("LOGIN_ID", loginId);
			request.getSession().setAttribute("PORTALCODE", "1");
			ResultSet rs = null;
			Connection con = null;
			PreparedStatement ps = null;
			String loginType = "";
			String userCode = "";
			try {
				host = (String) request.getHeader("host");
				host = host.replaceAll(":8080", "");
				if (InitProjectServlet.isMultiTenant) {
					con = DatabaseUtil.getMultiTenantConnection(host);
				} else {
					con = DatabaseUtil.getConnection();
				}
				String requri = request.getRequestURI();
//        		System.out.println("nnnnnnnnnnnnnnnnnnn"+requri);
//        		System.out.println("Login ID: "+loginId+" token: "+userToken);
				if ("".equals(loginId) && InitProjectServlet.isRegistration && !InitProjectServlet.smartBro) {
					ps = con.prepareStatement("select user_name,user_id,user_displayname from users where "
							+ InitProjectServlet.userIdField + "=?");
					ps.clearParameters();
					ps.setString(1, userToken);
					rs = ps.executeQuery();
					if (rs.next()) {
						request.getSession().setAttribute("LOGIN_ID", rs.getString("user_name"));
						request.getSession().setAttribute("USER_ID", rs.getString("user_id"));
						request.getSession().setAttribute("USER_NAME", rs.getString("user_displayname"));
					}
					rs.close();
					ps.close();
				} else if ("".equals(loginId) && InitProjectServlet.isRegistration && InitProjectServlet.smartBro) {
//        			System.out.println("select u.user_name,u.user_id,u.user_displayname from users u inner join broker_info b on u.broker_code=b.broker_code where b.broker_code=?");
					if (!checkUrl(host, requri)) {
						ps = con.prepareStatement(
								"select u.user_name,u.user_id,u.user_displayname from user_tokens t inner join users u on u.user_id=t.user_id inner join broker_info b on u.broker_code=b.broker_code where t.auth_token=?");
						ps.clearParameters();
						ps.setString(1, userToken);
						rs = ps.executeQuery();
						if (rs.next()) {
							request.getSession().setAttribute("LOGIN_ID", rs.getString("user_name"));
							request.getSession().setAttribute("USER_ID", rs.getString("user_id"));
							request.getSession().setAttribute("USER_NAME", rs.getString("user_displayname"));
						} else {
							isAuthenticated = false;
						}
						rs.close();
						ps.close();
					}
//	        		ps=con.prepareStatement("select u.user_name,u.user_id,u.user_displayname from users u inner join broker_info b on u.broker_code=b.broker_code where b.broker_code=?");
//	        		ps.clearParameters();
//	        		ps.setString(1, userToken);
//	        		rs=ps.executeQuery();
//	        		if(rs.next()){
//	        			request.getSession().setAttribute("LOGIN_ID", rs.getString("user_name"));
//	        			request.getSession().setAttribute("USER_ID", rs.getString("user_id"));
//	        			request.getSession().setAttribute("USER_NAME", rs.getString("user_displayname"));
//	        		}
//	        		rs.close();
//	        		ps.close();   
				} else {
					ps = con.prepareStatement("select em_name,em_code from employee_master where em_user_name=?");
					ps.clearParameters();
					ps.setString(1, loginId);
					rs = ps.executeQuery();
					if (rs.next()) {
						request.getSession().setAttribute("USER_ID", rs.getString("em_code"));
						request.getSession().setAttribute("USER_NAME", rs.getString("em_name"));
					}
					rs.close();
					ps.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (con != null) {
						con.close();
					}
					if (rs != null) {
						rs.close();
					}
					if (ps != null) {
						ps.close();
					}
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		} else if (!"".equals(loginId) && InitProjectServlet.isRegistration && InitProjectServlet.smartBro) {
			String requri = request.getRequestURI();
			if (!checkUrl(host, requri)) {
				ResultSet rs = null;
				Connection con = null;
				PreparedStatement ps = null;
				String loginType = "";
				String userCode = "";
				try {
					host = (String) request.getHeader("host");
					host = host.replaceAll(":8080", "");
					if (InitProjectServlet.isMultiTenant) {
						con = DatabaseUtil.getMultiTenantConnection(host);
					} else {
						con = DatabaseUtil.getConnection();
					}

					userToken = request.getHeader("Authorization");
					userToken = userToken.replace("Bearer ", "");
					ps = con.prepareStatement(
							"select u.user_name,u.user_id,u.user_displayname from user_tokens t inner join users u on u.user_id=t.user_id inner join broker_info b on u.broker_code=b.broker_code where t.auth_token=? and u.user_name=? ");
					ps.clearParameters();
					ps.setString(1, userToken);
					ps.setString(2, loginId);
					rs = ps.executeQuery();
					if (rs.next()) {
						request.getSession().setAttribute("LOGIN_ID", rs.getString("user_name"));
						request.getSession().setAttribute("USER_ID", rs.getString("user_id"));
						request.getSession().setAttribute("USER_NAME", rs.getString("user_displayname"));
					} else {
						isAuthenticated = false;
					}
					rs.close();
					ps.close();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if (con != null) {
							con.close();
						}
						if (rs != null) {
							rs.close();
						}
						if (ps != null) {
							ps.close();
						}
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}
			}
		}

		try {
			TomcatUserPrincipal p = (TomcatUserPrincipal) request.getUserPrincipal();

			TenantInfo info = new TenantInfo();

			if (p != null) {
				String tenantUrl = p.getTenantDatabaseUrl();
				info.setTenantDatabaseUrl(tenantUrl);
				info.setTenantDomain(host);
				info.setTenantId(String.valueOf(p.getTenantId()));
				CurrentTenantUtil.setTenantInfo(info);
			} else {

				host = (String) request.getHeader("host");
				host = host.replaceAll(":8080", "");
				host = host.replaceAll(":8443", "");
				info.setTenantDomain(host);
				CurrentTenantUtil.setTenantInfo(info);
			}
			/*
			 * try{ (new ReadCertificates()).getKeys(); }catch(Exception x){
			 * x.printStackTrace(); }
			 */
			if (isAuthenticated)
				chain.doFilter(req, res);
			else
				((HttpServletResponse) res).sendError(HttpServletResponse.SC_UNAUTHORIZED, "UnAuthorized");
			return;
		} finally {
			CurrentTenantUtil.removeTenantInfo();
		}
	}

	public void init(FilterConfig config) throws ServletException {

	}

	public void destroy() {
		// add code to release any resource
	}

	private boolean checkUrl(String host, String url) {
		ResultSet rs = null;
		Connection con = null;
		PreparedStatement ps = null;
		boolean skipUrl = false;
		try {
			if (InitProjectServlet.isMultiTenant) {
				con = DatabaseUtil.getMultiTenantConnection(host);
			} else {
				con = DatabaseUtil.getConnection();
			}
			ps = con.prepareStatement("select 'X' from skip_token_validation_url where LOCATE(stv_url,?) > 0");
			ps.clearParameters();
			ps.setString(1, url);
			rs = ps.executeQuery();
			if (rs.next()) {
				skipUrl = true;
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (con != null) {
					con.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return skipUrl;
	}
}
