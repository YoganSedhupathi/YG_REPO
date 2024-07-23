<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Vendor Product Master</title>
</head>
<body>
<script src="js/attributedialog.js"></script>
<script src="js/serialentrydialog.js"></script>
<script>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
%>
</script>
<!-- JQ grid starts style='position:relative;border:0px;padding:0px;display:block;float:left'-->
<div id="xyz" style='position:relative;border:0px;display:none;'></div>			    	 
<div id="callback"  >
	<div class="col-sm-12 col-md-12 col-lg-12 mpZero mTBx1" >
	<div  class="panelOrange hcH">
	<div  class="subHe1">Supplier Products
	
	
<span class="pull-right right-btn" onclick="showHideField('products')"><b id="plusbutton1" class="fa fa-angle-double-up"></b></span>
	<div class="col-sm-12 col-md-12 col-lg-12 mpZero" id="divHide">
	<div class="col-sm-12 col-md-12 col-lg-12">                    
    <div id="group1" class="">
   </div></div>
   </div></div></div>   </div>
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpRes mTBx1">
    <div id="products" class="panelOrange hcH" style="min-height:395px;" >
   </div></div>
</div>
<div class="clearfix"></div>
<!-- JQ grid ends-->
<div style="position:fixed; bottom:0; width:94.5%; background:#fff; z-index:1000;">
<div id="saveGrp" class="" >
<div class="col-sm-2 col-md-2 col-lg-2 adCl saVbN" onclick="onSaveClicked()">Save</div>
<div class="col-sm-2 col-md-2 col-lg-2 adCl1" >&nbsp;</div>
<div class="col-sm-2 col-md-2 col-lg-2 adCl1" >&nbsp;</div>
</div>
<div id='attrdlg'>
<div id='productprops' class="pop_lov_box" style="height:250px;display:none"/></div>
<div id='serialdlg'>
<div id='productserial' class="pop_lov_box" style="height:250px;display:none"/></div>
<script>
  	var l=new FlexUI.Ajax();
  var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"js/validations/customerproductmaster.js",screen:[
  {name:"group1",title:"",pcolumns:0,height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  fields:[{name:"name",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"products_data",lovOptions:{url:"/inventory/service/ajax",ajax:"supplier",scrollEnabled:true,searchFromList:false,dsi:1,params:[],results:[{tgt:"name",tt:true,id:"0"},{tgt:"name",tt:false,id:"1"},{tgt:"address1",tt:false,id:"3"},{tgt:"address2",tt:false,id:"4"},{tgt:"city",tt:false,id:"5"},{tgt:"pincode",tt:false,id:"6"},{tgt:"address",tt:false,id:"3,4,5,6",m:true}]}},
  {colno:0,name:"address",inputType:4,type:"SPAN",caption:"Address",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"go"},  
  {colno:0,name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address2"},
  {colno:0,name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"city"},
  {colno:0,name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"0","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"pincode"},
  {colno:0,name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"go"},
  {colno:0,name:"go",inputType:3,type:"",caption:"Go",onclick:"loadSupplierProduct",visible:true}
  ]
  },{name:"products",title:"Product Details",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,optional:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:20,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"y","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"productwotax",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[
    {tgt:"products_data",tt:false,row:"cr",col:"1",id:"0"},
    {tgt:"products_data",tt:true,row:"cr",col:"1",id:"1"},
    {tgt:"products_data",tt:false,row:"cr",col:"2",id:"2"},
    {tgt:"products_data",tt:false,row:"cr",col:"7",id:"4"}
    ]},width:100,chkTag:true,validation:"getAttributeDetail"},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:50,align:"right"},
    {order:"4",id: "discount", name: "Discount", field: "discount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:50,align:"right"},
    {order:"5",id: "gkm", name: "Margin", field: "margin",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,align:"right"},
    {order:"6",id: "attribid", name: "attribid", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0}
    ]
    }}]};
  var screenProps=changeScreenAttributes(110008,sProps);
  var suppProduct=new FlexUI.Screen("sp",screenProps);
  function onSaveClicked(id,me){
    suppProduct.setOperation("EDIT");
	var d=suppProduct.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		var r=s.callAjax("POST","/inventory/service/supplier/products",d);
		if(r.result=="Success"){
			setErrorMessage(r.message);
			suppProduct.clearScreen();
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
  function loadSupplierProduct(){
    var code=screenObjects.getScreenObject("name").getTag();
    if(code!='0' && code!=""){
	  	var	url="/inventory/service/supplier/products";
	  	var	data="code="+code+"";
		var v=l.callAjax("GET",url,data);
		suppProduct.loadData(v);
	 }
	 return true;
  }
  function getAttributeDetail(id,me,row,col){
	var cols=screenObjects.getScreenObject("products_data").getCols();
	if(me.getCellTag(row,cols.product)!="" && !suppProduct.getSaveInProgress()){
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getCellPopup(row,col)){
			invokeAttributeDialog(me,row,col,"productprops",me.getInputField());
			return false;				
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			onAttributeClose(me,row,col);			
		}
	}
	return true;
 }
 function onAttributeClose(me,row,col){
	var cols=screenObjects.getScreenObject("products_data").getCols();
	var suppcode=screenObjects.getScreenObject("name").getTag();
	var v=null;
	if(toNumber(me.getText(row,cols.rate))==0){
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
			v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=attribid,prevpurrate&suppcode="+suppcode+"&pmcode="+me.getCellTag(row,col)+"&udw="+me.getRelatedValues(row,col).condition);
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=attribid,prevpurrate&suppcode="+suppcode+"&pmcode="+me.getCellTag(row,col));
		}
		//v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=prevpurrate&suppcode="+suppcode+"&pmcode="+me.getCellTag(row,col));
		if(v!=null){
			if(v.data.attribid && v.data.attribid.length==1){
				me.setCurrentRowText(cols.attribid,v.data.attribid[0][0]);
			}		
			if(v.data && v.data.length==1){
				setRateDetails(me,cols,v.data.prevpurrate)
			}else{
				var r=l.callAjax("GET","/inventory/service/ajax","ic=0&id=productrate&pmcode="+me.getCellTag(row,col));
				if(r!=null){
					if(r.data && r.data.length==1){
						setRateDetails(me,cols,r.data)
					}
				}
			}
		}
	}
	return true;	
}
function setRateDetails(me,cols,v){
	me.setCurrentRowText(cols.rate,v[0][0]);
	me.setCurrentRowText(cols.discount,v[0][1]);
}
</script> 
</body>
</html>