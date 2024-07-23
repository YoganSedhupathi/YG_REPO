<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Referral Report</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String userId=(String)session.getAttribute("LOGIN_ID");
%>
<body>
	<div class="clearfix"></div>
	<div class="col-md-12 col-sm-12 mpZero marTp">
			<div class="col-md-12 panelOrange hcH" >
					<div class="subHe">Incentive Reports</div>
					<div class="col-md-12 col-sm-12 mpZero">
						<div  class="col-md-6 col-sm-6 mpZero">		
						<div class="form-group mbotto">
							<div class="col-md-2"><label>Type</label></div>
							<div class="col-md-10">
							<select class="form-control" id="rpttype" onchange="changeReportType()">
								<option value="REF">Referral (rs.)</option>
								<option value="REP">Reporting</option>
								<option value="STF">Staff Incentive</option>
							</select>
							</div>
						</div>
						</div>
						<div  class="col-md-6 col-sm-6 mpZero" id="doctorcont" style="display:none">		
						<div class="form-group mbotto">
							<div class="col-md-2"><label>Doctor</label></div>
							<div class="col-md-10"><input type="text" class="form-control" id="doctorname"/><input type="hidden" class="form-control" id="doctorcode" value="0"/></div>
						</div>
						</div>						
					</div>
					<div class="col-md-12 col-sm-12 mpZero">
						<div  class="col-md-6 col-sm-6 mpZero">		
						<div class="form-group mbotto">
							<div class="col-md-2"><label>From</label></div>
							<div class="col-md-10"><input type="text" class="form-control" id="fromdate"></div>
						</div>
						</div>	
						<div  class="col-md-6 col-sm-6 mpZero">		
						<div class="form-group mbotto">
							<div class="col-md-2"><label>To </label></div>
							<div class="col-md-10"><input type="text" class="form-control" id="todate"></div>
						</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12 mpZero" style="height:350px;overflow-y:auto">
						<table cellpadding=0 cellspacing=0 class="table">
						<thead>
							<tr>
								<td><input type="checkbox" id="selectall" onclick="selectAllBU()"/>&nbsp;Select</td>
								<td>BUU Name</td>
							</tr>
						</thead>
						<tbody id="bulist">
							
						</tbody>
						</table>
					</div>
					<div class="clearfix"></div>	
	            	<div id="actButton" class="col-md-12 text-right">
	            		<button id="btnGen" class="btn btn-primary priBut" type="button" onclick="reportGo('SUM')">Summary</button>
	                	<button id="btnGo" class="btn btn-primary priBut" type="button" onclick="reportGo('BUID')">Item Detail</button>
	                	<button id="btnDetailGo" class="btn btn-primary priBut" type="button" onclick="reportGo('BUD')">BU Detailed</button>
	                	<button id="btnItemDetailGo" class="btn btn-primary priBut" type="button" onclick="reportGo('BUDD')">BU Item Detailed</button>
	            	</div>
			</div>
	</div>
	<script>
	 var ajaxObj=new FlexUI.Ajax();
 	
	
	$("#doctorname").autocomplete({
		source: function(request,response){
		   var rdata=[];
			var doctors=ajaxObj.callAjax("GET","/waggle/service/ajax","ic=0&ro=true&id=doctors&F1="+$('#doctorname').val());
			for(var i=0;i<doctors.data.length;i++){
				rdata.push({"id":doctors.data[i].dr_code,"label":doctors.data[i].dr_name,"value":doctors.data[i].dr_name});
			}		
			response(rdata);
		},
		minLength: 0,
		select: function( event, ui ) {
			this.value=ui.item.label;
			$("#doctorcode").val(ui.item.id);
		},messages : {
	      	noResults : 'No results found.',
	      	results : function(count) {
	        	return count + (count > 1 ? ' results' : ' result ') + ' found';
	      	}
    	},
		change: function (event, ui) {
            $("#doctorname").val(ui.item ? ui.item.label : "");
            $("#doctorcode").val(ui.item ? ui.item.id : "0");
        }
	});
	function loadBUInfo(){
		var ajaxObj=new FlexUI.Ajax();
		var bData=ajaxObj.callAjax("GET","/waggle/service/ajax","ic=0&ro=true&id=businessunits&unittypes=1");
		var buData=bData.data;
 		$('#bulist').children().remove();
 		for(var i=0;i<buData.length;i++){
 			var tr=$("<tr></tr>");
 			tr.append('<td><input type="checkbox" bucode="'+buData[i].bum_code+'"/></td>');
 			tr.append('<td>'+buData[i].bum_buname+'</td>');
 			$('#bulist').append(tr);
 		}
 		changeReportType();
	}
	$('#fromdate').datepicker({
		dateFormat:'dd/mm/yy'
	});
	if($('#fromdate').val()==""){
		var cd=new Date();
		$('#fromdate').datepicker("setDate",cd);
	}
	$('#todate').datepicker({
			dateFormat:'dd/mm/yy'
	});			
	if($('#todate').val()==""){
		var cd=new Date();
		$('#todate').datepicker("setDate",cd);
	}
    function reportGo(rptform){
    	var url="";
    	var checkedInputs=$('#bulist').find('input:checked');
    	if(checkedInputs.length==0){
    		alert("Please select atleast one BU");
    		return;
    	}
    	var bulist="";
    	for(var i=0;i<checkedInputs.length;i++){
    		if(i==0){
    			bulist=$(checkedInputs[i]).attr("bucode");
    		}else{
    			bulist=bulist+","+$(checkedInputs[i]).attr("bucode");
    		}
    	}
    	var expname=$('#rpttype').val()+"_"+$('#fromdate').val()+"_TO_"+$('#todate').val();
    	if($('#doctorname').val().trim()!=""){
    		expname=expname+"_"+$('#doctorname').val().replace(new RegExp(',', 'g'),'');
    	}
		url="/waggle/service/account/incentive?exportname="+encodeURI(expname.replace(new RegExp(' ', 'g'),'_'))+"&rpttype="+$('#rpttype').val()+"&rptform="+rptform+"&bus="+bulist+"&doctorcode="+$('#doctorcode').val()+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val();
		window.open(url,"_blank");		
	}
	function changeReportType(){
		if($('#rpttype').val()=="STF"){
			$('#doctorcont').css("display","none");
			$('#doctorname').val("");
			$('#doctorcode').val("0");
		}else{
			$('#doctorcont').css("display","inline-block");
			$('#doctorname').val("");
			$('#doctorcode').val("0");			
		}
	}
	function selectAllBU(){
		if($('#selectall').is(':checked')){
			$('#bulist').find('input').prop("checked",true);
		}else{
			$('#bulist').find('input').prop("checked",false);
		}
	}
	loadBUInfo();
  </script>
</body>
</html>