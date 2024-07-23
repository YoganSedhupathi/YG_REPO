package com.cissol.core.ui;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Map;

public interface SaveMasterInterface {
	public String executeMaster(Connection con, String screenCode, String operation, Map<String, Object> saveData)
			throws Exception;
}