<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>GIN</title>
</head>
<body>
<script>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
%>
</script>
<script src="js/attributedialog.js"></script>
<script src="js/serialentrydialog.js"></script>
<script src="js/hamalientrydialog.js"></script>
<!-- JQ grid starts-->

<div class="card border-0 shadow">
  <div class="card-body lpage">
    <!--Header-->
    <div class="row w-100">
      <div class="col-md-6 d-flex align-items-center">
        <h4 class="header-title">Goods Inward Note</h4>
      </div>
      <div  class="col-md-6 text-right">
        <div class="dropdown">
          <button class="btn btn-clear dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
            <span class="mdi mdi-menu-open"></span>
          </button>
          <ul id="submenu" class="dropdown-menu" aria-labelledby="dropdownMenuButton1"></ul>
        </div>
      </div>
    </div>
    <!--Header End-->
    <!--Listing -->
        <div class="row" id="jqcontainer" style="display:none;">
          <div class="table-container">
            <div id="xyz" class="w-100">

            </div>
          </div>
        </div>	
    <!--Listing End-->
		<!--Content Start-->	
      <div id="divHide" class="mt-3">
          <div id="divFirst" style="display:block">
            <div class="row w-100">
              <div class="col-sm-4 col-md-4 col-lg-4">                    
                <div id="group1" class="cBor"></div>
              </div>
              <div class="col-sm-3 col-md-3 col-lg-3" style="display:none" >                    
              <div id="group2" class="cBor">
              </div>
              </div>
              <div class="col-sm-4 col-md-4 col-lg-4"  >                    
                <div id="group4" class="cBor">
                </div>
              </div>
              <div class="col-sm-4 col-md-4 col-lg-4"  >                    
                <!-- <div id="group6" class="cBor"></div> -->
                
                <div class="row mpzo">
                  <div id="group6" class="col-md-6 cBor"></div>
                  <div id="group7" class="col-md-6 cBor"></div>
                </div>
              </div>
              <div class="col-sm-3 col-md-3 col-lg-3" style="display:none">
                <div id="group5" class="cBor">

                </div>
              </div>
             
            </div>
            
          </div>

      <div id="divTransport" style="display:none">
          <div class="row w-100">
          
           <div class="col-sm-4 col-md-4 col-lg-4">                    
            <div id="lrdet" class="cBor"></div>
          </div>
          <div class="col-sm-4 col-md-4 col-lg-4">                    
            <div id="purdetail" class="cBor"></div>
          </div>
           <div class="col-sm-4 col-md-4 col-lg-4" style="display:none" >                    
            <div id="dummyDiv" class="cBor">
            </div>
          </div>
        </div>
      </div>
      <div class="hstack justify-content-end">
        <span id="spTrans"  class="" onclick="showHideTransport()"><b id="transbutton" class="labelText">More...</b></span>
      </div>


      <div class="row">
            <div class="table-container">
                <div class="col-md-12 col-sm-12 garea" id="invoice"></div>
                <div  style="display:none;"><div id="group3" class=""></div></div>
            </div>
      </div>
      <div class="row w-100 mt-3">
        <div class="col-md-4">
          <div class="hstack justify-content-start">
            <div id="saveGrp">
             
                
             
            </div>
          </div>
        </div>
              <div class="col-md-8">
                <div class="p-2 gap-2 bg-white shadow-sm rounded-3">
                  <div class="gap-2 card-dicount px-3 bg-custom rounded-3">
                    <table>
                      <thead>
                        <th style="width:10%;">
                          <span class="text-custom">Gross Amount:</span>
                        </th>
                        <th style="width:10%;">
                          <span class="amount-text" id="gross">0.00</span>
                        </th>
                        <th style="width:10%;">
                          <span class="text-custom">VAT:</span>
                        </th>
                        <th style="width:10%;">
                          <span class="amount-text" id="vat">0.00</span>
                        </th>
    
                        <th style="width:10%;">
                          <span class="text-custom">Disc:</span>
                        </th>
                        <th style="width:10%;">
                          <span class="amount-text" id="disc">0.00</span>
                        </th>
                        <th style="width:10%;display: none;">
                          <span class="text-custom">Roundoff:</span>
                        </th>
                        <th style="width:5%;display: none;">
                          <span class="amount-text" id="round">0.00</span>
                        </th>
                        <th style="width:25%;">
                          <div class="card-total rounded-3">
                            <span class="amount-text ml-2" id="netAmt">Net Amount &nbsp;:&nbsp;</span>
                            <label style="display:none;" id="totalamt"></label>
                          </div>
                        </th>
                      </thead>
                      <tbody>
                      </tbody>
                    </table>
                  </div>
                </div>
            </div>
    </div>

    <!--Content End-->                    
      </div>  
    </div>
  </div>






<div id='attrdlg'>
<div id='productprops' class="pop_lov_box" style="height:250px;display:none"/></div>
<div id='serialdlg'>
<div id='productserial' class="pop_lov_box" style="height:250px;display:none"/></div>
<div id='hamaliData'>
<div id="hamaliDialog" class="pop_lov_box" style="height:250px;display:none">
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


  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/grn.js",screen:[
  {name:"group1",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {colno:0,name:"suppname",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"invno",lovOptions:{url:"/inventory/service/ajax",ajax:"supplier",scrollEnabled:true,searchFromList:false,dsi:2,params:[],results:[{tgt:"suppname",tt:true,id:"0"},{tgt:"suppname",tt:false,id:"1"},{tgt:"name",tt:false,id:"1"},{tgt:"address",tt:false,id:"3,4,5,6",m:true},{tgt:"address1",tt:false,id:"3"},{tgt:"address2",tt:false,id:"4"},{tgt:"city",tt:false,id:"5"},{tgt:"pincode",tt:false,id:"6"},{tgt:"mobile",tt:false,id:"2"},{tgt:"creditdays",tt:false,id:"7"},{tgt:"showmobile",tt:false,id:"2"},{tgt:"showcreditdays",tt:false,id:"7"}]}},
  {colno:0,name:"address",inputType:4,type:"SPAN",caption:"Address",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address2"},  
  {colno:0,name:"name",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address1"},
  {colno:0,name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address2"},
  {colno:0,name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"city"},
  {colno:0,name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"pincode"},
  {colno:0,name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mobile"}
  
  ]},
  {name:"group2",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{name:"showmobile",inputType:4,type:"LABEL",caption:"Mobile",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"invno"},
  {name:"showcreditdays",inputType:4,type:"LABEL",caption:"Credit",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf"},
  {name:"mobile",inputType:0,type:"INT",caption:"Mobile",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"invno"},
  {name:"creditdays",inputType:0,type:"INT",caption:"Credit",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"pf"},
  {name:"dummy1",inputType:4,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf"}
  ]},
  {name:"branch",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"suppname",lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}}
  ]},
  {name:"group4",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"invno",inputType:0,type:"INT",caption:"Inv No",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"invdate"},
  {colno:0,name:"invdate",inputType:0,type:"TDATE",caption:"Inv Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"invamt"},
  {colno:0,name:"invamt",inputType:0,type:"DECIMAL",caption:"Inv Amt",defaultValue:"0","maxValue":9999999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,nf:"invoice_data","chkTag":false}
  ]},
 
  {name:"group6",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
    {colno:2,name:"pono",inputType:0,type:"INT",caption:"PO No/",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"recdthro"},
    {colno:2,name:"showpono",inputType:4,type:"INT",caption:"PO No/",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"recdthro"},
    {colno:2,name:"posno",inputType:0,type:"INT",caption:"PO No/",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"podate"},
    {colno:2,name:"podate",inputType:0,type:"DATE",caption:"PO Date/",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:false,nf:"paymode"},
    {colno:2,name:"showpodate",inputType:4,type:"DATE",caption:"PO Date/",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"paymode"},
    {colno:2,name:"rnno",inputType:0,type:"INT",caption:"GIN No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"rndate"},
    {colno:2,name:"showrnno",inputType:4,type:"INT",caption:"GIN No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"rndate"},
    {colno:2,name:"rndate",inputType:0,type:"DATE",caption:"Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"pono"}
    
  ]
},


  {name:"purdetail",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"recdthro",inputType:0,type:"LOV",caption:"Transport",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf",colspan:2,lovOptions:{url:"/inventory/service/ajax",ajax:"transport",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  {name:"pf",inputType:0,type:"DECIMAL",caption:"P&F",mandatory:false,defaultValue:"0","maxValue":99999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"lrno",colspan:2,onchange:"onTaxChange"},
  {name:"cdisc",inputType:0,type:"DECIMAL",caption:"Cash Disc%",mandatory:false,defaultValue:"0","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"invoice_data",colspan:2,onchange:""},
  {name:"cdiscamt",inputType:0,type:"DECIMAL",caption:"Cash Disc Amt",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"invoice_data",colspan:2,onchange:""},
  ]},
  {name:"lrdet",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  
  {name:"paymode",inputType:1,type:"TEXT",caption:"Payment Mode",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:false},
  {name:"documents",inputType:0,type:"TEXT",caption:"Documents",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"paymode"},
  {name:"lrno",inputType:0,type:"TEXT",caption:"LR No",mandatory:false,defaultValue:"NA","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"lrdate"},
  {name:"lrdate",inputType:0,type:"DATE",caption:"LR Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"pf"},
  {name:"paymode",inputType:1,type:"TEXT",caption:"Payment Mode",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"lrno",visible:false},
  {name:"go",inputType:3,caption:"Go",onclick:"calculateCashDiscount",visible:true}
  ]},
  {name:"dummyDiv",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"dummy1",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true},
  {name:"dummy2",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true}
  ]},
  {name:"invoice",title:"Products",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"product",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[
    {tgt:"invoice_data",tt:false,row:"cr",col:"1",id:"0"},
	{tgt:"invoice_data",tt:true,row:"cr",col:"1",id:"1"} ,
	{tgt:"invoice_data",tt:false,row:"cr",col:"2",id:"2"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"29",id:"5"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"25",id:"6"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"33",id:"7"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"6",id:"8"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"8",id:"9"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"7",id:"10"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"15",id:"9"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"14",id:"10"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"38",id:"13"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"16",id:"14"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"27",id:"16"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"3",id:"17"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"4",id:"18"},
	{tgt:"invoice_data",tt:true,row:"cr",col:"41",id:"19"},
	{tgt:"invoice_data",tt:true,row:"cr",col:"38",id:"20"}
    ]},width:200,chkTag:true,validation:"getAttributeDetail"},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "attribid", name: "AttributeId", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},            
    {order:"6",id: "unitgroup", name: "UnitGroup", field: "unitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "unitname", name: "Units", field: "unitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"invoice_data",row:"cr",col:"6",ft:false}],results:[
    {tgt:"invoice_data",tt:false,row:"cr",col:"7",id:"0"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"8",id:"1"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"38",id:"2"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"14",id:"0"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"15",id:"1"}
    ]},width:80,chkTag:false,validation:""},
    {order:"8",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "batchno", name: "BatchNo", field: "batchno",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"10",id: "batchdt", name: "BatchDt", field: "batchdt",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"11",id: "expdt", name: "ExpDt", field: "expdt",defaultValue:"","inputType":0,"type":"TDATE","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"12",id: "qty", name: "Qty", field: "quantity",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:80,onchange:"onRateQuantityChange",cTotal:true},
    {order:"13",id: "freeqty", name: "Free", field: "freeqty",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:80,onchange:"onRateQuantityChange",cTotal:true,validation:"getSerialDetail"},
    {order:"14",id: "funitname", name: "Units", field: "funitname",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":true,width:0,chkTag:false},
    {order:"15",id: "funitid", name: "unitid", field: "funitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},                    
    {order:"16",id: "unit", name: "Unit", field: "unit",defaultValue:"1","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"17",id: "stock", name: "Stock", field: "stock",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"18",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right",chkTag:true},
	{order:"19",id: "selling", name: "S.Rate", field: "selling",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"right",chkTag:true,onchange:"onRateQuantityChange"},
	{order:"20",id: "mrp", name: "MRP", field: "mrp",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"right",chkTag:true,onchange:"onRateQuantityChange"},    
    {order:"21",id: "discperc", name: "Disc%", field: "discperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:80,onchange:"onRateQuantityChange",align:"right"},
	{order:"22",id: "discamt", name: "Disc Amt", field: "discamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
    {order:"23",id: "cashdiscperc", name: "Cash Disc%", field: "cashdiscperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,onchange:"onRateQuantityChange",align:"right"},
	{order:"24",id: "cashdiscamt", name: "Cash Disc Amount", field: "cashdiscamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,align:"right"},	
    {order:"25",id: "ptaxperc", name: "P.Tax%", field: "ptaxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:80,onchange:"onRateQuantityChange",align:"right"},
	{order:"26",id: "ptaxamt", name: "P.Tax Amt", field: "ptaxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
	{order:"27",id: "srtax", name: "Service Tax%", field: "srtaxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"28",id: "srtaxamt", name: "Service Tax Amount", field: "srtaxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},		
	{order:"29",id: "staxperc", name: "S.Tax%", field: "staxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"right"},
    {order:"30",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:150,cTotal:true,align:"right"},
    {order:"31",id: "netamount", name: "NetAmount", field: "netamount",defaultValue:"y","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:150,cTotal:true,align:"right"},
    {order:"32",id: "csdid", name: "CsdId", field: "csdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"33",id: "taxincl", name: "TaxInclu", field: "taxincl",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"34",id: "taxableamt", name: "TaxableAmt", field: "taxableamt",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"35",id: "impno", name: "impno", field: "impno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"36",id: "impsno", name: "impsno", field: "impsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"37",id: "imptype", name: "imptype", field: "imptype",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":2,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"38",id: "conversionvalue", name: "conversionvalue", field: "conversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"39",id: "basequantity", name: "BaseQuantity", field: "basequantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,cTotal:true,chkTag:true},
    {order:"40",id: "freight", name: "Freight", field: "freight",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"41",id: "netcost", name: "NetCost", field: "netcost",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"42",id: "erate", name: "Rate", field: "erate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":true,width:100,align:"right"},
	{order:"43",id: "eselling", name: "S.Rate", field: "eselling",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:100,align:"right"},
	{order:"44",id: "emrp", name: "MRP", field: "emrp",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"right"},    
    
    ]}},
      /*{name:"group2",height:15,width:45,minWidth:250,minHeight:50,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"pf",inputType:0,type:"DECIMAL",caption:"P&F",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"discount",colspan:2,onchange:"onTaxChange"}
  ]
  },*/
  {name:"group3",height:20,width:45,minWidth:250,minHeight:50,colWidth:98,float:"right",backColor:"biege",contentType:"Fields",
  fields:[  {name:"discamt",inputType:0,type:"DECIMAL",caption:"Total Discount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"taxamt",onchange:"onTaxChange"},
  {name:"taxamt",inputType:0,type:"DECIMAL",caption:"VAT",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"total"},
  {name:"servtaxamt",inputType:0,type:"DECIMAL",caption:"VAT",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"total"},
  {name:"total",inputType:0,type:"DECIMAL",caption:"Total:",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"totalamt"},    
  {name:"totalamt",inputType:0,type:"DECIMAL",caption:"Net Amount",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false}
  ]
  }


]};
  /*
  ,
    {name:"group4",height:15,width:80,minWidth:500,minHeight:50,colWidth:15,float:"left",backColor:"beige",contentType:"Fields",fields:[
    {name:"add",inputType:3,caption:"Add",onclick:"add",visible:true},
    {name:"save",inputType:3,caption:"Save",onclick:"save",visible:true},
    {name:"edit",inputType:3,caption:"Edit",onclick:"edit",visible:true},
    {name:"Delete",inputType:3,caption:"Delete",onclick:"delete1",visible:true}
    ]}
    */
  var screenProps=changeScreenAttributes(210002,sProps);	
  var grnscreen=new FlexUI.Screen("xyz",screenProps);
  
  setDefaultBranch();
  <%if(mode!=null && mode.equals("VIEW")){%>
	  loadDataView(<%=code%>);
	  $('#saveGrp').html('<button type="button" class="btn btn-clear mx-2" onclick="closeScreen()"><span class="mdi mdi-close-box"></span>Close</button>');
		$('#spnSetting').css("display","none");
	<%}else{%>
		$('#spnSetting').css("display","block");
	<%}%>
	//$('#saveGrp').html('<button type="button" class="btn btn-primary mRhAj" onclick="invokeHamaliDialog()">Hamali</button>');

function showHideTransport(){
	if( $('#divTransport').is(':visible') ) {
		$('#divTransport').css("display","none");
		$('#divFirst').css("display","block");
		//$('#transbutton').removeClass("fa fa-minus-circle");
		//$('#transbutton').addClass("fa fa-plus-circle");
		$('#transbutton').html("More...");
	}else{
		$('#divTransport').css("display","block");
		$('#divFirst').css("display","none");
		//$('#transbutton').removeClass("fa fa-plus-circle");
		//$('#transbutton').addClass("fa fa-minus-circle");
		$('#transbutton').html("Less...");
	}
}
 </script>
<iframe src='' style='display:none' id="ppurchase">
</iframe> 
</body>
</html>
