package com.cissol.core.register;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Map;

import com.cissol.core.util.DatabaseUtil;

public class Register {
	private static final String insertQuery = "INSERT INTO registration_mast(server_ip,imei_no,defaultbranch)VALUES(?,?,?)";
	private static final String modifyQuery = "UPDATE registration_mast set server_ip=? where imei_no=?";
	private static final String deleteQuery = "DELETE FROM registration_mast where imei_no=?";
	private static final String checkUser = "select user_name,user_pass,ifnull(em_code,0) usercode from users left join employee_master on user_name=em_user_name where user_name=? and user_pass=?";
	private static final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public String register(Map<String, Object> l) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = "";
		try {
			conn = DatabaseUtil.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS);
			pstmt.clearParameters();
			pstmt.setString(1, (String) l.get("ip"));
			pstmt.setString(2, (String) l.get("imei_no"));
			pstmt.setString(3, (String) l.get("defaultbranch"));
			pstmt.executeUpdate();
			rs = pstmt.getGeneratedKeys();
			long code = 0;
			if (rs.next()) {
				code = rs.getLong(1);
			}
			rs.close();
			conn.commit();
			result = "{\"result\":\"Success\",\"message\":\"Registered Successfully\",\"code\":\"" + code + "\"}";
		} catch (Exception e) {
			try {
				if (conn != null) {
					conn.rollback();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
			e.printStackTrace();
			result = "{\"result\":\"Error\",\"message\":\"Error while registering device [" + e.getMessage() + "]\"}";
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
		}
		return result;
	}

	public String reRegister(Map<String, Object> l) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = "";
		try {
			conn = DatabaseUtil.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(modifyQuery);
			pstmt.clearParameters();
			pstmt.setString(1, (String) l.get("ip"));
			pstmt.setString(2, (String) l.get("imei_no"));
			pstmt.executeUpdate();
			conn.commit();
			result = "{\"result\":\"Success\",\"message\":\"Ip Modified Successfully\"}";
		} catch (Exception e) {
			try {
				if (conn != null) {
					conn.rollback();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
			e.printStackTrace();
			result = "{\"result\":\"Error\",\"message\":\"Error while modifying registration [" + e.getMessage()
					+ "]\"}";
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
		}
		return result;
	}

	public String deleteRegistration(Map<String, Object> l) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = "";
		try {
			conn = DatabaseUtil.getConnection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(deleteQuery);
			pstmt.clearParameters();
			pstmt.setString(1, (String) l.get("imei_no"));
			pstmt.executeUpdate();
			conn.commit();
			result = "{\"result\":\"Success\",\"message\":\"UnRegistered Successfully\"}";
		} catch (Exception e) {
			try {
				if (conn != null) {
					conn.rollback();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
			e.printStackTrace();
			result = "{\"result\":\"Error\",\"message\":\"Error while deleting ledger [" + e.getMessage() + "]\"}";
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
		}
		return result;
	}

	public String checkUser(String userId, String passWord) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = "";
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(checkUser);
			pstmt.clearParameters();
			pstmt.setString(1, userId);
			pstmt.setString(2, passWord);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String userCode = rs.getString("usercode");
				result = "{\"result\":\"Success\",\"message\":\"Logged in successfully\",\"code\":\"" + userCode
						+ "\"}";
			} else {
				result = "{\"result\":\"Failed\",\"message\":\"UserName or password is not correct/available\",\"code\":\"0\"}";
			}
		} catch (Exception e) {
			try {
				if (conn != null) {
					conn.rollback();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
			e.printStackTrace();
			result = "{\"result\":\"Error\",\"message\":\"Error while validating user [" + e.getMessage() + "]\"}";
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
		}
		return result;
	}

	public static Register getInstance() {
		return new Register();
	}
}