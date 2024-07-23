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
	String showCSVExport=request.getParameter("showcsv");
    	if(fromdt!=null && !fromdt.equals("")){%>
    		$('#fromDate').val(fromdt);
    	<%}
    	if(todt!=null && !todt.equals("")){%>
			$('#toDate').val(todt);
		<%}
	%>

    </script>
    
        <div id="content" >
        
        	
			<!-- <div id="brdCr" class="col-sm-10 col-md-10 col-lg-10" style="display:block"><h1><%=rptTitle%></h1><ol class="breadcrumb mpZero"><li><a href="#">Home</a></li><li><a>Reports</a></li><li class="active breaCSel"><strong><%=rptTitle%></strong></li></ol></div> -->
			<div class="clearfix"></div>
			
			<div id="filter"  class="col-sm-15 col-md-15 col-lg-15 mpRhZ mTBx">
			
				<div class="panelOrange hcH">
				<span id="spanClose" class="pull-right right-btn" onclick="closeReport()" style="width:50px;text-align:right;"><b id="settingsBtn" class="fa fa-times-circle"></b></span>
				<div class="subHe" id="dtfilter" name="dtfilter" ><%=rptTitle%><span class="pull-right" onclick="showHideFilter()"><b class="fa fa-caret-down"></b></span></div>
  					<div id="divFirstFilter" >
	  					<div class="col-sm-4 col-md-4 col-lg-4 mpZero">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">From Date</label><div class="col-sm-7 mpRes"><input id="fromDate" name="fromDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control"/></div></div>
							<div class="clearfix"></div>
	  					</div>
		    			<div class="col-sm-4 col-md-4 col-lg-4">
		  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">To Date</label><div class="col-sm-7 mpRes"><input id="toDate" name="toDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control"/></div></div>
		  						<div class="clearfix"></div>
		  				</div>
		  				<div class="col-sm-3 col-md-3 col-lg-3">
		  					<%if(rptId.equals("710032")){%>
		  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">MFR</label><div class="col-sm-7 mpRes"><input type="hidden" id="mfrid"/><input type="text" id="mfrname" class="form-control"/></div></div>
							<%}else{%>
								<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">Marketed By</label><div class="col-sm-7 mpRes"><input type="hidden" id="mfrid"/><input type="text" id="mfrname" class="form-control"/></div></div>
							<%}%>						
		  						<div class="clearfix"></div>
		  				</div>
		  				<div class="col-sm-1 col-md-1 col-lg-1 mpZero">
		  					<div class="form-group extrBT"><button type="button" class="btn btn-primary mRhAj btn-sm" onclick="reportGo('<%=rptId%>')">Go</button>	
							</div>
					    </div>
					</div>
					 
  				</div>
      		</div>			
      				    
					    <script>
					    $('#fromDate').datepicker({format:'dd/mm/yyyy'});			
							if($('#fromDate').val()==""){
								var cd=new Date();
								$('#fromDate').datepicker("setDate",cd);
							}
							$('#toDate').datepicker({format:'dd/mm/yyyy'});			
							if($('#toDate').val()==""){
								var cd=new Date();
								$('#toDate').datepicker("setDate",cd);
							}
					    </script>
            <div id="rep" style='position:relative;border:0px;display:block;' class="mTBx">
            	<div class=""><span class="pull-right" style="margin-top:-50px" ><button class="btn btn-sm seaColB" onclick="enableSearch();"><i class="fa fa-search"></i></button></span></div>
				<div class="clearfix"></div>
        	</div>
        	<div id="maincontent" style="display:none">
        	
        	</div>
        </div>
        <div id="modifydlg" style="display:none">
		<div id="modcontent"></div>
		</div>
</div>
<script>
var params="";
newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&noofdays="+$('#noofDays').val();
jqReport(<%=rptId%>,"#rep",newParams);
if(<%=showCSVExport%>==1){
	showCSVExportButton(<%=rptId%>,newParams);
}
function enableSearch(){
	toggleSearchToolBar(<%=rptId%>);
}
enableSearch();

function reportGo(id){
	
	showLoader();
	var newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&noofdays="+$('#noofDays').val();
	changeUrlAndReloadGrid(id,params,newParams);
	showPDFExportButton(id,newParams);
	if(<%=showCSVExport%>==1){
		showCSVExportButton(id,newParams);
	}
	hideLoader();
}
 
<%if(rptId.equals("710032")){%>
	
	$("#mfrname").autocomplete({
			source: "/inventory/service/autocomplete?id=manufacturer",
			minLength: 0,
			select: function( event, ui ) {
				this.value=ui.item.label;
				$('#mfrid').val(ui.item.id);
				reportGo(<%=rptId%>);
			},messages : {
		      	noResults : 'No results found.',
		      	results : function(count) {
		        	return count + (count > 1 ? ' results' : ' result ') + ' found';
		      	}
	    	}
	});
<%}else{%>
	
	$("#mfrname").autocomplete({
			source: "/inventory/service/autocomplete?id=marketedby",
			minLength: 0,
			select: function( event, ui ) {
				this.value=ui.item.label;
				$('#mfrid').val(ui.item.id);
				reportGo(<%=rptId%>);
			},messages : {
		      	noResults : 'No results found.',
		      	results : function(count) {
		        	return count + (count > 1 ? ' results' : ' result ') + ' found';
		      	}
	    	}
	});

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

</script>        
</body>
</html>