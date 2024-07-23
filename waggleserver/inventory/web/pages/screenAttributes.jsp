<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Screen</title>
</head>
<body>
<div style="width:100%;float:left">
<div id="callback" style="display:block" >
<div class="col-md-12">
	<label>Name:</label> <input type="text" id="screenname"/>
	<label>Screencode:</label> <input type="text" id="screencode"/>
</div>
<div class="col-md-12">
	<textarea col=200 row=100 id="screenprop">
	</textarea>
</div>
</div>
<div class="clearfix"></div>   
<div id="saveGrp" style='display:block' class="mTBx">
<span>
<button type="button" class="btn btn-primary mRhAj" onclick='onSaveClicked()'>Save</button>
<button type="button" class="btn btn-default" onclick='hideMasterData()'>Cancel</button>
</span>
</div>

<script>
var showExpiry=false;
var ew=0;
var cKeys="All";
var cValues="0";

//"screencode":"310001","screenname":"","screentitle":"",
var sProps={"screencode":"310001","screenname":"Sales","screentitle":"Sales",title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/invoice.js",screen:[
  {name:"group1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {colno:0,name:"name",inputType:0,type:"TEXT",caption:"Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {colno:0,name:"mobile",inputType:0,type:"TEXT",caption:"Mobile",mandatory:true,defaultValue:"","maxValue":0,"textLength":30,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"billdate",validation:"fetchCustomer"},  
  {colno:0,name:"custtype",inputType:1,type:"TEXT",caption:"Type",mandatory:true,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"custname",keys:cKeys,values:cValues,onchange:"validateCustType"},
  {colno:0,name:"custalias",inputType:0,type:"LOV",caption:"Alias",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"billdate",lovOptions:{url:"/inventory/service/ajax",ajax:"customer",scrollEnabled:true,searchFromList:false,dsi:8,params:[{n:"custtype",src:"custtype",ft:false}],results:[{tgt:"custname",tt:true,id:"0"},{tgt:"name",tt:false,id:"1"},{tgt:"custname",tt:false,id:"1"},{tgt:"mobile",tt:false,id:"2"},{tgt:"address",tt:false,id:"3,4,5,6",m:true},{tgt:"address1",tt:false,id:"3"},{tgt:"address2",tt:false,id:"4"},{tgt:"city",tt:false,id:"5"},{tgt:"pincode",tt:false,id:"6"},{tgt:"creditdays",tt:false,id:"7"},{tgt:"showcreditdays",tt:false,id:"7"},{tgt:"custalias",tt:false,id:"8"},{tgt:"custalias",tt:true,id:"8"}]}},
  {colno:0,name:"custname",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"billdate",lovOptions:{url:"/inventory/service/ajax",ajax:"customer",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"custtype",src:"custtype",ft:false}],results:[{tgt:"custname",tt:true,id:"0"},{tgt:"name",tt:false,id:"1"},{tgt:"custname",tt:false,id:"1"},{tgt:"mobile",tt:false,id:"2"},{tgt:"address",tt:false,id:"3,4,5,6",m:true},{tgt:"address1",tt:false,id:"3"},{tgt:"address2",tt:false,id:"4"},{tgt:"city",tt:false,id:"5"},{tgt:"pincode",tt:false,id:"6"},{tgt:"creditdays",tt:false,id:"7"},{tgt:"showcreditdays",tt:false,id:"7"},{tgt:"custalias",tt:false,id:"8"}]}},
  {colno:0,name:"address",inputType:4,type:"SPAN",caption:"Address",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address2"},  
  {colno:0,name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address2"},
  {colno:0,name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"city"},
  {colno:0,name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"pincode"},
  {colno:0,name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billdate"},
  {colno:0,name:"creditdays",inputType:0,type:"INT",caption:"Credit Days",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"salesman"},
  {colno:0,name:"showcreditdays",inputType:4,type:"INT",caption:"Credit",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"salesman"}
  ]},
  {name:"branch",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[ {colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"custname",lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}}
  ]},
    {name:"group2",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"billtype",inputType:1,type:"TEXT",caption:"Bill Type",keys:"Cash~Credit~Credit Card~Coupon~Cheque~Split",values:"CA~CR~CC~CO~CQ~SP",defaultValue:"C","readOnly":false,"chkTag":false,nf:"billdate",visible:false},
  {colno:0,name:"billno",inputType:0,type:"INT",caption:"Bill No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billdate"},
  {colno:0,name:"showbillno",inputType:4,type:"INT",caption:"Bill No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"billdate"},
  {colno:0,name:"billdate",inputType:0,type:"DATE",caption:"Bill Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"salesman"},
  {colno:0,name:"salesman",inputType:0,type:"LOV",caption:"Salesman",mandatory:false,defaultValue:"","visible":true,"readOnly":false,"chkTag":false,nf:"invoice_data",lovOptions:{url:"/inventory/service/ajax",ajax:"employee",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"salesman",tt:false,id:"0"},{tgt:"salesman",tt:true,id:"1"},{tgt:"empid",tt:false,id:"2"}]}},
  {colno:0,name:"empid",inputType:0,type:"INT",caption:"EmpId",mandatory:false,defaultValue:"0","visible":false,"readOnly":false,"chkTag":false,nf:""},
  {colno:0,name:"professional",inputType:0,type:"LOV",caption:"Professional",mandatory:false,defaultValue:"","visible":false,"readOnly":false,"chkTag":false,nf:"invoice_data",lovOptions:{url:"/inventory/service/ajax",ajax:"employee",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"professional",tt:false,id:"0"},{tgt:"professional",tt:true,id:"2"},{tgt:"prfcode",tt:true,id:"2"}]}},
  {colno:0,name:"prfcode",inputType:0,type:"INT",caption:"Prfcode",mandatory:false,defaultValue:"0","visible":false,"readOnly":false,"chkTag":false,nf:""}  
  ]},
  {name:"billdetail",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"dcno",inputType:0,type:"INT",caption:"DC No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"dcdate"},
  {colno:0,name:"dcdate",inputType:0,type:"DATE",caption:"DC Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:false,nf:"ordertype"},
  {colno:0,name:"ordertype",inputType:1,type:"TEXT",caption:"Order Type",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"sono",keys:"Direct Sale~Sales Order",values:"DS~SO",defaultValue:"SE"},
  {colno:0,name:"sono",inputType:0,type:"INT",caption:"SO No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"sodate"},
  {colno:0,name:"sosno",inputType:0,type:"INT",caption:"SO No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"sodate"},
  {colno:0,name:"sodate",inputType:0,type:"DATE",caption:"SO Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:false,nf:"despthro"}  ,
  {colno:0,name:"showordertype",inputType:4,type:"TEXT",caption:"Order Type",value:"Direct Sale",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"sono",keys:"Direct Sale~Sales Order",values:"DS~SO",defaultValue:"SE"},
  {colno:0,name:"showsono",inputType:4,type:"INT",caption:"SO No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"sodate"},
  {colno:0,name:"showsodate",inputType:4,type:"DATE",caption:"SO Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"despthro"}
  ]},{name:"dummyDiv",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"dummy1",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true},
  {name:"dummy2",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true},
  {name:"dummy3",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true}
  ]},
  {name:"dummyDiv1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"dummy4",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true},
  {name:"dummy5",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true},
  {name:"dummy6",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true}
  ]},
  {name:"transport",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"despthro",inputType:0,type:"LOV",caption:"Transport",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf",colspan:2,lovOptions:{url:"/inventory/service/ajax",ajax:"transport",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  {colno:0,name:"documents",inputType:0,type:"TEXT",caption:"Documents",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"paymode"},
  {colno:0,name:"paymode",inputType:1,type:"TEXT",caption:"Payment Mode",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"lrno",visible:false},
  {colno:0,name:"pf",inputType:0,type:"DECIMAL",caption:"Packing",mandatory:false,defaultValue:"0","maxValue":99999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"discount",colspan:2,onchange:"onTaxChange"},
  {colno:0,name:"cdisc",inputType:0,type:"DECIMAL",caption:"Cash DiscPerc",mandatory:false,defaultValue:"0","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"invoice_data",colspan:2,onchange:""},
  {colno:0,name:"cdiscamt",inputType:0,type:"DECIMAL",caption:"Cash Disc Amt",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"invoice_data",colspan:2,onchange:""}
  ]},
  {name:"lrdet",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"lrno",inputType:0,type:"TEXT",caption:"LR No",mandatory:false,defaultValue:"NA","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"lrdate"},
  {colno:0,name:"lrdate",inputType:0,type:"DATE",caption:"LR Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"creditdays"},
  {colno:0,name:"go",inputType:3,type:"",caption:"Go",onclick:"calculateCashDiscount",visible:true}
  ]},
  {name:"invoice",title:"Products",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"saleproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[
    {tgt:"invoice_data",tt:false,row:"cr",col:"1",id:"0"},
    {tgt:"invoice_data",tt:true,row:"cr",col:"1",id:"1"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"2",id:"2"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"23",id:"5"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"30",id:"7"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"6",id:"8"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"7",id:"10"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"8",id:"12"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"14",id:"10"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"15",id:"12"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"36",id:"13"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"16",id:"14"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"38",id:"15"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"25",id:"16"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"3",id:"17"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"4",id:"18"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"39",id:"19"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"40",id:"20"}        
        
    ]},width:200,chkTag:true,prevalidate:"checkBarCode",validation:"getAttributeDetail"},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "attribid", name: "AttributeId", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},        
    {order:"6",id: "unitgroup", name: "UnitGroup", field: "unitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "unitname", name: "Units", field: "unitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"invoice_data",row:"cr",col:"6",ft:false}],results:[
    {tgt:"invoice_data",tt:false,row:"cr",col:"7",id:"0"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"8",id:"1"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"14",id:"0"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"15",id:"1"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"36",id:"2"}
    ]},width:80,chkTag:false,validation:""},
    {order:"8",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "batchno", name: "BatchNo", field: "batchno",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"10",id: "batchdt", name: "BatchDt", field: "batchdt",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"11",id: "expdt", name: "ExpDt", field: "expdt",defaultValue:"","inputType":0,"type":"DATE","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"12",id: "qty", name: "Qty", field: "quantity",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:100,onchange:"onRateQuantityChange",cTotal:true,validation:"validateStock"},
    {order:"13",id: "freeqty", name: "Free", field: "freeqty",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:80,onchange:"onRateQuantityChange",cTotal:true,validation:"getSerialDetail"},
    {order:"14",id: "funitname", name: "Units", field: "funitname",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":true,width:0,chkTag:false},
    {order:"15",id: "funitid", name: "unitid", field: "funitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},                    
    {order:"16",id: "unit", name: "Unit", field: "unit",defaultValue:"1","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"17",id: "stock", name: "Stock", field: "stock",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"18",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:100,onchange:"onRateQuantityChange",align:"right"},
    {order:"19",id: "discperc", name: "DiscPerc", field: "discperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"20",id: "discamt", name: "Disc Amt", field: "discamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
    {order:"21",id: "cashdiscperc", name: "Cash DiscPerc", field: "cashdiscperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,onchange:"onRateQuantityChange",align:"right"},
	{order:"22",id: "cashdiscamt", name: "Cash Disc Amount", field: "cashdiscamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,align:"right"},	
    {order:"23",id: "staxperc", name: "S.TaxPerc", field: "staxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"24",id: "staxamt", name: "S.Tax Amt", field: "staxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
	{order:"25",id: "srtax", name: "Service TaxPerc", field: "srtaxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"26",id: "srtaxamt", name: "Service Tax Amount", field: "srtaxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},		
    {order:"27",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"28",id: "netamount", name: "NetAmount", field: "netamount",defaultValue:"y","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"29",id: "csdid", name: "CsdId", field: "csdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"30",id: "taxincl", name: "TaxInclu", field: "taxincl",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"31",id: "taxableamt", name: "TaxableAmt", field: "taxableamt",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"32",id: "impno", name: "impno", field: "impno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"33",id: "impsno", name: "impsno", field: "impsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"34",id: "imptype", name: "imptype", field: "imptype",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":2,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"35",id: "selling", name: "selling", field: "selling",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,align:"right"},
    {order:"36",id: "conversionvalue", name: "conversionvalue", field: "conversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"37",id: "basequantity", name: "BaseQuantity", field: "basequantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"38",id: "allownegative", name: "AllowNegative", field: "allownegative",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"39",id: "composite", name: "Composite", field: "composite",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"40",id: "updatestock", name: "UpdateStock", field: "updatestock",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false}
    ]}},
  {name:"group3",height:20,width:45,minWidth:250,minHeight:50,colWidth:98,float:"right",backColor:"biege",contentType:"Fields",
  fields:[  {name:"discamt",inputType:0,type:"DECIMAL",caption:"Total Discount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"taxamt",onchange:"onTaxChange"},
  {name:"taxamt",inputType:0,type:"DECIMAL",caption:"VAT",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"total"},
  {name:"servtaxamt",inputType:0,type:"DECIMAL",caption:"Service Tax",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"pf",onchange:"onTaxChange"},
  {name:"total",inputType:0,type:"DECIMAL",caption:"Total:",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"totalamt"},    
  {name:"totalamt",inputType:0,type:"DECIMAL",caption:"Net Amount",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false},
  {name:"advanceamt",inputType:0,type:"DECIMAL",caption:"Advance Amount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false}
  ]
  }]};
  function onSaveClicked(id,me){
  
	var s=new FlexUI.Ajax();
	var d='data={"savedata":'+JSON.stringify(sProps)+"}";
	alert(sProps);
	var r=s.callAjax("POST","/inventory/service/screenattributes",d);
	if(r.result=="Success"){
		setErrorMessage(r.message+" [No:"+r.code+"]");
	}else{
		setErrorMessage(r.message);		
	}
	return 0;
  }  
</script> 
</body>
</html>