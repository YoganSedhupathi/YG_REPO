<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String userId=(String)session.getAttribute("LOGIN_ID");
%>
<body>
	<div class="clearfix"></div>
	<div class="col-md-12 col-sm-12 mpZero marTp">
			<div class="col-md-12 panelOrange hcH" >
					<div class="subHe">MIS Report</div>
					<div class="col-md-12 col-sm-12 mpZero">
						<div  class="col-md-6 col-sm-6 mpZero">		
						<div class="form-group mbotto">
							<div class="col-md-4"><label>From Date</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="fromdate"></div>
						</div>
						</div>	
						<div  class="col-md-6 col-sm-6 mpZero">		
						<div class="form-group mbotto">
							<div class="col-md-4"><label>To Date</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="todate"></div>
						</div>
						</div>
					</div>
					<div class="clearfix"></div>	
	            	<div id="actButton" class="col-md-12 text-right">
	                	<button id="btnGo" class="btn btn-primary priBut" type="button" onclick="reportGo()">Go</button>
	                	<button id="btnPrint" class="btn btn-primary priBut" type="button" onclick="printMIS()">Print</button>
	            	</div>
			</div>
			<div class="col-md-12 panelOrange hcH" >
			<div class='clearfix'></div>
			<div class="subHe">Cash Patients Info</div>
			<div id="cashpatients" style='position:relative;border:0px;display:block;' class="mTBx">
        	</div>
        	</div>
        	<div class='clearfix'></div>
        	<div class="col-md-12 panelOrange hcH" >
        	<div class="subHe">Corporate Patients Info</div>
			<div id="sponsorpatients" style='position:relative;border:0px;display:block;' class="mTBx">
        	</div>
        	</div>        	
        	<div class='clearfix'></div>
        	<div class="col-md-12 panelOrange hcH" >
        	<div class="subHe">Cash Investigations</div>
			<div id="investigations" style='position:relative;border:0px;display:block;' class="mTBx">
        	</div>					
        	</div>
	</div>
	<script>
 	var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[{name:"fromdate",inputType:0,type:"DATE",caption:"From Date",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"todate"},
  	{name:"todate",inputType:0,type:"DATE",caption:"To Date",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"btnGenerate"},
	{name:"btnGo",inputType:3,caption:"",visible:false}
  	]}]};
	var misreport=null;
	misreport=new FlexUI.Screen("misreport",sProps);
    var newParams="&fromdate="+screenObjects.getScreenObject("fromdate").getValue()+"&todate="+screenObjects.getScreenObject("todate").getValue();
	jqReport(500010,"#cashpatients",newParams,null,300);
	jqReport(510010,"#sponsorpatients",newParams,null,300);
	jqReport(520010,"#investigations",newParams,null,300);
    toggleSearchToolBar(500010);
    toggleSearchToolBar(510010);
    toggleSearchToolBar(520010);
    function reportGo(){
		showLoader();
		var newParams="&fromdate="+screenObjects.getScreenObject("fromdate").getValue()+"&todate="+screenObjects.getScreenObject("todate").getValue();
		changeUrlAndReloadGrid("500010","",newParams);
		changeUrlAndReloadGrid("510010","",newParams);
		changeUrlAndReloadGrid("520010","",newParams);
		hideLoader();
	}
    function clearInnerScreen(){
    	misreport.clearScreen();
    }
    function printMIS(){
		var printData={};
		printData["fromdate"]=screenObjects.getScreenObject("fromdate").getValue();
		printData["todate"]=screenObjects.getScreenObject("todate").getValue();
		printData["type"]="MIS";
		printData["branchname"]="Tiruvarur Medical Center PVT Ltd";
		printData["address1"]="27,Javulikara Street";
		printData["address2"]="Tiruvarur - 610 001";
		printData["address3"]="Phone - 242292,240292";
		printData["login_id"]='<%=userId%>';
		printData["host"]='localhost:9090/HMS';
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