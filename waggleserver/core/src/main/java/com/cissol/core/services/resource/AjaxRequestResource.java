package com.cissol.core.services.resource;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import org.glassfish.jersey.uri.UriComponent;

import com.cissol.core.util.AjaxResponseUtil;
import com.cissol.core.util.AutoCompleteUtil;

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

@Path("ajax")
public class AjaxRequestResource {
	@Context
	HttpServletRequest req;
	@Context
	HttpServletResponse res;

	@GET
	@Produces("application/json;charset=utf-8")
	public StreamingOutput getAjaxResponse(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				PrintWriter p = new PrintWriter(out);
				MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(), true);
				String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
				if (loginId != null) {
					queryParams.add("login_id", loginId);
				}
				String portalCode = (String) req.getSession().getAttribute("PORTALCODE");
				if (portalCode != null) {
					queryParams.add("portal_code", portalCode);
				}
				AjaxResponseUtil.getResultJson(queryParams, out);
			}
		};
	}

	@Path("/autocomplete")
	@GET
	@Produces("application/json;charset=utf-8")
	public StreamingOutput getAutoCompleteResponse(@Context final UriInfo uriInfo) {
		return new StreamingOutput() {

			@Override
			public void write(OutputStream out) throws IOException, WebApplicationException {
				PrintWriter p = new PrintWriter(out);
				MultivaluedMap<String, String> queryParams = UriComponent.decodeQuery(uriInfo.getRequestUri(), true);
				String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
				if (loginId != null) {
					queryParams.add("login_id", loginId);
				}
				String portalCode = (String) req.getSession().getAttribute("PORTALCODE");
				if (portalCode != null) {
					queryParams.add("portal_code", portalCode);
				}
				AutoCompleteUtil.getResultJson(queryParams, out);
			}
		};
	}
}