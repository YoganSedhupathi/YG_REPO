package com.cissol.core.util;

public class TenantInfo {
	private String tenantId = "";
	private String tenantDatabaseUrl = "";
	private String tenantDomain = "";
	private String loginId = "";

	public String getTenantId() {
		return tenantId;
	}

	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}

	public String getTenantDatabaseUrl() {
		return tenantDatabaseUrl;
	}

	public void setTenantDatabaseUrl(String tenantDatabaseUrl) {
		this.tenantDatabaseUrl = tenantDatabaseUrl;
	}

	public String getTenantDomain() {
		return tenantDomain;
	}

	public void setTenantDomain(String tenantDomain) {
		this.tenantDomain = tenantDomain;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getLoginId() {
		return loginId;
	}
}
