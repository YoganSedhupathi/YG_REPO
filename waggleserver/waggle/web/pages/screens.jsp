<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title></title>
</head>
<body>
	<script>
		<%
	String screencode=(String)request.getParameter("screencode");
	String rptTitle=(String)request.getParameter("title");
		%>
	</script>

<div class="card border-0 shadow">
<div class="card-body lpage fsize">
	<div class="row w-100 mb-3">
		<div class="col-md-6 d-flex align-items-center">
            <h4 class="header-title"><%=rptTitle%></h4>
        </div>
		<div  class="col-md-6 text-right" id="addGrp"></div>
		<div  class="col-md-6 text-right" id="saveGrp" style='display:none'>
			<div class="mb-3">
				<button type="button" class="btn btn-edit" onclick='onSaveClicked()'><span class="mdi mdi-check-circle-outline me-2"></span>Save</button>
				<button type="button" class="btn btn-clear mx-3" onclick='hideMasterData()'><span class="mdi mdi-refresh me-2"></span>Cancel</button>
			</div>
		</div>
	</div>
	<div class="row " id="jqcontainer" >
	  <div class="table-container" >
	     <div id="xyz" class="w-100"></div>
	  </div>
	</div>	

	 <div id="callback" style="display:none" >	
		
	</div>
</div>
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
	$('#jqcontainer').css('display','none');
  	$('#xyz').css('display','none');
  }
  
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#history').css('display','none');
  	$('#addGrp').css('display','block');
	$('#jqcontainer').css('display','block');
  	$('#xyz').css('display','block');
  }
    
  function toggleHeaderRow(){
  	toggleSearchToolBar(<%=screencode%>);
  }
  
  toggleHeaderRow();
  
  function onSaveClicked(id,me){
		var r=masters.saveData();
		var code=screenObjects.getScreenObject("code").getValue();
		if(r.result=="Success"){
			if(code!=0){
				setErrorMessage(r.message+" [No:"+code+"]")   ;
			}else{
				setErrorMessage(r.message+" [No:"+r.code+"]") ;
			}
			masters.clearScreen();
			hideMasterData();
			reloadGrid(<%=screencode%>);
			return r.key;			
		}else{
			setErrorMessage(r.message);
			// setErrorMessage("The Value you entered is already in use. Please try a different value");		
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
	$('#jqcontainer').css('display','none');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	hideLoader();
  }
  function branchValidation(){
  	return true;
  }
//   $('input[type=text]').tooltip({
//   	trigger:"focus"
//   });
</script> 
</body>
</html>