package com.cissol.core.di;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.text.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import com.cissol.core.util.DatabaseUtil;
import com.fasterxml.jackson.core.JsonEncoding;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class DataImportUtil {
	public static final int impMappingColumnNo = 0;
	public static final int mappingColumn = 1;
	public static final int mappingColumnName = 2;

	public static final int importColumnNo = 0;
	public static final int importColumnName = 1;
	public static final int importColumnMandatory = 2;
	public static final int importColumnDataType = 3;
	public static final int importColumnDefault = 4;
	public static final int importColumnLength = 5;
	public static final int importColumnSheetName = 6;
	public static final int importColumnSheetPos = 7;

	private static final String selectImportData = "select IFH_SQL,IFH_DEL_SQL,IFH_IMPL_CLASS,IFH_RNUM_INDX from import_file_header where IFH_ID=? ";
	private static final String selectColumns = "select IFF_COLUMN_NO,IFF_COLUMN_NAME,IFF_MANDATORY,ifnull(IFM_XL_FIELDNAME,' ') SHEET_COLUMN_NAME,ifnull(IFM_XL_POS,-1) SHEET_COLUMN_POS,IFF_DATA_TYPE,IFF_COL_DEFAULT,ifnull(IFF_COL_LENGTH,'0') IFF_COL_LENGTH from import_file_fields left join import_field_mapping on iff_id=ifm_id and IFF_COLUMN_NO=ifm_field_pos and ifm_usercode=? where IFF_ID=? ";
//	private static String updateColumnData=" update import_file_fields set IFF_SHT_COLUMN_NAME=?,IFF_SHT_COLUMN_POS=? where IFF_ID=? AND IFF_COLUMN_NO=? ";
	private static final String insertMappingcolumns = "insert into import_field_mapping(ifm_id,ifm_usercode,ifm_xl_fieldname,ifm_field_pos,ifm_xl_pos) values(?,?,?,?,?)";
	private static String updateMappingColumnData = " update import_field_mapping set IFM_XL_FIELDNAME=?,IFM_XL_POS=? where IFM_ID=? AND IFM_USERCODE=? AND IFM_FIELD_POS=? ";
	private static String updateUploadId = "update tran_seq_no set seq_no=seq_no+1 where tran_id=9000 ";
	private static String getUploadId = "select seq_no from tran_seq_no where tran_id=9000 ";
	private static SimpleDateFormat formatddMMyyyy = new SimpleDateFormat("dd/MM/yyyy", Locale.ENGLISH);
	private static SimpleDateFormat formatyyyyMMdd = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
	private static JsonFactory jsonFactory = new JsonFactory();

	public static HashMap<String, File> saveImportFiles(HttpServletRequest request, HttpServletResponse response,
			HashMap<String, String> parameters, String path, String uploadNo) throws ServletException, IOException {
		HashMap<String, File> h = new HashMap<String, File>();
		boolean isMultipart = false; //// ServletFileUpload.isMultipartContent(request);
		if (isMultipart) {

			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
			servletFileUpload.setSizeMax(-1);
			try {
				List items = null; //// servletFileUpload.parseRequest(request);
				Iterator iter = items.iterator();
				FileItem file = null;
				while (iter.hasNext()) {
					FileItem item = (FileItem) iter.next();
					String fileName = item.getFieldName();
					if (!item.isFormField()) {
						System.out.println("Item FormField Else" + fileName);
						file = item;
					} else if (parameters != null) {
						parameters.put(item.getFieldName(), item.getString());
						System.out.println("Parameter : " + item.getFieldName() + " " + item.getString());
					}
				}
				if (file != null) {
					String originalFileName = parameters.get("fileName");
					String fName = "import_" + uploadNo + originalFileName.substring(originalFileName.lastIndexOf("."));
					File tempFile = null;
					System.out.println(" Uploaded file name " + fName);
					if (!"".equals(path)) {
						tempFile = new File(path + File.separator + fName);
					} else {
						tempFile = new File(fName);
					}
					file.write(tempFile);
					h.put(file.getFieldName(), tempFile);
				}
			} catch (Exception e) {
				System.out.println(e);
				throw new ServletException(e.getMessage());
			}
		}
		return h;
	}

	public static void getMigrationColumnList(JsonGenerator generator, String id, String userCode) {
		ResultSet rs = null;
		PreparedStatement pColumns = null;
		Connection con = null;
		String comma = "";
		try {
			con = DatabaseUtil.getConnection();
			pColumns = con.prepareStatement(selectColumns);
			pColumns.setString(1, userCode);
			pColumns.setString(2, id);
			rs = pColumns.executeQuery();
			generator.writeFieldName("migcolumns");
			generator.writeStartArray();
			while (rs.next()) {
				generator.writeStartArray();
				generator.writeString(rs.getString("IFF_COLUMN_NO"));
				generator.writeString(rs.getString("IFF_COLUMN_NAME"));
				generator.writeString(rs.getString("IFF_MANDATORY"));
				generator.writeString(rs.getString("SHEET_COLUMN_NAME"));
				generator.writeString(rs.getString("SHEET_COLUMN_POS"));
				generator.writeEndArray();
			}
			generator.writeEndArray();
			rs.close();
			pColumns.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (con != null) {
					con.close();
				}
				if (pColumns != null) {
					pColumns.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException es) {
				System.out.println(es.getMessage());
			}
		}
	}

	public static String getFieldMapping(String path, String tranId, String uploadNo, String fileName,
			String userCode) {
		String result = "";
		StringWriter columnList = new StringWriter();
		JsonGenerator generator = null;
		try {
			String fName = path + File.separator + "import_" + uploadNo + fileName.substring(fileName.lastIndexOf("."));
			HSSFWorkbook w = new HSSFWorkbook(new FileInputStream(new File(fName)));
			HSSFSheet s = w.getSheetAt(0);
			HSSFRow firstRow = null;
			String comma = "";
			columnList = new StringWriter();
			generator = jsonFactory.createJsonGenerator(columnList);
			generator.writeStartObject();
			generator.writeFieldName("data");
			generator.writeStartObject();
			generator.writeStringField("uploadno", uploadNo);
			generator.writeStringField("result", "Success");
			generator.writeFieldName("datacolumns");
			generator.writeStartArray();
			if (s != null) {
				firstRow = s.getRow(0);
				Iterator<Cell> cells = firstRow.cellIterator();
				int i = 0;
				while (cells.hasNext()) {
					Cell cell = cells.next();
					System.out.println(" Cell Values " + cell.getStringCellValue());
					generator.writeStartArray();
					generator.writeString(cell.getStringCellValue());
					generator.writeString(String.valueOf(i));
					generator.writeEndArray();
					i++;
				}
			}
			generator.writeEndArray();
			DataImportUtil.getMigrationColumnList(generator, tranId, userCode);
			generator.writeEndObject();
			generator.writeEndObject();
			generator.close();
			result = columnList.toString();
		} catch (Exception e) {
			try {
				generator.flush();
				generator.writeStartObject();
				generator.writeFieldName("data");
				generator.writeStartObject();
				generator.writeStringField("result", "Error in retrieving field mapping");
				generator.writeEndObject();
				generator.writeEndObject();
				generator.close();
				result = generator.toString();
			} catch (IOException e1) {

			}
			System.out.println(e.getMessage());
		}
		return result;
	}

	public static String updateImportFileColumns(Connection con, String tranId, ArrayList data, String userCode) {
		String result = "Success";
		PreparedStatement pUpdateColumns = null;
		PreparedStatement pInsertColumns = null;
		try {
			pUpdateColumns = con.prepareStatement(updateMappingColumnData);
			pInsertColumns = con.prepareStatement(insertMappingcolumns);
			int size = data.size();
			for (int i = 0; i < size; i++) {
				ArrayList column = (ArrayList) data.get(i);
				// IFM_XL_FIELDNAME=?,IFM_XL_POS=? where IFM_ID=? AND IFM_USERCODE=? AND
				// IFM_FIELD_POS=?
				pUpdateColumns.clearParameters();
				pUpdateColumns.setString(1, (String) column.get(mappingColumnName));
				pUpdateColumns.setString(2, (String) column.get(mappingColumn));
				pUpdateColumns.setString(3, tranId);
				pUpdateColumns.setString(4, userCode);
				pUpdateColumns.setString(5, (String) column.get(impMappingColumnNo));
				int a = pUpdateColumns.executeUpdate();
				if (a == 0) {
					// ifm_id,ifm_usercode,ifm_xl_fieldname,ifm_field_pos,ifm_xl_pos
					pInsertColumns.clearParameters();
					pInsertColumns.setString(1, tranId);
					pInsertColumns.setString(2, userCode);
					pInsertColumns.setString(3, (String) column.get(mappingColumnName));
					pInsertColumns.setString(4, (String) column.get(impMappingColumnNo));
					pInsertColumns.setString(5, (String) column.get(mappingColumn));
					pInsertColumns.executeUpdate();
				}
			}
		} catch (Exception e) {
			result = "Error while updating the migration mapping ";
			System.out.println(e.getMessage());
		} finally {
			try {
				if (pUpdateColumns != null) {
					pUpdateColumns.close();
				}
			} catch (SQLException es) {
				System.out.println(es.getMessage());
			}
		}
		return result;
	}

	public static ArrayList<ArrayList<String>> getMigrationColumnAttributes(Connection con, String id,
			String userCode) {
		ArrayList<ArrayList<String>> columnAttributes = new ArrayList<ArrayList<String>>();
		ResultSet rs = null;
		PreparedStatement pColumns = null;
		try {
			pColumns = con.prepareStatement(selectColumns);
			pColumns.setString(1, userCode);
			pColumns.setString(2, id);
			rs = pColumns.executeQuery();
			while (rs.next()) {
				System.out.println(rs.getString("IFF_COLUMN_NO"));
				ArrayList<String> column = new ArrayList<String>();
				column.add(importColumnNo, rs.getString("IFF_COLUMN_NO"));
				column.add(importColumnName, rs.getString("IFF_COLUMN_NAME"));
				column.add(importColumnMandatory, rs.getString("IFF_MANDATORY"));
				column.add(importColumnDataType, rs.getString("IFF_DATA_TYPE"));
				column.add(importColumnDefault, rs.getString("IFF_COL_DEFAULT"));
				column.add(importColumnLength, rs.getString("IFF_COL_LENGTH"));
				column.add(importColumnSheetName, rs.getString("SHEET_COLUMN_NAME"));
				column.add(importColumnSheetPos, rs.getString("SHEET_COLUMN_POS"));
				columnAttributes.add(column);
			}
			rs.close();
			pColumns.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (pColumns != null) {
					pColumns.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException es) {
				System.out.println(es.getMessage());
			}
		}
		return columnAttributes;
	}

	public static HashMap<String, String> getImportSQL(Connection con, String id) {
		ResultSet rs = null;
		PreparedStatement pSQL = null;
		HashMap<String, String> data = new HashMap<String, String>();
		try {
			pSQL = con.prepareStatement(selectImportData);
			pSQL.setString(1, id);
			rs = pSQL.executeQuery();
			if (rs.next()) {
				data.put("SQL", rs.getString("IFH_SQL"));
				data.put("INDX", rs.getString("IFH_RNUM_INDX"));
			}
			rs.close();
			pSQL.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (pSQL != null) {
					pSQL.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException es) {
				System.out.println(es.getMessage());
			}
		}
		return data;
	}

	public static DataImportInterface getImportImplementation(Connection con, String id) {
		ResultSet rs = null;
		PreparedStatement pSQL = null;
		String cls = "";
		DataImportInterface imp = null;
		try {
			pSQL = con.prepareStatement(selectImportData);
			pSQL.setString(1, id);
			rs = pSQL.executeQuery();
			if (rs.next()) {
				cls = rs.getString("IFH_IMPL_CLASS");
			}
			rs.close();
			pSQL.close();
			if (!"".equals(cls)) {
				Class s = Class.forName(cls);
				imp = (DataImportInterface) s.newInstance();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (pSQL != null) {
					pSQL.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException es) {
				System.out.println(es.getMessage());
			}
		}
		return imp;
	}

	public static String deleteTempTable(Connection con, String id, String uploadNo, String userCode) {
		ResultSet rs = null;
		PreparedStatement pSQL = null;
		PreparedStatement pDelete = null;
		String sql = "";
		String result = "Success";
		try {
			pSQL = con.prepareStatement(selectImportData);
			pSQL.setString(1, id);
			rs = pSQL.executeQuery();
			if (rs.next()) {
				sql = rs.getString("IFH_DEL_SQL");
			}
			rs.close();
			pSQL.close();
			if (!"".equals(sql)) {
				pDelete = con.prepareStatement(sql);
				pDelete.setString(1, uploadNo);
				pDelete.executeUpdate();
			}
		} catch (Exception e) {
			result = " Error in deleting the temp table";
			System.out.println(e.getMessage());
		} finally {
			try {
				if (pSQL != null) {
					pSQL.close();
				}
				if (pDelete != null) {
					pDelete.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException es) {
				System.out.println(es.getMessage());
			}
		}
		return result;
	}

	public static void getInvalidRowsJson(JsonGenerator generator, ArrayList<ArrayList<String>> invalidData) {
		try {
			generator.writeFieldName("invalidrows");
			generator.writeStartArray();
			int s = invalidData.size();
			for (int i = 0; i < s; i++) {
				ArrayList<String> row = invalidData.get(i);
				generator.writeStartArray();
				generator.writeString(row.get(DataImportInterface.invalidRow));
				generator.writeString(row.get(DataImportInterface.invalidReason));
				generator.writeEndArray();
			}
			generator.writeEndArray();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public static String parseImportedFile(Connection con, String filePath, String fileName, String uploadNo,
			String tranId, String userCode) {
		StringWriter result = null;
		PreparedStatement pImport = null;
		HashMap<String, String> data = null;
		String rowsToImport = "";
		ArrayList<ArrayList<String>> importColumnAttributes = null;
		ArrayList<ArrayList<String>> invalidData = new ArrayList<ArrayList<String>>();
		DataImportInterface imp = null;
		String sql = "";
		int rowNumColumn = 0;
		JsonGenerator generator = null;
		try {
			data = getImportSQL(con, tranId);
			result = new StringWriter();
			generator = jsonFactory.createJsonGenerator(result);
			generator.writeStartObject();
			generator.writeFieldName("data");
			generator.writeStartObject();
			System.out.println(data.get("SQL"));
			sql = data.get("SQL");
			rowNumColumn = Integer.parseInt(data.get("INDX"));
			sql = sql.replaceAll("<<UPLOADID>>", uploadNo);
			sql = sql.replaceAll("<<USERCODE>>", userCode);
			System.out.println(sql);
			pImport = con.prepareStatement(sql);
			importColumnAttributes = getMigrationColumnAttributes(con, tranId, userCode);
			String fName = filePath + File.separator + "import_" + uploadNo
					+ fileName.substring(fileName.lastIndexOf("."));
			HSSFWorkbook w = new HSSFWorkbook(new FileInputStream(new File(fName)));
			HSSFSheet s = w.getSheetAt(0);
			String comma = "";
			int size = s.getLastRowNum() + 1;
			System.out.println(" Size :" + size);
			int colSize = importColumnAttributes.size();
			if (s != null) {
				for (int i = 1; i < size; i++) {
					Row r = s.getRow(i);
					int cellCount = r.getLastCellNum() + 1;
					boolean addRow = true;
					String invalid = "";
					pImport.clearParameters();
					for (int j = 0, k = 1; j < colSize; j++, k++) {
						String value = "";
						ArrayList<String> column = importColumnAttributes.get(j);
						int sheetColumn = Integer.parseInt(column.get(importColumnSheetPos));
						int length = Integer.parseInt(column.get(importColumnLength));
						Cell c = r.getCell(sheetColumn);
						boolean colEmpty = false;
						// if(sheetColumn==-1 || cellCount<=sheetColumn || c==null ||
						// c.getCellType()==HSSFCell.CELL_TYPE_BLANK){
						if (sheetColumn == -1 || cellCount <= sheetColumn || c == null) {
							colEmpty = true;
							value = column.get(importColumnDefault);
						}
						if (colEmpty && "1".equals(column.get(importColumnMandatory))) {
							addRow = false;
							invalid = "value missing for the mandatory column : " + column.get(importColumnName);
						} else if (!colEmpty) {
							String val = "";
							//// c.setCellType(c.CELL_TYPE_STRING);
							val = c.getStringCellValue();
							try {
								if ("Text".equals(column.get(importColumnDataType))) {
									if (length < val.length()) {
										throw new Exception(
												"Data Length Exceeds for the Column " + column.get(importColumnName));
									}
								} else if ("Date".equals(column.get(importColumnDataType))) {
									Date n = formatddMMyyyy.parse(val);
									val = formatyyyyMMdd.format(n);
								} else if ("Integer".equals(column.get(importColumnDataType))
										|| "Number".equals(column.get(importColumnDataType))) {
									Integer.parseInt(val);
								} else if ("Decimal".equals(column.get(importColumnDataType))) {
									Double.parseDouble(val);
								}
								value = val;
							} catch (Exception e) {
								// System.out.println( "Column Value and datatype mismatch
								// :"+column.get(importColumnDataType)+" Value: "+val);
								if ("1".equals(column.get(importColumnMandatory))) {
									addRow = false;
									invalid = "Column value and datatype mismatch :" + column.get(importColumnDataType)
											+ " value: " + val;
								}
							}
						}
						if (k == rowNumColumn) {
							k++;
						}
						pImport.setString(k, value);
					}
					if (addRow) {
						pImport.setString(rowNumColumn, String.valueOf(i));
						pImport.addBatch();
					} else {
						ArrayList<String> list = new ArrayList<String>();
						list.add(String.valueOf(i));
						list.add(invalid);
						invalidData.add(list);
					}
					System.out.println(invalid + " ");
					comma = ",";
				}
			}
			pImport.executeBatch();
			imp = getImportImplementation(con, tranId);
			imp.validateRows(con, tranId, uploadNo, invalidData, userCode);
			if (invalidData != null) {
				size -= 1;// excluding first row
				size -= invalidData.size();
			}
			getInvalidRowsJson(generator, invalidData);
			generator.writeStringField("rowstoimport", String.valueOf(size));
			generator.writeStringField("result", "Success");
			generator.writeEndObject();
			generator.writeEndObject();
			generator.close();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				generator.flush();
				generator.writeStartObject();
				generator.writeFieldName("data");
				generator.writeStartObject();
				generator.writeStringField("result", "Error while updating the migration mapping");
				generator.writeEndObject();
				generator.writeEndObject();
				generator.close();
			} catch (IOException e1) {

			}
			System.out.println(e.getMessage());
		} finally {
			try {
				if (pImport != null) {
					pImport.close();
				}
			} catch (SQLException es) {
				System.out.println(es.getMessage());
			}
		}
		return result.toString();
	}

	public static String saveData(Connection con, String id, String uploadNo, String userCode) {
		String result = "Success";
		DataImportInterface imp = null;
		try {
			imp = getImportImplementation(con, id);
			imp.dataImport(con, id, uploadNo, userCode);
		} catch (Exception e) {
			result = " Error in saving the data ";
			System.out.println(e.getMessage());
		}
		return result;
	}

	public static String getNextUploadId() throws Exception {
		String upId = "";
		Connection conn = null;
		ResultSet rs = null;
		Statement stmt = null;
		try {
			conn = DatabaseUtil.getConnection();
			stmt = conn.createStatement();
			stmt.executeUpdate(updateUploadId);
			rs = stmt.executeQuery(getUploadId);
			if (rs.next()) {
				upId = rs.getString("seq_no");
			}
			rs.close();
			stmt.close();
			rs = null;
		} catch (Exception e) {
			throw new Exception("Error while taking upload id");
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException es) {
				es.printStackTrace();
			}
		}
		return upId;
	}
}
