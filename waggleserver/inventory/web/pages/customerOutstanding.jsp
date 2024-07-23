<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Receivables</title>
</head>
<body>

  <div class="card border-0 shadow">
		<div class="card-body lpage" >
			<div class="row w-100" >
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Receivables</h4>
				</div>
				<div  class="col-md-6 text-right" id="addGrp"></div>
				<div  class="col-md-6 text-right" id="saveGrp" style='display:none'>
					<div class="mb-3">
						<button type="button" class="btn btn-edit" onclick='onSaveClicked()'><span class="mdi mdi-check-circle-outline me-2"></span>Save</button>
						<button type="button" class="btn btn-clear mx-3" onclick='hideMasterData()'><span class="mdi mdi-refresh me-2"></span>Cancel</button>
					</div>
				</div>
			</div>
			
			<div class="row " id="jqcontainer" ><div class="table-container" ><div id="xyz" class="w-100"></div></div></div>	
			<div id="callback" style="display:none" >
				<div class="col-sm-12 col-md-12 col-lg-12 mTBx1">                    
					<div id="group1" class="panelOrange hcH">
			</div></div>
			<div class="col-sm-12 col-md-12 col-lg-12 mTBx1">
				<div id="group2" class="panelOrange hcH">
			</div></div>
			<div class="col-sm-12 col-md-12 col-lg-12 mTBx1">
				<div id="group3" class="panelOrange hcH">
			</div></div>
			
			</div>
		</div>
		</div>



<script>
  jqReport(610003,"#xyz");
  function toggleHeaderRow(){
  	toggleSearchToolBar("610003");
  }
  toggleHeaderRow();
  function loadOrderData(link){
  	$("#bodyContainer").load(link,onBillReceiptSuccess);
  }
  function onBillReceiptSuccess(){
  	var actions=new FlexUI.Actions(610001,'addGrp','saveGrp');
	actions.buildActions();									  	  	
  }
</script> 
</body>
</html>