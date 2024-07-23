<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Product Generic</title>
</head>
<body>

	<div class="card border-0 shadow">
		<div class="card-body lpage" >
			<div class="row w-100" >
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Product Generic</h4>
				</div>
				<div  class="col-md-6 text-right" id="addGrp"></div>
				<div  class="col-md-6 text-right" id="saveGrp" style='display:none'>
					<div class="mb-3">
						<button type="button" class="btn btn-edit" onclick='onSaveClicked()'><span class="mdi mdi-check-circle-outline me-2"></span>Save</button>
						<button type="button" class="btn btn-clear mx-3" onclick='hideMasterData()'><span class="mdi mdi-refresh me-2"></span>Cancel</button>
					</div>
				</div>
			</div>
			
			<div class="row" id="jqcontainer" ><div class="table-container" ><div id="xyz" class="w-100"></div></div></div>	
			
			<div id="callback" style="display:none" >
							<div class="table-container">
				<div class="row w-100 ml-8">                    
					<div id="group1" class="row"></div>
				</div>
			   <div class="row w-100 ml-8">
					<div id="group2" class="row"></div>
			   </div>
			   <div class="row w-100 ml-8">
					<div id="group3" class="row"></div>
				</div>
			</div>
			   
			</div>
		</div>
		</div>


<script>
  	var l=new FlexUI.Ajax();
  	var rackKey="";
  	var rackKeyValue="";
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Generic",pcolumns:2,height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"genericname"},
  	{colno:0,name:"genericname",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"status"},
	  {colno:1,name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"1","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"",keys:"Active~InActive",values:"1~0"}
  	
  	]
  	}]};
  //var screenProps=changeScreenAttributes(110023,sProps);
  var generic=new FlexUI.Screen("generic",sProps);
  jqReport(110023,"#xyz");
  function addMasterData(){ 
  	generic.clearScreen(); 
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
	$('#jqcontainer').css('display','none');
  	screenObjects.getScreenObject("genericname").focus();
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
	$('#jqcontainer').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("110023");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var code=screenObjects.getScreenObject("code").getValue();
    if(code!="0" && code!=""){
    	generic.setOperation("EDIT");
    }
	var d=generic.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/product/generic",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			generic.clearScreen();
			hideMasterData();
			reloadGrid("110023");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/product/generic";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
	var v=l.callAjax("GET",url,code);
	generic.loadData(v);
		
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
	$('#jqcontainer').css('display','none');
  	hideLoader();
  	screenObjects.getScreenObject("genericname").focus();
  }
</script> 
</body>
</html>