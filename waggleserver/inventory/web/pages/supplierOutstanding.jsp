<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Vendor Payables</title>
</head>
<body>



<div class="card border-0 shadow">
  <div class="card-body lpage" >
    <div class="row w-100 mb-3" >
      <div class="col-md-6 d-flex align-items-center">
        <h4 class="header-title">Vendor Payables</h4>
      </div>
      <div  class="col-md-6 text-right" id="addGrp">
        	
      </div>
      
    </div>
    <div class="row " id="jqcontainer" ><div class="table-container"><div id="xyz" class="w-100"></div></div>
  </div>	
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
  jqReport(610004,"#xyz");
  function toggleHeaderRow(){
  	toggleSearchToolBar("610004");
  }
  toggleHeaderRow();
  function loadOrderData(link){
  	$("#bodyContainer").load(link,onBillPaymentSuccess);
  }
  function onBillPaymentSuccess(){
  	var actions=new FlexUI.Actions(610002,'addGrp','saveGrp');
	actions.buildActions();  	  	
  }
</script> 
</body>
</html>