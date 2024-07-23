<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Stock Transfer Out</title>
</head>
<body>
<script src="js/attributedialog.js"></script>
<script src="js/serialentrydialog.js"></script>
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
	<div  class="subHe1">Stock Outward<span class="pull-right right-btn" onclick="showHideField('out')"><b id="plusbutton1" class="fa fa-angle-double-up"></b></span>
	<div id="branch" class="brTp" style="display:block">
   </div>
	<div class="col-sm-12 col-md-12 col-lg-12 mpZero" id="divHide">

	<div class="col-sm-4 col-md-4 col-lg-4">                    
    <div id="group1" class="">
   </div></div>
   <div class="col-sm-2 col-md-2 col-lg-2"  >                    
    <div id="group2" class="">
   </div></div>
   <div class="col-sm-3 col-md-3 col-lg-3"  >
    <div id="outdetail" class="">
   </div></div>
   <div class="col-sm-3 col-md-3 col-lg-3"  >
    <div id="lrdt" class="">
   </div></div>
   </div></div></div>   </div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpRes mTBx1">
    <div id="out" class="panelOrange hcH" style="min-height:425px;" >
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
<div id='attrdlg'>
<div id='productprops' class="pop_lov_box" style="height:250px;display:none"/></div>
<div id='serialdlg'>
<div id='productserial' class="pop_lov_box" style="height:250px;display:none"/></div>
    
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

  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/transferout.js",screen:[
  {name:"group1",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"tobranch"},
  {name:"tobranch",inputType:0,type:"LOV",caption:"To",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"transferdate",lovOptions:{url:"/inventory/service/ajax",ajax:"branch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  ]},
  {name:"group2",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"showoutno",inputType:4,type:"INT",caption:"No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"transferdate"},
  {colno:0,name:"outno",inputType:0,type:"INT",caption:"No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"transferdate"},
  {name:"transferdate",inputType:0,type:"DATE",caption:"Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"sendthro"},
  ]
  },
  {name:"branch",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[  {colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"tobranch",lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}}
  ]},
  {name:"outdetail",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"transfertype",inputType:1,type:"TEXT",caption:"Transfer Type",keys:"Normal",values:"N",defaultValue:"N","readOnly":false,"chkTag":false,nf:"sendthro",visible:false},
  {colno:0,name:"sendthro",inputType:0,type:"LOV",caption:"Transport",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf",colspan:2,lovOptions:{url:"/inventory/service/ajax",ajax:"transport",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  {colno:0,name:"pf",inputType:0,type:"DECIMAL",caption:"P&F",mandatory:false,defaultValue:"0","maxValue":99999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"lrno",colspan:2,onchange:"onTaxChange"}
  ]},
  {name:"lrdt",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:1,name:"documents",inputType:0,type:"TEXT",caption:"Documents",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"lrno"},
  {colno:1,name:"lrno",inputType:0,type:"TEXT",caption:"LR No",mandatory:false,defaultValue:"NA","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"lrdate"},
  {colno:1,name:"lrdate",inputType:0,type:"DATE",caption:"LR Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"out_data"}
  ]},
  {name:"out",title:"Products",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"transferproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[
    {tgt:"out_data",tt:false,row:"cr",col:"1",id:"0"},
    {tgt:"out_data",tt:true,row:"cr",col:"1",id:"1"},
    {tgt:"out_data",tt:false,row:"cr",col:"2",id:"2"},
    {tgt:"out_data",tt:false,row:"cr",col:"29",id:"5"},
    {tgt:"out_data",tt:false,row:"cr",col:"25",id:"6"},
    {tgt:"out_data",tt:false,row:"cr",col:"33",id:"7"},
    {tgt:"out_data",tt:false,row:"cr",col:"6",id:"8"},
    {tgt:"out_data",tt:false,row:"cr",col:"7",id:"10"},
    {tgt:"out_data",tt:false,row:"cr",col:"14",id:"10"},
    {tgt:"out_data",tt:false,row:"cr",col:"8",id:"11"},
    {tgt:"out_data",tt:false,row:"cr",col:"15",id:"11"},
    {tgt:"out_data",tt:false,row:"cr",col:"43",id:"13"},
    {tgt:"out_data",tt:false,row:"cr",col:"16",id:"14"}, 
    {tgt:"out_data",tt:false,row:"cr",col:"45",id:"15"},
    {tgt:"out_data",tt:false,row:"cr",col:"27",id:"16"},
    {tgt:"out_data",tt:false,row:"cr",col:"3",id:"17"},
    {tgt:"out_data",tt:false,row:"cr",col:"4",id:"18"}]},width:200,chkTag:true,validation:"getAttributeDetail"},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "attribid", name: "AttributeId", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"6",id: "unitgroup", name: "UnitGroup", field: "unitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "unitname", name: "Units", field: "unitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"out_data",row:"cr",col:"6",ft:false}],results:[
    {tgt:"out_data",tt:false,row:"cr",col:"7",id:"0"},
    {tgt:"out_data",tt:false,row:"cr",col:"8",id:"1"},
    {tgt:"out_data",tt:false,row:"cr",col:"43",id:"2"},
    {tgt:"out_data",tt:false,row:"cr",col:"14",id:"0"},
    {tgt:"out_data",tt:false,row:"cr",col:"15",id:"1"}
    ]},width:80,chkTag:false,validation:""},
    {order:"8",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "batchno", name: "BatchNo", field: "batchno",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"10",id: "batchdt", name: "BatchDt", field: "batchdt",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"11",id: "expdt", name: "ExpDt", field: "expdt",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"12",id: "qty", name: "Qty", field: "quantity",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:100,onchange:"onRateQuantityChange",cTotal:true,validation:"getSerialDetail"},
    {order:"13",id: "freeqty", name: "Free", field: "freeqty",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,onchange:"onRateQuantityChange",cTotal:true},
    {order:"14",id: "funitname", name: "Units", field: "funitname",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":true,width:0,chkTag:false},
    {order:"15",id: "funitid", name: "unitid", field: "funitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},                            
    {order:"16",id: "unit", name: "Unit", field: "unit",defaultValue:"1","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"17",id: "stock", name: "Stock", field: "stock",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"18",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"19",id: "selling", name: "S.Rate", field: "selling",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:100,align:"right"},
	{order:"20",id: "mrp", name: "MRP", field: "mrp",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:100,align:"right"},    
    {order:"21",id: "discperc", name: "Disc%", field: "discperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"22",id: "discamt", name: "Disc Amt", field: "discamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
    {order:"23",id: "cashdiscperc", name: "Cash Disc%", field: "cashdiscperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,onchange:"onRateQuantityChange",align:"right"},
	{order:"24",id: "cashdiscamt", name: "Cash Disc Amount", field: "cashdiscamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,align:"right"},	
    {order:"25",id: "ptaxperc", name: "P.Tax%", field: "ptaxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"26",id: "ptaxamt", name: "P.Tax Amt", field: "ptaxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
	{order:"27",id: "srtax", name: "Service Tax%", field: "srtaxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"28",id: "srtaxamt", name: "Service Tax Amount", field: "srtaxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},				
	{order:"29",id: "staxperc", name: "S.Tax%", field: "staxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
    {order:"30",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"31",id: "netamount", name: "NetAmount", field: "netamount",defaultValue:"y","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"32",id: "csdid", name: "CsdId", field: "csdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"33",id: "taxincl", name: "TaxInclu", field: "taxincl",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"34",id: "taxableamt", name: "TaxableAmt", field: "taxableamt",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"35",id: "impno", name: "impno", field: "impno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"36",id: "impsno", name: "impsno", field: "impsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"37",id: "imptype", name: "imptype", field: "imptype",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":2,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"38",id: "isdid", name: "IsdId", field: "isdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"39",id: "barcode", name: "Barcode", field: "barcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"40",id: "obranch", name: "obranch", field: "obranch",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"41",id: "oisdid", name: "oisdid", field: "oisdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"42",id: "supplier", name: "Supplier", field: "supplier",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"43",id: "conversionvalue", name: "conversionvalue", field: "conversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"44",id: "basequantity", name: "BaseQuantity", field: "basequantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"45",id: "allownegative", name: "AllowNegative", field: "allownegative",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false}
    
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
  var screenProps=changeScreenAttributes(410002,sProps);
  var toscreen=new FlexUI.Screen("xyz",screenProps);
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
