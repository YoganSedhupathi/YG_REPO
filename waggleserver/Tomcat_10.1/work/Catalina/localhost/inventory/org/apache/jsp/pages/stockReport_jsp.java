/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.9
 * Generated at: 2023-08-21 05:30:53 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.pages;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class stockReport_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\r\n");
      out.write("<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n");
      out.write("    <head>\r\n");
      out.write("        <title>Stock Report</title>\r\n");
      out.write("    </head>\r\n");
      out.write("    <body>\r\n");
      out.write("    <script>\r\n");
      out.write("    ");

    	String userId=(String)session.getAttribute("LOGIN_ID");
    	String rptId=request.getParameter("id");
    	String rptTitle=request.getParameter("title");
    	String fromdt=request.getParameter("fromdt");
    	String todt=request.getParameter("todt");
    	String fromdash=request.getParameter("fromdash");
    	if(fromdt!=null && !fromdt.equals("")){
      out.write("\r\n");
      out.write("    		$('#fromDate').val(fromdt);\r\n");
      out.write("    	");
}
    	if(todt!=null && !todt.equals("")){
      out.write("\r\n");
      out.write("			$('#toDate').val(todt);\r\n");
      out.write("		");
}
	
      out.write("\r\n");
      out.write("    </script>\r\n");
      out.write("    \r\n");
      out.write("	<div class=\"card border-0\">\r\n");
      out.write("		<div class=\"card-body\">\r\n");
      out.write("			<div class=\"row w-100\">\r\n");
      out.write("				<div class=\"col-md-3 d-flex align-items-center\">\r\n");
      out.write("					<h4 class=\"header-title\">");
      out.print(rptTitle);
      out.write("</h4>\r\n");
      out.write("				</div>\r\n");
      out.write("			\r\n");
      out.write("				<div class=\"col-md-9\">\r\n");
      out.write("					<div class=\"row\">\r\n");
      out.write("					");
if(!rptId.equals("710011")){
      out.write("\r\n");
      out.write("					<div id=\"datefilc\" class=\"col-md-4 d-flex h-30\" >\r\n");
      out.write("						<div class=\"input-group\">\r\n");
      out.write("							<span class=\"input-group-text\">From</span>\r\n");
      out.write("							<input id=\"fromDate\" name=\"fromDate\" inputType=\"date\"  type=\"text\" mandatory=\"1\" readonly class=\"form-control\"/>\r\n");
      out.write("							<span class=\"input-group-text\">To</span>\r\n");
      out.write("							<input id=\"toDate\" name=\"toDate\" inputType=\"date\"  type=\"text\" mandatory=\"1\" readonly class=\"form-control\"/>\r\n");
      out.write("							<button type=\"button\" class=\"btn btn-edit\" onclick=\"reportGo('");
      out.print(rptId);
      out.write("')\">Go</button>\r\n");
      out.write("						</div>\r\n");
      out.write("					</div>\r\n");
      out.write("					");
}else{
      out.write("\r\n");
      out.write("					<div id=\"ordfilc\" class=\"col-md-5 h-30\" style=\"display:none;\">\r\n");
      out.write("\r\n");
      out.write("							<span class=\"input-group-text\">Location</span>\r\n");
      out.write("							<select id=\"location\" name=\"location\" class=\"form-control\" onchange=\"reportGo('");
      out.print(rptId);
      out.write("')\"/></select>\r\n");
      out.write("\r\n");
      out.write("					</div>\r\n");
      out.write("					");
}
      out.write("\r\n");
      out.write("					</div>\r\n");
      out.write("				</div>\r\n");
      out.write("			</div>\r\n");
      out.write("			\r\n");
      out.write("			<div class=\"row\" id=\"jqcontainer\" ><div class=\"table-container\" ><div id=\"rep\" class=\"w-100\"></div></div></div>\r\n");
      out.write("		</div>\r\n");
      out.write("		</div>\r\n");
      out.write("	</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("	\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("		$('#fromDate').datepicker({format:'dd/mm/yy'});			\r\n");
      out.write("		if($('#fromDate').val()==\"\"){\r\n");
      out.write("			var cd=new Date();\r\n");
      out.write("			$('#fromDate').datepicker(\"setDate\",cd);\r\n");
      out.write("		}\r\n");
      out.write("		$('#toDate').datepicker({format:'dd/mm/yy'});			\r\n");
      out.write("		if($('#toDate').val()==\"\"){\r\n");
      out.write("			var cd=new Date();\r\n");
      out.write("			$('#toDate').datepicker(\"setDate\",cd);\r\n");
      out.write("		}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
if(rptId.equals("710011")){
      out.write("\r\n");
      out.write("	var l=new FlexUI.Ajax();\r\n");
      out.write("	var v=l.callAjax(\"GET\",\"/inventory/service/ajax\",\"ic=0&id=userbranch\");\r\n");
      out.write("	var branches=v.data;\r\n");
      out.write("	if(branches!=null){\r\n");
      out.write("		var s=branches.length;\r\n");
      out.write("		$('#branch').children().remove();\r\n");
      out.write("		for(var j=0;j<s;j++){\r\n");
      out.write("			$('#branch').append(\"<option value='\"+branches[j][1]+\"'>\"+branches[j][0]+\"</option>\");	\r\n");
      out.write("		}\r\n");
      out.write("	}\r\n");
      out.write("	v=l.callAjax(\"GET\",\"/inventory/service/ajax\",\"ic=0&id=branchlocations&branch=\"+$('#branch').val());\r\n");
      out.write("	var locations=v.data;\r\n");
      out.write("	if(locations!=null){\r\n");
      out.write("		var s=locations.length;\r\n");
      out.write("		$('#location').children().remove();\r\n");
      out.write("		for(var j=0;j<s;j++){\r\n");
      out.write("			$('#location').append(\"<option value='\"+locations[j][1]+\"'>\"+locations[j][0]+\"</option>\");	\r\n");
      out.write("		}\r\n");
      out.write("	}\r\n");
      out.write("	$('#stkReportTitle').css(\"display\",\"block\");\r\n");
      out.write("	showHideFilter();	\r\n");
}else{
      out.write("\r\n");
      out.write("	$('#stkReportTitle').css(\"display\",\"none\");\r\n");
}
      out.write('\r');
      out.write('\n');
if (fromdash!=null && fromdash.equals("true")){
      out.write("\r\n");
      out.write("	$('#spanClose').show();\r\n");
}else{
      out.write("\r\n");
      out.write("	$('#spanClose').hide();\r\n");
}
      out.write("\r\n");
      out.write("var params=\"\";\r\n");
if(rptId.equals("710011")){
      out.write("\r\n");
      out.write("	newParams=\"&branch=\"+$('#branch').val()+\"&location=\"+$('#location').val();\r\n");
}else{
      out.write("\r\n");
      out.write("	newParams=\"&fromdate=\"+$('#fromDate').val()+\"&todate=\"+$('#toDate').val();\r\n");
}
      out.write("\r\n");
      out.write("jqReport(");
      out.print(rptId);
      out.write(",\"#rep\",newParams);\r\n");
      out.write("\r\n");
      out.write("function enableSearch(){\r\n");
      out.write("	toggleSearchToolBar(");
      out.print(rptId);
      out.write(");\r\n");
      out.write("}\r\n");
      out.write("enableSearch();\r\n");
      out.write("function loadOrderData(link,name){\r\n");
      out.write("		$('#rep').hide();\r\n");
      out.write("		$('#filter').css(\"display\",\"none\");\r\n");
      out.write("		$('#dtfilter').css(\"display\",\"none\");\r\n");
      out.write("		$('#brdCr').css(\"display\",\"none\");\r\n");
      out.write("		$('#maincontent').show();\r\n");
      out.write("		$(\"#maincontent\").empty();\r\n");
      out.write("		$('#maincontent').load(link+\"&mode=VIEW\");\r\n");
      out.write("}\r\n");
      out.write("function reportGo(id){\r\n");
      out.write("	showLoader();\r\n");
      out.write("	var newParams=\"\";\r\n");
      out.write("	");
if(rptId.equals("710011")){
      out.write("\r\n");
      out.write("		$('#location').children().remove();\r\n");
      out.write("		v=l.callAjax(\"GET\",\"/inventory/service/ajax\",\"ic=0&id=branchlocations&branch=\"+$('#branch').val());\r\n");
      out.write("		var locations=v.data;\r\n");
      out.write("		if(locations!=null){\r\n");
      out.write("			var s=locations.length;\r\n");
      out.write("			$('#location').children().remove();\r\n");
      out.write("			for(var j=0;j<s;j++){\r\n");
      out.write("				$('#location').append(\"<option value='\"+locations[j][1]+\"'>\"+locations[j][0]+\"</option>\");	\r\n");
      out.write("			}\r\n");
      out.write("		}		\r\n");
      out.write("		newParams=\"&branch=\"+$('#branch').val()+\"&location=\"+$('#location').val();;\r\n");
      out.write("	");
}else{
      out.write("\r\n");
      out.write("		newParams=\"&fromdate=\"+$('#fromDate').val()+\"&todate=\"+$('#toDate').val();\r\n");
      out.write("	");
}
      out.write("	\r\n");
      out.write("	changeUrlAndReloadGrid(id,params,newParams);\r\n");
      out.write("	hideLoader();\r\n");
      out.write("}\r\n");
      out.write("function showHideFilter(){\r\n");
      out.write("	if( $('#divFirstFilter').is(':visible') ) {\r\n");
      out.write("		$('#divFirstFilter').css(\"display\",\"none\");\r\n");
      out.write("	}else{\r\n");
      out.write("		$('#divFirstFilter').css(\"display\",\"block\");\r\n");
      out.write("	}\r\n");
      out.write("}\r\n");
      out.write("function closeReport(){\r\n");
      out.write("	$(\"#divDash\").css(\"display\",\"block\");\r\n");
      out.write("	$(\"#reportcontent\").css(\"display\",\"none\");\r\n");
      out.write("}\r\n");
      out.write("</script>        \r\n");
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
