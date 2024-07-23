<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Conversion Master</title>
</head>
<body>
<div class="col-sm-10 col-md-10 col-lg-10 mpZero"><h1>Conversion Master</h1><ol class="breadcrumb mpZero"><li><a href="#">Home</a></li><li><a>Master</a></li><li class="active breaCSel"><strong>Conversion Master</strong></li></ol></div>
	
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
    <div id="conversionvalue" class="panelOrange hcH" style="height:200px;">
   </div></div>
</div>
<!-- JQ grid ends-->
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
  	{name:"group1",title:"Unit Group Details",pcolumns:2,height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{colno:1,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"name"},
  	{colno:0,name:"name",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"baseunit"},
  	{colno:1,name:"baseunit",inputType:0,type:"LOV",caption:"Base Unit",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"conversionvalue_data",lovOptions:{url:"/inventory/service/ajax",ajax:"unitmaster",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  	]
  	},{name:"conversionvalue",title:"Conversion Details",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,optional:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "unit", name: "Unit", field: "location",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,"chkTag":true,lovOptions:{url:"/inventory/service/ajax",ajax:"unitmaster",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
    {order:"2",id: "conversionvalue", name: "Conversion Value", field: "ptax",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":99999999.99999999,"textLength":17,"decimalLength":8,"visible":true,"readOnly":false,"mandatory":false,width:150}
    ]
    }}]};
  var screenProps=changeScreenAttributes(110011,sProps);
  var conversion=new FlexUI.Screen("conversionmaster",screenProps);
  jqReport(110011,"#xyz");
  function addMasterData(){ 
  	conversion.clearScreen(); 
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
  	toggleSearchToolBar("110011");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var cid=screenObjects.getScreenObject("code").getValue();
    if(cid!="0" && cid!=""){
    	conversion.setOperation("EDIT");
    }
	var d=conversion.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		var r=s.callAjax("POST","/inventory/service/unitconversion",d);
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			conversion.clearScreen();
			hideMasterData();
			reloadGrid("110011");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/unitconversion";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
	var v=l.callAjax("GET",url,code);
	conversion.loadData(v);
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	screenObjects.getScreenObject("name").focus();
  }
</script> 
</body>
</html>