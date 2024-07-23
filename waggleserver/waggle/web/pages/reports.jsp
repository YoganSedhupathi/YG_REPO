<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        
    </head>
    <body>
    <script>
    <%
    	String userId=(String)session.getAttribute("LOGIN_ID");
    	String rptId=request.getParameter("id");
		String screencode=(String)request.getParameter("screencode");
    	String rptTitle=request.getParameter("title");
    	String fromdt=request.getParameter("fromdt");
    	String todt=request.getParameter("todt");
    	String fromdash=request.getParameter("fromdash");
    	if(fromdt!=null && !fromdt.equals("")){%>
    		$('#fromDate').val(fromdt);
    	<%}
    	if(todt!=null && !todt.equals("")){%>
			$('#toDate').val(todt);
		<%}
%>

    </script>
    
	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100">
				<div class="col-md-3 d-flex align-items-center">
					<h4 class="header-title"><%=rptTitle%></h4>
				</div>

				<div class="col-md-3 d-flex align-items-center">
					<!-- <div class="input-group" id="branchdiv">
						<span class="input-group-text">Branch</span>
						<select class="form-select" id="branch" onchange="loadBranchUserData()"></select>
					</div> -->
					<div class="input-group" id="userdiv">
						<span class="input-group-text">User</span>
						<select class="form-select" id="username"></select>

					</div>
					<div class="input-group"  id="budiv">
						<span class="input-group-text">BU</span>
						<select class="form-select" id="buname"></select>
					</div>
				</div>

				<div  class="col-md-6" id="addGrp">
					<div class="row">
						<div class="col-md-8 d-flex text-right">
							
							<div class="input-group">
								<span class="input-group-text">From</span>
								<input id="fromDate" name="fromDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
								<span class="input-group-text">To</span>
								<input id="toDate" name="toDate" inputType="date"  type="text" mandatory="1"  class="form-control"/> &ensp;
								<button type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button> &ensp;
								<button type="button" class="btn btn-edit" onclick="printCurrentSession()">Print</button>
							</div>
						</div>
						
						<div class="col-md-4" style="text-align: right;">
							<button type="button" class="btn btn-clear" onclick='toggleHeaderRow()'><span class="mdi mdi-filter-variant">Search</span></button>	
						</div>
					</div>
				</div>
				
			</div>
			<div class="row " id="jqcontainer" >
			  <div class="table-container" >
				 <div id="rep" class="w-100"></div>
			  </div>
			</div>	
			<div id="callback" class="row " style="display:none;"></div>
		</div>
	</div>







        <!-- <div id="content" >
			<div class="clearfix"></div>
			<div id="filter" style="display:block" class="col-sm-15 col-md-15 col-lg-15 mpRhZ mTBx">
			
				<div class="panelOrange hcH">
				<span id="spanClose" class="pull-right right-btn" onclick="closeReport()" style="width:50px;text-align:right;"><b id="settingsBtn" class="fa fa-times-circle"></b></span>
				<div class="subHe" id="dtfilter" name="dtfilter" style="display: block"><%=rptTitle%><span class="pull-right" onclick="showHideFilter()"><b class="fa fa-caret-down"></b></span></div>
  					<div id="divFirstFilter" style="display:block">
  						<div class="col-sm-4 col-md-4 col-lg-4" id="branchdiv">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">Branch</label><div class="col-sm-7 mpRes"><select class="form-control" id="branch" onchange="loadBranchUserData()"></select></div></div>
	  					</div>  						
  						<div class="col-sm-4 col-md-4 col-lg-4" id="userdiv">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">User</label><div class="col-sm-7 mpRes"><select class="form-control" id="username"></select></div></div>
	  					</div>
	  					<div class="col-sm-4 col-md-4 col-lg-4" id="budiv">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">BU</label><div class="col-sm-7 mpRes"><select class="form-control" id="buname"></select></div></div>
	  					</div>
	  					<div class="clearfix"></div>
	  					<div class="col-sm-4 col-md-4 col-lg-4">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">From Date</label><div class="col-sm-7 mpRes"><input id="fromDate" name="fromDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control"/></div></div>
	  					</div>
		    			<div class="col-sm-4 col-md-4 col-lg-4">
		  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">To Date</label><div class="col-sm-7 mpRes"><input id="toDate" name="toDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control"/></div></div>
		  				</div>
		  				<div class="col-sm-4 col-md-4 col-lg-4 mpZero">
		  					<div class="form-group extrBT"><button type="button" class="btn btn-primary mRhAj btn-sm" onclick="reportGo('<%=rptId%>')">Go</button><button type="button" id="prntBtn" class="btn btn-primary mRhAj btn-sm" onclick="printCurrentSession()">Print</button></div>	
					    </div>
					</div>   
  				</div>
      		</div>			 -->
      				    
		    <script>
		    if(<%=rptId%>==400014 || <%=rptId%>==400015 || <%=rptId%>==400016 || <%=rptId%>==300010 || <%=rptId%>==300011 || <%=rptId%>==200011 || <%=rptId%>==400020 || <%=rptId%>==300013 || <%=rptId%>==200012){
			    $('#fromDate').datepicker({
						language: "en",
       				 	autoclose: true,
       					todayHighlight: true,
	 	 	     		format:'dd/mm/yyyy'
				});
				if($('#fromDate').val()==""){
					var cd=new Date();
					$('#fromDate').datepicker("setDate",cd);
				}
				$('#toDate').datepicker({
					language: "en",
					autoclose: true,
					todayHighlight: true,
					format:'dd/mm/yyyy'
				});			
				if($('#toDate').val()==""){
					var cd=new Date();
					$('#toDate').datepicker("setDate",cd);
				}		    
		    }else{
				$('#fromDate').datepicker({
				 language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy',
				 timeFormat: 'hh:mm TT'
					});
				if($('#fromDate').val()==""){
					var cd=new Date();
					$('#fromDate').datepicker("setDate",cd);
				}
				$('#toDate').datepicker({
						language: "en",
					autoclose: true,
					todayHighlight: true,
					format:'dd/mm/yyyy',
					timeFormat: 'hh:mm TT'
					});
				if($('#toDate').val()==""){
					var cd=new Date();
					$('#toDate').datepicker("setDate",cd);
				}
			}
		    </script>
			
            <!-- <div id="rep" style='position:relative;border:0px;display:block;' class="mTBx">
            	<div class=""><span class="pull-right" style="margin-top:-50px" ><button class="btn btn-sm seaColB" onclick="enableSearch();"><i class="fa fa-search"></i></button></span></div>
				<div class="clearfix"></div>
        	</div> -->
      



<script>


		

var showAll=false;
if(<%=rptId%>==400008){
	showAll=true;
}
loadBranchData(showAll);
loadBranchUserData();
loadBUData();
if(<%=rptId%>==400006){
	$('#userdiv').css("display","none");
	$('#budiv').css("display","none");
}else if(<%=rptId%>==400014 || <%=rptId%>==300010 || <%=rptId%>==300011 || <%=rptId%>==200011 || <%=rptId%>==300013  || <%=rptId%>==200012 || <%=rptId%>==300015 ){
	$('#userdiv').css("display","none");
	$('#branchdiv').css("display","none");
	$('#budiv').css("display","none");
	if(<%=rptId%>==200011 ||<%=rptId%>==300013 || <%=rptId%>==200012){
		$('#prntBtn').css("display","none");
	}
}else if(<%=rptId%>==400015 || <%=rptId%>==400016 || <%=rptId%>==400020){
	$('#userdiv').css("display","none");
	$('#branchdiv').css("display","none");
}
var params="";
newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&empid="+$('#username').val()+"&branch="+$('#branch').val()+"&bucode="+$('#buname').val()+"&buname="+escape($('#buname option:selected').text());
jqReport(<%=rptId%>,"#rep",newParams);

function enableSearch(){
	toggleSearchToolBar(<%=rptId%>);
}
enableSearch();
function reportGo(id){
	<%if(rptId.equals("400014") || rptId.equals("400015") || rptId.equals("400016")){%>
		$.ajax({
		            url: "/waggle/service/account/bills/dayend?branch=1",
        		    type: "GET",
	        	    async: false,
	        	    contentType:"application/json",
		            dataType: "json",
        		    success: function (r) {
	            	}
        	});		
	<%}%>	
	showLoader();
	var newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&empid="+$('#username').val()+"&branch="+$('#branch').val()+"&bucode="+$('#buname').val()+"&buname="+escape($('#buname option:selected').text());
	changeUrlAndReloadGrid(id,params,newParams);
	<%if(rptId.equals("400014") || rptId.equals("400015") || rptId.equals("400016")){%>
		showCSVExportButton(id,newParams);
	<%}%>
	hideLoader();
}

function toggleHeaderRow(){
  	toggleSearchToolBar(<%=rptId%>);
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
		printData["type"]="DCHBILL";
		printData["branch"]=$('#branch').val();
		printData["branchname"]=$('#branch option:selected').text();
		printData["address1"]="52, South Street";
		printData["address2"]="ARUPPUKOTTAI - 626 101";
		printData["address3"]="Phone - 222273,220936";		
		printData["empid"]=$('#username').val();
		printData["bucode"]=$('#buname').val();
		printData["buname"]=$('#buname option:selected').text();
		printData["username"]=$('#username option:selected').text();
		printData["fromdate"]=$('#fromDate').val();
		printData["todate"]=$('#toDate').val();
		printData["login_id"]='<%=userId%>';
		printData["reportid"]='<%=rptId%>';
		printData["host"]='192.168.1.6:8282/waggle';
		printData["rows"]="52";
		$.ajax({
            url: "http://localhost:8282",
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
function loadOrderData(url,name,did){
	if(<%=rptId%>==300010){
	  	if(name=="Print"){
	  		var rowData=$("#report_<%=rptId%>").getRowData(did);
		  	var printData={};	  		  	
		  	var data;
			$.ajax({
	            url: "/waggle/service/screen/data?screencode=16&branchcode="+rowData.branchcode+"&code="+rowData.cs_no,
	            type: "GET",
	            async: false,
	            contentType:"application/json",
	            dataType: "json",
	            success: function (r) {
					data=r;		
	            }
	        });	        
		    printData["type"]="CS";
			printData["branchname"]=$('#branch option:selected').text();
			printData["address1"]="52, South Street";
			printData["address2"]="ARUPPUKOTTAI - 626 101";
			printData["address3"]="Phone - 222273,220936";
			printData["billno"]=data["billno"];
			printData["billdate"]=data["addeddate"];
			printData["doctorname"]=data["doctorname"]+"";
			printData["referredby"]=data["referredby"]+"";
			printData["patientname"]=data["patientname"];		
			printData["patientage"]=data["patientage"];
			printData["gender"]=data["gender"];
			printData["mlccode"]=data["mlccode"];
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
	}else if(<%=rptId%>==200011){
		if(name=="Print"){
			var rowData=$("#report_<%=rptId%>").getRowData(did);
			var data;
			$.ajax({
	            url: "/waggle/service/ajax?id=medrequest&ic=0&ro=true&branch="+rowData.branchcode+"&code="+rowData.soh_no,
	            type: "GET",
	            async: false,
	            contentType:"application/json",
	            dataType: "json",
	            success: function (r) {
					data=r;		
	            }
	        });	        
			
			var printData={};
			printData["type"]="SOA";
			printData["branchcode"]=rowData.branchcode;
			printData["company"]=rowData.branchname;
			printData["address1"]="52, South Street";
			printData["address2"]="ARUPPUKOTTAI - 626 101";
			printData["address3"]="Phone - 222273,220936";
			printData["orderno"]=rowData.soh_order_no;
			printData["orderdate"]=rowData.soh_date;
			printData["tax"]="";
			printData["totalamt"]="";
			printData["custname"]=rowData.soh_cust_name;
			printData["custalias"]=rowData.cust_alias;
			printData["items"]=[];
			for(var x=0;x<data.data.length;x++){
				var item={};
				item.name=data.data[x].pm_name;
				item.sno=data.data[x].sod_sno;
				item.unit=data.data[x].um_name;
				item.quantity=data.data[x].sod_qty;
				printData.items.push(item);
			}
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
	}
}
</script>        
</body>
</html>