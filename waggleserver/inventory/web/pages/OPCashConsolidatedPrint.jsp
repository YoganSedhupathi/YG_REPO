<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Consolidated Cash Statement</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String stype=request.getParameter("type");
%>
<body>

	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Prescription Details</h4>
				</div>
			</div>
			<div class="row " id="jqcontainer" style="display:none">
				<div class="table-container" >
					 <div id="xyz" class="w-100">
					 </div>
				</div>
			</div>	
			<div id="callback"  >
			<div class="table-container">
				<div class="row w-100 ml-8">                    
					<div id="group1" class="row"></div>
				</div>
			</div>
			<div class="row w-100 mt-3">
				<div class="col-md-3">
				<div class="hstack justify-content-start">
					<div id="actButton">
					<button id="btnClear" class="btn btn-default" type="button" onclick="clearInnerScreen()">Clear</button>
					<button id="btnGenerate" class="btn btn-primary priBut" type="button" onclick="printSession()">Print</button>
				</div>
				</div>
				</div>
			</div>	
			</div>
		</div>
	</div>

	


	<script>
	var showBranch=false;
	var showToDate=false;
	if("<%=stype%>"=="Register"){
		showBranch=true;
		showToDate=true;
	}
 	var sProps={js:"",screen:[
  	{name:"group1",contentType:"Fields",
  	fields:[
  	{name:"branch",inputType:0,type:"LOV",caption:"Branch",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":showBranch,"readOnly":false,"chkTag":true,nf:"reqdate",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"}]}},
  	{name:"reqdate",inputType:0,type:"DATE",caption:"Date",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"todate"},
  	{name:"todate",inputType:0,type:"DATE",caption:"Date",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":showToDate,"readOnly":false,"chkTag":false,nf:""}
  	]}]};
	var consolidatedCash=null;	
    $(document).ready(function () {
    		consolidatedCash=new FlexUI.Screen("consolidatedcash",sProps);
            $('#subtitle').text("");
     });
    function clearInnerScreen(){
    	consolidatedCash.clearScreen();
    	if("<%=stype%>"=="Register"){
    		$("branch").focus();
    	}else{
    		$("reqdate").focus();
    	}
    }
	function printSession(){
		var reqDate=screenObjects.getScreenObject("reqdate").getValue();
		var toDate=screenObjects.getScreenObject("todate").getValue();
		var branch=screenObjects.getScreenObject("branch").getTag();
		var bname=screenObjects.getScreenObject("branch").getValue();
		if("<%=stype%>"=="Register"){
			var url="/inventory/service/invoice/generatepresreport?branchcode="+branch+"&branchname="+bname+"&fromdate="+reqDate+"&todate="+toDate+"&format=P";
			window.open(url,"_blank");
		}else{
		    var data;
			$.ajax({
	            url: "/inventory/service/account/cashhandover/total/print?&reqdate="+reqDate+"",
	            type: "GET",
	            async: false,
	            contentType:"application/json",
	            dataType: "json",
	            success: function (r) {
					data=r;		
	            }
	        });			
			if(data.status=="Success"){
				$.ajax({
		            url: "http://localhost:9191",
		            type: "POST",
		            async: true,
		            contentType:"application/x-www-form-urlencoded",
		            data:"printdata="+JSON.stringify(data),
		            dataType: "json",
		            success: function (r) {
						//alert(r.result);		
		            }
		        });
		    }else{
		    	alert(data.message);
		    }
		 }						
	}
  </script>
</body>
</html>