package com.cissol.core.ui;

import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import com.cissol.core.util.DatabaseUtil;
import com.fasterxml.jackson.core.JsonEncoding;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;

//import javax.servlet.*;
//import javax.servlet.http.*;
import jakarta.ws.rs.core.MultivaluedMap;

public class LoadMasters {
	private static final String loadQueries = "select sd.querysource,sd.queryparam,sd.dataarray, sd.datagroup,sg.groupname FROM screenloadqueries sd inner join screengroup sg on sd.screencode=sg.screencode and sd.datagroup=sg.groupcode where sd.screencode=? order by sd.queryorder asc";
	private static final SimpleDateFormat formatddMMyyyy = new SimpleDateFormat("dd/MM/yyyy");
	private static final SimpleDateFormat formatyyyyMMdd = new SimpleDateFormat("yyyy-MM-dd");

	public static void getScreenData(MultivaluedMap<String, String> parameters, OutputStream out) {
		Connection conn = null;
		PreparedStatement masterStatement = null;
		PreparedStatement selectStatement = null;
		ResultSet rs = null;
		ResultSet selectQuery = null;
		try {
			String screenCode = parameters.getFirst("screencode");
			conn = DatabaseUtil.getConnection();
//			JsonFactory factory=new JsonFactory();
//			JsonGenerator generator=factory.createJsonGenerator(out,JsonEncoding.UTF8);
			JsonFactory jsonFactory = new JsonFactory();
			JsonGenerator generator = jsonFactory.createGenerator(out, JsonEncoding.UTF8);
			generator.writeStartObject();
			masterStatement = conn.prepareStatement(loadQueries);
			masterStatement.setInt(1, Integer.parseInt(screenCode));
			rs = masterStatement.executeQuery();
			while (rs.next()) {
				String parameter = rs.getString("queryparam");
				String query = rs.getString("querysource");
				int isArray = rs.getInt("dataarray");
				String groupName = rs.getString("groupname");
				String[] params = parameter.split(",");
				int pSize = params.length;
				if ("".equals(parameters)) {
					pSize = 0;
				}
				System.out.println(query);
				selectStatement = conn.prepareStatement(query);
				if (isArray == 1) {
					generator.writeFieldName(groupName + "_data");
					for (int i = 0; i < pSize; i++) {
						if (DatabaseUtil.databaseType == 3) {
							try {
								selectStatement.setInt(i + 1,
										Integer.parseInt((String) parameters.getFirst(params[i])));
							} catch (Exception e1) {
								selectStatement.setString(i + 1, (String) parameters.getFirst(params[i]));
							}
						} else {
							selectStatement.setString(i + 1, (String) parameters.getFirst(params[i]));
						}
					}
					selectQuery = selectStatement.executeQuery();
					ResultSetMetaData rsmd = selectQuery.getMetaData();
					generator.writeStartArray();
					while (selectQuery.next()) {
						generator.writeStartObject();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							generator.writeStringField(rsmd.getColumnLabel(i), selectQuery.getString(i));
						}
						generator.writeEndObject();
					}
					selectQuery.close();
					generator.writeEndArray();
				} else if (isArray == 0) {
					for (int i = 0; i < pSize; i++) {
						if (DatabaseUtil.databaseType == 3) {
							try {
								selectStatement.setInt(i + 1,
										Integer.parseInt((String) parameters.getFirst(params[i])));
							} catch (Exception e1) {
								selectStatement.setString(i + 1, (String) parameters.getFirst(params[i]));
							}
						} else {
							selectStatement.setString(i + 1, (String) parameters.getFirst(params[i]));
						}

					}
					selectQuery = selectStatement.executeQuery();
					ResultSetMetaData rsmd = selectQuery.getMetaData();
					if (selectQuery.next()) {
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							generator.writeStringField(rsmd.getColumnLabel(i), selectQuery.getString(i));
						}
					}
					selectQuery.close();
				}
				selectStatement.close();
			}
			rs.close();
			rs = null;
			generator.writeEndObject();
			generator.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (masterStatement != null) {
					masterStatement.close();
				}
				if (selectStatement != null) {
					selectStatement.close();
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
	}
}
