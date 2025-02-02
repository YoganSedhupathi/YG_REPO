/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.9
 * Generated at: 2024-07-19 08:16:34 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.pages;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class RoomShift_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports,
                 org.apache.jasper.runtime.JspSourceDirectives {

  private static final jakarta.servlet.jsp.JspFactory _jspxFactory =
          jakarta.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("jakarta.servlet");
    _jspx_imports_packages.add("jakarta.servlet.http");
    _jspx_imports_packages.add("jakarta.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile jakarta.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public boolean getErrorOnELNotFound() {
    return false;
  }

  public jakarta.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final jakarta.servlet.http.HttpServletRequest request, final jakarta.servlet.http.HttpServletResponse response)
      throws java.io.IOException, jakarta.servlet.ServletException {

    if (!jakarta.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final jakarta.servlet.jsp.PageContext pageContext;
    jakarta.servlet.http.HttpSession session = null;
    final jakarta.servlet.ServletContext application;
    final jakarta.servlet.ServletConfig config;
    jakarta.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    jakarta.servlet.jsp.JspWriter _jspx_out = null;
    jakarta.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!DOCTYPE HTML>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\r\n");
      out.write("  <title>Admission</title>\r\n");
      out.write("</head>\r\n");
String mode=request.getParameter("mode");
String code=request.getParameter("code");

      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("	<div class=\"card border-0 shadow\">\r\n");
      out.write("		<div class=\"card-body lpage\">\r\n");
      out.write("		  <!--Header-->\r\n");
      out.write("		  <div class=\"row w-100\">\r\n");
      out.write("					  <div class=\"col-md-6 d-flex align-items-center\">\r\n");
      out.write("						  <h4 class=\"header-title\">Room Shifting </h4>\r\n");
      out.write("					  </div>\r\n");
      out.write("					  <div  class=\"col-md-6 text-right\">\r\n");
      out.write("			   \r\n");
      out.write("			  </div>\r\n");
      out.write("		  </div>\r\n");
      out.write("		  <!--Header End-->\r\n");
      out.write("		  <!--Content -->\r\n");
      out.write("			<div class=\"row\" id=\"jqcontainer\" style=\"display:none;\">\r\n");
      out.write("			  <div class=\"table-container\">\r\n");
      out.write("				<div id=\"xyz\" class=\"w-100\">\r\n");
      out.write("	  \r\n");
      out.write("				</div>\r\n");
      out.write("			  </div>\r\n");
      out.write("			</div>	\r\n");
      out.write("			<div id=\"callback\" class=\"mt-3\">\r\n");
      out.write("				<div class=\"bline\"><h6>Patient Details</h6></div>\r\n");
      out.write("			 \r\n");
      out.write("				<div class=\"row w-100 cBor\">\r\n");
      out.write("					<div class=\"col-sm-12 col-md-12 col-lg-12 \">     \r\n");
      out.write("						<div  class=\"col-md-2 col-sm-2 mpZero \" style=\"display:none\">\r\n");
      out.write("							<div class=\"form-group mbotto\">\r\n");
      out.write("								<div class=\"col-md-12\"><label>Search By </label></div>\r\n");
      out.write("							</div>\r\n");
      out.write("						</div>\r\n");
      out.write("						<div class=\"input-group mb-1\"> \r\n");
      out.write("								<div class=\"col-md-2\"><label for=\"smobileno\" class=\"form-lable\">Search By </label></div>\r\n");
      out.write("								<div class=\"col-md-4\"><input type=\"text\" class=\"form-control\" id=\"smobileno\"/></div>\r\n");
      out.write("								<div  class=\"col-md-6 col-sm-6 mpZero\">\r\n");
      out.write("									<div class=\"col-md-12 form-lable\">Reg No:&nbsp;<label  class=\"form-lable\" id=\"lcsno\"></label>&nbsp;|&nbsp;Room No:&nbsp;<label class=\"form-lable\" id=\"roomno\">RoomNo</label></div>\r\n");
      out.write("								</div>\r\n");
      out.write("						</div>\r\n");
      out.write("					</div>\r\n");
      out.write("					\r\n");
      out.write("					<div class=\"col-sm-12 col-md-12 col-lg-12\">  \r\n");
      out.write("						<div class=\"input-group mb-1\">\r\n");
      out.write("									   <div class=\"col-md-2\"><label for=\"patientname\" class=\"form-lable\">Patient Name </label></div>\r\n");
      out.write("									   <div class=\"col-md-4\"><input type=\"text\" class=\"form-control\" id=\"patientname\"><input type=\"hidden\" class=\"form-control\" id=\"patientcode\"><input type=\"hidden\" class=\"form-control\" id=\"hospregcode\"><input type=\"hidden\" class=\"form-control\" id=\"appid\"><input type=\"hidden\" class=\"form-control\" id=\"casualityno\"><input type=\"hidden\" class=\"form-control\" id=\"csno\"><input type=\"hidden\" class=\"form-control\" id=\"claimno\"></div>\r\n");
      out.write("									   \r\n");
      out.write("									    <div class=\"col-md-2\"><label class=\"form-lable\">IP No</label></div>\r\n");
      out.write("										<div class=\"col-md-4\"><input type=\"text\" class=\"form-control\" id=\"ipno\"><input type=\"hidden\" id=\"sponsorname\"/><input type=\"hidden\" id=\"sponsorcode\"/></div>\r\n");
      out.write("						</div>\r\n");
      out.write("					</div>\r\n");
      out.write("					<div class=\"col-sm-12 col-md-12 col-lg-12\">  \r\n");
      out.write("						<div class=\"input-group mb-1\">\r\n");
      out.write("							<div class=\"col-md-2\"><label for=\"patientage\" class=\"form-lable\">Age </label></div>\r\n");
      out.write("							<div class=\"col-md-4\"><label class=\"form-lable\" id=\"patientage\"></label></div>\r\n");
      out.write("							<div class=\"col-md-2\"><label for=\"gender\" class=\"form-lable\">Gender</label></div>\r\n");
      out.write("							<div class=\"col-md-4\"><label class=\"form-lable\" id=\"gender\"></label></div>\r\n");
      out.write("						</div>\r\n");
      out.write("					</div>\r\n");
      out.write("					<div class=\"col-sm-12 col-md-12 col-lg-12\">  \r\n");
      out.write("						<div class=\"input-group mb-1\">\r\n");
      out.write("							<div class=\"col-md-2\"><label for=\"doctorname\" class=\"form-lable\">Doctor name</label></div>\r\n");
      out.write("									   <div class=\"col-md-4\"><label class=\"form-lable\" id=\"doctorname\"></label><input type=\"hidden\" id=\"doctorcode\"/></div>\r\n");
      out.write("									   \r\n");
      out.write("									   <div class=\"col-md-2\"><label for=\"referredby\" class=\"form-lable\">Refer By</label></div>\r\n");
      out.write("									   <div class=\"col-md-4\"><label class=\"form-lable\" id=\"referredby\"></label><input type=\"hidden\" id=\"referralcode\"/></div>\r\n");
      out.write("							</div>\r\n");
      out.write("					</div>\r\n");
      out.write("				</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("	  \r\n");
      out.write("			   <div class=\"row\">\r\n");
      out.write("				  <div class=\"table-container\">\r\n");
      out.write("					<div class=\"col-md-12 col-sm-12 garea\" id=\"roomgrid\"></div>\r\n");
      out.write("				  </div>\r\n");
      out.write("				</div>\r\n");
      out.write("	  \r\n");
      out.write("				<div class=\"row w-100 mt-3\">\r\n");
      out.write("				  <div class=\"col-md-4\">\r\n");
      out.write("					<div class=\"hstack justify-content-start\">\r\n");
      out.write("					  <div id=\"saveGrp\">\r\n");
      out.write("						<div class=\"mb-3\">\r\n");
      out.write("							<button type=\"button\" class=\"btn btn-edit\" onclick='saveRoomShift()'><span class=\"mdi mdi-check-circle-outline me-2\">Save</span></button>\r\n");
      out.write("						     <button type=\"button\" class=\"btn btn-clear\" onclick='hideMasterData()'><span class=\"mdi mdi-refresh me-2\">Cancel</span></button>\r\n");
      out.write("						</div>\r\n");
      out.write("					  </div>\r\n");
      out.write("					</div>\r\n");
      out.write("				  </div>\r\n");
      out.write("				</div>\r\n");
      out.write("\r\n");
      out.write("		  </div>\r\n");
      out.write("		 <!--Content End-->\r\n");
      out.write("		</div>\r\n");
      out.write("	  </div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("	<script>\r\n");
      out.write("	loadBranchData();\r\n");
      out.write("	jqReport(12,\"#xyz\",\"&branchcode=\"+$('#branch').val());\r\n");
      out.write("    var sProps={js:\"\",screen:[\r\n");
      out.write("  	{name:\"group1\",predesigned:true,contentType:\"Fields\",\r\n");
      out.write("  	fields:[\r\n");
      out.write("  	{name:\"branchcode\",inputType:0,type:\"INT\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"ipno\"},\r\n");
      out.write("  	{name:\"ipno\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:true,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"patientname\"},\r\n");
      out.write("  	{name:\"roomno\",inputType:4,type:\"SPAN\",caption:\"\",mandatory:true,defaultValue:\"\",\"maxValue\":0,\"textLength\":100,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"patientname\"},\r\n");
      out.write("  	{name:\"patientname\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:true,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"patientage\"},\r\n");
      out.write("  	{name:\"patientcode\",inputType:0,type:\"INT\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"patientage\"},\r\n");
      out.write("  	{name:\"patientage\",inputType:4,type:\"SPAN\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":30,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"doctorname\"},\r\n");
      out.write("  	{name:\"gender\",inputType:4,type:\"SPAN\",caption:\"\",mandatory:false,defaultValue:\"M\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"doctorname\"},\r\n");
      out.write("  	{name:\"doctorname\",inputType:4,type:\"SPAN\",caption:\"\",mandatory:true,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"referredby\"},\r\n");
      out.write("  	{name:\"doctorcode\",inputType:0,type:\"INT\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"referredby\"},\r\n");
      out.write("  	{name:\"sponsorname\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:false,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"referredby\"},\r\n");
      out.write("  	{name:\"sponsorcode\",inputType:0,type:\"INT\",caption:\"\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"referredby\"},\r\n");
      out.write("  	{name:\"referralcode\",inputType:0,type:\"INT\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"referredby\"},\r\n");
      out.write("  	{name:\"referredby\",inputType:4,type:\"SPAN\",caption:\"\",mandatory:false,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"roomgrid_data\"},\r\n");
      out.write("  	{name:\"smobileno\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:false,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"ipno\",validation:\"checkIPPatientExists\"},\r\n");
      out.write("  	{name:\"btnSave\",inputType:3,caption:\"\",visible:false},\r\n");
      out.write("    {name:\"btnClear\",inputType:3,caption:\"\",visible:false}\r\n");
      out.write("  	]},\r\n");
      out.write("  	{name:\"roomgrid\",title:\"\",contentType:\"Table\",tableProperties:{rowObject:true,serialNumberColumn:\"sno\",rowEmptyCheckColumn:\"roomcode\",optional:false,enableAddRow:true,columns:[\r\n");
      out.write("    {order:\"0\",id: \"sno\", name: \"SNo\", field: \"sno\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,\"chkTag\":false,width:50,sno:true},\r\n");
      out.write("    {order:\"1\",id: \"rsdid\", name: \"ID\", field: \"rsdid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":false,\"chkTag\":false,width:0},\r\n");
      out.write("    {order:\"2\",id: \"roomcode\", name: \"RoomCode\", field: \"roomcode\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,width:0,\"chkTag\":false},    \r\n");
      out.write("  	{order:\"3\",id: \"roomname\", name: \"Room\", field: \"roomname\",defaultValue:\"\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"mandatory\":true,width:200,\"chkTag\":true,lovOptions:{url:\"/waggle/service/ajax\",ajax:\"rooms\",scrollEnabled:true,searchFromList:false,dsi:0,\r\n");
      out.write("	params:[\r\n");
      out.write("	{n:\"branchcode\",src:\"branchcode\",tt:false}\r\n");
      out.write("	],results:[\r\n");
      out.write("	{tgt:\"roomgrid_data\",col:\"roomname\",row:\"cr\",tt:false,id:\"rm_roomname\"},\r\n");
      out.write("	{tgt:\"roomgrid_data\",col:\"roomname\",row:\"cr\",tt:true,id:\"rm_roomname\"},\r\n");
      out.write("	{tgt:\"roomgrid_data\",col:\"roomcode\",row:\"cr\",tt:false,id:\"rm_code\"},\r\n");
      out.write("	{tgt:\"roomgrid_data\",col:\"wardname\",row:\"cr\",tt:false,id:\"wm_wardname\"},\r\n");
      out.write("	{tgt:\"roomgrid_data\",col:\"wardcode\",row:\"cr\",tt:false,id:\"rm_wardcode\"}\r\n");
      out.write("	]},validation:\"populateAdmissionTime\"\r\n");
      out.write("	},\r\n");
      out.write("	{order:\"4\",id: \"admissiondate\", name: \"Admission Time\", field: \"admissiondate\",defaultValue:\"\",\"inputType\":0,\"type\":\"TDATETIME\",\"maxValue\":0,\"textLength\":13,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"mandatory\":true,width:200,align:\"left\"},	\r\n");
      out.write("	{order:\"5\",id: \"wardcode\", name: \"WardCode\", field: \"wardcode\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":true,width:0,\"chkTag\":false},\r\n");
      out.write("    {order:\"6\",id: \"wardname\", name: \"Ward\", field: \"wardname\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,width:150,align:\"left\"},    	  \r\n");
      out.write("    {order:\"7\",id: \"dischargedtime\", name: \"Discharged Time\", field: \"dischargedtime\",defaultValue:\"\",\"inputType\":0,\"type\":\"TDATETIME\",\"maxValue\":0,\"textLength\":13,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"mandatory\":false,width:200,align:\"left\"}\r\n");
      out.write("    ]\r\n");
      out.write("    }}]};\r\n");
      out.write("	var roomshift=new FlexUI.Screen(\"roomshift\",sProps);	\r\n");
      out.write("	//ajax columns\r\n");
      out.write("	$('#screentitle').text(\"Room Shift\");\r\n");
      out.write("	var l=new FlexUI.Ajax();\r\n");
      out.write("    $(document).ready(function () {\r\n");
      out.write("    		addMasterData();\r\n");
      out.write("            screenObjects.getScreenObject(\"branchcode\").setValue($('#branch').val());\r\n");
      out.write("            var grid=screenObjects.getScreenObject(\"roomgrid_data\").onBeforeDeleteRow.subscribe(onRowDelete);\r\n");
      out.write("            $('#subtitle').text(\"\");\r\n");
      out.write("     });\r\n");
      out.write("\r\n");
      out.write("	 function checkdate(){\r\n");
      out.write("		var Adatetimeval = $(\"#admissiondate\").val();\r\n");
      out.write("		var Ddatetimeval = $(\"#dischargedtime\").val();\r\n");
      out.write("\r\n");
      out.write("		if (Adatetimeval > Ddatetimeval ) {\r\n");
      out.write("       alert(\"you can not choose date greater then current\");   \r\n");
      out.write("    }\r\n");
      out.write("   else {\r\n");
      out.write("      alert(\"valid date\");\r\n");
      out.write("	  return false;\r\n");
      out.write("	 }\r\n");
      out.write("	}\r\n");
      out.write("     function saveRoomShift(){\r\n");
      out.write("     		if(!checkPatientStatus()) return;\r\n");
      out.write("     		if(roomshift.getSaveInProgress()) return;\r\n");
      out.write("        	var r=null;\r\n");
      out.write("    		roomshift.setOperation(\"ADD\");\r\n");
      out.write("    		roomshift.setScreenCode(12);\r\n");
      out.write("    		var d=roomshift.processDataToSave(null,0,2);\r\n");
      out.write("			// alert(\"the value d\"+\" \"+ d);\r\n");
      out.write("    		roomshift.setSaveInProgress(true);\r\n");
      out.write("			if(\"FAILED\"!=d){\r\n");
      out.write("				var s=new FlexUI.Ajax();\r\n");
      out.write("				showLoader();\r\n");
      out.write("				r=s.callAjax(\"POST\",\"/waggle/service/screen/save\",d);\r\n");
      out.write("				hideLoader();\r\n");
      out.write("		 	}else{\r\n");
      out.write("		 		roomshift.setSaveInProgress(false);\r\n");
      out.write("		 		alert(\"Please correct the validation errors and continue...\");\r\n");
      out.write("		 		return;\r\n");
      out.write("		 	}		 \r\n");
      out.write("		 	if(r.result==\"Success\"){\r\n");
      out.write("				alert(r.message);\r\n");
      out.write("				hideMasterData();\r\n");
      out.write("				roomshift.setSaveInProgress(false);\r\n");
      out.write("				return r.key;		\r\n");
      out.write("			}else{\r\n");
      out.write("				roomshift.setSaveInProgress(false);\r\n");
      out.write("				alert(r.message);		\r\n");
      out.write("			}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("      }\r\n");
      out.write("      function deleteRoomShift(){\r\n");
      out.write("      		if(!checkPatientStatus()) return;\r\n");
      out.write("      		if(roomshift.getSaveInProgress()) return;\r\n");
      out.write("        	var r=null;\r\n");
      out.write("    		roomshift.setOperation(\"DEL\");\r\n");
      out.write("    		roomshift.setScreenCode(12);\r\n");
      out.write("    		var d=roomshift.processDataToSave(null,0,1);\r\n");
      out.write("    		roomshift.setSaveInProgress(true);    		\r\n");
      out.write("			if(\"FAILED\"!=d){\r\n");
      out.write("				var s=new FlexUI.Ajax();\r\n");
      out.write("				showLoader();\r\n");
      out.write("				r=s.callAjax(\"POST\",\"/waggle/service/screen/save\",d);\r\n");
      out.write("				hideLoader();\r\n");
      out.write("		 	}else{\r\n");
      out.write("		 		alert(\"Please correct the validation errors and continue...\");\r\n");
      out.write("		 		return;\r\n");
      out.write("		 	}		 \r\n");
      out.write("		 	if(r.result==\"Success\"){\r\n");
      out.write("		 		roomshift.setSaveInProgress(false);		 		\r\n");
      out.write("				alert(\"Room Details Deleted Successfully\");\r\n");
      out.write("				return \"OK\";			\r\n");
      out.write("			}else{\r\n");
      out.write("				roomshift.setSaveInProgress(false);				\r\n");
      out.write("				alert(r.message);\r\n");
      out.write("				return \"\";		\r\n");
      out.write("			}\r\n");
      out.write("      }\r\n");
      out.write("      \r\n");
      out.write("        function clearInnerScreen(){\r\n");
      out.write("        	$('#overlapdiv').css('display','none');\r\n");
      out.write("        	roomshift.clearScreen();\r\n");
      out.write("        	roomshift.setSaveInProgress(false);        	\r\n");
      out.write("        	screenObjects.getScreenObject(\"branchcode\").setValue($('#branch').val());\r\n");
      out.write("        }\r\n");
      out.write("  function addMasterData(){ \r\n");
      out.write("  	clearInnerScreen();\r\n");
      out.write("  	$('#callback').css('display','block');\r\n");
      out.write("	$('#jqcontainer').css('display','none');\r\n");
      out.write("  	$('#xyz').css('display','none');\r\n");
      out.write("  	$('#addGrp').css('display','none');\r\n");
      out.write("	$('#saveGrp').css('display','block');\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function hideMasterData(){\r\n");
      out.write("  	//$('#callback').css('display','none');\r\n");
      out.write("  	//$('#xyz').css('display','block');\r\n");
      out.write("  	//$('#addGrp').css('display','block');\r\n");
      out.write("	//$('#saveGrp').css('display','none');\r\n");
      out.write("  	clearInnerScreen();\r\n");
      out.write("  	$('#smobileno').focus();\r\n");
      out.write("  	//reloadGrid(12);\r\n");
      out.write("  }\r\n");
      out.write("    \r\n");
      out.write("  function toggleHeaderRow(){\r\n");
      out.write("  	toggleSearchToolBar(12);\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  toggleHeaderRow();\r\n");
      out.write("  \r\n");
      out.write("  function loadOrderData(url,code,did){\r\n");
      out.write("  	showLoader();\r\n");
      out.write("	var l=new FlexUI.Ajax();\r\n");
      out.write("	var v=l.callAjax(\"GET\",url,\"&screencode=12\");\r\n");
      out.write("	roomshift.loadObjectData(v);\r\n");
      out.write("	$('#callback').css('display','block');\r\n");
      out.write("  	$('#xyz').css('display','none');\r\n");
      out.write("	$('#jqcontainer').css('display','none');\r\n");
      out.write("  	$('#addGrp').css('display','none');\r\n");
      out.write("  	hideLoader();\r\n");
      out.write("  	var grid=screenObjects.getScreenObject(\"roomgrid_data\");\r\n");
      out.write("	var siz=grid.getSize();\r\n");
      out.write("	for(var i=0;i<siz-1;i++){\r\n");
      out.write("		grid.getRow(i).setEditable(false);\r\n");
      out.write("		grid.checkAndMove(\"Next\",false);		\r\n");
      out.write("	}\r\n");
      out.write("	grid.deleteAndMove();			\r\n");
      out.write("  }\r\n");
      out.write("  function populateAdmissionTime(id,me,row,col){\r\n");
      out.write("  		var grid=screenObjects.getScreenObject(\"roomgrid_data\");\r\n");
      out.write("  		var cols=grid.getCols();\r\n");
      out.write("  		if(grid.getSize()>1 && grid.getText(row,cols.admissiondate)==\"\"){\r\n");
      out.write("  			if(grid.getText(row-1,cols.dischargedtime)==\"\"){\r\n");
      out.write("  				alert(\"Please fill the discharge date for the previous room number and continue...\");\r\n");
      out.write("  				grid.setText(row,cols.roomcode,\"\");\r\n");
      out.write("  				grid.setText(row,cols.roomname,\"\");\r\n");
      out.write("  				grid.setText(row,cols.wardcode,\"\");\r\n");
      out.write("  				grid.setText(row,cols.wardname,\"\");  				\r\n");
      out.write("  				return false;\r\n");
      out.write("  			}\r\n");
      out.write("  			grid.setText(row,cols.admissiondate,grid.getText(row-1,cols.dischargedtime));\r\n");
      out.write("  		}\r\n");
      out.write("  		return true;\r\n");
      out.write("  } \r\n");
      out.write("  function onRowDelete(e,args){\r\n");
      out.write("  	var grid=screenObjects.getScreenObject(\"roomgrid_data\");\r\n");
      out.write("  	if(grid.getSize()-1==args.row){\r\n");
      out.write("  		var rsdid=grid.getText(args.row,grid.getCols().rsdid);\r\n");
      out.write("  		if(rsdid!=\"\" && rsdid!=0){\r\n");
      out.write("  			if(confirm(\"Do you want to delete the room details?\")){\r\n");
      out.write("	  			//call delete row\r\n");
      out.write("	  			var res=deleteRoomShift();\r\n");
      out.write("	  			if(res==\"OK\"){\r\n");
      out.write("	  				return true;\r\n");
      out.write("	  			}else{\r\n");
      out.write("	  				return false;\r\n");
      out.write("	  			}\r\n");
      out.write("	  		}else{\r\n");
      out.write("	  			return false;\r\n");
      out.write("	  		}\r\n");
      out.write("  		}\r\n");
      out.write("  		if(args.row-1>=0){\r\n");
      out.write("  			grid.getRow(args.row-1).setEditable(true);\r\n");
      out.write("  		}\r\n");
      out.write("	  	return true;\r\n");
      out.write("  	}\r\n");
      out.write("  	return false;\r\n");
      out.write("  }\r\n");
      out.write("  function checkPatientStatus(){\r\n");
      out.write("		var result=true;\r\n");
      out.write("		var code=screenObjects.getScreenObject(\"patientcode\").getValue();\r\n");
      out.write("		var l=new FlexUI.Ajax();\r\n");
      out.write("		v=l.callAjax(\"GET\",\"/waggle/service/ajax\",\"ic=0&id=patientstatus&code=\"+code);\r\n");
      out.write("		if(v!=null && v.data.length>0){\r\n");
      out.write("			if(v.data[0][0]==2){\r\n");
      out.write("				alert(\"Patient already discharged. Please exit the screen to continue\");\r\n");
      out.write("				result=false;\r\n");
      out.write("			}\r\n");
      out.write("		}				\r\n");
      out.write("		return result;	\r\n");
      out.write("  }\r\n");
      out.write("		function checkIPPatientExists(id,me){\r\n");
      out.write("			if(!roomshift.getSaveInProgress()){\r\n");
      out.write("				var branch=screenObjects.getScreenObject(\"branchcode\").getValue();\r\n");
      out.write("				var stext=screenObjects.getScreenObject(\"smobileno\").getValue();\r\n");
      out.write("				var params=\"\";\r\n");
      out.write("				var paramName=\"F1\";\r\n");
      out.write("				var dsi=0;\r\n");
      out.write("				var searchType=$('#searchtype').val();\r\n");
      out.write("				params=\"&F2=\"+stext;\r\n");
      out.write("				paramName=\"F2\";\r\n");
      out.write("				dsi=1;					\r\n");
      out.write("				if(stext!=\"\"){\r\n");
      out.write("					var v=null;\r\n");
      out.write("					var l=new FlexUI.Ajax();\r\n");
      out.write("					v=l.callAjax(\"GET\",\"/waggle/service/ajax\",\"ic=0&id=hospinpatients&branchcode=\"+branch+\"&searchtxt=\"+escape(stext));\r\n");
      out.write("					if(v!=null){\r\n");
      out.write("						if(v.data && v.data.length==1){\r\n");
      out.write("							getPatientInfo(branch,v.data[0]);					\r\n");
      out.write("							return true;\r\n");
      out.write("						}else if(v.data && v.data.length>1){\r\n");
      out.write("							screenObjects.getScreenObject(\"smobileno\").setTag(stext);\r\n");
      out.write("							var d=null;\r\n");
      out.write("							d={url:\"/waggle/service/ajax\",ajax:\"hospinpatients\",scrollEnabled:true,searchFromList:false,dsi:dsi,edsi:1,params:[{n:\"branchcode\",src:\"branchcode\",ft:false},{n:\"searchtxt\",src:\"smobileno\",ft:false}],results:[],standalone:true};\r\n");
      out.write("							var lov=new FlexUI.LOV(\"s_lov\",me,d,v.data);\r\n");
      out.write("							lov.onLovClose.subscribe(onPatientClose);\r\n");
      out.write("							lov.show();					\r\n");
      out.write("							return false;\r\n");
      out.write("						}		\r\n");
      out.write("					}\r\n");
      out.write("				}\r\n");
      out.write("				clearInnerScreen();\r\n");
      out.write("				return false;				\r\n");
      out.write("			}else{\r\n");
      out.write("				screenObjects.getScreenObject(\"smobileno\").setTag(\"\");\r\n");
      out.write("				return true;\r\n");
      out.write("			}	\r\n");
      out.write("		}\r\n");
      out.write("		function onPatientClose(e,args){\r\n");
      out.write("			var branch=screenObjects.getScreenObject(\"branchcode\").getValue();\r\n");
      out.write("			loadOrderData(\"/waggle/service/screen/data?branchcode=\"+branch+\"&patientcode=\"+args.result[20],0,\"\")\r\n");
      out.write("		}		\r\n");
      out.write("		function getPatientInfo(branch,result){\r\n");
      out.write("			$('#lcsno').text(result[1]);\r\n");
      out.write("			loadOrderData(\"/waggle/service/screen/data?branchcode=\"+branch+\"&patientcode=\"+result[20],0,\"\");\r\n");
      out.write("		}\r\n");
      out.write("  </script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof jakarta.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
