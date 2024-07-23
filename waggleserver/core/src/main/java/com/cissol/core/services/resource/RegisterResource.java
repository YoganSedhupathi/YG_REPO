package com.cissol.core.services.resource;

import java.util.Map;

import com.cissol.core.register.Register;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.MultivaluedMap;
import jakarta.ws.rs.core.UriInfo;

@Path("register")
public class RegisterResource {

	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public String register(MultivaluedMap<String, String> formParams, @Context final UriInfo uriInfo) {
		String result = "";
		try {
			ObjectMapper obj = new ObjectMapper();
			Map<String, Object> m = obj.readValue(formParams.getFirst("data"),
					new TypeReference<Map<String, Object>>() {
					});
			System.out.println(" " + m.get("savedata"));
			Register l = Register.getInstance();
			String op = (String) m.get("operation");
			if ("ADD".equals(op)) {
				result = l.register((Map) m.get("savedata"));
			} else if ("EDIT".equals(op)) {
				result = l.reRegister((Map) m.get("savedata"));
			} else if ("DELETE".equals(op)) {
				result = l.deleteRegistration((Map) m.get("savedata"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Path("/login")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public String login(MultivaluedMap<String, String> formParams, @Context final UriInfo uriInfo) {
		String result = "";
		try {
			Register l = Register.getInstance();
			result = l.checkUser(formParams.getFirst("userid"), formParams.getFirst("password"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}