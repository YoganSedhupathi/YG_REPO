/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.9
 * Generated at: 2023-08-21 05:30:54 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.pages;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class offers_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("  <title>Offers</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<script src=\"js/attributedialog.js\"></script>\r\n");
      out.write("<div class=\"col-sm-10 col-md-10 col-lg-10 mpZero\"><h1>Offers</h1><ol class=\"breadcrumb mpZero\"><li><a href=\"#\">Home</a></li><li><a>Master</a></li><li class=\"active breaCSel\"><strong>Offers</strong></li></ol></div>\r\n");
      out.write("	\r\n");
      out.write("<!--add and search-->\r\n");
      out.write("<div class=\"col-sm-2 col-md-2 col-lg-2 mpZero marTp\" id='addGrp'>\r\n");
      out.write("</div>\r\n");
      out.write("<div class=\"clearfix\"></div>\r\n");
      out.write("<!-- JQ grid starts-->\r\n");
      out.write("<div id=\"xyz\" style='position:relative;border:0px;display:block;' class=\"mTBx\"></div>			    	 \r\n");
      out.write("<div id=\"callback\" style=\"display:none\" >\r\n");
      out.write("<div class=\"col-sm-12 col-md-12 col-lg-12 mTBx1\">   \r\n");
      out.write("   <div id=\"group1\" class=\"panelOrange hcH\">\r\n");
      out.write("   </div></div>\r\n");
      out.write("   <div class=\"clearfix\"></div>\r\n");
      out.write("   <div class=\"col-sm-12 col-md-12 col-lg-12 mTBx1\">\r\n");
      out.write("    <div id=\"offers\" class=\"panelOrange hcH\" style=\"height:200px;\">\r\n");
      out.write("   </div></div>\r\n");
      out.write("</div>\r\n");
      out.write("<!-- JQ grid ends-->\r\n");
      out.write("<div class=\"clearfix\"></div>\r\n");
      out.write("<div id=\"saveGrp\" style='display:none' class=\"mTBx\">\r\n");
      out.write("<span>\r\n");
      out.write("<button type=\"button\" class=\"btn btn-primary mRhAj\" onclick='onSaveClicked()'>Save</button>\r\n");
      out.write("<button type=\"button\" class=\"btn btn-default\" onclick='hideMasterData()'>Cancel</button>\r\n");
      out.write("\r\n");
      out.write("</span>\r\n");
      out.write("</div>\r\n");
      out.write("<div id='attrdlg'>\r\n");
      out.write("<div id='productprops' class=\"pop_lov_box\" style=\"height:250px;display:none\"/></div>\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("  	var l=new FlexUI.Ajax();\r\n");
      out.write("  	var v=l.callAjax(\"GET\",\"/inventory/service/ajax\",\"ic=0&id=custtype\");\r\n");
      out.write("	var custtype=v.data;\r\n");
      out.write("	var cKeys=\"All\";\r\n");
      out.write("	var cValues=\"0\";\r\n");
      out.write("	var tilled=\"~\";	\r\n");
      out.write("	if(custtype.length>0){\r\n");
      out.write("		for(var m=0;m<custtype.length;m++){\r\n");
      out.write("			cKeys=cKeys+tilled+custtype[m][0];\r\n");
      out.write("			cValues=cValues+tilled+custtype[m][1];\r\n");
      out.write("			tilled=\"~\";\r\n");
      out.write("		}			\r\n");
      out.write("	}\r\n");
      out.write("  	\r\n");
      out.write("    var sProps={title:{height:30,width:100,name:\"AMC\"},container:{id:\"callback\",isdialog:false},js:\"\",screen:[\r\n");
      out.write("  	{name:\"group1\",title:\"Offer Details\",pcolumns:2,colcss:\"col-sm-6 col-md-6 col-lg-6\",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:\"left\",backColor:\"beige\",contentType:\"Fields\",\r\n");
      out.write("  	fields:[{colno:0,name:\"code\",inputType:0,type:\"INT\",caption:\"Code\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"offername\"},\r\n");
      out.write("  	{colno:0,name:\"offername\",inputType:0,type:\"TEXT\",caption:\"Name\",mandatory:true,defaultValue:\"\",\"maxValue\":0,\"textLength\":100,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"offertype\"},\r\n");
      out.write("  	{colno:1,name:\"offertype\",inputType:1,type:\"TEXT\",caption:\"Type\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,keys:\"Bill Offer~Item Offer\",values:\"1~2\",nf:\"validfrom\",\"onchange\":\"validateOfferType\"},\r\n");
      out.write("  	{colno:0,name:\"validfrom\",inputType:0,type:\"DATE\",caption:\"Valid From\",format:\"dd/mm/yyyy\",defaultValue:\"\",\"chkTag\":false,visible:true,nf:\"validto\"},\r\n");
      out.write("  	{colno:1,name:\"validto\",inputType:0,type:\"DATE\",caption:\"Valid Upto\",format:\"dd/mm/yyyy\",defaultValue:\"\",\"chkTag\":false,visible:true,nf:\"custtype\"},\r\n");
      out.write("  	{colno:0,name:\"custtype\",inputType:1,type:\"TEXT\",caption:\"Customer Type\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":100,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"billamount\",keys:cKeys,values:cValues},\r\n");
      out.write("  	{colno:0,name:\"billtype\",inputType:1,type:\"TEXT\",caption:\"Bill Type\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":100,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"billamount\",keys:\"CASH~CREDIT\",values:\"CA~CR\"},\r\n");
      out.write("  	{colno:1,name:\"billamount\",inputType:0,type:\"DECIMAL\",caption:\"For Amount\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"fromtime\"},\r\n");
      out.write("  	{colno:0,name:\"fromtime\",inputType:0,type:\"TIME\",caption:\"Valid From\",format:\"\",defaultValue:\"\",\"chkTag\":false,visible:true,nf:\"totime\"},\r\n");
      out.write("  	{colno:1,name:\"totime\",inputType:0,type:\"TIME\",caption:\"Valid Upto\",format:\"\",defaultValue:\"\",\"chkTag\":false,visible:true,nf:\"offermode\"},  	\r\n");
      out.write("  	{colno:0,name:\"offermode\",inputType:1,type:\"TEXT\",caption:\"Mode\",mandatory:true,defaultValue:\"\",\"textLength\":10,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"discperc\",keys:\"Discount%~Discount Amount~FreeItem~Discounted Rate\",values:\"1~2~3~4\",\"onchange\":\"offerModeValidate\"},  	\r\n");
      out.write("  	{colno:1,name:\"discperc\",inputType:0,type:\"DECIMAL\",caption:\"Discount %\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"discamount\"},\r\n");
      out.write("  	{colno:0,name:\"discamount\",inputType:0,type:\"DECIMAL\",caption:\"Discount Amount\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"status\"},\r\n");
      out.write("  	{colno:1,name:\"status\",inputType:1,type:\"TEXT\",caption:\"Status\",mandatory:true,defaultValue:\"\",\"textLength\":10,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"offers_data\",keys:\"Active~InActive\",values:\"1~0\"}  	\r\n");
      out.write("  	]},\r\n");
      out.write("  	{name:\"offers\",title:\"Offer Item Details\",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:\"left\",backColor:\"biege\",contentType:\"Table\",tableProperties:{rowEmptyCheckColumn:1,optional:true,columns:[\r\n");
      out.write("    {order:\"0\",id: \"sno\", name: \"SNo\", field: \"sno\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,\"chkTag\":false,width:50,sno:true},\r\n");
      out.write("	{order:\"1\",id: \"product\", name: \"Product\", field: \"product\",defaultValue:\"0\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"mandatory\":true,lovOptions:{url:\"/inventory/service/ajax\",ajax:\"salableproducts\",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"1\",id:\"0\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:true,row:\"cr\",col:\"1\",id:\"1\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"2\",id:\"2\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"3\",id:\"3\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"4\",id:\"4\"},    \r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"6\",id:\"5\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"7\",id:\"6\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"8\",id:\"7\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"9\",id:\"8\"}\r\n");
      out.write("    ]},width:200,chkTag:true,validation:\"getAttributeDetail\"},\r\n");
      out.write("    {order:\"2\",id: \"pgcode\", name: \"pgcode\", field: \"pgcode\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"3\",id: \"serialized\", name: \"serialized\", field: \"serialized\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"4\",id: \"isattribute\", name: \"isattribute\", field: \"isattribute\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"5\",id: \"attribid\", name: \"AttributeId\", field: \"attribid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},        \r\n");
      out.write("    {order:\"6\",id: \"unitgroup\", name: \"UnitGroup\", field: \"unitgroup\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"7\",id: \"unitname\", name: \"Units\", field: \"unitname\",defaultValue:\"0\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"mandatory\":true,lovOptions:{url:\"/inventory/service/ajax\",ajax:\"units\",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:\"unitgroup\",src:\"offers_data\",row:\"cr\",col:\"6\",ft:false}],results:[\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"7\",id:\"0\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"8\",id:\"1\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"9\",id:\"2\"}\r\n");
      out.write("    ]},width:80,chkTag:false,validation:\"\"},\r\n");
      out.write("    {order:\"8\",id: \"unitid\", name: \"unitid\", field: \"unitid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"9\",id: \"conversionvalue\", name: \"conversionvalue\", field: \"conversionvalue\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":10,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"10\",id: \"qty\", name: \"Qty\", field: \"quantity\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":false,\"mandatory\":true,width:100},\r\n");
      out.write("    {order:\"11\",id: \"freeproduct\", name: \"Free Product\", field: \"freeproduct\",defaultValue:\"0\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"mandatory\":true,lovOptions:{url:\"/inventory/service/ajax\",ajax:\"salableproducts\",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"11\",id:\"0\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:true,row:\"cr\",col:\"11\",id:\"1\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"12\",id:\"2\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"13\",id:\"3\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"14\",id:\"4\"},    \r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"16\",id:\"5\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"17\",id:\"6\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"18\",id:\"7\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"19\",id:\"8\"}\r\n");
      out.write("    ]},width:200,chkTag:true,\"validation\":\"getAttributeDetailForFreeItem\"},\r\n");
      out.write("    {order:\"12\",id: \"freepgcode\", name: \"freepgcode\", field: \"freepgcode\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"13\",id: \"fserialized\", name: \"fserialized\", field: \"fserialized\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"14\",id: \"fisattribute\", name: \"fisattribute\", field: \"fisattribute\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"15\",id: \"fattribid\", name: \"FreeAttributeId\", field: \"fattribid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},        \r\n");
      out.write("    {order:\"16\",id: \"funitgroup\", name: \"Free UnitGroup\", field: \"funitgroup\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"17\",id: \"funitname\", name: \"Unit Name\", field: \"funitname\",defaultValue:\"0\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"mandatory\":true,lovOptions:{url:\"/inventory/service/ajax\",ajax:\"units\",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:\"funitgroup\",src:\"offers_data\",row:\"cr\",col:\"6\",ft:false}],results:[\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"17\",id:\"0\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"18\",id:\"1\"},\r\n");
      out.write("    {tgt:\"offers_data\",tt:false,row:\"cr\",col:\"19\",id:\"2\"}\r\n");
      out.write("    ]},width:80,chkTag:false,validation:\"\"},\r\n");
      out.write("    {order:\"18\",id: \"funitid\", name: \"funitid\", field: \"funitid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"19\",id: \"fconversionvalue\", name: \"fconversionvalue\", field: \"fconversionvalue\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":10,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},    \r\n");
      out.write("    {order:\"20\",id: \"offerqty\", name: \"Offer Qty\", field: \"offerqty\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":2,\"visible\":true,\"readOnly\":false,\"mandatory\":false,width:100,chkTag:false},\r\n");
      out.write("    {order:\"21\",id: \"offerdiscperc\", name: \"Disc Perc\", field: \"offerdiscperc\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":2,\"visible\":true,\"readOnly\":false,\"mandatory\":false,width:100,chkTag:false},\r\n");
      out.write("    {order:\"22\",id: \"offerdiscamt\", name: \"Disc Amount\", field: \"offerdiscamt\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":2,\"visible\":true,\"readOnly\":false,\"mandatory\":false,width:100,chkTag:false},\r\n");
      out.write("    {order:\"23\",id: \"discrate\", name: \"Disc Rate\", field: \"discrate\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":2,\"visible\":true,\"readOnly\":false,\"mandatory\":false,width:100,chkTag:false}\r\n");
      out.write("    ]\r\n");
      out.write("    }}]};\r\n");
      out.write("  //var screenProps=changeScreenAttributes(110022,sProps);\r\n");
      out.write("  var offer=new FlexUI.Screen(\"offermaster\",sProps);\r\n");
      out.write("  jqReport(110022,\"#xyz\");\r\n");
      out.write("  function addMasterData(){ \r\n");
      out.write("  	offer.clearScreen(); \r\n");
      out.write("  	$('#callback').css('display','block');\r\n");
      out.write("  	$('#saveGrp').css('display','block');\r\n");
      out.write("  	$('#history').css('display','block');\r\n");
      out.write("  	$('#addGrp').css('display','none');\r\n");
      out.write("  	$('#xyz').css('display','none');\r\n");
      out.write("  	screenObjects.getScreenObject(\"offername\").focus();\r\n");
      out.write("  	validateOfferTypeWrapper(true);\r\n");
      out.write("  }\r\n");
      out.write("  function hideMasterData(){\r\n");
      out.write("  	$('#callback').css('display','none');\r\n");
      out.write("  	$('#saveGrp').css('display','none');\r\n");
      out.write("  	$('#history').css('display','none');\r\n");
      out.write("  	$('#addGrp').css('display','block');\r\n");
      out.write("  	$('#xyz').css('display','block');\r\n");
      out.write("  }  \r\n");
      out.write("  function toggleHeaderRow(){\r\n");
      out.write("  	toggleSearchToolBar(\"110022\");\r\n");
      out.write("  }\r\n");
      out.write("  toggleHeaderRow();\r\n");
      out.write("  function onSaveClicked(id,me){\r\n");
      out.write("    var cid=screenObjects.getScreenObject(\"code\").getValue();\r\n");
      out.write("    if(cid!=\"0\" && cid!=\"\"){\r\n");
      out.write("    	offer.setOperation(\"EDIT\");\r\n");
      out.write("    }\r\n");
      out.write("	var d=offer.processDataToSave();\r\n");
      out.write("	if(\"FAILED\"!=d){\r\n");
      out.write("		var s=new FlexUI.Ajax();\r\n");
      out.write("		showLoader();\r\n");
      out.write("		var r=s.callAjax(\"POST\",\"/inventory/service/product/offers\",d);\r\n");
      out.write("		hideLoader();\r\n");
      out.write("		if(r.result==\"Success\"){\r\n");
      out.write("			setErrorMessage(r.message+\" [No:\"+r.code+\"]\");\r\n");
      out.write("			offer.clearScreen();\r\n");
      out.write("			hideMasterData();\r\n");
      out.write("			reloadGrid(\"110022\");\r\n");
      out.write("		}else{\r\n");
      out.write("			setErrorMessage(r.message);		\r\n");
      out.write("		}\r\n");
      out.write("		return 0;\r\n");
      out.write("	}\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function loadOrderData(url,code,did){\r\n");
      out.write("  	if(url==\"\"){\r\n");
      out.write("  		url=\"/inventory/service/product/offers\";\r\n");
      out.write("  	}\r\n");
      out.write("  	if(code!=\"\"){\r\n");
      out.write("  		code=\"code=\"+code+\"\";\r\n");
      out.write("  	}\r\n");
      out.write("  	showLoader();\r\n");
      out.write("	var v=l.callAjax(\"GET\",url,code);\r\n");
      out.write("	offer.clearScreen();\r\n");
      out.write("	offer.loadData(v);\r\n");
      out.write("	screenObjects.getScreenObject('offername').setEnabled(false);\r\n");
      out.write("	$('#callback').css('display','block');\r\n");
      out.write("  	$('#saveGrp').css('display','block');\r\n");
      out.write("  	$('#history').css('display','block');\r\n");
      out.write("  	$('#addGrp').css('display','none');\r\n");
      out.write("  	$('#xyz').css('display','none');\r\n");
      out.write("  	hideLoader();\r\n");
      out.write("  	screenObjects.getScreenObject(\"offername\").focus();\r\n");
      out.write("  	validateOfferTypeWrapper(false);\r\n");
      out.write("  }\r\n");
      out.write("  function getAttributeDetail(id,me,row,col){\r\n");
      out.write("	var cols=screenObjects.getScreenObject(\"offers_data\").getCols();\r\n");
      out.write("	if(me.getCellTag(row,cols.product)!=\"\" && toNumber(me.getText(row,cols.quantity))==0 && !offer.getSaveInProgress()){\r\n");
      out.write("		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getCellPopup(row,col)){\r\n");
      out.write("			invokeAttributeDialog(me,row,col,\"productprops\",me.getInputField());\r\n");
      out.write("			return false;				\r\n");
      out.write("		}else if(toNumber(me.getText(row,cols.isattribute))==0){\r\n");
      out.write("			return true;\r\n");
      out.write("		}\r\n");
      out.write("	}\r\n");
      out.write("	return true;\r\n");
      out.write("  }\r\n");
      out.write("  function getAttributeDetailForFreeItem(id,me,row,col){\r\n");
      out.write("	var cols=screenObjects.getScreenObject(\"offers_data\").getCols();\r\n");
      out.write("	if(me.getCellTag(row,cols.freeproduct)!=\"\" && !offer.getSaveInProgress()){\r\n");
      out.write("		if(toNumber(me.getText(row,cols.fisattribute))==1 && me.getCellPopup(row,col)){\r\n");
      out.write("			invokeAttributeDialog(me,row,col,\"productprops\",me.getInputField(),'freepgcode');\r\n");
      out.write("			return false;				\r\n");
      out.write("		}else if(toNumber(me.getText(row,cols.fisattribute))==0){\r\n");
      out.write("			return true;			\r\n");
      out.write("		}		\r\n");
      out.write("	}\r\n");
      out.write("	return true;\r\n");
      out.write("  }\r\n");
      out.write("  function validateOfferTypeWrapper(clearTable){\r\n");
      out.write("    if(!offer.getSaveInProgress()){\r\n");
      out.write("		var offerType=screenObjects.getScreenObject(\"offertype\").getValue();\r\n");
      out.write("		var offerMode=screenObjects.getScreenObject(\"offermode\");\r\n");
      out.write("		var discPerc=screenObjects.getScreenObject(\"discperc\");\r\n");
      out.write("		var discAmount=screenObjects.getScreenObject(\"discamount\");\r\n");
      out.write("		var billAmount=screenObjects.getScreenObject(\"billamount\");\r\n");
      out.write("		if(offerType==1){\r\n");
      out.write("				offerMode.getSelect().find(\"option[value='4']\").prop('disabled',true);\r\n");
      out.write("				offerMode.getSelect().find(\"option[value='3']\").prop('disabled',true);\r\n");
      out.write("				if(clearTable){\r\n");
      out.write("					offerMode.setValue('1');					\r\n");
      out.write("					billAmount.setValue('0');					\r\n");
      out.write("				}\r\n");
      out.write("				billAmount.setEnabled(true);								\r\n");
      out.write("		}else{\r\n");
      out.write("			    offerMode.getSelect().find(\"option[value='4']\").prop('disabled',false);\r\n");
      out.write("			    offerMode.getSelect().find(\"option[value='3']\").prop('disabled',false);\r\n");
      out.write("			    discPerc.setEnabled(false);\r\n");
      out.write("			    discAmount.setEnabled(false);\r\n");
      out.write("			    billAmount.setEnabled(false);\r\n");
      out.write("			    if(clearTable){\r\n");
      out.write("			    	offerMode.setValue('1');			    	\r\n");
      out.write("				    discPerc.setValue('0');\r\n");
      out.write("				    discAmount.setValue('0');\r\n");
      out.write("				    billAmount.setValue('0');\r\n");
      out.write("			    }\r\n");
      out.write("		}\r\n");
      out.write("		offerModeValidateWrapper(clearTable)\r\n");
      out.write("	}\r\n");
      out.write("	return true;\r\n");
      out.write("  }\r\n");
      out.write("  function validateOfferType(){\r\n");
      out.write("  	return validateOfferTypeWrapper(true);\r\n");
      out.write("  }\r\n");
      out.write("  function offerModeValidate(){\r\n");
      out.write("  	return offerModeValidateWrapper(true);\r\n");
      out.write("  }\r\n");
      out.write("  function offerModeValidateWrapper(clearTable){\r\n");
      out.write("  	if(!offer.getSaveInProgress()){\r\n");
      out.write("	    var offerType=screenObjects.getScreenObject(\"offertype\").getValue();\r\n");
      out.write("		var offerMode=screenObjects.getScreenObject(\"offermode\");\r\n");
      out.write("		var discPerc=screenObjects.getScreenObject(\"discperc\");\r\n");
      out.write("		var discAmount=screenObjects.getScreenObject(\"discamount\");\r\n");
      out.write("		var offersTable=screenObjects.getScreenObject(\"offers_data\");\r\n");
      out.write("		var cols=offersTable.getCols();\r\n");
      out.write("		if(offerType==1){\r\n");
      out.write("			if(offerMode.getValue()==\"1\"){	\r\n");
      out.write("			  	discPerc.setEnabled(true);\r\n");
      out.write("		  		discAmount.setEnabled(false);\r\n");
      out.write("		  		discAmount.setValue('0');\r\n");
      out.write("		  		offersTable.getOptions().tableIsReadOnly=true;\r\n");
      out.write("		  	}else if(offerMode.getValue()==\"2\"){\r\n");
      out.write("			  	discPerc.setEnabled(false);\r\n");
      out.write("			  	discPerc.setValue('0');\r\n");
      out.write("		  		discAmount.setEnabled(true);\r\n");
      out.write("		  		offersTable.getOptions().tableIsReadOnly=true;\r\n");
      out.write("		  	}else if(offerMode.getValue()==\"3\"){\r\n");
      out.write("		  		discPerc.setEnabled(false);\r\n");
      out.write("		  		discAmount.setEnabled(false);\r\n");
      out.write("		  		discPerc.setValue('0');\r\n");
      out.write("		  		discAmount.setValue('0');\r\n");
      out.write("		  		offersTable.getOptions().tableIsReadOnly=false;		  		\r\n");
      out.write("		  		offersTable.getOptions().rowEmptyCheckColumn=cols.freeproduct;\r\n");
      out.write("		  		var columnProps=offersTable.getColumnProperties();\r\n");
      out.write("		  		columnProps[cols.product].readOnly=true;	  		\r\n");
      out.write("		  		columnProps[cols.product].mandatory=false;\r\n");
      out.write("		  		columnProps[cols.quantity].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.quantity].mandatory=false;\r\n");
      out.write("		  		columnProps[cols.unitname].readOnly=true;	  		\r\n");
      out.write("		  		columnProps[cols.unitname].mandatory=false;\r\n");
      out.write("		  		columnProps[cols.freeproduct].readOnly=false;\r\n");
      out.write("		  		columnProps[cols.funitname].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerqty].readOnly=false;\r\n");
      out.write("		  		columnProps[cols.freeproduct].mandatory=true;\r\n");
      out.write("		  		columnProps[cols.offerqty].mandatory=true;\r\n");
      out.write("		  		columnProps[cols.funitname].mandatory=true;\r\n");
      out.write("		  		columnProps[cols.offerdiscperc].mandatory=false;\r\n");
      out.write("		  		columnProps[cols.offerdiscamt].mandatory=false;\r\n");
      out.write("		  		columnProps[cols.discrate].mandatory=false;	  		  		  			  			  		\r\n");
      out.write("		  		columnProps[cols.offerdiscperc].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerdiscamt].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.discrate].readOnly=true;\r\n");
      out.write("		  	}\r\n");
      out.write("		  	if(clearTable){\r\n");
      out.write("		  		offersTable.clear();		  		\r\n");
      out.write("		  	}else{\r\n");
      out.write("		  		offersTable.checkAndMove(\"Next\",false);\r\n");
      out.write("		  	}\r\n");
      out.write("		 }else{\r\n");
      out.write("		 	offersTable.getOptions().tableIsReadOnly=false;		  		\r\n");
      out.write("	  		var columnProps=offersTable.getColumnProperties();\r\n");
      out.write("	  		columnProps[cols.product].readOnly=false;	  		\r\n");
      out.write("	  		columnProps[cols.quantity].readOnly=false;\r\n");
      out.write("	  		columnProps[cols.unitname].readOnly=false;\r\n");
      out.write("	  		columnProps[cols.product].mandatory=true;	  		\r\n");
      out.write("	  		columnProps[cols.quantity].mandatory=true;\r\n");
      out.write("	  		columnProps[cols.unitname].mandatory=true;\r\n");
      out.write("	  		columnProps[cols.freeproduct].mandatory=false;\r\n");
      out.write("		  	columnProps[cols.offerqty].mandatory=false;\r\n");
      out.write("		  	columnProps[cols.funitname].mandatory=false;\r\n");
      out.write("		  	columnProps[cols.offerdiscperc].mandatory=false;\r\n");
      out.write("		  	columnProps[cols.offerdiscamt].mandatory=false;\r\n");
      out.write("		  	columnProps[cols.discrate].mandatory=false;\r\n");
      out.write("		  	offersTable.getOptions().rowEmptyCheckColumn=cols.product;	  		  		  			  		\r\n");
      out.write("		 	if(offerMode.getValue()==\"1\"){\r\n");
      out.write("		  		columnProps[cols.freeproduct].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerqty].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.funitname].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerdiscperc].readOnly=false;\r\n");
      out.write("		  		columnProps[cols.offerdiscperc].mandatory=true;\r\n");
      out.write("		  		columnProps[cols.offerdiscamt].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.discrate].readOnly=true;\r\n");
      out.write("		  	}else if(offerMode.getValue()==\"2\"){\r\n");
      out.write("		  		columnProps[cols.freeproduct].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerqty].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.funitname].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerdiscperc].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerdiscamt].readOnly=false;\r\n");
      out.write("		  		columnProps[cols.offerdiscamt].mandatory=true;\r\n");
      out.write("		  		columnProps[cols.discrate].readOnly=true;\r\n");
      out.write("		  	}else if(offerMode.getValue()==\"3\"){\r\n");
      out.write("		  		columnProps[cols.freeproduct].readOnly=false;\r\n");
      out.write("		  		columnProps[cols.offerqty].readOnly=false;\r\n");
      out.write("		  		columnProps[cols.funitname].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.freeproduct].mandatory=true;\r\n");
      out.write("		  		columnProps[cols.offerqty].mandatory=true;\r\n");
      out.write("		  		columnProps[cols.funitname].mandatory=true;	  			  		\r\n");
      out.write("		  		columnProps[cols.offerdiscperc].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerdiscamt].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.discrate].readOnly=true;\r\n");
      out.write("		  	}else if(offerMode.getValue()==\"4\"){\r\n");
      out.write("		  		columnProps[cols.freeproduct].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerqty].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.funitname].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerdiscperc].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.offerdiscamt].readOnly=true;\r\n");
      out.write("		  		columnProps[cols.discrate].readOnly=false;\r\n");
      out.write("		  		columnProps[cols.discrate].mandatory=true;\r\n");
      out.write("		  	}\r\n");
      out.write("			if(clearTable){\r\n");
      out.write("		  		offersTable.clear();		  		\r\n");
      out.write("		  	}else{\r\n");
      out.write("		  		offersTable.checkAndMove(\"Next\",false);\r\n");
      out.write("		  	}\r\n");
      out.write("		}	 			  			  				 \r\n");
      out.write("	 }\r\n");
      out.write("  	return true;\r\n");
      out.write("  } \r\n");
      out.write("</script> \r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
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
