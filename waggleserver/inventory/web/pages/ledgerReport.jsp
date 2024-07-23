<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Receipts/Payments</title>
</head>
<body>
<%
	String code=(String)request.getParameter("code");
	String branch=(String)request.getParameter("branch");
	String userId=(String)session.getAttribute("LOGIN_ID");
	String rptId=(String)request.getParameter("id");
	String rptTitle="Ledger Report";
	if(rptId.equals("610015")){
		rptTitle="Cash Book";
	}
%>



<div class="card border-0 shadow">
	<div class="card-body lpage">
	  <!--Header-->
	  <div class="row w-100">
		<div class="col-md-6 d-flex align-items-center">
			<h4 class="header-title"><%=rptTitle%></h4>
		</div>
		<div class="col-md-6 text-right" id="addGrp">
			<div id="actionicons">
				<button type="button" class="btn btn-edit" onclick="printCurrentSession()"><span class="mdi mdi-printer">Print</span></button>
				<button type="button" class="btn btn-clear mx-3" onclick="enableSearch();"><span class="mdi mdi-filter">Filter</span></button>
			</div>
		</div>
	  </div>
	  <!--Header End-->
		<!--Content Start-->	  
		<div id="content" class="mt-3">
			<div id="filter" style="display:block" >
		  		<div class="row w-100">
					<div >                    
						<div id="branch1" class=""></div>
					</div>
					<div class="col-sm-9 col-md-9 col-lg-9"  >                    
						<div id="divFirstFilter" class="sBor">

						</div>
					</div>
					<div class="col-sm-3 col-md-4 col-lg-3"  >
						<div id="divSecond" class="">
							<div class="col-sm-4 col-md-4 col-lg-4 mpZero">
								<div class="form-group extrBT" style="justify-content: space-between;">
									<button type="button" class="btn btn-save" onclick="reportGo(<%=rptId%>)"><span class="mdi mdi-arrow-right">Go</span></button>
								</div>	
							</div>
						</div>
					</div>
					</div>
			</div>

			<div class="row">
				<div class="table-container">
					<div class="col-md-12 col-sm-12 aarea" id="rep"></div>
				</div>
		  	</div>	
			  <div class="row w-100 mt-3">
				<div class="col-md-8">
					<div class="p-2 gap-2 bg-white shadow-sm rounded-3">
						<div class="gap-2 card-dicount px-3 bg-custom rounded-3 text-right">
					
					  	<div class="">
								<span class="amount-text" id="netAmt">Closing Balance :0.00</span>
						</div>
					</div>
					</div>
					<!--  -->
			</div>
			  </div>


		  </div>
		</div>
		</div>
	  <!--Content End-->
<script>
var l=new FlexUI.Ajax();
var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=userdefbranch");
var defbranch=v.data;
var acvis=false;
var colno=0;
if(<%=rptId%>==610014){
	acvis=true;
	colno=1;
}
  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"",screen:[
  {name:"divFirstFilter",title:"",pcolumns:3,colcss:"col-sm-4 col-md-4 col-lg-4",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"account",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":acvis,"readOnly":false,"chkTag":true,nf:"fromdate",lovOptions:{url:"/inventory/service/ajax",ajax:"ledgers",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  {colno:colno,name:"fromdate",inputType:0,type:"DATE",caption:"From Date",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"todate"},
  {colno:2,name:"todate",inputType:0,type:"DATE",caption:"To Date",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""}  
  ]},
  {name:"branch1",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  ]}]};

var ledgereport=null;
ledgereport=new FlexUI.Screen("ledgereport",sProps);
console.log("v"+Object.values(ledgereport));
setDefaultBranch();
var newParams="&fromdate="+screenObjects.getScreenObject("fromdate").getValue()+"&todate="+screenObjects.getScreenObject("todate").getValue()+"&account=0&branch="+screenObjects.getScreenObject("branch").getTag();
jqReport(<%=rptId%>,"#rep",newParams,null,300);
	
function setDefaultBranch(){
		var branch=screenObjects.getScreenObject("branch");
		branch.setTag(defbranch[0][1]);
		branch.setValue(defbranch[0][0]);
	}
function enableSearch(){
	toggleSearchToolBar(<%=rptId%>);
}
enableSearch();	       
function reportGo(id){
	alert("go");
	showLoader();
	var newParams="&fromdate="+screenObjects.getScreenObject("fromdate").getValue()+"&todate="+screenObjects.getScreenObject("todate").getValue()+"&account="+screenObjects.getScreenObject("account").getTag()+"&branch="+screenObjects.getScreenObject("branch").getTag();
	changeUrlAndReloadGrid(id,"",newParams);
	hideLoader();
	var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=<%=rptId%>&fromdate="+screenObjects.getScreenObject("fromdate").getValue()+"&todate="+screenObjects.getScreenObject("todate").getValue()+"&account="+screenObjects.getScreenObject("account").getTag()+"&branch="+screenObjects.getScreenObject("branch").getTag());
	if(v.data[0][0]<0){
		$('#netAmt').text("Closing Balance "+roundOff(toNumber(v.data[0][0])*-1,2)+" Cr ");
	}else{
		$('#netAmt').text("Closing Balance "+roundOff(toNumber(v.data[0][0]),2)+" Dr ");
	}
}
function showHideFilter(){
	if( $('#divFirstFilter').is(':visible') ) {
		$('#divFirstFilter').css("display","none");
	}else{
		$('#divFirstFilter').css("display","block");
	}
}
function printCurrentSession(){
		var printData={};
		printData["fromdate"]=screenObjects.getScreenObject("fromdate").getValue();
		printData["todate"]=screenObjects.getScreenObject("todate").getValue();
		printData["account"]=screenObjects.getScreenObject("account").getTag();
		printData["name"]=screenObjects.getScreenObject("account").getValue();
		printData["branch"]=screenObjects.getScreenObject("branch").getTag();		
		printData["type"]="LEDREP";
		printData["branchname"]="Tiruvarur Medical Center PVT Ltd";
		printData["address1"]="27,Javulikara Street";
		printData["address2"]="Tiruvarur - 610 001";
		printData["address3"]="Phone - 242292,240292";
		printData["login_id"]='<%=userId%>';
		printData["reportid"]="<%=rptId%>";
		printData["host"]='192.168.1.101:8080/inventory';
		printData["rows"]="48";		
		$.ajax({
            url: "http://localhost:9191",
            type: "POST",
            async: true,
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
