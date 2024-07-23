package com.cissol.core.di;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Map;

import com.cissol.core.servlet.InitProjectServlet;
import com.cissol.core.util.DatabaseUtil;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DataSave extends HttpServlet {

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection con = null;
		ResultSet rs = null;
		String output = "";
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");

		String userName = (String) request.getSession().getAttribute("LOGIN_ID");
		System.out.println("User name============== " + userName);

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
		SimpleDateFormat format1 = new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
		try {
			String saveData = (String) request.getParameter("savedata");
			con = DatabaseUtil.getConnection();
			con.setAutoCommit(false);
			System.out.println(" import data :" + saveData);
			ObjectMapper o = new ObjectMapper();
			Map h = o.readValue(saveData, new TypeReference<Map<String, Object>>() {
			});
			String importId = (String) h.get("importid");
			String type = (String) h.get("type");
			String uploadId = (String) h.get("uploadid");
			String fileName = (String) h.get("filename");
			ArrayList data = (ArrayList) h.get("data");
			String userCode = (String) h.get("usercode");
			String result = "";
			String checkResult = "";
			if ("mapping".equals(type)) {
				result = DataImportUtil.updateImportFileColumns(con, importId, data, userCode);
				if ("Success".equals(result)) {
					String serverName = request.getServerName();
					String homepath = System.getProperty("catalina.home") + File.separator + "../"
							+ InitProjectServlet.context + "/import" + File.separator + serverName;
					result = DataImportUtil.parseImportedFile(con, homepath, fileName, uploadId, importId, userCode);
					ObjectMapper obj = new ObjectMapper();
					Map<String, Object> m = obj.readValue(result, new TypeReference<Map<String, Object>>() {
					});
					checkResult = (String) ((Map) m.get("data")).get("result");
				} else {
					checkResult = result;
				}
			} else if ("cancel".equals(type)) {
				result = DataImportUtil.deleteTempTable(con, importId, uploadId, userCode);
				checkResult = result;
			} else if ("save".equals(type)) {
				result = DataImportUtil.saveData(con, importId, uploadId, userCode);
				String res = DataImportUtil.deleteTempTable(con, importId, uploadId, userCode);
				checkResult = result;
			}
			out.write(result);
			System.out.println(checkResult);
			if ("Success".equals(checkResult)) {
				con.commit();
			} else {
				con.rollback();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			try {
				con.rollback();
				out.print("Error: Please contact support ");
			} catch (Exception ex) {
				System.out.println(ex.getMessage());
			}
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (Exception es) {
				System.out.println(es.getMessage());
			}

		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			processRequest(request, response);
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public static final Object dataSaveObject = new Object();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			processRequest(request, response);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
