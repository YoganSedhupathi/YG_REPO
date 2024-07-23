<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
		<title>CISSOL Technologies</title>  
    </head>
    <body>
    <%
    	String userId=(String)session.getAttribute("LOGIN_ID");
    	String rptId=request.getParameter("id");
    	String rptTitle=request.getParameter("title");
    	String fromdt=request.getParameter("fromdt");
    	String todt=request.getParameter("todt");
    	String fromdash=request.getParameter("fromdash");
		String showCSVExport=request.getParameter("showcsv");
    	if(fromdt!=null && !fromdt.equals("")){%>
    		$('#fromDate').val(fromdt);
    	<%}
    	if(todt!=null && !todt.equals("")){%>
			$('#toDate').val(todt);
		<%}
	%>
    
	<!-- New Report UI Starts-->


	<div id="listContainer" class="card border-0">
		<div class="card-body">
			<div class="row w-100 mb-3">
				<div class="col-md-2 d-flex align-items-center">
					<h4 class="header-title"><%=rptTitle%></h4>
				</div>
				<div  class="col-md-10 d-flex text-right" id="addGrp">
						<div class="col-md-10">
							<div class="row">

								<%if(rptId.equals("710032")){%>
									<div class="row w-100">
										<div >                    
											<div id="branch1" class=""></div>
										</div>
										<div class="col-sm-11 col-md-11 col-lg-11"  >                    
											<div id="mfrfilter" class="sBor">
					
											</div>
										</div>
										<div class="col-sm-1 col-md-1 col-lg-1"  >
											<div id="divSecond" class="">
												<div class="col-sm-4 col-md-4 col-lg-4 mpZero">
													<div class="form-group extrBT" style="justify-content: space-between;">
														<button type="button" class="btn btn-primary" onclick="reportGo(<%=rptId%>)"><span >Go</span></button>
													</div>	
												</div>
											</div>
										</div>
									</div>
									<%}%>

									<%if(!rptId.equals("710032")){%>

										<div  class="col-md-6"  id="noofdays"  style="display: none;">
											<div class="input-group">
												<span class="input-group-text">No Of Days</span>
												<input type="text" id="noofDays" name="noofDays" class="form-control" value="60"/>
												<button type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button>
											</div>
										</div>
									
										<div class="col-md-6 input-group" id="datefilter"  >
											<span class="input-group-text">From Date</span>
											<input id="fromDate" name="fromDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
											<span id="startDateSelected"></span>
											<span class="input-group-text">To Date</span>
											<input id="toDate" name="toDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
											<button type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button>
											<%if(rptId.equals("710021")){%>
												<button type="button" class="btn btn-primary mRhAj btn-sm" onclick="exportCSV('<%=rptId%>')">CSV Export</button>
												<button type="button" class="btn btn-primary mRhAj btn-sm" onclick="exportPDF('<%=rptId%>')">PDF</button>
											<%}%>
										</div>

									<%}%>
							</div>
						</div>
						<div class="col-md-2">
							<button type="button" class="btn btn-clear" onclick='enableSearch();'><span class="mdi mdi-filter-variant">Search</span></button>	
						</div>
				</div>
				
			</div>
			<div class="row " id="jqcontainer" ><div class="table-container" ><div id="rep" class="w-100"></div></div></div>
		</div>
	</div>

	<!-- New Report UI End-->

	<div id="maincontent" style="display:none">
        	
	</div>
	<div id="modifydlg" style="display:none">
		<div id="modcontent"></div>
	</div>

<script>

var l=new FlexUI.Ajax();
var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=userdefbranch");
var defbranch=v.data;
var acvis=false;
var colno=0;
if(<%=rptId%>==710032){
	acvis=true;
	colno=1;
}

var sProps={title:{height:125,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"",screen:[
  {name:"mfrfilter",title:"",pcolumns:3,colcss:"col-sm-4 col-md-4 col-lg-4",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"mfrname",inputType:0,type:"LOV",caption:"Mfr Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":acvis,"readOnly":false,"chkTag":true,nf:"fromdate",lovOptions:{url:"/inventory/service/ajax",ajax:"manufacturer",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  {colno:colno,name:"fromdate",inputType:0,type:"DATE",caption:"From Date",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"todate"},
  {colno:2,name:"todate",inputType:0,type:"DATE",caption:"To Date",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""}  
  ]},
  {name:"branch1",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  ]}]};


var mfrreport=null;
mfrreport=new FlexUI.Screen("mfrreport",sProps);
function setDefaultBranch(){
		var branch=screenObjects.getScreenObject("branch");
		branch.setTag(defbranch[0][1]);
		branch.setValue(defbranch[0][0]);
	}
setDefaultBranch();

var newParams="&fromdate="+screenObjects.getScreenObject("fromdate").getValue()+"&todate="+screenObjects.getScreenObject("todate").getValue()+"&mfrname=0&branch="+screenObjects.getScreenObject("branch").getTag();

		$('#fromDate').datepicker(
			{
				language: "en",
				autoclose: true,
				autoOpen: false,
				todayHighlight: true,
				format:'dd/mm/yyyy'
			}
			);			
		$('#toDate').datepicker({
				language: "en",
				autoclose: true,
				autoOpen: false,
				todayHighlight: true,
				format:'dd/mm/yyyy'
			});
		if($('#fromDate').val()==""){
			var cd=new Date();
			$('#fromDate').datepicker("setDate",cd);
		}
					
		if($('#toDate').val()==""){
			var cd=new Date();
			$('#toDate').datepicker("setDate",cd);	
		}
			


var params="";
<%if(rptId.equals("710032")){%>
newParams ="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&noofdays="+$('#noofDays').val()+"&mfr_id="+escape($("#mfrid").val());
<%}else{%>
newParams ="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&noofdays="+$('#noofDays').val();
<%}%>

jqReport(<%=rptId%>,"#rep",newParams);

if(<%=showCSVExport%>==1){
	showCSVExportButton(<%=rptId%>,newParams);
}
function enableSearch(){
	toggleSearchToolBar(<%=rptId%>);
}
enableSearch();
function loadOrderData(link,name,did){
		if(name=="View"){
			$("#jqcontainer").css("display","none");
			$('#rep').hide();
			$('#filter').css("display","none");
			$('#dtfilter').css("display","none");
			$('#brdCr').css("display","none");
			$('#listContainer').hide();
			$('#maincontent').show();
			$("#maincontent").empty();
			$('#modifycontent').hide();
			$('#modifycontent').empty();
			$('#maincontent').load(link+"&mode=VIEW");
		}else if(name=="Print"){
			printBill(undefined,false,link);
		}else if(name=="Modify"){
			window.open(link);
		}else if(name=="AllBillsSummary"){
			var rowData=$("#report_<%=rptId%>").getRowData(did);
			var expParams="summary=1&allbills=1&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&patientcode="+rowData.sh_cust_code+"&patientno="+rowData.cust_alias;
			window.open("/inventory/service/invoice/customerbills?"+expParams,"_blank");			
		}else if(name=="AllBillsDetail"){
			var rowData=$("#report_<%=rptId%>").getRowData(did);
			var expParams="summary=0&allbills=1&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&patientcode="+rowData.sh_cust_code+"&patientno="+rowData.cust_alias;
			window.open("/inventory/service/invoice/customerbills?"+expParams,"_blank");						
		}else if(name=="PeriodBillsSummary"){
			var rowData=$("#report_<%=rptId%>").getRowData(did);
			var expParams="summary=1&allbills=0&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&patientcode="+rowData.sh_cust_code+"&patientno="+rowData.cust_alias;
			window.open("/inventory/service/invoice/customerbills?"+expParams,"_blank");						
		}else if(name=="PeriodBillsDetail"){
			var rowData=$("#report_<%=rptId%>").getRowData(did);
			var expParams="summary=0&allbills=0&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&patientcode="+rowData.sh_cust_code+"&patientno="+rowData.cust_alias;
			window.open("/inventory/service/invoice/customerbills?"+expParams,"_blank");									
		}
}

function reportGo(id){
	<%if(rptId.equals("710021") || rptId.equals("1200003")){%>
		$.ajax({
		            url: "/inventory/service/account/sales/dayend?branch=1",
        		    type: "GET",
	        	    async: false,
	        	    contentType:"application/json",
		            dataType: "json",
        		    success: function (r) {
						
	            	}
        	});		
	<%}%>
	showLoader();
	var newParams=""
	<%if(rptId.equals("710032")){%>
		newParams="&fromdate="+screenObjects.getScreenObject("fromdate").getValue()+"&todate="+screenObjects.getScreenObject("todate").getValue()+"&noofdays="+$('#noofDays').val()+"&mfr_id="+screenObjects.getScreenObject("mfrname").getTag();
	<%}else{%>
		newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&noofdays="+$('#noofDays').val();
	<%}%>
	changeUrlAndReloadGrid(id,params,newParams);
	showPDFExportButton(id,newParams);
	if(<%=showCSVExport%>==1){
		showCSVExportButton(id,newParams);
	}
	hideLoader();
}
function exportCSV(id){
	var newParams="id=<%=rptId%>&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&noofdays="+$('#noofDays').val();
	window.open("/inventory/service/account/sales/exportcsv?"+newParams,"_blank");
}
function exportPDF(id){
	var newParams="id=<%=rptId%>&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&noofdays="+$('#noofDays').val();
	window.open("/inventory/service/account/incomestatement?"+newParams,"_blank");
}
<%if(rptId.equals("710011")){%>
	$('#filter').css("display","none");
	$('#dtfilter').css("display","none");
	$('#stkReportTitle').css("display","block");
	$('#divExpDaysFilter').css("display","none");
<%}else if(rptId.equals("1200007")){%>
	$('#datefilter').css("display","none");
	$('#filter').css("display","block");
	$('#dtfilter').css("display","none");
	$('#stkReportTitle').css("display","none");
	$('#divExpDaysFilter').css("display","block");		
	$('#noofdays').css("display","block");		
<%}else if(rptId.equals("710032")){%>
	$('#filter').css("display","block");
	$('#dtfilter').css("display","block");
	$('#stkReportTitle').css("display","none");
	$('#divExpDaysFilter').css("display","none");
	$('#mfrfilter').css("display","block");		
<%}else if(rptId.equals("1200008")){%>
	$('#datefilter').css("display","none");
<%}else{%>
	$('#filter').css("display","block");
	$('#dtfilter').css("display","block");
	$('#stkReportTitle').css("display","none");
	$('#divExpDaysFilter').css("display","none");
<%}%>
<%if (fromdash!=null && fromdash.equals("true")){%>
	$('#spanClose').show();
<%}else{%>
	$('#spanClose').hide();
<%}%>



function showHideFilter(){
	if( $('#divFirstFilter').is(':visible') ) {
		$('#divFirstFilter').css("display","none");
	}else{
		$('#divFirstFilter').css("display","block");
	}
}
function closeReport(){
	$("#divDash").css("display","block");
	$("#reportcontent").css("display","none");
}

function printBill(data,first,link){
	alert("print rep");
	console.log("printbill"+ data,first,link);
		var printData={};
		if(!first){
			if(link==""){
				return;
			}
			$.ajax({
		            url: link,
        		    type: "GET",
	        	    async: false,
	        	    contentType:"application/json",
		            dataType: "json",
        		    success: function (r) {
					data=r;	
					console.log("data"+" "+Object.values(data));
	            		}
        		});			
		}
		if(link.indexOf("salesreturn")!=-1 || link.indexOf("invoice")!=-1){
		var isSalesReturn=false;
		if(link.indexOf("salesreturn")!=-1){
			isSalesReturn=true;
		}
		var printData={};
		if(isSalesReturn){
			printData["type"]="PGSHSR";
		}else{
			 printData["type"]="PGSHSR";
		}
		
		printData["branchcode"]=data["branch"];
		printData["company"]="Tiruvarur Medical Center(P) Ltd";
		printData["address1"]="27,Javulikara Street";
		printData["address2"]="Tiruvarur - 610 001";
		printData["address3"]="Phone - 242292,240292";
		printData["tin"]="";
		printData["userid"]='<%=userId%>';
		printData["custalias"]=data["custalias"];
		if(isSalesReturn){
			printData["returnno"]=data["returnno"];
			printData["returndate"]=data["returndate"];
		}else{
			printData["billno"]=data["billno"];
			printData["billdate"]=data["billdate"];
			printData["tendered"]=data["tendered"]+"";
			printData["balance"]=data["balance"]+"";
			printData["despthro"]=data["despthro"]+"";
		}
		printData["tax"]=data["taxamt"];
		printData["totalamt"]=data["totalamt"]+"";
		printData["roundoff"]=data["roundedoff"]+"";
		printData["doctorname"]=data["professional"]+"";
		printData["total"]=data["total"]+"";		
		printData["cdiscamt"]=data["cdiscamt"]+"";
		printData["cardcharges"]=data["cardcharges"]+"";
		printData["customer"]=data.name;
		printData["printtax"]="1";
		printData["printdisc"]="0";
		printData["printround"]="1";
		printData["printnetamount"]="1";
		printData["printcardchg"]="1";
		printData["showprintdlg"]="0";
		if(data.billType=="CR"){		
			printData["invtype"]="CREDIT";
		}else if(data.billType=="CO"){
			printData["invtype"]="CORPORATE";
		}else{
			printData["invtype"]="TAX";
		}		
		
		printData["items"]=[];
		for(var x=0;x<data.noofitems;x++){
			var item={};
			item.name=data.products[x].productname;
			item.rate=data.products[x].rate+"";
			item.qty=data.products[x].qty+"";
			item.batch=data.products[x].batchno+"";
			item.expdt=data.products[x].expdt+"";
			item.amount=data.products[x].amount+"";				
			item.totalamount=data.products[x].totalamount+"";
			item.taxableamt=data.products[x].taxableamt+"";
			item.staxamt=data.products[x].staxamt+"";
			item.staxperc=data.products[x].staxperc+"";
			item.cashdiscamt=data.products[x].cashdiscamt+"";
			item.hsncode=data.products[x].hsncode+"";
			printData.items.push(item);
		                              }
		console.log("item"+" "+Object.values(item));
		console.log("data"+" "+Object.values(data));
		console.log("print values"+" "+Object.values(printData));
		}else if(link.indexOf("cashhandover")!=-1){
			printData=data;
		}else if(link.indexOf("vouchers")!=-1){
			printData=data;
			printData["type"]="VCHER";
			printData["branchname"]="Tiruvarur Medical Center(P) Ltd";
			printData["address1"]="27,Javulikara Street";
			printData["address2"]="Tiruvarur - 610 001";
			printData["address3"]="Phone - 242292,240292";
		}		
		$.ajax({
	            url: "http://localhost:9696",
        	    type: "POST",
	            async: false,
        	    contentType:"application/x-www-form-urlencoded",
	            data:"printdata="+JSON.stringify(printData),
	            dataType: "json",
        	    success: function (r) {
				//alert(r.result);	
					
        	    }
	        });		
	}

	
		
	
</script>        
</body>
</html>