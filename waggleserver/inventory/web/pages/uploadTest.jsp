<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        
    </head>
    <body>
    <script>
    <%
    	String userId=(String)session.getAttribute("LOGIN_ID");
    	String rptId=request.getParameter("id");
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
    
        <div id="content" >
			<div class="clearfix"></div>
			<div id="filter" style="display:block" class="col-sm-15 col-md-15 col-lg-15 mpRhZ mTBx">
			
				<div class="panelOrange hcH">
				<span id="spanClose" class="pull-right right-btn" onclick="closeReport()" style="width:50px;text-align:right;"><b id="settingsBtn" class="fa fa-times-circle"></b></span>
				<div class="subHe" id="dtfilter" name="dtfilter" style="display: none"><%=rptTitle%><span class="pull-right" onclick="showHideFilter()"><b class="fa fa-caret-down"></b></span></div>
  					<div id="divFirstFilter" style="display:block">
  						<div class="col-sm-4 col-md-4 col-lg-4">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">Branch</label><div class="col-sm-7 mpRes"><select class="form-control" id="branch" onchange="loadBranchUserData()"></select></div></div>
	  					</div>  						
  						<div class="col-sm-4 col-md-4 col-lg-4">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">User</label><div class="col-sm-7 mpRes"><select class="form-control" id="username"></select></div></div>
	  					</div>
	  					<div class="col-sm-4 col-md-4 col-lg-4">
	  					</div>
	  					<div class="clearfix"></div>
	  					<div class="col-sm-4 col-md-4 col-lg-4">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">From Date</label><div class="col-sm-7 mpRes"><input id="fromDate" name="fromDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control"/></div></div>
	  					</div>
		    			<div class="col-sm-4 col-md-4 col-lg-4">
		  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">To Date</label><div class="col-sm-7 mpRes"><input id="toDate" name="toDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control"/></div></div>
		  				</div>
		  				<div class="col-sm-4 col-md-4 col-lg-4 mpZero">
		  					<div class="form-group extrBT"><button type="button" class="btn btn-primary mRhAj btn-sm" onclick="reportGo('<%=rptId%>')">Go</button><button type="button" class="btn btn-primary mRhAj btn-sm" onclick="printCurrentSession()">Print</button></div>	
					    </div>
					</div>   
  				</div>
      		</div>			
      				    
		    <script>
		    $('#fromDate').datetimepicker({
					timeFormat: 'hh:mm TT',
					dateFormat:'dd/mm/yy'
			});
			if($('#fromDate').val()==""){
				var cd=new Date();
				$('#fromDate').datetimepicker("setDate",cd);
			}
			$('#toDate').datetimepicker({
					timeFormat: 'hh:mm TT',
					dateFormat:'dd/mm/yy'
			});			
			if($('#toDate').val()==""){
				var cd=new Date();
				$('#toDate').datepicker("setDate",cd);
			}
		    </script>
            <div id="rep" style='position:relative;border:0px;display:block;' class="mTBx">
            	<div class=""><span class="pull-right" style="margin-top:-50px" ><button class="btn btn-sm seaColB" onclick="enableSearch();"><i class="fa fa-search"></i></button></span></div>
				<div class="clearfix"></div>
        	</div>
        </div>
<script>
function loadBranchData(){
	var ajaxObj=new FlexUI.Ajax();
	var bData=ajaxObj.callAjax("GET","/inventory/service/ajax","ic=0&id=userdefbranch,userbranch");
	var branchData=bData.data.userbranch;
	var defBranchData=bData.data.userdefbranch;
 	var branchCode=1;
 	var branchName=0;
 	var locationCode=6;
 	$('#branch').children().remove();
 	for(var i=0;i<branchData.length;i++){
 		var brn=$("<option value='"+branchData[i][branchCode]+"'>"+branchData[i][branchName]+"</option>");
 		brn.data("location",branchData[i][locationCode]);
 		$('#branch').append(brn);
 	}
 	$('#branch').val(defBranchData[0][branchCode]);
}
function loadBranchUserData(){
	var ajaxObj=new FlexUI.Ajax();
	var bData=ajaxObj.callAjax("GET","/inventory/service/ajax","ic=0&id=branchemployee&branch="+$('#branch').val());
	var userData=bData.data;
 	var empCode=2;
 	var empName=0;
 	$('#username').children().remove();
 	for(var i=0;i<userData.length;i++){
 		var usr=$("<option value='"+userData[i][empCode]+"'>"+userData[i][empName]+"</option>");
 		$('#username').append(usr);
 	}
}
loadBranchData();
loadBranchUserData();
var params="";
newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&empid="+$('#username').val()+"&branch="+$('#branch').val();
jqReport(<%=rptId%>,"#rep",newParams);

function enableSearch(){
	toggleSearchToolBar(<%=rptId%>);
}
enableSearch();
function reportGo(id){
	showLoader();
	var newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&empid="+$('#username').val()+"&branch="+$('#branch').val();
	changeUrlAndReloadGrid(id,params,newParams);
	hideLoader();
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
		printData["address1"]="27,Javulikara Street";
		printData["address2"]="Tiruvarur - 610 001";
		printData["address3"]="Phone - 242292,240292";		
		printData["empid"]=$('#username').val();
		printData["username"]=$('#username option:selected').text();
		printData["fromdate"]=$('#fromDate').val();
		printData["todate"]=$('#toDate').val();
		printData["login_id"]='<%=userId%>';
		printData["reportid"]='<%=rptId%>';
		printData["host"]='192.168.1.100:9090/inventory';
		printData["rows"]="52";
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