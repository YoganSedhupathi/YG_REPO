/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.9
 * Generated at: 2023-08-21 05:30:52 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.pages;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class godownstockinward_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("  <title>Stock Inward</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<script>\r\n");
String mode=request.getParameter("mode");
String code=request.getParameter("code");

      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("<!-- JQ grid starts-->\r\n");
      out.write("\r\n");
      out.write("<div id=\"xyz\" style='position:relative;border:0px;display:none;'></div>			    	 \r\n");
      out.write("<div id=\"callback\"  >\r\n");
      out.write("	<div class=\"col-sm-12 col-md-12 col-lg-12 mpZero mTBx1\" >\r\n");
      out.write("	<div  class=\"panelOrange hcH\">\r\n");
      out.write("	<div  class=\"subHe1\">Stock Inward Note<span class=\"pull-right right-btn\" onclick=\"showHideField('invoice')\"><b id=\"plusbutton1\" class=\"fa fa-angle-double-up\"></b></span>\r\n");
      out.write("	<div id=\"branch\" class=\"brTp\" style=\"display:block\">\r\n");
      out.write("   </div>\r\n");
      out.write("	<div class=\"col-sm-12 col-md-12 col-lg-12 mpZero\" id=\"divHide\">\r\n");
      out.write("\r\n");
      out.write("	<div class=\"col-sm-6 col-md-6 col-lg-6\">                    \r\n");
      out.write("    <div id=\"group1\" class=\"\">\r\n");
      out.write("   </div></div>\r\n");
      out.write("   <div class=\"col-sm-3 col-md-3 col-lg-3\"  >                    \r\n");
      out.write("    <div id=\"group2\" class=\"\">\r\n");
      out.write("   </div></div>\r\n");
      out.write("   <div class=\"col-sm-3 col-md-3 col-lg-3\"  >\r\n");
      out.write("    <div id=\"purdetail\" class=\"\">\r\n");
      out.write("   </div></div>\r\n");
      out.write("   </div></div></div>   </div>\r\n");
      out.write("   <div class=\"col-sm-12 col-md-12 col-lg-12 mpRes mTBx1\">\r\n");
      out.write("    <div id=\"invoice\" class=\"panelOrange hcH\" style=\"min-height:363px;\" >\r\n");
      out.write("   </div></div>\r\n");
      out.write("   <div class=\"clearfix\"></div>\r\n");
      out.write("   <!--div class=\"col-sm-5 col-md-5 col-lg-5 mpZero\">                    \r\n");
      out.write("    <div id=\"group2\" class=\"panelOrange hcH\">\r\n");
      out.write("   </div></div-->\r\n");
      out.write("   <div class=\"col-sm-7 col-md-7 col-lg-7 mTBx1\" style=\"display:none;\">                    \r\n");
      out.write("    <div id=\"group3\" class=\"panelOrange hcH\">\r\n");
      out.write("   </div></div>\r\n");
      out.write("</div>\r\n");
      out.write("<div class=\"clearfix\"></div>\r\n");
      out.write("<!-- JQ grid ends-->\r\n");
      out.write("<div style=\"position:fixed; bottom:0; width:94.5%; background:#fff; z-index:1000;\">\r\n");
      out.write("<div id=\"saveGrp\" class=\"\" >\r\n");
      out.write("</div>\r\n");
      out.write("<div class=\"col-sm-6 col-md-6 col-lg-6 pull-right\" >\r\n");
      out.write("    <div style=\"background:#fedc34; display:inline-block; width:100%; padding:5px 10px\" >\r\n");
      out.write("    <div class=\"netAm\" id=\"netAmt\">Net Amount 0.00</div>\r\n");
      out.write("    <div class=\"col-md-12 colBg2 mpZero\"><div class=\"col-md-6\">&nbsp;</div><div class=\"col-md-6\" id=\"disc\"></div></div>\r\n");
      out.write("    </div>\r\n");
      out.write("    </div>\r\n");
      out.write("    </div>\r\n");
      out.write("    \r\n");
      out.write("    \r\n");
      out.write("<script>\r\n");
      out.write("$('.butt_sav').click(function(e){\r\n");
      out.write("	e.preventDefault();\r\n");
      out.write("});\r\n");
      out.write("$('.butt_can').click(function(e){\r\n");
      out.write("	e.preventDefault();\r\n");
      out.write("});			 \r\n");
      out.write("var l=new FlexUI.Ajax();\r\n");
      out.write("var v=l.callAjax(\"GET\",\"/inventory/service/ajax\",\"ic=0&id=userdefbranch,config&configname=showexpiry\");\r\n");
      out.write("var defbranch=v.data.userdefbranch;\r\n");
      out.write("var showExpiry=v.data.config[0][0]==1?true:false;\r\n");
      out.write("var ew=0;\r\n");
      out.write("if(showExpiry){\r\n");
      out.write("	ew=100;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("  var sProps={title:{height:25,width:100,name:\"Invoice\"},container:{id:\"callback\",isdialog:false},js:\"js/validations/godownstockinward.js\",screen:[\r\n");
      out.write("  {name:\"group1\",title:\"\",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:\"left\",backColor:\"biege\",contentType:\"Fields\",\r\n");
      out.write("  fields:[{name:\"code\",inputType:0,type:\"INT\",caption:\"Code\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"branch\"},\r\n");
      out.write("  {name:\"frombranch\",inputType:0,type:\"LOV\",caption:\"Inward From\",mandatory:true,defaultValue:\"\",\"maxValue\":0,\"textLength\":100,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":true,nf:\"outwardno\",lovOptions:{url:\"/inventory/service/ajax\",ajax:\"branch\",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},\r\n");
      out.write("  {name:\"outwardno\",inputType:0,type:\"LOV\",caption:\"Outward No\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"billdate\",lovOptions:{url:\"/inventory/service/ajax\",ajax:\"stocktransferout\",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:\"branch\",src:\"frombranch\",ft:true}],results:[{tgt:\"outwardsno\",id:\"0\",tt:false},{tgt:\"outwardno\",id:\"1\",tt:false}]},validation:\"geTransferOutDetail\"},\r\n");
      out.write("  {name:\"outwardsno\",inputType:0,type:\"INT\",caption:\"Outward SNo\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"billdate\"},\r\n");
      out.write("  {name:\"showpf\",inputType:4,type:\"DECIMAL\",caption:\"P&F\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"recdthro\",colspan:2,onchange:\"onTaxChange\"},\r\n");
      out.write("  {name:\"pf\",inputType:0,type:\"DECIMAL\",caption:\"P&F\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":false,\"readOnly\":false,\"chkTag\":false,nf:\"recdthro\",colspan:2,onchange:\"onTaxChange\"}\r\n");
      out.write("  ]},\r\n");
      out.write("  \r\n");
      out.write("  {name:\"purdetail\",title:\"\",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:\"left\",backColor:\"biege\",contentType:\"Fields\",\r\n");
      out.write("  fields:[\r\n");
      out.write("  {colno:0,name:\"recdthro\",inputType:4,type:\"LOV\",caption:\"Transport\",mandatory:false,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":false,\"chkTag\":false,nf:\"lrno\",colspan:2,lovOptions:{url:\"/inventory/service/ajax\",ajax:\"transport\",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},\r\n");
      out.write("  {colno:0,name:\"showrecdthro\",inputType:4,type:\"LOV\",caption:\"Transport\",mandatory:false,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"lrno\",colspan:2,lovOptions:{url:\"/inventory/service/ajax\",ajax:\"transport\",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},\r\n");
      out.write("  {colno:0,name:\"documents\",inputType:0,type:\"TEXT\",caption:\"Documents\",mandatory:false,defaultValue:\"\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":false,\"chkTag\":false,nf:\"lrno\"},\r\n");
      out.write("  {colno:0,name:\"lrno\",inputType:0,type:\"TEXT\",caption:\"LR No\",mandatory:false,defaultValue:\"NA\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":false,\"chkTag\":false,nf:\"lrdate\"},\r\n");
      out.write("  {colno:0,name:\"lrdate\",inputType:0,type:\"DATE\",caption:\"LR Date\",format:\"dd/mm/yyyy\",defaultValue:\"\",\"chkTag\":false,visible:false,nf:\"invoice_data\"},\r\n");
      out.write("  {colno:0,name:\"showlrno\",inputType:4,type:\"TEXT\",caption:\"LR No\",mandatory:false,defaultValue:\"NA\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":false,nf:\"lrdate\"},\r\n");
      out.write("  {colno:0,name:\"showlrdate\",inputType:4,type:\"DATE\",caption:\"LR Date\",format:\"dd/mm/yyyy\",defaultValue:\"\",\"chkTag\":false,visible:true,nf:\"invoice_data\"}\r\n");
      out.write("  ]\r\n");
      out.write("  },\r\n");
      out.write("  {name:\"group2\",title:\"\",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:\"left\",backColor:\"biege\",contentType:\"Fields\",\r\n");
      out.write("  fields:[\r\n");
      out.write("  {colno:0,name:\"billno\",inputType:0,type:\"INT\",caption:\"Inward No\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"chkTag\":false,nf:\"outwardno\"},\r\n");
      out.write("  {colno:0,name:\"showbillno\",inputType:4,type:\"INT\",caption:\"Inward No\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"outwardno\"},\r\n");
      out.write("  {colno:0,name:\"billdate\",inputType:0,type:\"DATE\",caption:\"Inward Date\",format:\"dd/mm/yyyy\",defaultValue:\"\",\"chkTag\":false,visible:true,nf:\"invoice_data\"}\r\n");
      out.write("  ]},\r\n");
      out.write("  {name:\"branch\",title:\"\",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:\"left\",backColor:\"biege\",contentType:\"Fields\",\r\n");
      out.write("  fields:[{colno:0,name:\"branch\",inputType:0,type:\"LOV\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":true,nf:\"location\",lovOptions:{url:\"/inventory/service/ajax\",ajax:\"userbranch\",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:\"branch\",tt:true,id:\"1\"},{tgt:\"branch\",tt:false,id:\"0\"},{tgt:\"location\",tt:false,id:\"5\"},{tgt:\"location\",tt:true,id:\"6\"}]}},\r\n");
      out.write("  {colno:0,name:\"location\",inputType:0,type:\"LOV\",caption:\"\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"chkTag\":true,nf:\"frombranch\",lovOptions:{url:\"/inventory/service/ajax\",ajax:\"branchlocations\",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:\"branch\",src:\"branch\",ft:true}],results:[]}}\r\n");
      out.write("  ]},\r\n");
      out.write("  {name:\"invoice\",title:\"Products\",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:\"left\",backColor:\"biege\",contentType:\"Table\",tableProperties:{enableAddRow:false,enableDeleteRow:false,rowEmptyCheckColumn:1,columns:[\r\n");
      out.write("    {order:\"0\",id: \"sno\", name: \"SNo\", field: \"sno\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,\"chkTag\":false,width:50,sno:true},\r\n");
      out.write("    {order:\"1\",id: \"product\", name: \"Product\", field: \"product\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,width:200,chkTag:true,validation:\"\"},\r\n");
      out.write("    {order:\"2\",id: \"pgcode\", name: \"pgcode\", field: \"pgcode\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"3\",id: \"serialized\", name: \"serialized\", field: \"serialized\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"4\",id: \"isattribute\", name: \"isattribute\", field: \"isattribute\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"5\",id: \"attribid\", name: \"AttributeId\", field: \"attribid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},    \r\n");
      out.write("    {order:\"6\",id: \"unitgroup\", name: \"UnitGroup\", field: \"unitgroup\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"7\",id: \"unitname\", name: \"Units\", field: \"unitname\",defaultValue:\"0\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,width:80,chkTag:false,validation:\"\"},\r\n");
      out.write("    {order:\"8\",id: \"unitid\", name: \"unitid\", field: \"unitid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},\r\n");
      out.write("    {order:\"9\",id: \"batchno\", name: \"BatchNo\", field: \"batchno\",defaultValue:\"NA\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":showExpiry,\"readOnly\":true,\"mandatory\":showExpiry,width:ew,chkTag:false},\r\n");
      out.write("    {order:\"10\",id: \"batchdt\", name: \"BatchDt\", field: \"batchdt\",defaultValue:\"NA\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"11\",id: \"expdt\", name: \"ExpDt\", field: \"expdt\",defaultValue:\"\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":showExpiry,\"readOnly\":true,\"mandatory\":showExpiry,width:ew,chkTag:false},\r\n");
      out.write("    {order:\"12\",id: \"qty\", name: \"Qty\", field: \"quantity\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":false,\"mandatory\":true,width:100,onchange:\"\",cTotal:true,validation:\"\"},\r\n");
      out.write("    {order:\"13\",id: \"freeqty\", name: \"Free\", field: \"freeqty\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":false,\"mandatory\":false,width:0,onchange:\"onRateQuantityChange\",cTotal:true},\r\n");
      out.write("    {order:\"14\",id: \"funitname\", name: \"Units\", field: \"funitname\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":false,\"mandatory\":true,width:0,chkTag:false},\r\n");
      out.write("    {order:\"15\",id: \"funitid\", name: \"unitid\", field: \"funitid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0},                            \r\n");
      out.write("    {order:\"16\",id: \"unit\", name: \"Unit\", field: \"unit\",defaultValue:\"1\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},    \r\n");
      out.write("    {order:\"17\",id: \"stock\", name: \"Stock\", field: \"stock\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"18\",id: \"rate\", name: \"Rate\", field: \"rate\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":true,width:100,onchange:\"onRateQuantityChange\",align:\"right\"},\r\n");
      out.write("	{order:\"19\",id: \"selling\", name: \"S.Rate\", field: \"selling\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":true,width:100,align:\"right\"},\r\n");
      out.write("	{order:\"20\",id: \"mrp\", name: \"MRP\", field: \"mrp\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":true,width:100,align:\"right\"},    \r\n");
      out.write("    {order:\"21\",id: \"discperc\", name: \"Disc%\", field: \"discperc\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":99.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:100,onchange:\"onRateQuantityChange\",align:\"right\"},\r\n");
      out.write("	{order:\"22\",id: \"discamt\", name: \"Disc Amt\", field: \"discamt\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:100,align:\"right\"},\r\n");
      out.write("    {order:\"23\",id: \"cashdiscperc\", name: \"Cash Disc%\", field: \"cashdiscperc\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,onchange:\"onRateQuantityChange\",align:\"right\"},\r\n");
      out.write("	{order:\"24\",id: \"cashdiscamt\", name: \"Cash Disc Amount\", field: \"cashdiscamt\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,align:\"right\"},	\r\n");
      out.write("    {order:\"25\",id: \"ptaxperc\", name: \"P.Tax%\", field: \"ptaxperc\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:100,onchange:\"onRateQuantityChange\",align:\"right\"},\r\n");
      out.write("	{order:\"26\",id: \"ptaxamt\", name: \"P.Tax Amount\", field: \"ptaxamt\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:100,align:\"right\"},\r\n");
      out.write("	{order:\"27\",id: \"srtax\", name: \"Service Tax%\", field: \"srtaxperc\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":false,\"mandatory\":false,width:100,onchange:\"onRateQuantityChange\",align:\"right\"},\r\n");
      out.write("	{order:\"28\",id: \"srtaxamt\", name: \"Service Tax Amount\", field: \"srtaxamt\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:100,align:\"right\"},				\r\n");
      out.write("	{order:\"29\",id: \"staxperc\", name: \"S.Tax%\", field: \"staxperc\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:100,align:\"right\"},\r\n");
      out.write("    {order:\"30\",id: \"amount\", name: \"Amount\", field: \"amount\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":true,width:150,cTotal:true,align:\"right\"},\r\n");
      out.write("    {order:\"31\",id: \"netamount\", name: \"NetAmount\", field: \"netamount\",defaultValue:\"y\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":999999.99,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"mandatory\":true,width:150,cTotal:true,align:\"right\"},\r\n");
      out.write("    {order:\"32\",id: \"csdid\", name: \"CsdId\", field: \"csdid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"33\",id: \"taxincl\", name: \"TaxInclu\", field: \"taxincl\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"34\",id: \"taxableamt\", name: \"TaxableAmt\", field: \"taxableamt\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"35\",id: \"impno\", name: \"impno\", field: \"impno\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"36\",id: \"impsno\", name: \"impsno\", field: \"impsno\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"37\",id: \"imptype\", name: \"imptype\", field: \"imptype\",defaultValue:\"NA\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":2,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"38\",id: \"isdid\", name: \"IsdId\", field: \"isdid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"39\",id: \"barcode\", name: \"Barcode\", field: \"barcode\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"40\",id: \"obranch\", name: \"obranch\", field: \"obranch\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"41\",id: \"oisdid\", name: \"oisdid\", field: \"oisdid\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"42\",id: \"supplier\", name: \"Supplier\", field: \"supplier\",defaultValue:\"0\",\"inputType\":0,\"type\":\"TEXT\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"43\",id: \"conversionvalue\", name: \"conversionvalue\", field: \"conversionvalue\",defaultValue:\"0\",\"inputType\":0,\"type\":\"DECIMAL\",\"maxValue\":0,\"textLength\":20,\"decimalLength\":10,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,chkTag:false},\r\n");
      out.write("    {order:\"44\",id: \"basequantity\", name: \"BaseQuantity\", field: \"basequantity\",defaultValue:\"0\",\"inputType\":0,\"type\":\"INT\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":false,\"readOnly\":true,\"mandatory\":false,width:0,cTotal:true,chkTag:false},\r\n");
      out.write("    {order:\"45\",id: \"binname\", name: \"Bin\", field: \"binname\",defaultValue:\"0\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,lovOptions:{url:\"/inventory/service/ajax\",ajax:\"bin\",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:\"branch\",src:\"frombranch\",ft:true}],results:[{tgt:\"out_data\",tt:false,row:\"cr\",col:\"37\",id:\"0\"},{tgt:\"out_data\",tt:true,row:\"cr\",col:\"37\",id:\"1\"}]},width:120,chkTag:true,validation:\"\"},\r\n");
      out.write("    {order:\"46\",id: \"rackname\", name: \"Rack\", field: \"rackname\",defaultValue:\"0\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,lovOptions:{url:\"/inventory/service/ajax\",ajax:\"racks\",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:\"bin\",src:\"out_data\",row:\"cr\",col:\"37\",ft:true}],results:[{tgt:\"out_data\",tt:false,row:\"cr\",col:\"38\",id:\"0\"},{tgt:\"out_data\",tt:true,row:\"cr\",col:\"38\",id:\"1\"}]},width:120,chkTag:true,validation:\"\"},\r\n");
      out.write("    {order:\"47\",id: \"shelfname\", name: \"Shelf\", field: \"shelfname\",defaultValue:\"0\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,lovOptions:{url:\"/inventory/service/ajax\",ajax:\"shelf\",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:\"rackname\",src:\"out_data\",row:\"cr\",col:\"38\",ft:true}],results:[{tgt:\"out_data\",tt:false,row:\"cr\",col:\"39\",id:\"0\"},{tgt:\"out_data\",tt:true,row:\"cr\",col:\"39\",id:\"1\"}]},width:120,chkTag:true,validation:\"\"},\r\n");
      out.write("    {order:\"48\",id: \"boxname\", name: \"Box\", field: \"boxname\",defaultValue:\"0\",\"inputType\":0,\"type\":\"LOV\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":0,\"visible\":true,\"readOnly\":true,\"mandatory\":true,lovOptions:{url:\"/inventory/service/ajax\",ajax:\"box\",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:\"shelfname\",src:\"out_data\",row:\"cr\",col:\"39\",ft:true}],results:[{tgt:\"out_data\",tt:false,row:\"cr\",col:\"40\",id:\"0\"},{tgt:\"out_data\",tt:true,row:\"cr\",col:\"40\",id:\"1\"}]},width:120,chkTag:true,validation:\"\"}\r\n");
      out.write("    ]}},\r\n");
      out.write("  {name:\"group3\",height:20,width:45,minWidth:250,minHeight:50,colWidth:98,float:\"right\",backColor:\"biege\",contentType:\"Fields\",\r\n");
      out.write("  fields:[  {name:\"discamt\",inputType:0,type:\"DECIMAL\",caption:\"Total Discount\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"taxamt\",onchange:\"onTaxChange\"},\r\n");
      out.write("  {name:\"taxamt\",inputType:0,type:\"DECIMAL\",caption:\"VAT\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"total\"},\r\n");
      out.write("  {name:\"servtaxamt\",inputType:0,type:\"DECIMAL\",caption:\"VAT\",mandatory:false,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"total\"},\r\n");
      out.write("  {name:\"total\",inputType:0,type:\"DECIMAL\",caption:\"Total:\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"chkTag\":false,nf:\"totalamt\"},    \r\n");
      out.write("  {name:\"totalamt\",inputType:0,type:\"DECIMAL\",caption:\"Net Amount\",mandatory:true,defaultValue:\"0\",\"maxValue\":0,\"textLength\":10,\"decimalLength\":2,\"visible\":true,\"readOnly\":true,\"chkTag\":false}\r\n");
      out.write("  ]\r\n");
      out.write("  }]};\r\n");
      out.write("  /*\r\n");
      out.write("  ,\r\n");
      out.write("    {name:\"group4\",height:15,width:80,minWidth:500,minHeight:50,colWidth:15,float:\"left\",backColor:\"beige\",contentType:\"Fields\",fields:[\r\n");
      out.write("    {name:\"add\",inputType:3,caption:\"Add\",onclick:\"add\",visible:true},\r\n");
      out.write("    {name:\"save\",inputType:3,caption:\"Save\",onclick:\"save\",visible:true},\r\n");
      out.write("    {name:\"edit\",inputType:3,caption:\"Edit\",onclick:\"edit\",visible:true},\r\n");
      out.write("    {name:\"Delete\",inputType:3,caption:\"Delete\",onclick:\"delete1\",visible:true}\r\n");
      out.write("    ]}\r\n");
      out.write("    */\r\n");
      out.write("  var screenProps=changeScreenAttributes(410004,sProps);\r\n");
      out.write("  var godownstockscreen=new FlexUI.Screen(\"xyz\",screenProps);\r\n");
      out.write("  setDefaultBranch();\r\n");
      out.write("  ");
if(mode!=null && mode.equals("VIEW")){
      out.write("\r\n");
      out.write("	  loadDataView(");
      out.print(code);
      out.write(");\r\n");
      out.write("	  $('#saveGrp').html('<div class=\"col-sm-2 col-md-2 col-lg-2 adCl saVbN\" onclick=\"closeScreen()\">Close</div><div class=\"col-sm-2 col-md-2 col-lg-2 adCl1\" >&nbsp;</div><div class=\"col-sm-2 col-md-2 col-lg-2 adCl1\" >&nbsp;</div>');\r\n");
      out.write("	");
}
      out.write("\r\n");
      out.write(" </script>\r\n");
      out.write("<iframe src='' style='display:none' id=\"ppurchase\">\r\n");
      out.write("</iframe> \r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
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
