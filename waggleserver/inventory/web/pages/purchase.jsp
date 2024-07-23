<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Purchase</title>
</head>
<body >
<script src="js/attributedialog.js"></script>
<script src="js/serialentrydialog.js"></script>
<script>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
%>

</script>
<script src="js/hamalientrydialog.js"></script>




<div class="card border-0 shadow">
  <div class="card-body lpage">
    <!--Header-->
    <div class="row w-100">
      <div class="col-md-6 d-flex align-items-center">
        <h4 class="header-title">Purchase Invoice</h4>
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
      <div id="callback" class="mt-3">
        <div id="divFirst" style="display:block">
          <div class="row w-100">
            <div class="col-sm-4 col-md-4 col-lg-4 mpzo">                    
                <div id="group1" class="cBor"></div>
            </div>
            <div class="col-sm-4 col-md-4 col-lg-4 mpzo" style="display:none" >                    
                <div id="group2" class="cBor"></div>
            </div>
            <div class="col-sm-4 col-md-4 col-lg-4 mpzo"  >                    
              <div id="purdetail" class="cBor"></div>
            </div>
            <div class="col-sm-4 col-md-4 col-lg-4 mpzo"  >                    
              <div id="invdetail" class="cBor"></div>
            </div>
            
          </div>
      </div>

      <div id="divTransport" style="display:none">
          <div class="row w-100">
            <div class="col-sm-3 col-md-3 col-lg-3 mpzo"  >
              <div class="row mpzo">
                <div id="grndetail" class="col-md-6 cBor"></div>
                <div id="podetail" class="col-md-6 cBor"></div>
              </div>
            </div>
           <div class="col-sm-3 col-md-3 col-lg-3 mpzo"  >                 
             <div id="transport" class="cBor"></div>
           </div>
           <div class="col-sm-3 col-md-3 col-lg-3 mpzo"  >                 
            <div id="roundoff" class="cBor"></div>
          </div>
          <div class="col-sm-3 col-md-3 col-lg-3 mpzo"  >                   
            <div id="lrdet" class="cBor">
            </div>
          </div>
        </div>
      </div>
      <div class="hstack justify-content-end">
        <span id="showMoreButton"  class="" onclick="showHideTransport()"><b id="transbutton" class="labelText">More...</b></span>
      </div>
      <div class="row">
            <div class="table-container">
                <div class="col-md-12 col-sm-12 garea" id="invoice"></div>
            </div>
      </div>
      <div class="row w-100 mt-3">
        <div class="col-md-6">
          <div class="hstack justify-content-start">
            <div id="saveGrp">     
            </div>
          </div>
        </div>
        <div class="col-md-6">
                        <div class="hstack justify-content-end">
                              <div class="p-2 hstack gap-2 bg-white shadow-sm rounded-3">
                                  <div class="hstack gap-2 card-dicount px-3 bg-custom rounded-3">
                                      <h6 class="dicount-type hstack gap-1">
                                          <span class="text-custom">Gross Amount:</span>
                                          <span class="amount-text" id="gross"></span>
                                      </h6>
                                     <div class="vr align-self-auto"></div>
                                     <h6 class="dicount-type hstack gap-1">
                                          <span class="text-custom">Disc:</span>
                                          <span class="amount-text" id="disc"></span>
                                      </h6>
                                     <div class="vr align-self-auto"></div>
                                      <h6 class="dicount-type hstack gap-1">
                                          <span class="text-custom">VAT:</span>
                                          <span class="amount-text" id="vat"></span>
                                      </h6>
                                      <div class="vr align-self-auto"></div>
                                      <h6 class="dicount-type hstack gap-1">
                                          <span class="text-custom">Roundoff:</span>
                                          <span class="amount-text" id="round"></span>
                                      </h6>
                                  </div>
                                  <div class="card-total px-3 rounded-3">
                                    <h5 class="dicount-type hstack gap-1">
                                      <span class="text-dark"><b>Net Amount&nbsp;:</b></span>
                                      <span class="net-amount" id="netAmt"></span>
                                  </h5>
                                  </div>
                                    <div class="col-md-8" style="display:none"><label id="totalamt"></label></div>
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
<div id="hamaliDialog" class="pop_lov_box" style="height:250px;display:none"/></div>
<div id="purreturndata" class="modal" tabindex='-1' role='dialog' aria-hidden='true'>
  
  <div class='modal-dialog' role='document'>
    <div class='modal-header'><h5 class='modal-title'>Debit Notes</h5><button type='button' onclick="cancelPurReturnDialog()" data-bs-dismiss='modal' aria-label='Close'></button></div>
    <div class='modal-content'  >
      <div id='purreturn' class='modal-body' style="height: 250px;">
      </div>
      <div style='height:50px;' class="modal-footer">
        <div class="adCl saVbN" onclick="cancelPurReturnDialog()">Ok</div>
      </div>    
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

  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/purchase.js",screen:[
  {name:"group1",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {name:"suppname",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"billdate",lovOptions:{url:"/inventory/service/ajax",ajax:"supplier",scrollEnabled:true,searchFromList:false,dsi:1,params:[],results:[{tgt:"suppname",tt:true,id:"0"},{tgt:"suppname",tt:false,id:"1"},{tgt:"name",tt:false,id:"1"},{tgt:"address",tt:false,id:"3,4,5,6",m:true},{tgt:"address1",tt:false,id:"3"},{tgt:"address2",tt:false,id:"4"},{tgt:"city",tt:false,id:"5"},{tgt:"pincode",tt:false,id:"6"},{tgt:"mobile",tt:false,id:"2"},{tgt:"creditdays",tt:false,id:"7"},{tgt:"showmobile",tt:false,id:"2"},{tgt:"showcreditdays",tt:false,id:"7"},{tgt:"purtype",tt:false,id:"8"}]}},  
  {name:"name",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address1"},
  {name:"address",inputType:4,type:"SPAN",caption:"Address",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address2"},
  {name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address2"},
  {name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"city"},
  {name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"pincode"},
  {name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mobile"},
  {name:"mobile",inputType:0,type:"TEXT",caption:"Mobile",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"creditdays"},
  {name:"creditdays",inputType:0,type:"INT",caption:"Credit Days",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"purtype"},
  {name:"approved",inputType:0,type:"INT",caption:"Approved",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"purtype"}
  ]},{name:"group2",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{name:"showmobile",inputType:4,type:"LABEL",caption:"Mobile",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"invno"},
  {name:"showcreditdays",inputType:4,type:"LABEL",caption:"Credit",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf"}
  ]},
  {name:"branch",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"suppname",lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}}
  ]},
  {name:"purdetail",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"billno",inputType:0,type:"INT",caption:"GRN No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billdate"},
  {colno:0,name:"showbillno",inputType:4,type:"INT",caption:"No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"billdate"},
  {colno:0,name:"billdate",inputType:0,type:"DATE",caption:"Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"purtype"},
  {colno:0,name:"purtype",inputType:1,type:"TEXT",caption:"Type",keys:"Cash~Credit",values:"C~R",defaultValue:"C","readOnly":false,"chkTag":false,nf:"invno",visible:true}  
  ]
  },
  {name:"invdetail",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
{colno:0,name:"invno",inputType:0,type:"INT",caption:"Inv No",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"invdate"},
  {colno:0,name:"invdate",inputType:0,type:"DATE",caption:"Inv Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"invamt","maxday":"1d"},
  {colno:0,name:"invamt",inputType:0,type:"DECIMAL",caption:"Inv Amt",defaultValue:"0","maxValue":9999999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,nf:"invoice_data","chkTag":false}  
  ]},
  {name:"grndetail",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"rnno",inputType:0,type:"INT",caption:"GIN No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"rndate"},
  {colno:0,name:"pono",inputType:0,type:"INT",caption:"PO No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"podate"},
  {colno:0,name:"showrnno",inputType:4,type:"INT",caption:"GIN No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"rndate"},
  {colno:0,name:"showpono",inputType:4,type:"INT",caption:"PO No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"podate"},

  ]},
  {name:"podetail",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"rndate",inputType:0,type:"DATE",caption:"Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:false,nf:"pono"},
  {colno:0,name:"posno",inputType:0,type:"INT",caption:"PO No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"podate"},
  {colno:0,name:"podate",inputType:0,type:"DATE",caption:"Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:false,nf:"recdthro"},
  {colno:0,name:"showrndate",inputType:4,type:"DATE",caption:"Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"pono"},
  {colno:0,name:"showpodate",inputType:4,type:"DATE",caption:"Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"recdthro"}
  ]},
  {name:"transport",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"recdthro",inputType:0,type:"LOV",caption:"Transport",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf",colspan:2,lovOptions:{url:"/inventory/service/ajax",ajax:"transport",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  {name:"pf",inputType:0,type:"DECIMAL",caption:"P&F",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"cdisc",colspan:2,onchange:"onTaxChange"},
  {name:"cdisc",inputType:0,type:"DECIMAL",caption:"Cash Disc%",mandatory:false,defaultValue:"0","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"invoice_data",colspan:2,onchange:""},
  {name:"cdiscamt",inputType:0,type:"DECIMAL",caption:"Cash Disc Amt",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"invoice_data",colspan:2,onchange:""},
  {name:"paymode",inputType:1,type:"TEXT",caption:"Payment Mode",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"lrno",visible:false}
  ]},

  {name:"lrdet",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"ordertype",inputType:0,type:"TEXT",caption:"Order Type",mandatory:false,defaultValue:"PU","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"pf"},
  {name:"documents",inputType:0,type:"TEXT",caption:"Documents",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"paymode"},
  {name:"lrno",inputType:0,type:"TEXT",caption:"LR No",mandatory:false,defaultValue:"NA","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"lrdate"},
  {name:"lrdate",inputType:0,type:"DATE",caption:"LR Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"invoice_data"},
  {name:"paymode",inputType:1,type:"TEXT",caption:"Payment Mode",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"lrno",visible:false},
  {name:"dummy3",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:false}
  ]},  {name:"roundoff",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  
  fields:[
  {name:"roundedoff",inputType:0,type:"NEGDEC",caption:"Round Off",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"lrno",onchange:"onTaxChange"},
  {name:"dummy2",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true},
  {name:"go",inputType:3,caption:"Go",onclick:"calculateCashDiscount",visible:true}    
  ]},
  
  {name:"invoice",title:"Products",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"product",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[
    {tgt:"invoice_data",tt:false,row:"cr",col:"1",id:"0"},
	{tgt:"invoice_data",tt:true,row:"cr",col:"1",id:"1"} ,
	{tgt:"invoice_data",tt:false,row:"cr",col:"2",id:"2"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"30",id:"5"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"26",id:"6"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"34",id:"7"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"6",id:"8"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"8",id:"9"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"7",id:"10"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"15",id:"9"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"14",id:"10"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"39",id:"13"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"16",id:"14"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"28",id:"16"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"3",id:"17"},
	{tgt:"invoice_data",tt:false,row:"cr",col:"4",id:"18"},
	{tgt:"invoice_data",tt:true,row:"cr",col:"42",id:"19"},
	{tgt:"invoice_data",tt:true,row:"cr",col:"39",id:"20"}
	]},width:200,chkTag:true,validation:"getAttributeDetail"},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "attribid", name: "AttributeId", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},        
    {order:"6",id: "unitgroup", name: "UnitGroup", field: "unitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "unitname", name: "Units", field: "unitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"invoice_data",row:"cr",col:"6",ft:false}],results:[
    {tgt:"invoice_data",tt:false,row:"cr",col:"7",id:"0"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"8",id:"1"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"39",id:"2"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"14",id:"0"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"15",id:"1"}]},width:80,chkTag:false,validation:""},
    {order:"8",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "batchno", name: "BatchNo", field: "batchno",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":!showExpiry,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"10",id: "batchdt", name: "BatchDt", field: "batchdt",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"11",id: "expdt", name: "ExpDt", field: "expdt",defaultValue:"","inputType":0,"type":"TDATE","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":!showExpiry,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"12",id: "qty", name: "Qty", field: "quantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",cTotal:true},
    {order:"13",id: "freeqty", name: "Free", field: "freeqty",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:80,onchange:"onRateQuantityChange",cTotal:true,validation:"getSerialDetail"},
    {order:"14",id: "funitname", name: "Units", field: "funitname",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":true,width:0,chkTag:false},
    {order:"15",id: "funitid", name: "unitid", field: "funitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},            
    {order:"16",id: "unit", name: "Unit", field: "unit",defaultValue:"1","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"17",id: "stock", name: "Stock", field: "stock",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"18",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:100,onchange:"onRateQuantityChange",align:"right",chkTag:true,validation:"checkPrevPurchaseRate"},
	{order:"19",id: "selling", name: "S.Rate", field: "selling",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right",onchange:"onRateQuantityChange",chkTag:true},
	{order:"20",id: "mrp", name: "MRP", field: "mrp",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right",onchange:"onRateQuantityChange",chkTag:true,validation:"checkPrevPurchaseMrp"},    
    {order:"21",id: "discperc", name: "Disc%", field: "discperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"22",id: "discamt", name: "Disc Amt", field: "discamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
	
	{order:"23",id: "schemediscount", name: "Sch.Disc Amt", field: "schemediscount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right",onchange:"onRateQuantityChange"},
	
    {order:"24",id: "cashdiscperc", name: "Cash Disc%", field: "cashdiscperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,onchange:"onRateQuantityChange",align:"right"},
	{order:"25",id: "cashdiscamt", name: "Cash Disc Amount", field: "cashdiscamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,align:"right"},	
    {order:"26",id: "ptaxperc", name: "P.Tax%", field: "ptaxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right",validation:"checkPrevPurchaseTax"},
	{order:"27",id: "ptaxamt", name: "P.Tax Amount", field: "ptaxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
	{order:"28",id: "srtax", name: "Service Tax%", field: "srtaxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"29",id: "srtaxamt", name: "Service Tax Amount", field: "srtaxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},		
	{order:"30",id: "staxperc", name: "S.Tax%", field: "staxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"right"},
    {order:"31",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"32",id: "netamount", name: "NetAmount", field: "netamount",defaultValue:"y","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"33",id: "csdid", name: "CsdId", field: "csdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"34",id: "taxincl", name: "TaxInclu", field: "taxincl",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"35",id: "taxableamt", name: "TaxableAmt", field: "taxableamt",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"36",id: "impno", name: "impno", field: "impno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"37",id: "impsno", name: "impsno", field: "impsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"38",id: "imptype", name: "imptype", field: "imptype",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":2,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"39",id: "conversionvalue", name: "conversionvalue", field: "conversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"40",id: "basequantity", name: "BaseQuantity", field: "basequantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,cTotal:true,chkTag:true},
    {order:"41",id: "freight", name: "Freight", field: "freight",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"42",id: "netcost", name: "NetCost", field: "netcost",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"43",id: "erate", name: "Rate", field: "erate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":true,width:100,align:"right"},
	{order:"44",id: "eselling", name: "S.Rate", field: "eselling",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:100,align:"right"},
	{order:"45",id: "emrp", name: "MRP", field: "emrp",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"right"},    
    {order:"46",id: "prevmrp", name: "Prev.MRP", field: "prevmrp",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:0,align:"right"},
    {order:"47",id: "prevptax", name: "Prev.Tax", field: "prevptax",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:0,align:"right"},
    {order:"48",id: "prevrate", name: "Prev.Rate", field: "prevrate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:0,align:"right"}
    ]}},
    /*
      {name:"group2",height:15,width:45,minWidth:250,minHeight:50,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"pf",inputType:0,type:"DECIMAL",caption:"P&F",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"discount",colspan:2,onchange:"onTaxChange"}
  ]
  },*/  
  {name:"group3",height:20,width:45,minWidth:250,minHeight:50,colWidth:98,float:"right",backColor:"biege",contentType:"Fields",
  fields:[  {name:"discamt",inputType:0,type:"DECIMAL",caption:"Total Discount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"taxamt",onchange:"onTaxChange"},
  {name:"taxamt",inputType:0,type:"DECIMAL",caption:"VAT",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"total"},
  {name:"servtaxamt",inputType:0,type:"DECIMAL",caption:"Service Tax",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  {name:"total",inputType:0,type:"DECIMAL",caption:"Total:",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"totalamt"},    
  {name:"totalamt",inputType:0,type:"DECIMAL",caption:"Net Amount",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false},
  {name:"purreturnamt",inputType:0,type:"DECIMAL",caption:"Return Amount",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false}
  ]
  },
  {name:"purreturn",title:"Purchase Returns",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,optional:true,columns:[
    {order:"0",id: "psno", name: "SNo", field: "psno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "returnno", name: "Return No", field: "returnno",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,"chkTag":true,lovOptions:{url:"/inventory/service/ajax",ajax:"pendingpurreturns",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"suppcode",src:"suppname",ft:true},{n:"code",src:"code",ft:false},{n:"branch",src:"branch",ft:true}],results:[
    {tgt:"purreturn_data",tt:false,row:"cr",col:"1",id:"1"},
    {tgt:"purreturn_data",tt:true,row:"cr",col:"1",id:"0"},
    {tgt:"purreturn_data",tt:false,row:"cr",col:"2",id:"3"},
    {tgt:"purreturn_data",tt:false,row:"cr",col:"3",id:"1"}
    ]},width:200,validation:""},
    {order:"2",id: "returnamt", name: "Amount", field: "returnamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:100,chkTag:false,validation:""},
    {order:"3",id: "returncode", name: "Code", field: "returncode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,chkTag:false,validation:""}
    ]}}]};
  /*
  ,
    {name:"group4",height:15,width:80,minWidth:500,minHeight:50,colWidth:15,float:"left",backColor:"beige",contentType:"Fields",fields:[
    {name:"add",inputType:3,caption:"Add",onclick:"add",visible:true},
    {name:"save",inputType:3,caption:"Save",onclick:"save",visible:true},
    {name:"edit",inputType:3,caption:"Edit",onclick:"edit",visible:true},
    {name:"Delete",inputType:3,caption:"Delete",onclick:"delete1",visible:true}
    ]}
    */
  var screenProps=changeScreenAttributes(210003,sProps);
  var purchasescreen=new FlexUI.Screen("xyz",screenProps);
  setDefaultBranch();
  screenObjects.getScreenObject("code").setValue("0");
  <%if(mode!=null && mode.equals("VIEW")){%>
	  loadDataView(<%=code%>);
    $('#saveGrp').html('<button type="button" class="btn btn-clear mx-2" onclick="closeScreen()"><span class="mdi mdi-close-box"></span>Close</button>');
	  $('#spnSetting').css("display","none");
	<%}else{%>
		$('#spnSetting').css("display","block");
	<%}%>
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
