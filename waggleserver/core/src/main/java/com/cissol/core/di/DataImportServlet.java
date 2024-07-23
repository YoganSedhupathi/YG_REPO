package com.cissol.core.di;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;

import com.cissol.core.servlet.InitProjectServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DataImportServlet extends HttpServlet {

	HashMap dataMap = new HashMap();
	private static String FS = System.getProperty("file.separator");

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			processRequest(request, response);
		} catch (Exception e) {
			try {
				throw e;
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
	}

	public static final Object migrationSyncLock = new Object();

	protected synchronized void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		synchronized (DataImportServlet.migrationSyncLock) {
			HashMap<String, String> parameters = new HashMap<String, String>();
			try {
				processRequest(request, response);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			try {
				String serverName = request.getServerName();
				File f = new File(System.getProperty("catalina.home") + File.separator + "../"
						+ InitProjectServlet.context + "/import" + File.separator + serverName);
				f.mkdirs();
				String homepath = System.getProperty("catalina.home") + File.separator + "../"
						+ InitProjectServlet.context + "/import" + File.separator + serverName;
				String uploadId = DataImportUtil.getNextUploadId();
				HashMap<String, File> hmresultmap = DataImportUtil.saveImportFiles(request, response, parameters,
						homepath, uploadId);
				String fileName = (String) parameters.get("fileName");
				String importId = (String) parameters.get("impid");
				String userCode = (String) parameters.get("usercode");
				String result = DataImportUtil.getFieldMapping(homepath, importId, uploadId, fileName, userCode);
				response.setContentType("text/plain");
				response.setHeader("Pragma", "no-cache");
				response.setHeader("Expires", "0");
				response.setHeader("Cache-Control", "no-store");
				PrintWriter out = response.getWriter();
				out.print(result);
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
				throw new ServletException(e);
			}
		}
	}
}
