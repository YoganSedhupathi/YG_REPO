package com.cissol.core.di;

import java.sql.Connection;
import java.util.ArrayList;

public interface DataImportInterface {
	public static final int invalidRow = 0;
	public static final int invalidReason = 1;

	public void validateRows(Connection con, String importId, String uploadId, ArrayList<ArrayList<String>> invalidData,
			String userCode) throws Exception;

	public String dataImport(Connection con, String importId, String uploadId, String userCode) throws Exception;
}