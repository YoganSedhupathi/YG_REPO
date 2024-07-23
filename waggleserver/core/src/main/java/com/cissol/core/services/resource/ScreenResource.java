package com.cissol.core.services.resource;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Map;

import org.glassfish.jersey.uri.UriComponent;

import com.cissol.core.ui.LoadMasters;
import com.cissol.core.ui.SaveMasters;
import com.cissol.core.ui.ScreenProperties;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedMap;
import jakarta.ws.rs.core.StreamingOutput;
import jakarta.ws.rs.core.UriInfo;

@Path("screen")
public class ScreenResource {
	@Context
	HttpServletRequest req;

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
				ScreenProperties.getScreenProperties(queryParams, p);
			}
		};
	}

	@Path("/data")
	@GET
	@Produces("application/json;charset=utf-8")
	public StreamingOutput getEditData(@Context final UriInfo uriInfo) {
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
				LoadMasters.getScreenData(queryParams, out);
			}
		};
	}

	@Path("/save")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED + ";charset=utf-8")
	public String register(MultivaluedMap<String, String> formParams, @Context final UriInfo uriInfo) {
		String result = "";
		try {
			String userId = (String) req.getSession().getAttribute("USER_ID");
			String loginId = (String) req.getSession().getAttribute("LOGIN_ID");
			String portalCode = (String) req.getSession().getAttribute("PORTALCODE");
			ObjectMapper obj = new ObjectMapper();
			System.out.println(formParams.getFirst("data"));
			Map<String, Object> m = obj.readValue(formParams.getFirst("data").getBytes("UTF-8"),
					new TypeReference<Map<String, Object>>() {
					});
			System.out.println(" " + m.get("savedata"));
			Map saveData = (Map) m.get("savedata");
			saveData.put("loginid", loginId);
			saveData.put("userid", userId);
			saveData.put("portalcode", portalCode);
			SaveMasters sm = SaveMasters.getInstance();
			String operation = (String) m.get("operation");
			String screenCode = (String) m.get("screencode");
			result = sm.saveData((Map) m.get("savedata"), screenCode, operation);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}