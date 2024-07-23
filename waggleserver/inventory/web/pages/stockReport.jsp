<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Stock Report</title>
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
    
	<div class="card border-0">
		<div class="card-body">
			<div class="row w-100">
				<div class="col-md-3 d-flex align-items-center">
					<h4 class="header-title"><%=rptTitle%></h4>
				</div>
			
				<div class="col-md-9">
					<div class="row">
					<%if(!rptId.equals("710011")){%>
					<div id="datefilc" class="col-md-4 d-flex h-30" >
						<div class="input-group">
							<span class="input-group-text">From</span>
							<input id="fromDate" name="fromDate" inputType="date"  type="text" mandatory="1" readonly class="form-control"/>
							<span class="input-group-text">To</span>
							<input id="toDate" name="toDate" inputType="date"  type="text" mandatory="1" readonly class="form-control"/>
							<button type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button>
						</div>
					</div>
					<%}else{%>
					<div id="ordfilc" class="col-md-5 h-30" style="display:none;">

							<span class="input-group-text">Location</span>
							<select id="location" name="location" class="form-control" onchange="reportGo('<%=rptId%>')"/></select>

					</div>
					<%}%>
					</div>
				</div>
			</div>
			
			<div class="row" id="jqcontainer" ><div class="table-container" ><div id="rep" class="w-100"></div></div></div>
		</div>
		</div>
	</div>






	


<script>
		$('#fromDate').datepicker({format:'dd/mm/yy'});			
		if($('#fromDate').val()==""){
			var cd=new Date();
			$('#fromDate').datepicker("setDate",cd);
		}
		$('#toDate').datepicker({format:'dd/mm/yy'});			
		if($('#toDate').val()==""){
			var cd=new Date();
			$('#toDate').datepicker("setDate",cd);
		}




<%if(rptId.equals("710011")){%>
	var l=new FlexUI.Ajax();
	var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=userbranch");
	var branches=v.data;
	if(branches!=null){
		var s=branches.length;
		$('#branch').children().remove();
		for(var j=0;j<s;j++){
			$('#branch').append("<option value='"+branches[j][1]+"'>"+branches[j][0]+"</option>");	
		}
	}
	v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=branchlocations&branch="+$('#branch').val());
	var locations=v.data;
	if(locations!=null){
		var s=locations.length;
		$('#location').children().remove();
		for(var j=0;j<s;j++){
			$('#location').append("<option value='"+locations[j][1]+"'>"+locations[j][0]+"</option>");	
		}
	}
	$('#stkReportTitle').css("display","block");
	showHideFilter();	
<%}else{%>
	$('#stkReportTitle').css("display","none");
<%}%>
<%if (fromdash!=null && fromdash.equals("true")){%>
	$('#spanClose').show();
<%}else{%>
	$('#spanClose').hide();
<%}%>
var params="";
<%if(rptId.equals("710011")){%>
	newParams="&branch="+$('#branch').val()+"&location="+$('#location').val();
<%}else{%>
	newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val();
<%}%>
jqReport(<%=rptId%>,"#rep",newParams);

function enableSearch(){
	toggleSearchToolBar(<%=rptId%>);
}
enableSearch();
function loadOrderData(link,name){
		$('#rep').hide();
		$('#filter').css("display","none");
		$('#dtfilter').css("display","none");
		$('#brdCr').css("display","none");
		$('#maincontent').show();
		$("#maincontent").empty();
		$('#maincontent').load(link+"&mode=VIEW");
}
function reportGo(id){
	showLoader();
	var newParams="";
	<%if(rptId.equals("710011")){%>
		$('#location').children().remove();
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=branchlocations&branch="+$('#branch').val());
		var locations=v.data;
		if(locations!=null){
			var s=locations.length;
			$('#location').children().remove();
			for(var j=0;j<s;j++){
				$('#location').append("<option value='"+locations[j][1]+"'>"+locations[j][0]+"</option>");	
			}
		}		
		newParams="&branch="+$('#branch').val()+"&location="+$('#location').val();;
	<%}else{%>
		newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val();
	<%}%>	
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
function closeReport(){
	$("#divDash").css("display","block");
	$("#reportcontent").css("display","none");
}
</script>        
</body>
</html>