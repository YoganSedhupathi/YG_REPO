/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.9
 * Generated at: 2024-07-19 08:16:36 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.pages;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class sugerTest_jsp extends org.apache.jasper.runtime.HttpJspBase
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
   String userId=(String)session.getAttribute("LOGIN_ID");
   String branch=request.getParameter("branch"); 

   

      out.write("\r\n");
      out.write("<body>	\r\n");
      out.write("\r\n");
      out.write("	<div class=\"card border-0 shadow\">\r\n");
      out.write("		<div class=\"card-body lpage\">\r\n");
      out.write("		  <!--Header-->\r\n");
      out.write("		  <div class=\"row w-100\">\r\n");
      out.write("					  <div class=\"col-md-6 d-flex align-items-center\">\r\n");
      out.write("						  <h4 class=\"header-title\">Sugar Test</h4>\r\n");
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
      out.write("			  <div class=\"row w-100\">\r\n");
      out.write("\r\n");
      out.write("				<div class=\"col-sm-12 col-md-12 col-lg-12 \" id=\"divsearch\">   \r\n");
      out.write("					<div class=\"input-group mb-1\">  \r\n");
      out.write("						<div class=\"col-md-2\"><label for=\"smobileno\" class=\"form-lable\">Search By </label></div>\r\n");
      out.write("						<div class=\"col-md-4\"><input type=\"text\" class=\"form-control\" id=\"smobileno\"/></div>\r\n");
      out.write("						<div  class=\"col-md-6 col-sm-6 mpZero\">\r\n");
      out.write("							<div class=\"col-md-12 form-lable\">Reg No:&nbsp;<label  class=\"form-lable\" id=\"lcsno\"></label></div>\r\n");
      out.write("						</div>\r\n");
      out.write("					</div>  \r\n");
      out.write("				</div>  \r\n");
      out.write("\r\n");
      out.write("				<div class=\"col-sm-12 col-md-12 col-lg-12 \" id=\"divsearch\">   \r\n");
      out.write("					<div class=\"input-group mb-1\">  \r\n");
      out.write("						<div class=\"col-md-2\"><label class=\"form-lable\">IP No</label></div>\r\n");
      out.write("						<div class=\"col-md-4\"><input type=\"text\" class=\"form-control\" id=\"ipno\"><input type=\"hidden\" id=\"sponsorname\"/><input type=\"hidden\" id=\"sponsorcode\"/></div>\r\n");
      out.write("					\r\n");
      out.write("						\r\n");
      out.write("					</div>  \r\n");
      out.write("				</div> \r\n");
      out.write("				 \r\n");
      out.write("				<div class=\"col-sm-12 col-md-12 col-lg-12\">  \r\n");
      out.write("					<div class=\"input-group mb-1\">\r\n");
      out.write("									<div class=\"col-md-2\"><label for=\"patientname\" class=\"form-lable\">Patient Name </label></div>\r\n");
      out.write("									<div class=\"col-md-4\"><input type=\"text\" class=\"form-control\" id=\"patientname\"><input type=\"hidden\" class=\"form-control\" id=\"patientcode\"><input type=\"hidden\" class=\"form-control\" id=\"hospregcode\"><input type=\"hidden\" class=\"form-control\" id=\"crno\"><input type=\"hidden\" class=\"form-control\" id=\"crsno\"><input type=\"hidden\" class=\"form-control\" id=\"crstatus\" value=\"1,2\"></div>\r\n");
      out.write("\r\n");
      out.write("								   <div class=\"col-md-2\"><label for=\"testtime\" class=\"form-lable\">Date & Time  </label></div>\r\n");
      out.write("								   <div class=\"col-md-4\"><input type=\"text\" class=\"form-control\" id=\"testtime\"></div>\r\n");
      out.write("					</div>\r\n");
      out.write("				</div>\r\n");
      out.write("				<div class=\"col-sm-12 col-md-12 col-lg-12\">  \r\n");
      out.write("					<div class=\"input-group mb-1\">\r\n");
      out.write("						<div class=\"col-md-2\"><label for=\"patientage\" class=\"form-lable\">Age </label></div>\r\n");
      out.write("						<div class=\"col-md-4\"><input type=\"text\" class=\"form-control\" id=\"patientage\"></div>\r\n");
      out.write("						<div class=\"col-md-2\"><label for=\"gender\" class=\"form-lable\">Gender</label></div>\r\n");
      out.write("						<div class=\"col-md-4\"><select class=\"form-control\" id=\"gender\"></select></div>\r\n");
      out.write("					</div>\r\n");
      out.write("				</div>\r\n");
      out.write("				<div class=\"col-sm-12 col-md-12 col-lg-12\">  \r\n");
      out.write("					<div class=\"input-group mb-1\">\r\n");
      out.write("						<div class=\"col-md-2\"><label for=\"doctorname\" class=\"form-lable\">Doctor name</label></div>\r\n");
      out.write("								   <div class=\"col-md-4\"><input type=\"text\" class=\"form-control\" id=\"doctorname\"><input type=\"hidden\" id=\"doctorcode\"/></div>\r\n");
      out.write("								   \r\n");
      out.write("								   <div class=\"col-md-2\"><label for=\"technician\" class=\"form-lable\">Technician</label></div>\r\n");
      out.write("								   <div class=\"col-md-4\"><input type=\"text\" class=\"form-control\" id=\"technician\"><input type=\"hidden\" id=\"referralcode\"/></div>\r\n");
      out.write("						</div>\r\n");
      out.write("				</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("				\r\n");
      out.write("\r\n");
      out.write("			   </div>\r\n");
      out.write("	  \r\n");
      out.write("			   <div class=\"row\">\r\n");
      out.write("				  <div class=\"table-container\">\r\n");
      out.write("					  <div class=\"col-md-12 col-sm-12 garea\" id=\"testgrid\"></div>\r\n");
      out.write("				  </div>\r\n");
      out.write("				</div>\r\n");
      out.write("	  \r\n");
      out.write("\r\n");
      out.write("				<div class=\"row w-100 mt-3\">\r\n");
      out.write("					<div class=\"col-md-4\">\r\n");
      out.write("					  <div class=\"hstack justify-content-start\">\r\n");
      out.write("						<div id=\"saveGrp\">\r\n");
      out.write("							<button id=\"btnPrintReport\" class=\"btn btn-save mx-1\" type=\"button\" onclick=\"printLabReport()\"><span class=\"mdi mdi-printer me-2\"></span>Print Report</button>\r\n");
      out.write("							<button id=\"btnLoadCR\" class=\"btn btn-edit mx-1\" type=\"button\" onclick=\"loadClinicalRequests()\"><span class=\"mdi mdi-bell-plus me-2\"></span>Test Requests</button>\r\n");
      out.write("							<button id=\"btnClearScr\" class=\"btn btn-clear mx-1\" type=\"button\" onclick=\"clearInnerScreen()\"><span class=\"mdi mdi-refresh me-2\"></span>Clear</button>\r\n");
      out.write("						</div>\r\n");
      out.write("					  </div>\r\n");
      out.write("					</div>\r\n");
      out.write("					\r\n");
      out.write("				</div>\r\n");
      out.write("				</div>\r\n");
      out.write("		  </div>\r\n");
      out.write("		 <!--Content End-->\r\n");
      out.write("		</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("	<script>\r\n");
      out.write("	loadBranchData();\r\n");
      out.write("	\r\n");
      out.write("		groupw=200;\r\n");
      out.write("		testunitw=100;\r\n");
      out.write("		testrangew=200;\r\n");
      out.write("		testactualw=150;\r\n");
      out.write("		testnamew=200;\r\n");
      out.write("		testnotesw=200;\r\n");
      out.write("		xrayv=true;\r\n");
      out.write("		\r\n");
      out.write("    var sProps={js:\"\",screen:[\r\n");
      out.write("  	{name:\"group1\",predesigned:true,contentType:\"Fields\",\r\n");
      out.write("  	fields:[{name:\"code\",inputType:0,type:\"INT\",caption:\"\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"billno\"},\r\n");
      out.write("  	{name:\"billno\",inputType:0,type:\"INT\",caption:\"\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"branchcode\"},\r\n");
      out.write("  	{name:\"billtype\",inputType:0,type:\"INT\",caption:\"\",mandatory:false,defaultValue:\"2\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"branchcode\"},\r\n");
      out.write("  	{name:\"patienttype\",inputType:0,type:\"INT\",caption:\"\",mandatory:false,defaultValue:\"2\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"branchcode\"},\r\n");
      out.write("  	{name:\"branchcode\",inputType:0,type:\"INT\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"ipno\"},\r\n");
      out.write("  	{name:\"ipno\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:false,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":false,\"chkTag\":false,nf:\"patientname\"},\r\n");
      out.write("  	{name:\"patientname\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:true,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"patientage\"},\r\n");
      out.write("  	{name:\"patientcode\",inputType:0,type:\"INT\",caption:\"\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"patientage\"},\r\n");
      out.write("  	{name:\"patientage\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":30,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"gender\"},\r\n");
      out.write("  	{name:\"gender\",inputType:1,type:\"TEXT\",caption:\"\",mandatory:true,defaultValue:\"M\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"testtime\",values:\"M~F\",keys:\"Male~Female\"},\r\n");
      out.write("  	{name:\"testtime\",inputType:0,type:\"DATETIME\",caption:\"\",mandatory:true,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"doctorname\"},\r\n");
      out.write("  	{name:\"doctorname\",inputType:0,type:\"LOV\",caption:\"\",mandatory:true,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":true,nf:\"technician\",lovOptions:{url:\"/waggle/service/ajax\",ajax:\"doctors\",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:\"doctorcode\",tt:false,id:\"dr_code\"},{tgt:\"doctorname\",tt:true,id:\"dr_name\"},{tgt:\"doctorname\",tt:false,id:\"dr_name\"}]}},\r\n");
      out.write("  	{name:\"doctorcode\",inputType:0,type:\"INT\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"technician\"},  	  	  \r\n");
      out.write("  	{name:\"technician\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:false,defaultValue:\"\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"btnSave\"},\r\n");
      out.write("  	{name:\"grouptest\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":0,\"visible\":false,\"readOnly\":false,\"chkTag\":false,nf:\"btnSave\"},\r\n");
      out.write("  	{name:\"billdate\",inputType:0,type:\"TDATE\",caption:\"\",mandatory:false,defaultValue:\"1\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"btnSave\"},  	\r\n");
      out.write("  	{name:\"hospregcode\",inputType:0,type:\"INT\",caption:\"\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"btnSave\"},\r\n");
      out.write("  	{name:\"crno\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"btnSave\"},\r\n");
      out.write("  	{name:\"crsno\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"btnSave\"},\r\n");
      out.write("  	{name:\"crstatus\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:false,defaultValue:\"1\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"btnSave\"},\r\n");
      out.write("  	{name:\"smobileno\",inputType:0,type:\"TEXT\",caption:\"\",mandatory:false,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"ipno\",validation:\"checkIPPatientExists\"},\r\n");
      out.write("  	{name:\"btnSave\",inputType:3,caption:\"\",visible:false,readOnly:true},\r\n");
      out.write("    {name:\"btnClear\",inputType:3,caption:\"\",visible:false,readOnly:true}\r\n");
      out.write("  	]},\r\n");
      out.write("  	{name:\"testgrid\",title:\"\",contentType:\"Table\",tableProperties:{rowObject:true,serialNumberColumn:\"sno\",enableDeleteRow:true,enableAddRow:true,rowEmptyCheckColumn:\"testdatetime\",optional:false,columns:[\r\n");
      out.write("    {order:\"0\",id: \"sno\", name: \"SNo\", field: \"sno\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,\"chkTag\":false,width:50,sno:true},\r\n");
      out.write("    {order:\"1\",id: \"testdatetime\", name: \"Test Date Time\", field: \"testdatetime\",defaultValue:\"\",\"inputType\":0,\"type\":\"TDATETIME\",\"maxValue\":0,\"textLength\":100,\"decimalLength\":0,\"visible\":xrayv,\"readOnly\":false,\"mandatory\":true,width:groupw,align:\"left\"},\r\n");
      out.write("    \r\n");
      out.write("  \r\n");
      out.write("    {order:\"2\",id: \"timings\", name: \"Type of Test\", field: \"timings\",defaultValue:\"0\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"mandatory\":true,width:testactualw,\"chkTag\":true,lovOptions:{url:\"/waggle/service/ajax\",ajax:\"sugertesttype\",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[\r\n");
      out.write("  		{tgt:\"testgrid_data\",tt:false,row:\"cr\",id:\"TestType\",col:\"timings\"},\r\n");
      out.write("  	{tgt:\"testgrid_data\",tt:true,row:\"cr\",id:\"TestType\",col:\"timings\"},\r\n");
      out.write("  	{tgt:\"testgrid_data\",tt:false,row:\"cr\",id:\"TestRefUnit\",col:\"testunit\"},\r\n");
      out.write("  	{tgt:\"testgrid_data\",tt:false,row:\"cr\",id:\"TestRefRange\",col:\"testrange\"}\r\n");
      out.write("  	]}},\r\n");
      out.write("  	\r\n");
      out.write("    {order:\"3\",id: \"testactual\", name: \"Actual\", field: \"testactual\",defaultValue:\"\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":50,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"mandatory\":false,width:testactualw,align:\"left\",onchange:\"onDetailChange\"},\r\n");
      out.write("  	{order:\"4\",id: \"testunit\", name: \"Unit\", field: \"testunit\",defaultValue:\"\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":100,\"decimalLength\":0,\"visible\":xrayv,\"readOnly\":true,\"mandatory\":false,width:testunitw,align:\"left\"},\r\n");
      out.write("    {order:\"5\",id: \"testrange\", name: \"Range\", field: \"testrange\",defaultValue:\"\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":100,\"decimalLength\":0,\"visible\":xrayv,\"readOnly\":true,\"mandatory\":false,width:testrangew,align:\"left\"}\r\n");
      out.write("\r\n");
      out.write("    ]\r\n");
      out.write("    }}]};\r\n");
      out.write("	var labbill=new FlexUI.Screen(\"labbill\",sProps);\r\n");
      out.write("	//ajax columns ,values:\"F~PP~R\",keys:\"F~PP~R\"\r\n");
      out.write("	var l=new FlexUI.Ajax();\r\n");
      out.write("    $(document).ready(function () {\r\n");
      out.write("    	\r\n");
      out.write("		$('#divfootmenu').css(\"display\",\"block\");\r\n");
      out.write("		$('#divsearch').css(\"display\",\"block\");\r\n");
      out.write("		\r\n");
      out.write("		screenObjects.getScreenObject(\"branchcode\").setValue($('#branch').val());\r\n");
      out.write("        screenObjects.getScreenObject(\"testgrid_data\").getInputField().onTextKeyDown.subscribe(tableTextKeyDown);\r\n");
      out.write("        screenObjects.getScreenObject(\"testgrid_data\").onAfterDeleteRow.subscribe(tableRowDelete);\r\n");
      out.write("        $('#subtitle').text(\"\");\r\n");
      out.write("        \r\n");
      out.write("			screenObjects.getScreenObject(\"crno\").setMandatory(false);\r\n");
      out.write("			screenObjects.getScreenObject(\"crsno\").setMandatory(false);\r\n");
      out.write("			screenObjects.getScreenObject(\"grouptest\").setValue(\"1\");\r\n");
      out.write("			\r\n");
      out.write("        screenObjects.getScreenObject(\"smobileno\").focus();\r\n");
      out.write("            \r\n");
      out.write("    \r\n");
      out.write("            \r\n");
      out.write("        });\r\n");
      out.write("\r\n");
      out.write("		function onDetailChange(){\r\n");
      out.write("\r\n");
      out.write("			\r\n");
      out.write("			alert(\"its in fn\");\r\n");
      out.write("			var totalActual = $(\"#testactual\").val();\r\n");
      out.write("			alert(\"totalActual:\"+\" \"+totalActual);\r\n");
      out.write("\r\n");
      out.write("			\r\n");
      out.write("		}\r\n");
      out.write("\r\n");
      out.write("        function saveLabBill(){\r\n");
      out.write("\r\n");
      out.write("        	if('");
      out.print(mode);
      out.write("'==\"View\") return;\r\n");
      out.write("        	if(labbill.getSaveInProgress()) return;\r\n");
      out.write("        	\r\n");
      out.write("        	screenObjects.getScreenObject(\"grouptest\").setValue(\"1\");\r\n");
      out.write("        	\r\n");
      out.write("        	var r=null;\r\n");
      out.write("        	var code=toNumber(screenObjects.getScreenObject(\"code\").getValue());\r\n");
      out.write("        	if(code!=0){\r\n");
      out.write("    			labbill.setOperation(\"MOD\");\r\n");
      out.write("        	}else{\r\n");
      out.write("    			labbill.setOperation(\"ADD\");\r\n");
      out.write("    		}\r\n");
      out.write("    		labbill.setScreenCode(28);    		\r\n");
      out.write("    		var d=labbill.processDataToSave();\r\n");
      out.write("    		labbill.setSaveInProgress(true);   \r\n");
      out.write("    		 		\r\n");
      out.write("			if(\"FAILED\"!=d){\r\n");
      out.write("				var s=new FlexUI.Ajax();\r\n");
      out.write("				showLoader();\r\n");
      out.write("				r=s.callAjax(\"POST\",\"/waggle/service/screen/save\",d);\r\n");
      out.write("				hideLoader();\r\n");
      out.write("		 	}else{\r\n");
      out.write("		 		alert(\"Please correct the validation errors and continue...\");\r\n");
      out.write("		 		labbill.setSaveInProgress(false);\r\n");
      out.write("		 		return;\r\n");
      out.write("		 	}		 \r\n");
      out.write("			try{		 \r\n");
      out.write("		 	if(r.result==\"Success\"){\r\n");
      out.write("				setErrorMessage(r.message+\" [No:\"+code+\"]\")   ;\r\n");
      out.write("				clearInnerScreen();\r\n");
      out.write("				return r.key;			\r\n");
      out.write("			}else{\r\n");
      out.write("				labbill.setSaveInProgress(false);								\r\n");
      out.write("				alert(r.message);	\r\n");
      out.write("			}\r\n");
      out.write("			}catch(e){    		labbill.setSaveInProgress(false);}\r\n");
      out.write("        }\r\n");
      out.write("        function clearInnerScreen(){\r\n");
      out.write("        	labbill.clearScreen();\r\n");
      out.write("			$(\"#lcsno\").text(\"\");\r\n");
      out.write("        	labbill.setSaveInProgress(false);  \r\n");
      out.write("        	screenObjects.getScreenObject(\"crstatus\").setValue(\"1,2\");\r\n");
      out.write("        	screenObjects.getScreenObject(\"branchcode\").setValue($('#branch').val());\r\n");
      out.write("       		screenObjects.getScreenObject(\"smobileno\").focus();\r\n");
      out.write("        }\r\n");
      out.write("		function tableTextKeyDown(e,args){\r\n");
      out.write("			var key=e.which || e.keyCode;\r\n");
      out.write("			if(key==113){\r\n");
      out.write("				e.preventDefault();\r\n");
      out.write("				saveLabBill();\r\n");
      out.write("			}\r\n");
      out.write("		}\r\n");
      out.write("		function tableRowDelete(e,args){\r\n");
      out.write("		}\r\n");
      out.write("		function loadClinicalRequests(id,me){\r\n");
      out.write("			var l={url:\"/waggle/service/ajax\",ajax:\"sugertest\",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:\"branchcode\",src:\"branchcode\",ft:false},{n:\"status\",src:\"crstatus\",ft:false}],results:[],standalone:true};\r\n");
      out.write("			var lov=new FlexUI.LOV(\"cr_lov\",me,l);\r\n");
      out.write("			lov.onLovClose.subscribe(onClinicalRequestLoad);\r\n");
      out.write("			lov.show();\r\n");
      out.write("			\r\n");
      out.write("		}\r\n");
      out.write("		function onClinicalRequestLoad(e,args){\r\n");
      out.write("			showLoader();\r\n");
      out.write("			var branch=screenObjects.getScreenObject(\"branchcode\").getValue();\r\n");
      out.write("			var code=args.result[3];\r\n");
      out.write("			var l=new FlexUI.Ajax();\r\n");
      out.write("			var v=l.callAjax(\"GET\",\"/waggle/service/screen/data?screencode=28&branchcode=\"+branch+\"&crsno=\"+code,\"\");\r\n");
      out.write("			clearInnerScreen();\r\n");
      out.write("			labbill.loadObjectData(v);\r\n");
      out.write("\r\n");
      out.write("		  	hideLoader();\r\n");
      out.write("		}\r\n");
      out.write("		function printLabReport(){\r\n");
      out.write("			var branch=screenObjects.getScreenObject(\"branchcode\").getValue();\r\n");
      out.write("			var code=screenObjects.getScreenObject(\"code\").getValue();\r\n");
      out.write("			if(toNumber(code)!=0){\r\n");
      out.write("				var url=\"/waggle/service/discharge/printsugertest?branchcode=\"+branch+\"&billno=\"+code;\r\n");
      out.write("				window.open(url,\"_blank\");\r\n");
      out.write("			}\r\n");
      out.write("		}\r\n");
      out.write("		\r\n");
      out.write("		function checkIPPatientExists(id,me){\r\n");
      out.write("			if(!labbill.getSaveInProgress()){\r\n");
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
      out.write("		function loadOrderData(url,code,did){\r\n");
      out.write("		  	showLoader();\r\n");
      out.write("			var l=new FlexUI.Ajax();\r\n");
      out.write("			var v=l.callAjax(\"GET\",url,\"&screencode=12\");\r\n");
      out.write("			labbill.loadObjectData(v);\r\n");
      out.write("			$('#callback').css('display','block');\r\n");
      out.write("		  	$('#xyz').css('display','none');\r\n");
      out.write("		  	$('#addGrp').css('display','none');\r\n");
      out.write("		  	hideLoader();\r\n");
      out.write("		  	var grid=screenObjects.getScreenObject(\"testgrid_data\");\r\n");
      out.write("			var siz=grid.getSize();\r\n");
      out.write("			for(var i=0;i<siz-1;i++){\r\n");
      out.write("				grid.getRow(i).setEditable(false);\r\n");
      out.write("				grid.checkAndMove(\"Next\",false);		\r\n");
      out.write("			}\r\n");
      out.write("			grid.deleteAndMove();			\r\n");
      out.write("		}		\r\n");
      out.write("\r\n");
      out.write("		\r\n");
      out.write("	</script>\r\n");
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
