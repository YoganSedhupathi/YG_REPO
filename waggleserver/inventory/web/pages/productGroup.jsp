<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Product Groups</title>
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
   <div class="col-sm-12 col-md-12 col-lg-12 mTBx1">
    <div id="group2" class="panelOrange hcH">
   </div></div>
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12 mTBx1">
    <div id="attributes" class="panelOrange hcH" style="height:200px;">
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

<!-- JQ grid ends-->
</div>


<script>
  	var l=new FlexUI.Ajax();
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Group Details",pcolumns:2,colcss:"col-sm-6 col-md-6 col-lg-6",height:40,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"productname"},
  	{colno:0,name:"groupname",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"type"},
  	{colno:1,name:"type",inputType:0,type:"LOV",caption:"Type",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"hasattribute",lovOptions:{url:"/inventory/service/ajax",ajax:"producttype",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  	]
  	},
  	{name:"group2",title:"Additional Details",pcolumns:2,colcss:"col-sm-6 col-md-6 col-lg-6",height:40,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{colno:0,name:"hasattribute",inputType:1,type:"TEXT",caption:"Has Attributes",mandatory:false,defaultValue:"0","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"noattribute",keys:"No~Yes",values:"0~1"},
  	{colno:0,name:"pnoattribute",inputType:0,type:"INT",caption:"No Of Attributes",mandatory:false,defaultValue:"0","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"status"},
  	{colno:1,name:"noattribute",inputType:0,type:"INT",caption:"No Of Attributes",mandatory:false,defaultValue:"0","maxValue":10,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"status",validation:"validateNoOfAttributes"},
  	{colno:0,name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"attributes_data",keys:"Active~InActive",values:"Active~InActive"}  	  	
  	]
  	},{name:"attributes",title:"Attributes",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{enableAddRow:false,enableDeleteRow:false,rowEmptyCheckColumn:2,optional:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:100,sno:true},
    {order:"1",id: "attributeno", name: "Attribute", field: "attribute",defaultValue:"0","inputType":1,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:150,"chkTag":false,keys:"Attribute1~Attribute2~Attribute3~Attribute4~Attribute5~Attribute6~Attribute7~Attribute8~Attribute9~Attribute10",values:"1~2~3~4~5~6~7~8~9~10"},
    {order:"2",id: "name", name: "Name", field: "name",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200},
    {order:"3",id: "caption", name: "Caption", field: "caption",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200},
    {order:"4",id: "mandatory", name: "Mandatory", field: "mandatory",defaultValue:"0","inputType":1,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:100,keys:"Yes~No",values:"1~0"},
    {order:"5",id: "type", name: "Type", field: "type",defaultValue:"0","inputType":1,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:100,keys:"List~String~Number",values:"L~S~N"},
    {order:"6",id: "order", name: "Order", field: "order",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:100}
    ]
    }}]};
  var screenProps=changeScreenAttributes(110002,sProps);
  var productg=new FlexUI.Screen("productgroup",screenProps);
  jqReport(9,"#xyz");
  function addMasterData(){ 
  	productg.clearScreen(); 
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	screenObjects.getScreenObject("groupname").focus();
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#history').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("9");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var code=screenObjects.getScreenObject("code").getValue();
    if(code!="0" && code!=""){
    	productg.setOperation("EDIT");
    }
	var d=productg.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/productgroup",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			productg.clearScreen();
			hideMasterData();
			reloadGrid("9");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/productgroup";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
	var v=l.callAjax("GET",url,code);
	productg.loadData(v);
	createAttributeRows(0);
	screenObjects.getScreenObject("type").setEnabled(false);
	if(screenObjects.getScreenObject("hasattribute").getValue()){
		screenObjects.getScreenObject("hasattribute").setEnabled(false);
	}		
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	hideLoader();
  	screenObjects.getScreenObject("groupname").focus();
  }
  function validateNoOfAttributes(id,me){
	var noOfAttributes=me.getValue();
	var pNo=screenObjects.getScreenObject("pnoattribute").getValue();
	if(pNo>noOfAttributes){
		alert("Cannot reduce the number of the attributes for the product group");
		me.setValue(pNo);
		return false;
	}
	createAttributeRows(noOfAttributes);
	return true;
	}
	function createAttributeRows(noOfAttributes){
		var g=screenObjects.getScreenObject("attributes_data");
		if(noOfAttributes==0){
			noOfAttributes=g.getSize();
		}
		for(var k=0;k<noOfAttributes;k++){
			if(g.getSize()==k){
				g.addRow();
			}
			g.getCell(k,1).getWidgetRef().setValue((k+1)+'');
			g.getCell(k,1).getWidgetRef().getSelect().attr('disabled','disabled');
		}		
	}  
</script> 
</body>
</html>