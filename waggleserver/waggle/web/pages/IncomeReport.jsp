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
String reportName="Income Statement - Daywise";
%>
<body>

	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title"><%=reportName%></h4>
				</div>
			</div>
			
			<div class="row " id="jqcontainer" style="display:none"> <div class="table-container" > <div id="xyz" class="w-100"></div></div></div>	
			<div id="callback"  >
				
			<div class="table-container">
				<div class="row w-100 ml-8">
					<div class="col-sm-6 col-md-6 col-lg-6">    

						<div class="form-group mbotto">
							<div class="col-md-2"><label>From</label></div>
							<div class="col-md-10"><input type="text" class="form-control" id="fromdate"></div>
						</div>
						<div class="form-group mbotto">
							<div class="col-md-2"><label>To </label></div>
							<div class="col-md-10"><input type="text" class="form-control" id="todate"></div>
						</div>

					</div>                    
					
				</div>
			   
			</div>

			<div class="row w-100 mt-3">
				<div class="col-md-3">
				  <div class="hstack justify-content-start">
					<div id="actButton">
						<button id="btnGo" class="btn btn-primary priBut" type="button" onclick="reportGo()">Summary</button>
					</div>
				  </div>
				</div>
			</div>	
			   
			</div>
		</div>
	</div>

	<script>
	$('#btnGo').text("Go");
	$('#fromdate').datepicker({
				 language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy'
		});
	if($('#fromdate').val()==""){
		var cd=new Date();
		$('#fromdate').datepicker("setDate",cd);
	}
	$('#todate').datepicker({
				 language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy'
		});		
	if($('#todate').val()==""){
		var cd=new Date();
		$('#todate').datepicker("setDate",cd);
	}
	function reportGo(){
		$.ajax({
		            url: "/waggle/service/account/bills/dayend?branch=1",
        		    type: "GET",
	        	    async: false,
	        	    contentType:"application/json",
		            dataType: "json",
        		    success: function (r) {
						
	            	}
        });
    	var url="";
		url="/waggle/service/account/incomestatement?fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val();
		window.open(url,"_blank");		
	}	
  </script>
</body>
</html>