package com.cissol.core.ui;

import java.io.StringWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.cissol.core.util.DatabaseUtil;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;

public class SaveMasters {
	private static final String saveQueries = "select sd.querysource,sd.queryparam,sd.querydataarray,sd.querytype, sd.primarygroup, sd.isscope,sg.groupname,sd.queryresult,sd.querycheckfield FROM savedetail sd inner join screengroup sg on sd.screencode=sg.screencode and sd.primarygroup=sg.groupcode where sd.screencode=? and sd.operation=? and sg.groupsavetype=0 order by sd.queryorder asc";
	private static final String getSaveGroups = "select sg.groupcode,sg.groupname from screengroup sg where sg.screencode=? and sg.groupsavetype=1 ";
	private static final String groupSaveQueries = "select sd.querysource,sd.queryparam,sd.querydataarray,sd.querytype, sd.primarygroup, sd.isscope,sg.groupname,sd.queryresult,sd.querycheckfield,sd.querycheckvalue FROM savedetail sd inner join screengroup sg on sd.screencode=sg.screencode and sd.primarygroup=sg.groupcode where sd.screencode=? and sg.groupsavetype=1 ";
	private static final SimpleDateFormat formatddMMyyyy = new SimpleDateFormat("dd/MM/yyyy");
	private static final SimpleDateFormat formatyyyyMMdd = new SimpleDateFormat("yyyy-MM-dd");

	public String saveData(Map<String, Object> saveData, String screenCode, String operation) {
		Connection conn = null;
		PreparedStatement masterStatement = null;
		PreparedStatement updateStatement = null;
		ResultSet rs = null;
		ResultSet selectQuery = null;
		Map<String, String> returnResult = new HashMap<String, String>();
		StringWriter result = new StringWriter();
		try {
			conn = DatabaseUtil.getConnection();
			conn.setAutoCommit(false);
			masterStatement = conn.prepareStatement(saveQueries);
			masterStatement.setInt(1, Integer.parseInt(screenCode));
			masterStatement.setString(2, operation);
			rs = masterStatement.executeQuery();
			while (rs.next()) {
				String parameters = rs.getString("queryparam");
				String query = rs.getString("querysource");
				int isArray = rs.getInt("querydataarray");
				int queryType = rs.getInt("querytype");
				String groupName = rs.getString("groupname");
				String queryResult = rs.getString("queryresult");
				String checkField = rs.getString("querycheckfield");
				String[] qResult = null;
				if (queryResult != null && !"".equals(queryResult)) {
					qResult = queryResult.split(",");
				}
				String[] params = parameters.split(",");
				int pSize = params.length;
				if ("".equals(parameters)) {
					pSize = 0;
				}
				// System.out.println(query +" "+parameters+pSize);
				if (isArray == 1) {
					updateStatement = conn.prepareStatement(query);
					ArrayList primaryList = (ArrayList) saveData.get(groupName + "_data");
					int ps = primaryList.size();
					for (int j = 0; j < ps; j++) {
						Map<String, Object> rowData = (HashMap) primaryList.get(j);
						updateStatement.clearParameters();
						for (int i = 0; i < pSize; i++) {
							if (rowData.get(params[i]) == null) {
								if ("Null".equals((String) saveData.get(params[i]))) {
									updateStatement.setString(i + 1, null);
								} else {
									updateStatement.setString(i + 1, (String) saveData.get(params[i]));
								}
							} else {
								if ("Null".equals((String) rowData.get(params[i]))) {
									updateStatement.setString(i + 1, null);
								} else {
									updateStatement.setString(i + 1, (String) rowData.get(params[i]));
								}
							}
						}
						updateStatement.addBatch();
					}
					updateStatement.executeBatch();
					updateStatement.close();
				} else if (isArray == 0) {
					if (queryType == 0) {
						updateStatement = conn.prepareStatement(query);
						for (int i = 0; i < pSize; i++) {
							if ("Null".equals((String) saveData.get(params[i]))) {
								updateStatement.setString(i + 1, null);
							} else {
								if (DatabaseUtil.databaseType == 3) {
									System.out.println(params[i] + " " + (String) saveData.get(params[i]));
									try {
										updateStatement.setInt(i + 1,
												Integer.parseInt((String) saveData.get(params[i])));
									} catch (Exception e) {
										updateStatement.setString(i + 1, (String) saveData.get(params[i]));
									}
								} else {
									updateStatement.setString(i + 1, (String) saveData.get(params[i]));
								}
							}
						}
						updateStatement.executeUpdate();
						updateStatement.close();
					} else if (queryType == 1) {
						updateStatement = conn.prepareStatement(query);
						for (int i = 0; i < pSize; i++) {
							updateStatement.setString(i + 1, (String) saveData.get(params[i]));
						}
						selectQuery = updateStatement.executeQuery();
						ResultSetMetaData rsmd = selectQuery.getMetaData();
						if (selectQuery.next()) {
							for (int i = 1; i <= rsmd.getColumnCount(); i++) {
								saveData.put(rsmd.getColumnLabel(i), selectQuery.getString(i));
							}
						}
						selectQuery.close();
						updateStatement.close();
						if (qResult != null) {
							for (int i = 0; i < qResult.length; i++) {
								returnResult.put(qResult[i], (String) saveData.get(qResult[i]));
							}
						}
					} else if (queryType == 3) {
						String checkValue = (String) saveData.get(checkField);
						if ("".equals(checkField) || checkValue.equals("0")) {
							Client c = ClientBuilder.newClient();
							WebTarget wt = c.target(query);
							ObjectMapper obj = new ObjectMapper();
							String postd = URLEncoder.encode(obj.writeValueAsString(saveData));
							String res = wt.request().accept(MediaType.APPLICATION_JSON)
									.post(Entity.entity(
											"data={\"operation\":\"" + operation + "\",\"savedata\":" + postd + "}",
											MediaType.APPLICATION_FORM_URLENCODED), String.class);
							System.out.println("===Posting Record Status===" + res);
							if (!res.contains("Success")) {
								throw new Exception("Error while posting records to the URL" + query);
							}
							ObjectMapper resultMapper = new ObjectMapper();
							Map<String, Object> m = resultMapper.readValue(res,
									new TypeReference<Map<String, Object>>() {
									});
							if (qResult != null) {
								for (int i = 0; i < qResult.length; i++) {
									saveData.put(qResult[i], (String) m.get(qResult[i]));
									returnResult.put(qResult[i], (String) m.get(qResult[i]));
								}
							}
						}
					} else if (queryType == 4) {
						SaveMasterInterface saveMaster = getSaveImplementation(conn, query);
						String sResult = saveMaster.executeMaster(conn, screenCode, operation, saveData);
						if (!"Success".equals(sResult)) {
							throw new Exception(sResult);
						}
					}
				}
			}
			rs.close();
			rs = null;
			masterStatement.close();
			masterStatement = null;

			// save separate groups
			ArrayList<HashMap<String, String>> groups = new ArrayList<HashMap<String, String>>();
			HashMap<String, ArrayList<GroupQuery>> groupQueries = new HashMap<String, ArrayList<GroupQuery>>();
			masterStatement = conn.prepareStatement(getSaveGroups);
			masterStatement.setInt(1, Integer.parseInt(screenCode));
			rs = masterStatement.executeQuery();
			while (rs.next()) {
				HashMap<String, String> h = new HashMap<String, String>();
				h.put("groupcode", rs.getString("groupcode"));
				h.put("groupname", rs.getString("groupname"));
				groups.add(h);
			}
			rs.close();
			masterStatement.close();
			masterStatement = null;

			StringBuffer grpSaveQuery = new StringBuffer(100);
			grpSaveQuery.append(groupSaveQueries);
			grpSaveQuery.append(" and sd.operation like '%");
			grpSaveQuery.append(operation);
			grpSaveQuery.append("%' order by sd.queryorder asc");
			masterStatement = conn.prepareStatement(grpSaveQuery.toString());
			masterStatement.setInt(1, Integer.parseInt(screenCode));
			rs = masterStatement.executeQuery();
			while (rs.next()) {
				GroupQuery gq = new GroupQuery();
				gq.queryParam = rs.getString("queryparam");
				gq.querySource = rs.getString("querysource");
				gq.queryType = rs.getInt("querytype");
				gq.queryResult = rs.getString("queryresult");
				gq.queryCheckField = rs.getString("querycheckfield");
				gq.queryCheckValue = rs.getString("querycheckvalue");
				if (groupQueries.get(rs.getString("groupname")) == null) {
					groupQueries.put(rs.getString("groupname"), new ArrayList<GroupQuery>());
				}
				groupQueries.get(rs.getString("groupname")).add(gq);
			}
			rs.close();
			masterStatement.close();
			masterStatement = null;
			int gs = groups.size();
			for (int i = 0; i < gs; i++) {
				HashMap<String, String> h = groups.get(i);
				ArrayList primaryList = (ArrayList) saveData.get(h.get("groupname") + "_data");
				int ps = primaryList.size();
				for (int j = 0; j < ps; j++) {
					int qs = groupQueries.get(h.get("groupname")).size();
					Map<String, Object> rowData = (HashMap) primaryList.get(j);
					for (int k = 0; k < qs; k++) {
						GroupQuery q = groupQueries.get(h.get("groupname")).get(k);
						String[] qResult = null;
						if (q.queryResult != null && !"".equals(q.queryResult)) {
							qResult = q.queryResult.split(",");
						}
						String[] params = q.queryParam.split(",");
						int pSize = params.length;
						if ("".equals(q.queryParam)) {
							pSize = 0;
						}
						String checkValue = (String) rowData.get(q.queryCheckField);
						if ("".equals(q.queryCheckField) || checkValue.equals(q.queryCheckValue)) {
							if (q.queryType == 0) {
								updateStatement = conn.prepareStatement(q.querySource);
								for (int jj = 0; jj < pSize; jj++) {
									if (rowData.get(params[jj]) == null) {
										if ("Null".equals((String) saveData.get(params[jj]))) {
											updateStatement.setString(jj + 1, null);
										} else {
											updateStatement.setString(jj + 1, (String) saveData.get(params[jj]));
										}
									} else {
										if ("Null".equals((String) rowData.get(params[jj]))) {
											updateStatement.setString(jj + 1, null);
										} else {
											updateStatement.setString(jj + 1, (String) rowData.get(params[jj]));
										}
									}
								}
								updateStatement.executeUpdate();
								updateStatement.close();
							} else if (q.queryType == 1) {
								updateStatement = conn.prepareStatement(q.querySource);
								for (int jj = 0; jj < pSize; jj++) {
									if (rowData.get(params[jj]) == null) {
										if ("Null".equals((String) saveData.get(params[jj]))) {
											updateStatement.setString(jj + 1, null);
										} else {
											updateStatement.setString(jj + 1, (String) saveData.get(params[jj]));
										}
									} else {
										if ("Null".equals((String) rowData.get(params[jj]))) {
											updateStatement.setString(jj + 1, null);
										} else {
											updateStatement.setString(jj + 1, (String) rowData.get(params[jj]));
										}
									}
								}
								selectQuery = updateStatement.executeQuery();
								ResultSetMetaData rsmd = selectQuery.getMetaData();
								if (selectQuery.next()) {
									for (int jj = 1; jj <= rsmd.getColumnCount(); jj++) {
										rowData.put(rsmd.getColumnLabel(jj), selectQuery.getString(jj));
									}
								}
								selectQuery.close();
								updateStatement.close();
							}
						}
					}
				}
			}
			conn.commit();
			returnResult.put("result", "Success");
			returnResult.put("message", "Data Saved Successfully");
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {

			}
			returnResult.put("result", "Failed");
			returnResult.put("message", e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (masterStatement != null) {
					masterStatement.close();
				}
				if (updateStatement != null) {
					updateStatement.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (selectQuery != null) {
					selectQuery.close();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
		}
		ObjectMapper obj = new ObjectMapper();
		try {
			obj.writeValue(result, returnResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}

	public Map<String, String> saveData(Connection conn, Map<String, Object> saveData, String screenCode,
			String operation) {
		PreparedStatement masterStatement = null;
		PreparedStatement updateStatement = null;
		ResultSet rs = null;
		ResultSet selectQuery = null;
		Map<String, String> returnResult = new HashMap<String, String>();
		StringWriter result = new StringWriter();
		try {
			masterStatement = conn.prepareStatement(saveQueries);
			masterStatement.setString(1, screenCode);
			masterStatement.setString(2, operation);
			rs = masterStatement.executeQuery();
			while (rs.next()) {
				String parameters = rs.getString("queryparam");
				String query = rs.getString("querysource");
				int isArray = rs.getInt("querydataarray");
				int queryType = rs.getInt("querytype");
				String groupName = rs.getString("groupname");
				String queryResult = rs.getString("queryresult");
				String[] qResult = null;
				if (queryResult != null && !"".equals(queryResult)) {
					qResult = queryResult.split(",");
				}
				String[] params = parameters.split(",");
				int pSize = params.length;
				if ("".equals(parameters)) {
					pSize = 0;
				}
				if (isArray == 1) {
					updateStatement = conn.prepareStatement(query);
					ArrayList primaryList = (ArrayList) saveData.get(groupName + "_data");
					int ps = primaryList.size();
					for (int j = 0; j < ps; j++) {
						Map<String, Object> rowData = (HashMap) primaryList.get(j);
						updateStatement.clearParameters();
						for (int i = 0; i < pSize; i++) {
							if (rowData.get(params[i]) == null) {
								updateStatement.setString(i + 1, (String) saveData.get(params[i]));
							} else {
								updateStatement.setString(i + 1, (String) rowData.get(params[i]));
							}
						}
						updateStatement.addBatch();
					}
					updateStatement.executeBatch();
					updateStatement.close();
				} else if (isArray == 0) {
					if (queryType == 0) {
						updateStatement = conn.prepareStatement(query);
						for (int i = 0; i < pSize; i++) {
							updateStatement.setString(i + 1, (String) saveData.get(params[i]));
						}
						updateStatement.executeUpdate();
						updateStatement.close();
					} else if (queryType == 1) {
						updateStatement = conn.prepareStatement(query);
						for (int i = 0; i < pSize; i++) {
							updateStatement.setString(i + 1, (String) saveData.get(params[i]));
						}
						selectQuery = updateStatement.executeQuery();
						ResultSetMetaData rsmd = selectQuery.getMetaData();
						if (selectQuery.next()) {
							for (int i = 1; i <= rsmd.getColumnCount(); i++) {
								saveData.put(rsmd.getColumnLabel(i), selectQuery.getString(i));
							}
						}
						selectQuery.close();
						updateStatement.close();
						if (qResult != null) {
							for (int i = 0; i < qResult.length; i++) {
								returnResult.put(qResult[i], (String) saveData.get(qResult[i]));
							}
						}
					} else if (queryType == 3) {
						Client c = ClientBuilder.newClient();
						WebTarget wt = c.target(query);
						ObjectMapper obj = new ObjectMapper();
						String postd = URLEncoder.encode(obj.writeValueAsString(saveData));
						String res = wt.request().accept(MediaType.APPLICATION_JSON)
								.post(Entity.entity(
										"data={\"operation\":\"" + operation + "\",\"savedata\":" + postd + "}",
										MediaType.APPLICATION_FORM_URLENCODED), String.class);
						System.out.println("===Posting Record Status===" + res);
						if (!res.contains("Success")) {
							throw new Exception("Error while posting records to the URL" + query);
						}
						ObjectMapper resultMapper = new ObjectMapper();
						Map<String, Object> m = resultMapper.readValue(res, new TypeReference<Map<String, Object>>() {
						});
						if (qResult != null) {
							for (int i = 0; i < qResult.length; i++) {
								saveData.put(qResult[i], (String) m.get(qResult[i]));
								returnResult.put(qResult[i], (String) m.get(qResult[i]));
							}
						}
					} else if (queryType == 4) {
						SaveMasterInterface saveMaster = getSaveImplementation(conn, query);
						String sResult = saveMaster.executeMaster(conn, screenCode, operation, saveData);
						if (!"Success".equals(sResult)) {
							throw new Exception(sResult);
						}
					}
				}
			}
			rs.close();
			rs = null;
			returnResult.put("result", "Success");
			returnResult.put("message", "Data Saved Successfully");
		} catch (Exception e) {
			returnResult.put("result", "Failed");
			returnResult.put("message", e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (masterStatement != null) {
					masterStatement.close();
				}
				if (updateStatement != null) {
					updateStatement.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (selectQuery != null) {
					selectQuery.close();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
		}
		return returnResult;
	}

	public static SaveMasterInterface getSaveImplementation(Connection con, String className) {
		SaveMasterInterface imp = null;
		try {
			if (!"".equals(className)) {
				Class<?> s = Class.forName(className);
				imp = (SaveMasterInterface) s.getDeclaredConstructor().newInstance();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return imp;
	}

	public static SaveMasters getInstance() {
		return new SaveMasters();
	}
}
