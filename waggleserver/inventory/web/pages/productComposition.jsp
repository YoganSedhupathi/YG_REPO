<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Product Composition</title>
</head>
<body>
<script src="js/attributedialog.js"></script>
<div class="col-sm-10 col-md-10 col-lg-10 mpZero"><h1>Product Composition</h1><ol class="breadcrumb mpZero"><li><a href="#">Home</a></li><li><a>Master</a></li><li class="active breaCSel"><strong>Product Composition</strong></li></ol></div>
	
<!--add and search-->
<div class="col-sm-2 col-md-2 col-lg-2 mpZero marTp" id='addGrp'>
</div>
<div class="clearfix"></div>
<!-- JQ grid starts-->
<div id="xyz" style='position:relative;border:0px;display:block;' class="mTBx"></div>			    	 
<div id="callback" style="display:none" >
<div class="col-sm-12 col-md-12 col-lg-12 mTBx1">   
   <div id="group1" class="panelOrange hcH">
   </div></div>
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12 mTBx1">
    <div id="consumables" class="panelOrange hcH" style="height:200px;">
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
<div id='attrdlg'>
<div id='productprops' class="pop_lov_box" style="height:250px;display:none"/></div>

<script>
  	var l=new FlexUI.Ajax();
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Product Details",pcolumns:1,colcss:"col-sm-12 col-md-12 col-lg-12",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"productname"},
  	{colno:0,name:"productname",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"forqty",lovOptions:{url:"/inventory/service/ajax",ajax:"compositeproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  	{colno:0,name:"forqty",inputType:0,type:"DECIMAL",caption:"For Quantity",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"makingchg"},
  	{colno:0,name:"makingchg",inputType:0,type:"DECIMAL",caption:"Making Charge",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"returnable"},
  	{colno:0,name:"returnable",inputType:1,type:"TEXT",caption:"Returnable",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"status",keys:"No~Yes",values:"0~1"},  	
  	{colno:0,name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"consumables_data",keys:"Active~InActive",values:"Active~InActive"}
  	]},
  	{name:"consumables",title:"Consumption Details",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,optional:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
	{order:"1",id: "product", name: "Product", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"consumableproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[
    {tgt:"consumables_data",tt:false,row:"cr",col:"1",id:"0"},
    {tgt:"consumables_data",tt:true,row:"cr",col:"1",id:"1"},
    {tgt:"consumables_data",tt:false,row:"cr",col:"2",id:"2"},
    {tgt:"consumables_data",tt:false,row:"cr",col:"3",id:"3"},
    {tgt:"consumables_data",tt:false,row:"cr",col:"4",id:"4"},    
    {tgt:"consumables_data",tt:false,row:"cr",col:"6",id:"5"},
    {tgt:"consumables_data",tt:false,row:"cr",col:"7",id:"6"},
    {tgt:"consumables_data",tt:false,row:"cr",col:"8",id:"7"},
    {tgt:"consumables_data",tt:false,row:"cr",col:"9",id:"8"}
    ]},width:200,chkTag:true,validation:"getAttributeDetail"},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "attribid", name: "AttributeId", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},        
    {order:"6",id: "unitgroup", name: "UnitGroup", field: "unitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "unitname", name: "Units", field: "unitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"consumables_data",row:"cr",col:"6",ft:false}],results:[
    {tgt:"consumables_data",tt:false,row:"cr",col:"7",id:"0"},
    {tgt:"consumables_data",tt:false,row:"cr",col:"8",id:"1"},
    {tgt:"consumables_data",tt:false,row:"cr",col:"9",id:"2"}
    ]},width:80,chkTag:false,validation:""},
    {order:"8",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "conversionvalue", name: "conversionvalue", field: "conversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"10",id: "qty", name: "Qty", field: "quantity",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:100},    
    {order:"11",id: "perunitqty", name: "perunitqty", field: "perunitqty",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"12",id: "extraname", name: "For Extra", field: "extraname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,lovOptions:{url:"/inventory/service/ajax",ajax:"productextras",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"productcode",src:"productname",ft:true}],results:[
    ]},width:150,chkTag:true,validation:""},
    ]
    }}]};
  var screenProps=changeScreenAttributes(110019,sProps);
  var product=new FlexUI.Screen("productmaster",screenProps);
  jqReport(110019,"#xyz");
  function addMasterData(){ 
  	product.clearScreen(); 
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	screenObjects.getScreenObject("productname").focus();
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#history').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("110019");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var cid=screenObjects.getScreenObject("code").getValue();
    if(cid!="0" && cid!=""){
    	product.setOperation("EDIT");
    }
	var d=product.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/product/consumables",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			product.clearScreen();
			hideMasterData();
			reloadGrid("110019");
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/product/consumables";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
  	product.clearScreen();
	var v=l.callAjax("GET",url,code);
	product.loadData(v);
	screenObjects.getScreenObject('productname').setEnabled(false);
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	hideLoader();
  	screenObjects.getScreenObject("productname").focus();
  }
  function getAttributeDetail(id,me,row,col){
	var cols=screenObjects.getScreenObject("consumables_data").getCols();
	if(me.getCellTag(row,cols.product)!="" && toNumber(me.getText(row,cols.quantity))==0 && !product.getSaveInProgress()){
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getCellPopup(row,col)){
			invokeAttributeDialog(me,row,col,"productprops",me.getInputField());
			return false;				
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			return true;
		}
	}
	return true;
  }
</script> 
</body>
</html>