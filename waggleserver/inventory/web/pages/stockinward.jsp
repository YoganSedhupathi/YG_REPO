<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Stock Inward</title>
</head>
<body>
<script>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
%>
</script>
<!-- JQ grid starts-->

<div id="xyz" style='position:relative;border:0px;display:none;'></div>			    	 
<div id="callback"  >
	<div class="col-sm-12 col-md-12 col-lg-12 mpZero mTBx1" >
	<div  class="panelOrange hcH">
	<div  class="subHe1">Stock Inward<span class="pull-right right-btn" onclick="showHideField('invoice')"><b id="plusbutton1" class="fa fa-angle-double-up"></b></span>
	<div id="branch" class="brTp" style="display:block">
   </div>
	<div class="col-sm-12 col-md-12 col-lg-12" id="divHide">

	<div class="col-sm-6 col-md-6 col-lg-6">                    
    <div id="group1" class="">
   </div></div>
   <div class="col-sm-3 col-md-3 col-lg-3"  >                    
    <div id="group2" class="">
   </div></div>
   <div class="col-sm-3 col-md-3 col-lg-3"  >
    <div id="purdetail" class="">
   </div></div>
   </div></div></div>   </div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpRes mTBx1">
    <div id="invoice" class="panelOrange hcH" style="min-height:385px;" >
   </div></div>
   <div class="clearfix"></div>
   <!--div class="col-sm-5 col-md-5 col-lg-5 mpZero">                    
    <div id="group2" class="panelOrange hcH">
   </div></div-->
   <div class="col-sm-7 col-md-7 col-lg-7 mTBx1" style="display:none;">                    
    <div id="group3" class="">
   </div></div>
</div>
<div class="clearfix"></div>
<!-- JQ grid ends-->
<div style="position:fixed; bottom:0; width:94.5%; background:#fff; z-index:1000;">
<div id="saveGrp" class="" >
</div>
<div class="col-sm-6 col-md-6 col-lg-6" >
    <div style="background:#fedc34; display:inline-block; width:100%; padding:5px 10px" >
    <div class="netAm" id="netAmt">Net Amount 0.00</div>
    <div class="col-md-4 colBg2 mpZero"><div class="col-md-6">Disc</div><div class="col-md-6" id="disc">0.00</div></div>
    <div class="col-md-4 colBg2 mpZero"><div class="col-md-6">VAT</div><div class="col-md-6" id="vat">0.00</div></div>
    <div class="col-md-4 colBg2 mpZero"><div class="col-md-6">Total</div><div class="col-md-6" id="totamt">0.00</div></div>
    </div>
    </div>
    </div>
    
<script>
$('.butt_sav').click(function(e){
	e.preventDefault();
});
$('.butt_can').click(function(e){
	e.preventDefault();
});			 
var l=new FlexUI.Ajax();
var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=userdefbranch,config&configname=showexpiry");
var defbranch=v.data.userdefbranch;
var showExpiry=v.data.config[0][0]==1?true:false;
var ew=0;
if(showExpiry){
	ew=100;
}


  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/stockinward.js",screen:[
  {name:"group1",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {name:"frombranch",inputType:0,type:"LOV",caption:"Inward From",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"outwardno",lovOptions:{url:"/inventory/service/ajax",ajax:"branch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  {name:"outwardno",inputType:0,type:"LOV",caption:"Outward No",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"billdate",lovOptions:{url:"/inventory/service/ajax",ajax:"transferout",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"frombranch",ft:true}],results:[{tgt:"outwardsno",id:"0",tt:false},{tgt:"outwardno",id:"1",tt:false}]},validation:"geTransferOutDetail"},
  {name:"outwardsno",inputType:0,type:"INT",caption:"Outward SNo",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billdate"},
  {colno:0,name:"pf",inputType:0,type:"DECIMAL",caption:"P&F",mandatory:false,defaultValue:"0","maxValue":99999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"recdthro",colspan:2,onchange:"onTaxChange"}
  
    
  /*{name:"name",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address1"},
  {name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address2"},
  {name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"city"},
  {name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"pincode"},
  {name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"mobile"},
  {name:"mobile",inputType:0,type:"TEXT",caption:"Mobile",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"invno"}*/
  ]},
  {name:"purdetail",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"recdthro",inputType:0,type:"LOV",caption:"Transport",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"lrno",colspan:2,lovOptions:{url:"/inventory/service/ajax",ajax:"transport",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  {colno:0,name:"documents",inputType:0,type:"TEXT",caption:"Documents",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"lrno"},
  {colno:0,name:"lrno",inputType:0,type:"TEXT",caption:"LR No",mandatory:false,defaultValue:"NA","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"lrdate"},
  {colno:0,name:"lrdate",inputType:0,type:"DATE",caption:"LR Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"invoice_data"}
  ]
  },
  {name:"group2",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"billno",inputType:0,type:"INT",caption:"Inward No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"outwardno"},
  {colno:0,name:"showbillno",inputType:4,type:"INT",caption:"Inward No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"outwardno"},
  {colno:0,name:"billdate",inputType:0,type:"DATE",caption:"Inward Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"pf"},
  {colno:1,name:"go",inputType:3,caption:"Go",onclick:"calculateCashDiscount",visible:true}
  
  ]
  },
  {name:"branch",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[  {colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"frombranch",lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}}
  ]},
  {name:"invoice",title:"Products",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,readOnly:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:200,chkTag:true,validation:""},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "attribid", name: "AttributeId", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},        
    {order:"6",id: "unitgroup", name: "UnitGroup", field: "unitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "unitname", name: "Units", field: "unitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:80,chkTag:false,validation:""},
    {order:"8",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "batchno", name: "BatchNo", field: "batchno",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"10",id: "batchdt", name: "BatchDt", field: "batchdt",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"11",id: "expdt", name: "ExpDt", field: "expdt",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"12",id: "qty", name: "Qty", field: "quantity",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:100,onchange:"",cTotal:true,validation:""},
    {order:"13",id: "freeqty", name: "Free", field: "freeqty",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,onchange:"onRateQuantityChange",cTotal:true},
    {order:"14",id: "funitname", name: "Units", field: "funitname",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":true,width:0,chkTag:false},
    {order:"15",id: "funitid", name: "unitid", field: "funitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},                                    
    {order:"16",id: "unit", name: "Unit", field: "unit",defaultValue:"1","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"17",id: "stock", name: "Stock", field: "stock",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"18",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:100,onchange:"",align:"right"},
	{order:"19",id: "selling", name: "S.Rate", field: "selling",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:100,align:"right"},
	{order:"20",id: "mrp", name: "MRP", field: "mrp",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:100,align:"right"},    
    {order:"21",id: "discperc", name: "Disc%", field: "discperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,onchange:"",align:"right"},
	{order:"22",id: "discamt", name: "Disc Amt", field: "discamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
	{order:"23",id: "schemediscount", name: "Sch.Disc Amt", field: "schemediscount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:100,align:"right",onchange:"onRateQuantityChange"},
    {order:"24",id: "cashdiscperc", name: "Cash Disc%", field: "cashdiscperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:0,onchange:"",align:"right"},
	{order:"25",id: "cashdiscamt", name: "Cash Disc Amount", field: "cashdiscamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:0,align:"right"},	
    {order:"26",id: "ptaxperc", name: "P.Tax%", field: "ptaxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,onchange:"",align:"right"},
	{order:"27",id: "ptaxamt", name: "P.Tax Amount", field: "ptaxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
	{order:"28",id: "srtax", name: "Service Tax%", field: "srtaxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"29",id: "srtaxamt", name: "Service Tax Amount", field: "srtaxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},					
	{order:"30",id: "staxperc", name: "S.Tax%", field: "staxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
    {order:"31",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"32",id: "netamount", name: "NetAmount", field: "netamount",defaultValue:"y","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"33",id: "csdid", name: "CsdId", field: "csdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"34",id: "taxincl", name: "TaxInclu", field: "taxincl",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"35",id: "taxableamt", name: "TaxableAmt", field: "taxableamt",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"36",id: "impno", name: "impno", field: "impno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"37",id: "impsno", name: "impsno", field: "impsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"38",id: "imptype", name: "imptype", field: "imptype",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":2,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"39",id: "isdid", name: "IsdId", field: "isdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"40",id: "barcode", name: "Barcode", field: "barcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"41",id: "obranch", name: "obranch", field: "obranch",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"42",id: "oisdid", name: "oisdid", field: "oisdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"43",id: "supplier", name: "Supplier", field: "supplier",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"44",id: "conversionvalue", name: "conversionvalue", field: "conversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"45",id: "basequantity", name: "BaseQuantity", field: "basequantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,cTotal:true,chkTag:false},
    {order:"46",id: "freight", name: "Freight", field: "freight",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"47",id: "netcost", name: "NetCost", field: "netcost",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false}
            
    ]}},
  {name:"group3",height:20,width:45,minWidth:250,minHeight:50,colWidth:98,float:"right",backColor:"biege",contentType:"Fields",
  fields:[  {name:"discamt",inputType:0,type:"DECIMAL",caption:"Total Discount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"taxamt",onchange:"onTaxChange"},
  {name:"taxamt",inputType:0,type:"DECIMAL",caption:"VAT",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"total"},
  {name:"servtaxamt",inputType:0,type:"DECIMAL",caption:"VAT",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"total"},
  {name:"total",inputType:0,type:"DECIMAL",caption:"Total:",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"totalamt"},    
  {name:"totalamt",inputType:0,type:"DECIMAL",caption:"Net Amount",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false}
  ]
  }]};
  /*
  ,
    {name:"group4",height:15,width:80,minWidth:500,minHeight:50,colWidth:15,float:"left",backColor:"beige",contentType:"Fields",fields:[
    {name:"add",inputType:3,caption:"Add",onclick:"add",visible:true},
    {name:"save",inputType:3,caption:"Save",onclick:"save",visible:true},
    {name:"edit",inputType:3,caption:"Edit",onclick:"edit",visible:true},
    {name:"Delete",inputType:3,caption:"Delete",onclick:"delete1",visible:true}
    ]}
    */
  var screenProps=changeScreenAttributes(410001,sProps);
  var stockinwardscreen=new FlexUI.Screen("xyz",screenProps);
  setDefaultBranch();
  <%if(mode!=null && mode.equals("VIEW")){%>
	  loadDataView(<%=code%>);
	  $('#saveGrp').html('<div class="col-sm-2 col-md-2 col-lg-2 adCl saVbN" onclick="closeScreen()">Close</div><div class="col-sm-2 col-md-2 col-lg-2 adCl1" >&nbsp;</div><div class="col-sm-2 col-md-2 col-lg-2 adCl1" >&nbsp;</div>');
	<%}%>
 </script>
<iframe src='' style='display:none' id="ppurchase">
</iframe> 
</body>
</html>
