<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Manufacture</title>
</head>
<body>

	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100 mb-3">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Manufacturer</h4>
				</div>
				<div  class="col-md-6 text-right" id="addGrp"></div>
				<div  class="col-md-6 text-right" id="saveGrp" style='display:none'>
					<div class="mb-3">
						<button type="button" class="btn btn-edit" onclick='onSaveClicked()'><span class="mdi mdi-content-save"></span>Save</button>
						<button type="button" class="btn btn-clear mx-3" onclick='hideMasterData()'><span class="mdi mdi-close-box"></span>Close</button>
					</div>
				</div>
			</div>
			
			<div class="row" id="jqcontainer"> <div class="table-container" > <div id="xyz" class="w-100" > </div></div></div>	
			<div id="callback" style="display:none" >	
				<div class="table-container">
					<div class="row w-100 ml-8">                    
						<div id="group1" class="row"></div>
					</div>
				</div> 
			</div>
		</div>
	</div>


<script>
  	var l=new FlexUI.Ajax();
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Brand/Marketer Details",height:40,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"manufacturername"},
  	{name:"manufacturername",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"status"},
  	{name:"mfrtype",inputType:1,type:"TEXT",caption:"Type",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"",keys:"Manufacturer~Marketing Company",values:"MFR~MKT"},
  	{name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"",keys:"Active~InActive",values:"Active~InActive"}
  	]
  	}]};
  var screenProps=changeScreenAttributes(110001,sProps);
  var manufacturerm=new FlexUI.Screen("manufacturer",screenProps);
  jqReport(11,"#xyz");

 
  
  
  function addMasterData(){ 
  	manufacturerm.clearScreen(); 
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
    $('#jqcontainer').css('display','none');
  	screenObjects.getScreenObject("manufacturername").focus();
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#history').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
	$('#jqcontainer').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("11");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var code=screenObjects.getScreenObject("code").getValue();
    if(code!="0" && code!=""){
    	manufacturerm.setOperation("EDIT");
    }
	var d=manufacturerm.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/manufacturer",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]" );
			manufacturerm.clearScreen();
			hideMasterData();
			reloadGrid("11");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/manufacturer";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
	var v=l.callAjax("GET",url,code);
	manufacturerm.loadData(v);
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
	$('#jqcontainer').css('display','none');
  	hideLoader();
  	screenObjects.getScreenObject("manufacturername").focus();
  }
</script> 
</body>
</html>