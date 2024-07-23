package com.cissol.core.services.resource;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.glassfish.jersey.uri.UriComponent;

import com.cissol.core.report.ExportReport;
import com.cissol.core.report.WritePDFReport;
import com.cissol.core.util.AjaxResponseUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MultivaluedMap;
import jakarta.ws.rs.core.StreamingOutput;
import jakarta.ws.rs.core.UriInfo;

@Path("report")
public class ReportResource {
	@Context
	HttpServletRequest req;
	@Context
	HttpServletResponse res;
	private static final SimpleDateFormat formatyyyyMMdd = new SimpleDateFormat("yyyyMMdd", Locale.ENGLISH);

	@Path("/metadata")
	@GET
	@Produces("application/json")
	public StreamingOutput getMetaData(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				PrintWriter p = new PrintWriter(out);
				MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(), true);
				String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
				if (loginId != null) {
					queryParams.add("login_id", loginId);
				}
				String userId = (String) req.getSession().getAttribute("USER_ID");
				if (userId != null) {
					queryParams.add("user_id", userId);
				}
				String userCode = (String) req.getSession().getAttribute("SUPPLIERCODE");
				if (userCode != null) {
					queryParams.add("user_code", userCode);
				}
				String portalUserCode = (String) req.getSession().getAttribute("PORTALCODE");
				if (portalUserCode != null) {
					queryParams.add("portal_code", portalUserCode);
				}
				ExportReport.getReportMetaData(queryParams, p);
			}
		};
	}

	@Path("/params")
	@GET
	@Produces("application/json")
	public StreamingOutput getReportParams(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				PrintWriter p = new PrintWriter(out);
				MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(), true);
				String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
				if (loginId != null) {
					queryParams.add("login_id", loginId);
				}
				String userId = (String) req.getSession().getAttribute("USER_ID");
				if (userId != null) {
					queryParams.add("user_id", userId);
				}
				String userCode = (String) req.getSession().getAttribute("SUPPLIERCODE");
				if (userCode != null) {
					queryParams.add("user_code", userCode);
				}
				String portalUserCode = (String) req.getSession().getAttribute("PORTALCODE");
				if (portalUserCode != null) {
					queryParams.add("portal_code", portalUserCode);
				}
				ExportReport.getReportParameters(queryParams, p);
			}
		};
	}

	@Path("/report")
	@GET
	@Produces("application/pdf")
	public StreamingOutput getReport(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				try {
					MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(),
							true);
					queryParams.putSingle("server", AjaxResponseUtil.getServerLocation(uriInfo));
					String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
					if (loginId != null) {
						queryParams.add("login_id", loginId);
					}
					String userId = (String) req.getSession().getAttribute("USER_ID");
					if (userId != null) {
						queryParams.add("user_id", userId);
					}
					String userCode = (String) req.getSession().getAttribute("SUPPLIERCODE");
					if (userCode != null) {
						queryParams.add("user_code", userCode);
					}
					String portalUserCode = (String) req.getSession().getAttribute("PORTALCODE");
					if (portalUserCode != null) {
						queryParams.add("portal_code", portalUserCode);
					}
					ExportReport.exportReport(res, out, queryParams, "pdf");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
	}

	@Path("/xls")
	@GET
	@Produces("application/xls")
	public StreamingOutput getXlsReport(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				try {
					MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(),
							true);
					queryParams.putSingle("server", AjaxResponseUtil.getServerLocation(uriInfo));
					String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
					if (loginId != null) {
						queryParams.add("login_id", loginId);
					}
					String userId = (String) req.getSession().getAttribute("USER_ID");
					if (userId != null) {
						queryParams.add("user_id", userId);
					}
					String userCode = (String) req.getSession().getAttribute("SUPPLIERCODE");
					if (userCode != null) {
						queryParams.add("user_code", userCode);
					}
					String portalUserCode = (String) req.getSession().getAttribute("PORTALCODE");
					if (portalUserCode != null) {
						queryParams.add("portal_code", portalUserCode);
					}
					ExportReport.exportReport(res, out, queryParams, "xls");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
	}

	@Path("/html")
	@GET
	@Produces("text/html")
	public StreamingOutput getHtmlReport(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				try {
					MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(),
							true);
					queryParams.putSingle("server", AjaxResponseUtil.getServerLocation(uriInfo));
					String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
					if (loginId != null) {
						queryParams.add("login_id", loginId);
					}
					String userId = (String) req.getSession().getAttribute("USER_ID");
					if (userId != null) {
						queryParams.add("user_id", userId);
					}
					String userCode = (String) req.getSession().getAttribute("SUPPLIERCODE");
					if (userCode != null) {
						queryParams.add("user_code", userCode);
					}
					String portalUserCode = (String) req.getSession().getAttribute("PORTALCODE");
					if (portalUserCode != null) {
						queryParams.add("portal_code", portalUserCode);
					}
					ExportReport.exportReport(res, out, queryParams, "html");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
	}

	@Path("/reportparams")
	@GET
	@Produces("application/json")
	public StreamingOutput getReportParameters(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				try {
					//PrintWriter p = new PrintWriter(out);
					MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(),
							true);
					AjaxResponseUtil.getReportDetails(queryParams.getFirst("id"), out);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
	}

	@Path("/data")
	@GET
	@Produces("application/json")
	public StreamingOutput getReportData(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				try {
					// PrintWriter p=new PrintWriter(out);
					MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(),
							true);
					String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
					if (loginId != null) {
						queryParams.add("login_id", loginId);
					}
					String userId = (String) req.getSession().getAttribute("USER_ID");
					if (userId != null) {
						queryParams.add("user_id", userId);
					}
					String userCode = (String) req.getSession().getAttribute("SUPPLIERCODE");
					if (userCode != null) {
						queryParams.add("user_code", userCode);
					}
					String portalUserCode = (String) req.getSession().getAttribute("PORTALCODE");
					if (portalUserCode != null) {
						queryParams.add("portal_code", portalUserCode);
					}
					ExportReport.getReportData(queryParams, out);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
	}

	@Path("/writepdf")
	@GET
	@Produces("application/pdf")
	public StreamingOutput getPDF(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				try {
					MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(),
							true);
					String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
					if (loginId != null) {
						queryParams.add("login_id", loginId);
					}
					String userId = (String) req.getSession().getAttribute("USER_ID");
					if (userId != null) {
						queryParams.add("user_id", userId);
					}
					String userCode = (String) req.getSession().getAttribute("SUPPLIERCODE");
					if (userCode != null) {
						queryParams.add("user_code", userCode);
					}
					String portalUserCode = (String) req.getSession().getAttribute("PORTALCODE");
					if (portalUserCode != null) {
						queryParams.add("portal_code", portalUserCode);
					}
					if (queryParams.getFirst("exportname") != null && !"".equals(queryParams.getFirst("exportname"))) {
						res.addHeader("Content-Disposition", "attachment;filename=" + queryParams.getFirst("exportname")
								+ "_" + formatyyyyMMdd.format(new Date()) + ".pdf");
					} else {
						res.addHeader("Content-Disposition",
								"attachment;filename=Report_" + queryParams.getFirst("id") + ".pdf");
					}
					WritePDFReport pdf = new WritePDFReport();
					pdf.writeSimpleDocument(queryParams, out);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
	}

	@Path("/writecsv")
	@GET
	@Produces("text/csv")
	public StreamingOutput getCSV(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				try {
					MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(),
							true);
					String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
					if (loginId != null) {
						queryParams.add("login_id", loginId);
					}
					String userId = (String) req.getSession().getAttribute("USER_ID");
					if (userId != null) {
						queryParams.add("user_id", userId);
					}
					String userCode = (String) req.getSession().getAttribute("SUPPLIERCODE");
					if (userCode != null) {
						queryParams.add("user_code", userCode);
					}
					String portalUserCode = (String) req.getSession().getAttribute("PORTALCODE");
					if (portalUserCode != null) {
						queryParams.add("portal_code", portalUserCode);
					}
					if (queryParams.getFirst("exportname") != null && !"".equals(queryParams.getFirst("exportname"))) {
						res.addHeader("Content-Disposition", "attachment;filename=" + queryParams.getFirst("exportname")
								+ "_" + formatyyyyMMdd.format(new Date()) + ".csv");
					} else {
						res.addHeader("Content-Disposition",
								"attachment;filename=export_" + queryParams.getFirst("id") + ".csv");
					}
					ExportReport.writeCSVDocument(queryParams, out);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		};
	}
}