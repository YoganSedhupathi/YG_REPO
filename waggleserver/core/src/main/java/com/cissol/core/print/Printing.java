package com.cissol.core.print;

import java.applet.Applet;

//import jakarta.jnlp.PrintService;
//import jakarta.jnlp.ServiceManager;
//import jakarta.jnlp.UnavailableServiceException;

import netscape.javascript.JSObject;

@SuppressWarnings("removal")
public class Printing extends Applet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	JSObject jsObj = null;
	private String browserName = null;

	public void printDocument() {
//		 PrintService ps; 
//
//		    try { 
//		        ps = (PrintService)ServiceManager.lookup("javax.jnlp.PrintService"); 
//		    } catch (UnavailableServiceException e) { 
//		        ps = null; 
//		    } 
//
//		    if (ps != null) { 
//		        try { 
//		             
//		            // get the default PageFormat
//		            PageFormat pf = ps.getDefaultPage(); 
//
//		            // ask the user to customize the PageFormat
//		            PageFormat newPf = ps.showPageFormatDialog(pf); 
//
//		            // print the document with the PageFormat above
//		            ps.print(new PrintUtil().getDocument()); 
//		           
//		        } catch (Exception e) { 
//		            e.printStackTrace(); 
//		        } 
//		    } 
		new PrintUtil();
	}

	public void init() {
		System.out.println("intializing....");
		//// jsObj=JSObject.getWindow(this);
	}
}