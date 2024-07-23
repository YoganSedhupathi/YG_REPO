<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title></title>
</head>
<body>
<%
	String screencode=(String)request.getParameter("screencode");
%>
<!--add and search-->
<div class="col-sm-2 col-md-2 col-lg-2 mpZero marTp pull-right" id='addGrp'>
</div>
<div class="clearfix"></div>
<!-- JQ grid starts-->
<div id="xyz" style='position:relative;border:0px;display:block;'></div>			    	 
<div id="callback" style="display:none;">

</div>
<!-- JQ grid ends-->
<div id="saveGrp" style='display:none'>
<span>
<button type="button" class="btn btn-primary mRhAj" onclick='onSaveClicked()'>Save</button>
<button type="button" class="btn btn-default" onclick='hideMasterData()'>Cancel</button>
</span>
</div>

<script>
  var masters=new FlexUI.ConstructScreen(<%=screencode%>,"addGrp","","callback");
  masters.buildScreen();
  jqReport(<%=screencode%>,"#xyz");
  function addMasterData(){ 
  	masters.clearScreen();
  	masters.enableDisableOperatingFields("ADD");
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  }
  
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#history').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
  }
    
  function toggleHeaderRow(){
  	toggleSearchToolBar(<%=screencode%>);
  }
  
  toggleHeaderRow();
  
  function onSaveClicked(id,me){
		var r=masters.saveData();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			masters.clearScreen();
			hideMasterData();
			reloadGrid(<%=screencode%>);
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
  }
  
  function loadOrderData(url,code,did){
  	showLoader();
	masters.clearScreen();
	masters.enableDisableOperatingFields("EDIT");
	masters.setOperation("MOD");
	var l=new FlexUI.Ajax();
	var v=l.callAjax("GET",url,"&screencode=<%=screencode%>");	
	masters.loadScreen(v);
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	hideLoader();
  }
  function branchValidation(){
  	return true;
  }
</script> 
</body>
</html>