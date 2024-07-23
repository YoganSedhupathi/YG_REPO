<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Bin/Rack</title>
</head>
<body>
<div class="col-sm-10 col-md-10 col-lg-10 mpZero"><h1>Bin/Rack</h1><ol class="breadcrumb mpZero"><li><a href="#">Home</a></li><li><a>Master</a></li><li class="active breaCSel"><strong>Bin/Rack</strong></li></ol></div>
	
<!--add and search-->
<div class="col-sm-2 col-md-2 col-lg-2 mpZero marTp" id='addGrp'>
</div>
<div class="clearfix"></div>
<!-- JQ grid starts-->
<div id="xyz" style='position:relative;border:0px;display:block;' class="mTBx"></div>			    	 
<div id="callback" style="display:none" >
<div class="col-sm-12 col-md-12 col-lg-12 mpZero mTBx">   
    <div id="group1" class="panelOrange hcH">
   </div></div>
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpRes mTBx">
    <div id="rack" class="panelOrange hcH" style="height:265px;">
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
  	var rackKey="";
  	var rackKeyValue="";
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Bin Details",pcolumns:2,height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"productname"},
  	{colno:1,name:"branch",inputType:0,type:"LOV",caption:"Godown",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"norack",lovOptions:{url:"/inventory/service/ajax",ajax:"godown",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  	{colno:0,name:"groupname",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"branch"},
  	{colno:0,name:"pnorack",inputType:0,type:"INT",caption:"No Of Racks",mandatory:false,defaultValue:"0","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"status"},
  	{colno:0,name:"norack",inputType:0,type:"INT",caption:"No Of Racks",mandatory:false,defaultValue:"0","maxValue":10,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"status",validation:"validateNoOfRack"},
  	{colno:1,name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"rack_data",keys:"Active~InActive",values:"Active~InActive"}
  	]
  	},{name:"rack",title:"Rack Details",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{enableAddRow:false,enableDeleteRow:false,rowEmptyCheckColumn:2,optional:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "rackno", name: "Rack", field: "rackno",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,"chkTag":false},
    {order:"2",id: "name", name: "Rack Name", field: "name",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:250},
    {order:"3",id: "order", name: "Order", field: "order",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:50}
    ]
    }}]};
  var screenProps=changeScreenAttributes(110012,sProps);
  var binm=new FlexUI.Screen("bin",screenProps);
  jqReport(110012,"#xyz");
  function addMasterData(){ 
  	binm.clearScreen(); 
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	screenObjects.getScreenObject("groupname").focus();
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("110012");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var code=screenObjects.getScreenObject("code").getValue();
    if(code!="0" && code!=""){
    	binm.setOperation("EDIT");
    }
	var d=binm.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/binmaster",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			binm.clearScreen();
			hideMasterData();
			reloadGrid("110012");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/binmaster";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
	var v=l.callAjax("GET",url,code);
	binm.loadData(v);
	createRackRows(0);
	//screenObjects.getScreenObject("type").setEnabled(false);
		
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	hideLoader();
  	screenObjects.getScreenObject("groupname").focus();
  }
  function validateNoOfRack(id,me){
	var noOfRack=me.getValue();
	var pNo=screenObjects.getScreenObject("pnorack").getValue();
	if(pNo>noOfRack){
		alert("Cannot reduce the number of the Racks for the Binn");
		me.setValue(pNo);
		return false;
	}
	createRackRows(noOfRack);
	return true;
	}
	function createRackRows(noOfRack){
		var g=screenObjects.getScreenObject("rack_data");
		if(noOfRack==0){
			noOfRack=g.getSize();
		}
		for(var k=0;k<noOfRack;k++){
		
			if(g.getSize()==k){
			alert(k);
				g.addRow();
			}
//			g.getCell(k,1).getWidgetRef().setValue((k+1)+'');
//			g.getCell(k,1).getWidgetRef().getSelect().attr('disabled','disabled');
		}		
	}  
</script> 
</body>
</html>