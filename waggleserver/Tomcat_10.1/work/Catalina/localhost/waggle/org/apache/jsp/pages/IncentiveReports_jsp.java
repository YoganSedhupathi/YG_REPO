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

public final class IncentiveReports_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("  <title>Referral Report</title>\r\n");
      out.write("</head>\r\n");
String mode=request.getParameter("mode");
String code=request.getParameter("code");
String userId=(String)session.getAttribute("LOGIN_ID");

      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("	<div class=\"clearfix\"></div>\r\n");
      out.write("	<div class=\"col-md-12 col-sm-12 mpZero marTp\">\r\n");
      out.write("			<div class=\"col-md-12 panelOrange hcH\" >\r\n");
      out.write("					<div class=\"subHe\">Incentive Reports</div>\r\n");
      out.write("					<div class=\"col-md-12 col-sm-12 mpZero\">\r\n");
      out.write("						<div  class=\"col-md-6 col-sm-6 mpZero\">		\r\n");
      out.write("						<div class=\"form-group mbotto\">\r\n");
      out.write("							<div class=\"col-md-2\"><label>Type</label></div>\r\n");
      out.write("							<div class=\"col-md-10\">\r\n");
      out.write("							<select class=\"form-control\" id=\"rpttype\" onchange=\"changeReportType()\">\r\n");
      out.write("								<option value=\"REF\">Referral (rs.)</option>\r\n");
      out.write("								<option value=\"REP\">Reporting</option>\r\n");
      out.write("								<option value=\"STF\">Staff Incentive</option>\r\n");
      out.write("							</select>\r\n");
      out.write("							</div>\r\n");
      out.write("						</div>\r\n");
      out.write("						</div>\r\n");
      out.write("						<div  class=\"col-md-6 col-sm-6 mpZero\" id=\"doctorcont\" style=\"display:none\">		\r\n");
      out.write("						<div class=\"form-group mbotto\">\r\n");
      out.write("							<div class=\"col-md-2\"><label>Doctor</label></div>\r\n");
      out.write("							<div class=\"col-md-10\"><input type=\"text\" class=\"form-control\" id=\"doctorname\"/><input type=\"hidden\" class=\"form-control\" id=\"doctorcode\" value=\"0\"/></div>\r\n");
      out.write("						</div>\r\n");
      out.write("						</div>						\r\n");
      out.write("					</div>\r\n");
      out.write("					<div class=\"col-md-12 col-sm-12 mpZero\">\r\n");
      out.write("						<div  class=\"col-md-6 col-sm-6 mpZero\">		\r\n");
      out.write("						<div class=\"form-group mbotto\">\r\n");
      out.write("							<div class=\"col-md-2\"><label>From</label></div>\r\n");
      out.write("							<div class=\"col-md-10\"><input type=\"text\" class=\"form-control\" id=\"fromdate\"></div>\r\n");
      out.write("						</div>\r\n");
      out.write("						</div>	\r\n");
      out.write("						<div  class=\"col-md-6 col-sm-6 mpZero\">		\r\n");
      out.write("						<div class=\"form-group mbotto\">\r\n");
      out.write("							<div class=\"col-md-2\"><label>To </label></div>\r\n");
      out.write("							<div class=\"col-md-10\"><input type=\"text\" class=\"form-control\" id=\"todate\"></div>\r\n");
      out.write("						</div>\r\n");
      out.write("						</div>\r\n");
      out.write("					</div>\r\n");
      out.write("					<div class=\"col-md-12 col-sm-12 mpZero\" style=\"height:350px;overflow-y:auto\">\r\n");
      out.write("						<table cellpadding=0 cellspacing=0 class=\"table\">\r\n");
      out.write("						<thead>\r\n");
      out.write("							<tr>\r\n");
      out.write("								<td><input type=\"checkbox\" id=\"selectall\" onclick=\"selectAllBU()\"/>&nbsp;Select</td>\r\n");
      out.write("								<td>BUU Name</td>\r\n");
      out.write("							</tr>\r\n");
      out.write("						</thead>\r\n");
      out.write("						<tbody id=\"bulist\">\r\n");
      out.write("							\r\n");
      out.write("						</tbody>\r\n");
      out.write("						</table>\r\n");
      out.write("					</div>\r\n");
      out.write("					<div class=\"clearfix\"></div>	\r\n");
      out.write("	            	<div id=\"actButton\" class=\"col-md-12 text-right\">\r\n");
      out.write("	            		<button id=\"btnGen\" class=\"btn btn-primary priBut\" type=\"button\" onclick=\"reportGo('SUM')\">Summary</button>\r\n");
      out.write("	                	<button id=\"btnGo\" class=\"btn btn-primary priBut\" type=\"button\" onclick=\"reportGo('BUID')\">Item Detail</button>\r\n");
      out.write("	                	<button id=\"btnDetailGo\" class=\"btn btn-primary priBut\" type=\"button\" onclick=\"reportGo('BUD')\">BU Detailed</button>\r\n");
      out.write("	                	<button id=\"btnItemDetailGo\" class=\"btn btn-primary priBut\" type=\"button\" onclick=\"reportGo('BUDD')\">BU Item Detailed</button>\r\n");
      out.write("	            	</div>\r\n");
      out.write("			</div>\r\n");
      out.write("	</div>\r\n");
      out.write("	<script>\r\n");
      out.write("	 var ajaxObj=new FlexUI.Ajax();\r\n");
      out.write(" 	\r\n");
      out.write("	\r\n");
      out.write("	$(\"#doctorname\").autocomplete({\r\n");
      out.write("		source: function(request,response){\r\n");
      out.write("		   var rdata=[];\r\n");
      out.write("			var doctors=ajaxObj.callAjax(\"GET\",\"/waggle/service/ajax\",\"ic=0&ro=true&id=doctors&F1=\"+$('#doctorname').val());\r\n");
      out.write("			for(var i=0;i<doctors.data.length;i++){\r\n");
      out.write("				rdata.push({\"id\":doctors.data[i].dr_code,\"label\":doctors.data[i].dr_name,\"value\":doctors.data[i].dr_name});\r\n");
      out.write("			}		\r\n");
      out.write("			response(rdata);\r\n");
      out.write("		},\r\n");
      out.write("		minLength: 0,\r\n");
      out.write("		select: function( event, ui ) {\r\n");
      out.write("			this.value=ui.item.label;\r\n");
      out.write("			$(\"#doctorcode\").val(ui.item.id);\r\n");
      out.write("		},messages : {\r\n");
      out.write("	      	noResults : 'No results found.',\r\n");
      out.write("	      	results : function(count) {\r\n");
      out.write("	        	return count + (count > 1 ? ' results' : ' result ') + ' found';\r\n");
      out.write("	      	}\r\n");
      out.write("    	},\r\n");
      out.write("		change: function (event, ui) {\r\n");
      out.write("            $(\"#doctorname\").val(ui.item ? ui.item.label : \"\");\r\n");
      out.write("            $(\"#doctorcode\").val(ui.item ? ui.item.id : \"0\");\r\n");
      out.write("        }\r\n");
      out.write("	});\r\n");
      out.write("	function loadBUInfo(){\r\n");
      out.write("		var ajaxObj=new FlexUI.Ajax();\r\n");
      out.write("		var bData=ajaxObj.callAjax(\"GET\",\"/waggle/service/ajax\",\"ic=0&ro=true&id=businessunits&unittypes=1\");\r\n");
      out.write("		var buData=bData.data;\r\n");
      out.write(" 		$('#bulist').children().remove();\r\n");
      out.write(" 		for(var i=0;i<buData.length;i++){\r\n");
      out.write(" 			var tr=$(\"<tr></tr>\");\r\n");
      out.write(" 			tr.append('<td><input type=\"checkbox\" bucode=\"'+buData[i].bum_code+'\"/></td>');\r\n");
      out.write(" 			tr.append('<td>'+buData[i].bum_buname+'</td>');\r\n");
      out.write(" 			$('#bulist').append(tr);\r\n");
      out.write(" 		}\r\n");
      out.write(" 		changeReportType();\r\n");
      out.write("	}\r\n");
      out.write("	$('#fromdate').datepicker({\r\n");
      out.write("		dateFormat:'dd/mm/yy'\r\n");
      out.write("	});\r\n");
      out.write("	if($('#fromdate').val()==\"\"){\r\n");
      out.write("		var cd=new Date();\r\n");
      out.write("		$('#fromdate').datepicker(\"setDate\",cd);\r\n");
      out.write("	}\r\n");
      out.write("	$('#todate').datepicker({\r\n");
      out.write("			dateFormat:'dd/mm/yy'\r\n");
      out.write("	});			\r\n");
      out.write("	if($('#todate').val()==\"\"){\r\n");
      out.write("		var cd=new Date();\r\n");
      out.write("		$('#todate').datepicker(\"setDate\",cd);\r\n");
      out.write("	}\r\n");
      out.write("    function reportGo(rptform){\r\n");
      out.write("    	var url=\"\";\r\n");
      out.write("    	var checkedInputs=$('#bulist').find('input:checked');\r\n");
      out.write("    	if(checkedInputs.length==0){\r\n");
      out.write("    		alert(\"Please select atleast one BU\");\r\n");
      out.write("    		return;\r\n");
      out.write("    	}\r\n");
      out.write("    	var bulist=\"\";\r\n");
      out.write("    	for(var i=0;i<checkedInputs.length;i++){\r\n");
      out.write("    		if(i==0){\r\n");
      out.write("    			bulist=$(checkedInputs[i]).attr(\"bucode\");\r\n");
      out.write("    		}else{\r\n");
      out.write("    			bulist=bulist+\",\"+$(checkedInputs[i]).attr(\"bucode\");\r\n");
      out.write("    		}\r\n");
      out.write("    	}\r\n");
      out.write("    	var expname=$('#rpttype').val()+\"_\"+$('#fromdate').val()+\"_TO_\"+$('#todate').val();\r\n");
      out.write("    	if($('#doctorname').val().trim()!=\"\"){\r\n");
      out.write("    		expname=expname+\"_\"+$('#doctorname').val().replace(new RegExp(',', 'g'),'');\r\n");
      out.write("    	}\r\n");
      out.write("		url=\"/waggle/service/account/incentive?exportname=\"+encodeURI(expname.replace(new RegExp(' ', 'g'),'_'))+\"&rpttype=\"+$('#rpttype').val()+\"&rptform=\"+rptform+\"&bus=\"+bulist+\"&doctorcode=\"+$('#doctorcode').val()+\"&fromdate=\"+$('#fromdate').val()+\"&todate=\"+$('#todate').val();\r\n");
      out.write("		window.open(url,\"_blank\");		\r\n");
      out.write("	}\r\n");
      out.write("	function changeReportType(){\r\n");
      out.write("		if($('#rpttype').val()==\"STF\"){\r\n");
      out.write("			$('#doctorcont').css(\"display\",\"none\");\r\n");
      out.write("			$('#doctorname').val(\"\");\r\n");
      out.write("			$('#doctorcode').val(\"0\");\r\n");
      out.write("		}else{\r\n");
      out.write("			$('#doctorcont').css(\"display\",\"inline-block\");\r\n");
      out.write("			$('#doctorname').val(\"\");\r\n");
      out.write("			$('#doctorcode').val(\"0\");			\r\n");
      out.write("		}\r\n");
      out.write("	}\r\n");
      out.write("	function selectAllBU(){\r\n");
      out.write("		if($('#selectall').is(':checked')){\r\n");
      out.write("			$('#bulist').find('input').prop(\"checked\",true);\r\n");
      out.write("		}else{\r\n");
      out.write("			$('#bulist').find('input').prop(\"checked\",false);\r\n");
      out.write("		}\r\n");
      out.write("	}\r\n");
      out.write("	loadBUInfo();\r\n");
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
