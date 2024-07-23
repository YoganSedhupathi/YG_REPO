<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Discharge History</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String rptId=request.getParameter("id");
String fromDate=request.getParameter("fromdate");
String toDate=request.getParameter("todate");
String reportTitle="Discharge History";
if("400017".equals(rptId)){
	reportTitle="Hospital Bill Detail";
}else if("400011".equals(rptId)){
	reportTitle="Admissions";
}else if("500016".equals(rptId) || "500017".equals(rptId)){
	reportTitle="Doctor Fees";
}
if(fromDate==null){
	fromDate="";
}
if(toDate==null){
	toDate="";
}
%>
<body>

	<div class="card border-0">
		<div class="card-body lpage">
			<div class="row w-100 mb-3">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title"><%=reportTitle%></h4>
				</div>
				<div  class="col-md-6 d-flex text-right" id="addGrp">
						<div class="col-md-7">
							<div class="input-group">
								<span class="input-group-text">From</span>
								<input id="fromDate" name="fromDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
								<span class="input-group-text">To</span>
								<input id="toDate" name="toDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
								<button type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button>
							</div>
						</div>
						<div class="col-md-5">
							<button type="button" class="btn btn-clear" onclick='toggleHeaderRow()'><span class="mdi mdi-filter-variant">Search</span></button>	
						</div>
					
				</div>

			</div>
			<div class="row " id="jqcontainer" ><div class="table-container" ><div id="xyz" class="w-100"></div></div></div>

		</div>
	</div>





	
   
	
	
	<div id='printdlg' class='pop_lov_box' style="display:none">
			<div id='printtitle' class='pop_lov_hed_box'>
			<div class='pop_lov_clos'>
				<a href='#'>
					<span class='fa fa-times-circle'>
					</span>
				</a>
			</div>
			<div class='pop_lov_hed_txt'><span id="ipno"></span></div>
			</div>
			<div id='printd' class='pop_lov_inp_box'>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Summary</label></div>
						<div class="col-md-8"><input type="checkbox" class="form-control" id="printsummary" checked disabled></div>
					</div>
					</div>
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Investigation</label></div>
						<div class="col-md-8"><input type="checkbox" class="form-control" id="printlabs"></div>
					</div>
					</div>
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Pharmacy</label></div>
						<div class="col-md-8"><input type="checkbox" class="form-control" id="printpharmacy"></div>
					</div>
					</div>
				</div>
				<div id="actButton" class="col-md-12 text-right">
                	<button id="btnPrint" class="btn btn-primary priBut" type="button" onclick="printDischarge()">Print</button>
	                <button id="btnCancel" class="btn btn-default" type="button" onclick="cancelPrintDlg()">Cancel</button>
            	</div>
			</div>
	</div>
	<script>
	var newParams="";

	$('#fromDate').datepicker({
				 language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy'
		});
	$('#toDate').datepicker({
				 language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy'
		});
	
	if($('#fromDate').val()==""){
		if("<%=fromDate%>"==""){	
			var cd=new Date();
			$('#fromDate').datepicker("setDate",cd);
		}else{
			$('#fromDate').val("<%=fromDate%>");
		}
	}
			
	if($('#toDate').val()==""){
		if("<%=toDate%>"==""){
			var cd=new Date();
			$('#toDate').datepicker("setDate",cd);
		}else{
			$('#toDate').val("<%=toDate%>");
		}
	}
 	loadBranchData();	
 	newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&branchcode="+$('#branch').val();
	jqReport(<%=rptId%>,"#xyz",newParams);
	showCSVExportButton(<%=rptId%>,newParams);
    $(document).ready(function () {
            $('#subtitle').text("");
            $('#screentitle').text("Bills");
     });
  	function toggleHeaderRow(){
  		toggleSearchToolBar(<%=rptId%>);
  	}
  
  	toggleHeaderRow();
  	
  	function reportGo(id){
		showLoader();
		var newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&branchcode="+$('#branch').val();
		changeUrlAndReloadGrid(id,"",newParams);
		showCSVExportButton(id,newParams);
		hideLoader();
	}
    function loadOrderData(url,colname,did){
	  	var rowData=$("#report_<%=rptId%>").getRowData(did);
	  	if(colname=="Print"){
	  		if(<%=rptId%>==500017){
	  			printProfessionalPDF(rowData.branchcode,rowData.drcode);
	  		}else{
		  		/*$('#printdlg').dialog({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:600,position:'center'});
				$('#printdlg').dialog('open');
				$('#printdlg').data("row",rowData);
				$('#ipno').text(rowData.dh_patient_no);*/
				printDischarge(rowData);
			}					
	    }else if(colname=="Pay"){
	    	var fDate=$('#fromDate').val();
			var tDate=$('#toDate').val();	    
	    	$('.ui-dialog').children().remove();
			$('.ui-dialog').remove();
			$("#bodyContainer").children().remove();
			$("#bodyContainer").html("");
			$("#bodyContainer").load("/waggle/professionalPayments.do?screencode=500015&mode=Pay&branch="+rowData.branchcode+"&doctorcode="+rowData.drcode+"&doctorname="+escape(rowData.doctorname)+"&fromdate="+fDate+"&todate="+tDate,onSuccess);	  					    
	    }else{
	    	var fDate=$('#fromDate').val();
			var tDate=$('#toDate').val();	    
	    	$('.ui-dialog').children().remove();
			$('.ui-dialog').remove();
			$("#bodyContainer").children().remove();
			$("#bodyContainer").html("");
			$("#bodyContainer").load("/waggle/discharge.do?id=<%=rptId%>&mode=View&branch="+rowData.dh_branchcode+"&dhno="+rowData.dh_no+"&fromdate="+fDate+"&todate="+tDate,onSuccess);	  				
	    }
	 }
	 function printDischarge(rowData){
	    //var rowData=$('#printdlg').data("row");
	    var printSummary=$('#printsummary').prop("checked")?"1":"0";
	    var printLab=$('#printlabs').prop("checked")?"1":"0";
	    var printPharmacy=$('#printpharmacy').prop("checked")?"1":"0";
 		var data;
		$.ajax({
            url: "/waggle/service/discharge/print?branchcode="+rowData.dh_branchcode+"&code="+rowData.dh_no,
            type: "GET",
            async: false,
            contentType:"application/json",
            dataType: "json",
            success: function (r) {
				data=r;		
            }
        });
        data["type"]="DLBILL";			
		data["address1"]="27,Javulikara Street";
		data["address2"]="Tiruvarur - 610 001";
		data["address3"]="Phone - 242292,240292";
		data["id"]="<%=rptId%>";	
		data["summary"]=printSummary;
		data["labs"]=printLab;
		data["pharmacy"]=printPharmacy;
		data["printdod"]="1";
		data["printdodtime"]="0";
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
        cancelPrintDlg();
	 }
	 function cancelPrintDlg(){
	 	$('#printdlg').removeData('row');
	 	$('#printdlg').dialog('close');
		$('#printdlg').dialog('destroy');	 	
	 }
	 function printProfessionalPDF(branchcode,code){
			var url="/waggle/service/account/printmonthlydoctorfee?branchcode="+branchcode+"&code="+code+"&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val();
			window.open(url,"_blank");
	 }
  </script>
</body>
</html>