<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Offers</title>
</head>
<body>
<script src="js/attributedialog.js"></script>
<div class="col-sm-10 col-md-10 col-lg-10 mpZero"><h1>Offers</h1><ol class="breadcrumb mpZero"><li><a href="#">Home</a></li><li><a>Master</a></li><li class="active breaCSel"><strong>Offers</strong></li></ol></div>
	
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
    <div id="offers" class="panelOrange hcH" style="height:200px;">
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
  	var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=custtype");
	var custtype=v.data;
	var cKeys="All";
	var cValues="0";
	var tilled="~";	
	if(custtype.length>0){
		for(var m=0;m<custtype.length;m++){
			cKeys=cKeys+tilled+custtype[m][0];
			cValues=cValues+tilled+custtype[m][1];
			tilled="~";
		}			
	}
  	
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Offer Details",pcolumns:2,colcss:"col-sm-6 col-md-6 col-lg-6",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"offername"},
  	{colno:0,name:"offername",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"offertype"},
  	{colno:1,name:"offertype",inputType:1,type:"TEXT",caption:"Type",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,keys:"Bill Offer~Item Offer",values:"1~2",nf:"validfrom","onchange":"validateOfferType"},
  	{colno:0,name:"validfrom",inputType:0,type:"DATE",caption:"Valid From",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"validto"},
  	{colno:1,name:"validto",inputType:0,type:"DATE",caption:"Valid Upto",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"custtype"},
  	{colno:0,name:"custtype",inputType:1,type:"TEXT",caption:"Customer Type",mandatory:true,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"billamount",keys:cKeys,values:cValues},
  	{colno:0,name:"billtype",inputType:1,type:"TEXT",caption:"Bill Type",mandatory:true,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billamount",keys:"CASH~CREDIT",values:"CA~CR"},
  	{colno:1,name:"billamount",inputType:0,type:"DECIMAL",caption:"For Amount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"fromtime"},
  	{colno:0,name:"fromtime",inputType:0,type:"TIME",caption:"Valid From",format:"",defaultValue:"","chkTag":false,visible:true,nf:"totime"},
  	{colno:1,name:"totime",inputType:0,type:"TIME",caption:"Valid Upto",format:"",defaultValue:"","chkTag":false,visible:true,nf:"offermode"},  	
  	{colno:0,name:"offermode",inputType:1,type:"TEXT",caption:"Mode",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"discperc",keys:"Discount%~Discount Amount~FreeItem~Discounted Rate",values:"1~2~3~4","onchange":"offerModeValidate"},  	
  	{colno:1,name:"discperc",inputType:0,type:"DECIMAL",caption:"Discount %",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"discamount"},
  	{colno:0,name:"discamount",inputType:0,type:"DECIMAL",caption:"Discount Amount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"status"},
  	{colno:1,name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"offers_data",keys:"Active~InActive",values:"1~0"}  	
  	]},
  	{name:"offers",title:"Offer Item Details",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,optional:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
	{order:"1",id: "product", name: "Product", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"salableproducts",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[
    {tgt:"offers_data",tt:false,row:"cr",col:"1",id:"0"},
    {tgt:"offers_data",tt:true,row:"cr",col:"1",id:"1"},
    {tgt:"offers_data",tt:false,row:"cr",col:"2",id:"2"},
    {tgt:"offers_data",tt:false,row:"cr",col:"3",id:"3"},
    {tgt:"offers_data",tt:false,row:"cr",col:"4",id:"4"},    
    {tgt:"offers_data",tt:false,row:"cr",col:"6",id:"5"},
    {tgt:"offers_data",tt:false,row:"cr",col:"7",id:"6"},
    {tgt:"offers_data",tt:false,row:"cr",col:"8",id:"7"},
    {tgt:"offers_data",tt:false,row:"cr",col:"9",id:"8"}
    ]},width:200,chkTag:true,validation:"getAttributeDetail"},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "attribid", name: "AttributeId", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},        
    {order:"6",id: "unitgroup", name: "UnitGroup", field: "unitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "unitname", name: "Units", field: "unitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"offers_data",row:"cr",col:"6",ft:false}],results:[
    {tgt:"offers_data",tt:false,row:"cr",col:"7",id:"0"},
    {tgt:"offers_data",tt:false,row:"cr",col:"8",id:"1"},
    {tgt:"offers_data",tt:false,row:"cr",col:"9",id:"2"}
    ]},width:80,chkTag:false,validation:""},
    {order:"8",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "conversionvalue", name: "conversionvalue", field: "conversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"10",id: "qty", name: "Qty", field: "quantity",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:100},
    {order:"11",id: "freeproduct", name: "Free Product", field: "freeproduct",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"salableproducts",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[
    {tgt:"offers_data",tt:false,row:"cr",col:"11",id:"0"},
    {tgt:"offers_data",tt:true,row:"cr",col:"11",id:"1"},
    {tgt:"offers_data",tt:false,row:"cr",col:"12",id:"2"},
    {tgt:"offers_data",tt:false,row:"cr",col:"13",id:"3"},
    {tgt:"offers_data",tt:false,row:"cr",col:"14",id:"4"},    
    {tgt:"offers_data",tt:false,row:"cr",col:"16",id:"5"},
    {tgt:"offers_data",tt:false,row:"cr",col:"17",id:"6"},
    {tgt:"offers_data",tt:false,row:"cr",col:"18",id:"7"},
    {tgt:"offers_data",tt:false,row:"cr",col:"19",id:"8"}
    ]},width:200,chkTag:true,"validation":"getAttributeDetailForFreeItem"},
    {order:"12",id: "freepgcode", name: "freepgcode", field: "freepgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"13",id: "fserialized", name: "fserialized", field: "fserialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"14",id: "fisattribute", name: "fisattribute", field: "fisattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"15",id: "fattribid", name: "FreeAttributeId", field: "fattribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},        
    {order:"16",id: "funitgroup", name: "Free UnitGroup", field: "funitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"17",id: "funitname", name: "Unit Name", field: "funitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"funitgroup",src:"offers_data",row:"cr",col:"6",ft:false}],results:[
    {tgt:"offers_data",tt:false,row:"cr",col:"17",id:"0"},
    {tgt:"offers_data",tt:false,row:"cr",col:"18",id:"1"},
    {tgt:"offers_data",tt:false,row:"cr",col:"19",id:"2"}
    ]},width:80,chkTag:false,validation:""},
    {order:"18",id: "funitid", name: "funitid", field: "funitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"19",id: "fconversionvalue", name: "fconversionvalue", field: "fconversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"20",id: "offerqty", name: "Offer Qty", field: "offerqty",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,chkTag:false},
    {order:"21",id: "offerdiscperc", name: "Disc Perc", field: "offerdiscperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,chkTag:false},
    {order:"22",id: "offerdiscamt", name: "Disc Amount", field: "offerdiscamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,chkTag:false},
    {order:"23",id: "discrate", name: "Disc Rate", field: "discrate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,chkTag:false}
    ]
    }}]};
  //var screenProps=changeScreenAttributes(110022,sProps);
  var offer=new FlexUI.Screen("offermaster",sProps);
  jqReport(110022,"#xyz");
  function addMasterData(){ 
  	offer.clearScreen(); 
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	screenObjects.getScreenObject("offername").focus();
  	validateOfferTypeWrapper(true);
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#history').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("110022");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var cid=screenObjects.getScreenObject("code").getValue();
    if(cid!="0" && cid!=""){
    	offer.setOperation("EDIT");
    }
	var d=offer.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/product/offers",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			offer.clearScreen();
			hideMasterData();
			reloadGrid("110022");
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/product/offers";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
	var v=l.callAjax("GET",url,code);
	offer.clearScreen();
	offer.loadData(v);
	screenObjects.getScreenObject('offername').setEnabled(false);
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	hideLoader();
  	screenObjects.getScreenObject("offername").focus();
  	validateOfferTypeWrapper(false);
  }
  function getAttributeDetail(id,me,row,col){
	var cols=screenObjects.getScreenObject("offers_data").getCols();
	if(me.getCellTag(row,cols.product)!="" && toNumber(me.getText(row,cols.quantity))==0 && !offer.getSaveInProgress()){
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getCellPopup(row,col)){
			invokeAttributeDialog(me,row,col,"productprops",me.getInputField());
			return false;				
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			return true;
		}
	}
	return true;
  }
  function getAttributeDetailForFreeItem(id,me,row,col){
	var cols=screenObjects.getScreenObject("offers_data").getCols();
	if(me.getCellTag(row,cols.freeproduct)!="" && !offer.getSaveInProgress()){
		if(toNumber(me.getText(row,cols.fisattribute))==1 && me.getCellPopup(row,col)){
			invokeAttributeDialog(me,row,col,"productprops",me.getInputField(),'freepgcode');
			return false;				
		}else if(toNumber(me.getText(row,cols.fisattribute))==0){
			return true;			
		}		
	}
	return true;
  }
  function validateOfferTypeWrapper(clearTable){
    if(!offer.getSaveInProgress()){
		var offerType=screenObjects.getScreenObject("offertype").getValue();
		var offerMode=screenObjects.getScreenObject("offermode");
		var discPerc=screenObjects.getScreenObject("discperc");
		var discAmount=screenObjects.getScreenObject("discamount");
		var billAmount=screenObjects.getScreenObject("billamount");
		if(offerType==1){
				offerMode.getSelect().find("option[value='4']").prop('disabled',true);
				offerMode.getSelect().find("option[value='3']").prop('disabled',true);
				if(clearTable){
					offerMode.setValue('1');					
					billAmount.setValue('0');					
				}
				billAmount.setEnabled(true);								
		}else{
			    offerMode.getSelect().find("option[value='4']").prop('disabled',false);
			    offerMode.getSelect().find("option[value='3']").prop('disabled',false);
			    discPerc.setEnabled(false);
			    discAmount.setEnabled(false);
			    billAmount.setEnabled(false);
			    if(clearTable){
			    	offerMode.setValue('1');			    	
				    discPerc.setValue('0');
				    discAmount.setValue('0');
				    billAmount.setValue('0');
			    }
		}
		offerModeValidateWrapper(clearTable)
	}
	return true;
  }
  function validateOfferType(){
  	return validateOfferTypeWrapper(true);
  }
  function offerModeValidate(){
  	return offerModeValidateWrapper(true);
  }
  function offerModeValidateWrapper(clearTable){
  	if(!offer.getSaveInProgress()){
	    var offerType=screenObjects.getScreenObject("offertype").getValue();
		var offerMode=screenObjects.getScreenObject("offermode");
		var discPerc=screenObjects.getScreenObject("discperc");
		var discAmount=screenObjects.getScreenObject("discamount");
		var offersTable=screenObjects.getScreenObject("offers_data");
		var cols=offersTable.getCols();
		if(offerType==1){
			if(offerMode.getValue()=="1"){	
			  	discPerc.setEnabled(true);
		  		discAmount.setEnabled(false);
		  		discAmount.setValue('0');
		  		offersTable.getOptions().tableIsReadOnly=true;
		  	}else if(offerMode.getValue()=="2"){
			  	discPerc.setEnabled(false);
			  	discPerc.setValue('0');
		  		discAmount.setEnabled(true);
		  		offersTable.getOptions().tableIsReadOnly=true;
		  	}else if(offerMode.getValue()=="3"){
		  		discPerc.setEnabled(false);
		  		discAmount.setEnabled(false);
		  		discPerc.setValue('0');
		  		discAmount.setValue('0');
		  		offersTable.getOptions().tableIsReadOnly=false;		  		
		  		offersTable.getOptions().rowEmptyCheckColumn=cols.freeproduct;
		  		var columnProps=offersTable.getColumnProperties();
		  		columnProps[cols.product].readOnly=true;	  		
		  		columnProps[cols.product].mandatory=false;
		  		columnProps[cols.quantity].readOnly=true;
		  		columnProps[cols.quantity].mandatory=false;
		  		columnProps[cols.unitname].readOnly=true;	  		
		  		columnProps[cols.unitname].mandatory=false;
		  		columnProps[cols.freeproduct].readOnly=false;
		  		columnProps[cols.funitname].readOnly=true;
		  		columnProps[cols.offerqty].readOnly=false;
		  		columnProps[cols.freeproduct].mandatory=true;
		  		columnProps[cols.offerqty].mandatory=true;
		  		columnProps[cols.funitname].mandatory=true;
		  		columnProps[cols.offerdiscperc].mandatory=false;
		  		columnProps[cols.offerdiscamt].mandatory=false;
		  		columnProps[cols.discrate].mandatory=false;	  		  		  			  			  		
		  		columnProps[cols.offerdiscperc].readOnly=true;
		  		columnProps[cols.offerdiscamt].readOnly=true;
		  		columnProps[cols.discrate].readOnly=true;
		  	}
		  	if(clearTable){
		  		offersTable.clear();		  		
		  	}else{
		  		offersTable.checkAndMove("Next",false);
		  	}
		 }else{
		 	offersTable.getOptions().tableIsReadOnly=false;		  		
	  		var columnProps=offersTable.getColumnProperties();
	  		columnProps[cols.product].readOnly=false;	  		
	  		columnProps[cols.quantity].readOnly=false;
	  		columnProps[cols.unitname].readOnly=false;
	  		columnProps[cols.product].mandatory=true;	  		
	  		columnProps[cols.quantity].mandatory=true;
	  		columnProps[cols.unitname].mandatory=true;
	  		columnProps[cols.freeproduct].mandatory=false;
		  	columnProps[cols.offerqty].mandatory=false;
		  	columnProps[cols.funitname].mandatory=false;
		  	columnProps[cols.offerdiscperc].mandatory=false;
		  	columnProps[cols.offerdiscamt].mandatory=false;
		  	columnProps[cols.discrate].mandatory=false;
		  	offersTable.getOptions().rowEmptyCheckColumn=cols.product;	  		  		  			  		
		 	if(offerMode.getValue()=="1"){
		  		columnProps[cols.freeproduct].readOnly=true;
		  		columnProps[cols.offerqty].readOnly=true;
		  		columnProps[cols.funitname].readOnly=true;
		  		columnProps[cols.offerdiscperc].readOnly=false;
		  		columnProps[cols.offerdiscperc].mandatory=true;
		  		columnProps[cols.offerdiscamt].readOnly=true;
		  		columnProps[cols.discrate].readOnly=true;
		  	}else if(offerMode.getValue()=="2"){
		  		columnProps[cols.freeproduct].readOnly=true;
		  		columnProps[cols.offerqty].readOnly=true;
		  		columnProps[cols.funitname].readOnly=true;
		  		columnProps[cols.offerdiscperc].readOnly=true;
		  		columnProps[cols.offerdiscamt].readOnly=false;
		  		columnProps[cols.offerdiscamt].mandatory=true;
		  		columnProps[cols.discrate].readOnly=true;
		  	}else if(offerMode.getValue()=="3"){
		  		columnProps[cols.freeproduct].readOnly=false;
		  		columnProps[cols.offerqty].readOnly=false;
		  		columnProps[cols.funitname].readOnly=true;
		  		columnProps[cols.freeproduct].mandatory=true;
		  		columnProps[cols.offerqty].mandatory=true;
		  		columnProps[cols.funitname].mandatory=true;	  			  		
		  		columnProps[cols.offerdiscperc].readOnly=true;
		  		columnProps[cols.offerdiscamt].readOnly=true;
		  		columnProps[cols.discrate].readOnly=true;
		  	}else if(offerMode.getValue()=="4"){
		  		columnProps[cols.freeproduct].readOnly=true;
		  		columnProps[cols.offerqty].readOnly=true;
		  		columnProps[cols.funitname].readOnly=true;
		  		columnProps[cols.offerdiscperc].readOnly=true;
		  		columnProps[cols.offerdiscamt].readOnly=true;
		  		columnProps[cols.discrate].readOnly=false;
		  		columnProps[cols.discrate].mandatory=true;
		  	}
			if(clearTable){
		  		offersTable.clear();		  		
		  	}else{
		  		offersTable.checkAndMove("Next",false);
		  	}
		}	 			  			  				 
	 }
  	return true;
  } 
</script> 
</body>
</html>

