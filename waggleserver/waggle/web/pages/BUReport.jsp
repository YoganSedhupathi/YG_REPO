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

	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">BU Report</h4>
				</div>
			</div>
			
			<div class="row " id="jqcontainer" style="display:none"> <div class="table-container" > <div id="xyz" class="w-100"></div></div></div>	
			<div id="callback"  >
				
			<div class="table-container">
				<div class="row w-100 ml-8">
					<div class="col-sm-6 col-md-6 col-lg-6">                    
						<div class="form-group mbotto">
							<div class="col-md-2"><label>BU</label></div>
							<div class="col-md-10"><select class="form-control" id="buname"></select></div>
						</div>

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
						<button id="btnGo" class="btn btn-primary priBut" type="button" onclick="reportGo()">Go</button>
					</div>
				  </div>
				</div>
			</div>	
			   
			</div>
		</div>
	</div>


	
	<script>
	loadBUData();

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
		var url="/waggle/service/account/generatebureport?bucode="+$('#buname').val()+"&buname="+$('#buname option:selected').text()+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val();
		window.open(url,"_blank");
		alert("url: " + url);
		alert("buname: " + $("#buname").val());
		alert("fromdate: " + $("#fromdate").val());
		alert("todate: " + $("#todate").val());

	}
  </script>
</body>
</html>