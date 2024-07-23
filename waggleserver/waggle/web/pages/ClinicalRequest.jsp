<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
%>
<body>
	<div class="clearfix"></div>
	<div id="branchcontainer" class="brTp" style="display:block;z-index:999">
		<select class="form-control" id='branch' onchange="changeBranchCodeAndClearSubScreenData()"></select>
    </div>
    <div class="col-sm-12 col-md-12 col-lg-12 mpZero marTp">
    	<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
			Clinical Request
		<div id="addGrp" class="btn-group pull-right">
		<div class="btn-group pull-right" id="actionicons">
			<button onclick="toggleHeaderRow()" class="btn btn-sm seaColB"><i class="fa fa-search"></i></button>
		</div>
		</div>
	</div>    
	<div class="col-md-12 col-sm-12 mpZero">
		<div class="col-md-12 col-sm-12 mpZero marTp" id="xyz">
		
		</div>
		<div class="col-md-12 col-sm-12 mpZero" id="callback" style="display:none"></div>
	</div>
	<script>
 	loadBranchData();	
	jqReport(15,"#xyz","&branchcode="+$('#branch').val());
    $(document).ready(function () {
            $('#subtitle').text("");
            $('#screentitle').text("Clinical Request");
     });
  	function addMasterData(){ 
	  	$('#callback').css('display','block');
  		$('#xyz').css('display','none');
  		$('#addGrp').css('display','none');
  	}
  
  	function hideMasterData(){
  		$('#callback').css('display','none');
  		$('#xyz').css('display','block');
  		$('#addGrp').css('display','block');
  		$('#callback').removeData('row');  		
  		$('#subtitle').text("");
  		$('#screentitle').text("Clinical Request");
  		reloadGrid(15);
  	}
    
  	function toggleHeaderRow(){
  		toggleSearchToolBar(15);
  	}
  
  	toggleHeaderRow();
  
	  function loadOrderData(url,code,did){
	  	var rowData=$("#report_15").getRowData(did);
	  	$('#callback').data('row',rowData);
	  	$('#callback').data('url',"opbill.do?showTender=0&screencode=20");
	  	$('#callback').load("opbill.do?showTender=0&screencode=20");
	  	$('#callback').css('display','block');
	  	$('#xyz').css('display','none');
	  	$('#addGrp').css('display','none');
	  }
  </script>
</body>
</html>