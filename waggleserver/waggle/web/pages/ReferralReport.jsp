<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Referral Report</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String userId=(String)session.getAttribute("LOGIN_ID");
String rptType=request.getParameter("type");
String reportName="";
if(rptType.equals("REFERRAL")){
	reportName="Referral Report";
}else if(rptType.equals("PHRCORP")){
	reportName="Pharmacy Corporate Detail";
}
%>
<body>
	<div class="clearfix"></div>
	<div class="col-md-12 col-sm-12 mpZero marTp">
			<div class="col-md-12 panelOrange hcH" >
					<div class="subHe"><%=reportName%></div>
					<div class="col-md-12 col-sm-12 mpZero">
						<div  class="col-md-3 col-sm-3 mpZero" id="doctorcont" style="display:none">		
						<div class="form-group mbotto">
							<div class="col-md-2"><label>Doctor</label></div>
							<div class="col-md-10"><input type="text" class="form-control" id="doctorname"/><input type="hidden" class="form-control" id="doctorcode" value="0"/></div>
						</div>
						</div>
						<div  class="col-md-3 col-sm-3 mpZero">		
						<div class="form-group mbotto">
							<div class="col-md-2"><label>From</label></div>
							<div class="col-md-10"><input type="text" class="form-control" id="fromdate"></div>
						</div>
						</div>	
						<div  class="col-md-3 col-sm-3 mpZero">		
						<div class="form-group mbotto">
							<div class="col-md-2"><label>To </label></div>
							<div class="col-md-10"><input type="text" class="form-control" id="todate"></div>
						</div>
						</div>
					</div>
					<div class="clearfix"></div>	
	            	<div id="actButton" class="col-md-12 text-right">
	            		<button id="btnGen" class="btn btn-primary priBut" type="button" onclick="runReport()" style="display:none">Generate</button>
	                	<button id="btnGo" class="btn btn-primary priBut" type="button" onclick="reportGo()">Summary</button>
	                	<button id="btnDetailGo" class="btn btn-primary priBut" type="button" onclick="reportDetailGo()" style="display:none">Detail</button>
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
	/*function loadDoctorData(){
		var ajaxObj=new FlexUI.Ajax();
		var bData=ajaxObj.callAjax("GET","/waggle/service/ajax","ic=0&id=doctors");
		var userData=bData.data;
 		var docCode=1;
 		var docName=0;
 		$('#doctorname').children().remove();
 		$('#doctorname').append("<option value='0'>All</option>");
 		for(var i=0;i<userData.length;i++){
 			var usr=$("<option value='"+userData[i][docCode]+"'>"+userData[i][docName]+"</option>");
 			$('#doctorname').append(usr);
 		}
	}*/
	<%if(rptType.equals("REFERRAL")){%>
		//loadDoctorData();	
		$('#doctorcont').css("display","block");
		$('#btnGen').css("display","inline-block");
		$('#btnDetailGo').css("display","inline-block");
	<%}else{%>
		$('#btnGo').text("Go");
	<%}%>
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
	function runReport(){
		 var s=new FlexUI.Ajax();
		 showLoader();
		 var data={};
		 data["screencode"]="22";
		 data["operation"]="ADD";
		 data["savedata"]={};
		 data["savedata"]["fromdate"]=$('#fromdate').val();
		 data["savedata"]["todate"]=$('#todate').val();
		 var d="data="+JSON.stringify(data);
		 r=s.callAjax("POST","/waggle/service/screen/save",d);
		 hideLoader();
		 if(r.result=="Success"){
			alert(r.message);
		}else{
			alert(r.message);		
		}
    }
    function reportGo(){
    	var url="";
    	if("<%=rptType%>"=="REFERRAL"){
			url="/waggle/service/account/referralsummary?fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val();
		}else if("<%=rptType%>"=="PHRCORP"){
			url="/waggle/service/account/pharmacycorp?fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val();
		}
		window.open(url,"_blank");		
	}
	function reportDetailGo(){
		var url="/waggle/service/account/referraldetail?doctorcode="+$('#doctorcode').val()+"&doctorname="+$('#doctorname').val()+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val();
		window.open(url,"_blank");
	}
  </script>
</body>
</html>