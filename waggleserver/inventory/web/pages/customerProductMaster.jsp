<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Customer Product Master</title>
</head>
<body>
<h1>Customer Products</h1>
<!--add and search-->
<!-- JQ grid starts-->
<div id="xyz" style='position:relative;border:0px;display:none;'></div>			    	 
<div id="callback" style='position:relative;border:0px;padding:0px;display:block;float:left'></div>
<!-- JQ grid ends-->
<div id="saveGrp" style='display:block'>
</div>

<script>
  	var l=new FlexUI.Ajax();
  var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"js/validations/customerproductmaster.js",screen:[
  {name:"group1",title:"Customer Details",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  fields:[{name:"mobile",inputType:0,type:"TEXT",caption:"Mobile",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"name",validation:"fetchCustomer"},  
  {name:"name",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"address1",lovOptions:{url:"/inventory/service/ajax",ajax:"customer",scrollEnabled:true,searchFromList:false,dsi:2,params:[],results:[{tgt:"name",tt:true,id:"0"},{tgt:"name",tt:false,id:"1"},{tgt:"mobile",tt:false,id:"2"},{tgt:"custname",tt:false,id:"0"},{tgt:"address1",tt:false,id:"3"},{tgt:"address2",tt:false,id:"4"},{tgt:"city",tt:false,id:"5"},{tgt:"pincode",tt:false,id:"6"}]}},  
  {name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address2"},
  {name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"city"},
  {name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"0","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"pincode"},
  {name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"go"},
  {name:"go",inputType:3,caption:"Go",onclick:"loadCustomerProduct",visible:true}
  ]
  },{name:"products",title:"Product Details",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,optional:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:20,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"y","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"productwotax",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"products_data",tt:false,row:"cr",col:"1",id:"0"},{tgt:"products_data",tt:true,row:"cr",col:"1",id:"1"},{tgt:"products_data",tt:false,row:"cr",col:"2",id:"2"},{tgt:"products_data",tt:false,row:"cr",col:"3",id:"3"},{tgt:"products_data",tt:false,row:"cr",col:"4",id:"4"}]},width:100,chkTag:true},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"right"},
    {order:"6",id: "discount", name: "Discount", field: "discount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"right"}
    ]
    }}]};
  var custProduct=new FlexUI.Screen("cp",sProps);
  function onSaveClicked(id,me){
    custProduct.setOperation("EDIT");
	var d=custProduct.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		var r=s.callAjax("POST","/inventory/service/customer/products",d);
		if(r.result=="Success"){
			setErrorMessage(r.message);
			custProduct.clearScreen();
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadCustomerProduct(){
    var code=screenObjects.getScreenObject("name").getTag();
    if(code!='0' && code!=""){
	  	var	url="/inventory/service/customer/products";
	  	var	data="code="+code+"";
		var v=l.callAjax("GET",url,data);
		custProduct.loadData(v);
	 }
	 return true;
  }
</script> 
</body>
</html>