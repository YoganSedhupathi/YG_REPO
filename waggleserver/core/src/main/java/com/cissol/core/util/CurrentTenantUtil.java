package com.cissol.core.util;

public class CurrentTenantUtil {
	private static ThreadLocal<TenantInfo> currentTenant = new ThreadLocal<TenantInfo>();

	public static void setTenantInfo(TenantInfo tenant) {
		currentTenant.set(tenant);
	}

	public static TenantInfo getTenantInfo() {
		return currentTenant.get();
	}

	public static void removeTenantInfo() {
		currentTenant.remove();
	}
}
