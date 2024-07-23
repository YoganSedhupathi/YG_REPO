package com.cissol.core.ui;

import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import com.cissol.core.util.DatabaseUtil;
import com.fasterxml.jackson.core.JsonEncoding;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;

import jakarta.ws.rs.core.MultivaluedMap;

public class ScreenProperties {
	public static String getScreenGroup = "select screencode,groupcode,grouptitle,groupname,grouptype,grouplayout,grouptablerowadd,grouptableoptional,tablerowcheckcolumn,grouploadtype,grouploadurl,serialnocolumn,groupvisible,groupareaname,grouprows,groupsequence from screengroup where screencode=? order by grouporder";
	public static String getScreen = "select screencode,screenname,screentitle,screenjs,screenlayout,showreport,onloadhandler from screens where screencode=?";
	public static String getScreenAttributes = "select b.grouporder,a.screencode,a.attributeid,a.attributegroupid groupcode,a.attributeorder,a.attributecaption caption,a.attributename name,a.attributetype inputType,a.attributesubtype type,a.attributedefaultvalue defaultValue,a.attributelistid,a.attributemaxlength textLength,a.attributemaxvalue maximumValue,a.attributemaxdeclength decimalLength,a.attributeformat format,a.ismandatory mandatory,a.attributealign align,a.attributeevent ,a.attributekeyvalues,a.attributeajaxparams,a.attributeajaxparamsrc,a.attributeajaxsrctype,a.attributeajaxresults,a.attributeajaxresultstgt,	a.attributeajaxtgttype,a.attributecolwidth width,a.attributeloadgroup,a.issystem,a.attributeerror error,a.attributetooltip tooltip,a.addenabled,a.editenabled,a.viewenabled,a.attributevalidatetag chkTag,a.attributesavetag saveTag,a.attributeajaxdsi dsi,a.attributehassuffix hassuffix from screenattributes a inner join screengroup b on a.screencode=b.screencode and a.attributegroupid=b.groupcode where a.screencode=? order by a.attributegroupid,a.attributeorder ";
	public static String getScreenAttributeEvents = "select attributegroupid,attributename,eventname,eventhandlerfunc from screenattributeevents a  where a.screencode=? order by a.attributegroupid ";
	public static String getScreenActions = "SELECT a.so_name opername,a.so_caption opercaption,a.so_action operaction,a.so_class operclass,a.so_icon opericon,a.so_type opertype FROM screen_operations a inner join role_operation_map rm on a.so_menu_id=rm.rom_menu_id and a.so_id=rm.rom_so_id inner join users u on u.role_id=rm.rom_role_id and u.user_name=? WHERE so_menu_id=? and so_type in (0,1,3)";

	public static void getScreenProperties(MultivaluedMap<String, String> queryParams, PrintWriter out) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String screenCode = "0";
		String loginId = "";
		try {
			screenCode = queryParams.getFirst("screencode");
			loginId = queryParams.getFirst("login_id");
//			JsonFactory factory=new JsonFactory();
//			JsonGenerator generator=factory.createJsonGenerator(out);
			JsonFactory jsonFactory = new JsonFactory();
			Writer outputStream = out;
			JsonGenerator generator = jsonFactory.createGenerator(outputStream);
//			JsonGenerator generator = jsonFactory.createGenerator(outputStream, JsonEncoding.UTF8);
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(getScreen);
			generator.writeStartObject();
			generator.writeFieldName("screenprop");
			pstmt.setString(1, screenCode);
			rs = pstmt.executeQuery();
			rsmd = rs.getMetaData();
			generator.writeStartArray();
			while (rs.next()) {
				generator.writeStartObject();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					generator.writeStringField(rsmd.getColumnLabel(i), rs.getString(i));
				}
				generator.writeEndObject();
			}
			generator.writeEndArray();
			rs.close();
			pstmt.close();
			pstmt = conn.prepareStatement(getScreenGroup);
			generator.writeFieldName("groups");
			pstmt.setString(1, screenCode);
			rs = pstmt.executeQuery();
			rsmd = rs.getMetaData();
			generator.writeStartArray();
			while (rs.next()) {
				generator.writeStartObject();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					generator.writeStringField(rsmd.getColumnLabel(i), rs.getString(i));
				}
				generator.writeEndObject();
			}
			generator.writeEndArray();
			rs.close();
			pstmt.close();
			pstmt = conn.prepareStatement(getScreenAttributes);
			generator.writeFieldName("attributes");
			pstmt.setString(1, screenCode);
			rs = pstmt.executeQuery();
			rsmd = rs.getMetaData();
			generator.writeStartArray();
			while (rs.next()) {
				generator.writeStartObject();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					generator.writeStringField(rsmd.getColumnLabel(i), rs.getString(i));
				}
				generator.writeEndObject();
			}
			generator.writeEndArray();
			rs.close();
			pstmt.close();
			pstmt = conn.prepareStatement(getScreenAttributeEvents);
			generator.writeFieldName("events");
			pstmt.setString(1, screenCode);
			rs = pstmt.executeQuery();
			rsmd = rs.getMetaData();
			String attributeName = "";
			generator.writeStartObject();
			while (rs.next()) {
				if (!attributeName.equals(rs.getString("attributename"))) {
					if (!"".equals(attributeName)) {
						generator.writeEndArray();
					}
					generator.writeFieldName(rs.getString("attributename"));
					attributeName = rs.getString("attributename");
					generator.writeStartArray();
				}
				generator.writeStartObject();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					generator.writeStringField(rsmd.getColumnLabel(i), rs.getString(i));
				}
				generator.writeEndObject();
			}
			if (!"".equals(attributeName)) {
				generator.writeEndArray();
			}
			generator.writeEndObject();
			rs.close();
			pstmt.close();
			pstmt = conn.prepareStatement(getScreenActions);
			generator.writeFieldName("actions");
			pstmt.setString(1, loginId);
			pstmt.setString(2, screenCode);
			rs = pstmt.executeQuery();
			rsmd = rs.getMetaData();
			generator.writeStartArray();
			while (rs.next()) {
				generator.writeStartObject();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					generator.writeStringField(rsmd.getColumnLabel(i), rs.getString(i));
				}
				generator.writeEndObject();
			}
			generator.writeEndArray();
			rs.close();
			pstmt.close();
			generator.writeEndObject();
			generator.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException esql) {
				esql.printStackTrace();
			}
		}
	}
}