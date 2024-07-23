<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Hamali</title>
</head>
<body>
<div class="col-sm-10 col-md-10 col-lg-10 mpZero"><h1>Hamali</h1><ol class="breadcrumb mpZero"><li><a href="#">Home</a></li><li><a>Master</a></li><li class="active breaCSel"><strong>Hamali</strong></li></ol></div>
	
<!--add and search-->
<div class="col-sm-2 col-md-2 col-lg-2 mpZero marTp" id='addGrp'>
</div>
<div class="clearfix"></div>
<!-- JQ grid starts-->
<div id="xyz" style='position:relative;border:0px;display:block;' class="mTBx"></div>			    	 

<div id="callback" style="display:none" >
	<div class="col-sm-12 col-md-12 col-lg-12 mTBx">                    
    	<div id="group1" class="panelOrange hcH">
   </div></div>
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12 mTBx">
    <div id="group2" class="panelOrange hcH">
   </div></div>
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

<script>
  	var l=new FlexUI.Ajax();
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Hamali Details",pcolumns:2,height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"name"},
  	{colno:1,name:"branch",inputType:0,type:"LOV",caption:"Branch",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"name",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  	{colno:0,name:"name",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"alias"},
  	{colno:1,name:"alias",inputType:0,type:"TEXT",caption:"Alias",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"address1"}
  	]
  	},{name:"group2",title:"Contact Details",pcolumns:2,height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[
  	{colno:0,name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"address2"},
  	{colno:1,name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"city"},
  	{colno:0,name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pincode"},
	{colno:1,name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"mobile"},
	{colno:0,name:"mobile",inputType:0,type:"TEXT",caption:"Mobile",mandatory:false,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"phone"},  
	{colno:1,name:"phone",inputType:0,type:"TEXT",caption:"Phone",mandatory:false,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"status"},
	{colno:0,name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"",keys:"Active~InActive",values:"Active~InActive"}
	]
  	}]};
  var screenProps=changeScreenAttributes(110009,sProps);
  var hamalim=new FlexUI.Screen("hamali",screenProps);
  jqReport(29,"#xyz");
  function addMasterData(){ 
  	hamalim.clearScreen(); 
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	screenObjects.getScreenObject("name").focus();
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#history').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("29");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var code=screenObjects.getScreenObject("code").getValue();
    if(code!="0" && code!=""){
    	hamalim.setOperation("EDIT");
    }
	var d=hamalim.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/hamali",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			hamalim.clearScreen();
			hideMasterData();
			reloadGrid("29");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/hamali";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
	var v=l.callAjax("GET",url,code);
	hamalim.loadData(v);
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	hideLoader();
  	screenObjects.getScreenObject("name").focus();
  }
</script> 
</body>
</html>