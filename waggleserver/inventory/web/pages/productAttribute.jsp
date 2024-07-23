<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Group Attribute Values</title>
</head>
<body>
<div class="col-sm-10 col-md-10 col-lg-10 mpZero"><h1>Product Groups</h1><ol class="breadcrumb mpZero"><li><a href="#">Home</a></li><li><a>Master</a></li><li class="active breaCSel"><strong>Product Groups</strong></li></ol></div>
<!--add and search-->
<div class="col-sm-2 col-md-2 col-lg-2 mpZero marTp" id='addGrp'>
</div>
<!-- JQ grid starts-->
<div style="width:100%;float:left">
<div id="xyz" style='position:relative;border:0px;display:block;' class="mTBx"></div>			    	 
<div id="callback" style="display:none" >
<div class="col-sm-12 col-md-12 col-lg-12 mTBx">                    
    <div id="group1" class="panelOrange hcH">
   </div></div>
   <div class="clearfix"></div>
</div>
<!-- JQ grid ends-->
</div>
<div class="clearfix"></div>   
<div id="saveGrp" style='display:none' class="mTBx">
<span>
<button type="button" class="btn btn-primary mRhAj" onclick='onSaveClicked()'>Save</button>
<button type="button" class="btn btn-default" onclick='hideMasterData()'>Cancel</button>
</span>
</div>

<!-- JQ grid ends-->
</div>
<script>
  	var l=new FlexUI.Ajax();
    var sProps={title:{height:100,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"js/validations/productattribute.js",screen:[
  	{name:"group1",title:"Attribute Details",height:40,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"productname"},
  	{name:"groupname",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"attributename",lovOptions:{url:"/inventory/service/ajax",ajax:"productgroup",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"pgcode",ft:true,src:"groupname"}],results:[{tgt:"groupname",tt:true,id:"1"},{tgt:"groupname",tt:false,id:"0"}]}},
  	{name:"attributename",inputType:0,type:"LOV",caption:"Attribute Name",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"value",lovOptions:{url:"/inventory/service/ajax",ajax:"groupattribute",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"pgcode",ft:true,src:"groupname"}],results:[{tgt:"attributename",tt:true,id:"0"},{tgt:"attributename",tt:false,id:"1"}]}},
  	{name:"value",inputType:0,type:"TEXT",caption:"Value",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"status"},
  	{name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"attributes_data",keys:"Active~InActive",values:"Active~InActive"}
  	]
  	}]};
  var screenProps=changeScreenAttributes(110017,sProps);
  var productav=new FlexUI.Screen("groupattribute",screenProps);
  jqReport(10,"#xyz");
  function addMasterData(){ 
  	productav.clearScreen(); 
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
  	toggleSearchToolBar("10");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var code=screenObjects.getScreenObject("code").getValue();
    if(code!="0" && code!=""){
    	productav.setOperation("EDIT");
    }
	var d=productav.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		var r=s.callAjax("POST","/inventory/service/productattribute",d);
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			productav.clearScreen();
			hideMasterData();
			reloadGrid("10");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  function closeError(){
	$("#errorContainer").fadeOut();
  }
  function setErrorMessage(err){
	$("#error-message").html(err);
	if(!$("#error").is(":visible")){
		runEffect();
	}
  }
  function runEffect() {
	$("#errorContainer").show();
  }
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/productattribute";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
	var v=l.callAjax("GET",url,code);
	productav.loadData(v);
	screenObjects.getScreenObject('groupname').setEnabled(false);
	screenObjects.getScreenObject('attributename').setEnabled(false);
	screenObjects.getScreenObject('value').setEnabled(false);
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  }
</script> 
</body>
</html>