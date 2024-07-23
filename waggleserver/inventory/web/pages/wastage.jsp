<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Damage/Wastage</title>
</head>
<body>
<script src="js/attributedialog.js"></script>
<script src="js/serialentrydialog.js"></script>
<script>
<%
  String mode=request.getParameter("mode");
  String code=request.getParameter("code");
%>
</script>


<div class="card border-0 shadow">
  <div class="card-body lpage">
    <!--Header-->
    <div class="row w-100">
      <div class="col-md-6 d-flex align-items-center">
        <h4 class="header-title">Damage/Wastage</h4>
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
              <div class="col-sm-3 col-md-3 col-lg-3" style="display:none">                    
                <div id="group1" class=""></div>
              </div>
              <div class="col-sm-3 col-md-3 col-lg-3" style="display:none" >                    
              <div id="group2" class="">
              </div>
              </div>
              <div class="col-sm-12 col-md-12 col-lg-12" >                    
                <div id="purdetail" class="cBor">
                </div>
              </div>
              <div class="col-sm-3 col-md-3 col-lg-3"  style="display:none" >                    
                <div id="group4" class="">
                </div>
              </div>
              
            </div>
          </div>

        <div class="row">
              <div class="table-container">
                  <div class="col-md-12 col-sm-12 garea" id="return"></div>
                  <div  style="display:none;">   
                    <div id="group3" class="">

                    </div>
                  </div>
              </div>
        </div>
      <div class="row w-100 mt-3">
        <div class="col-md-4">
          <div class="hstack justify-content-start">
            <div id="saveGrp"> 

            </div>
          </div>
        </div>
        <div class="col-md-6"></div>
        <div class="col-md-2">
          <div class="p-2 gap-2 bg-white shadow-sm rounded-3">
              <table>
                <thead>
                  <th style="width:25%;">
                    <div class="card-total rounded-3 " >
                      Net Amount &nbsp;:&nbsp; <span class="amount-text ml-2" id="netAmt"></span>
                      <label style="display:none;" id="totalamt"></label>
                    </div>
                  </th>
                </thead>
                <tbody>
                </tbody>
              </table>
         </div>
    <!--Content End-->                    
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

  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/wastage.js",screen:[
  {name:"group1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {colno:0,name:"suppname",inputType:0,type:"LOV",caption:"Name",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"returndate",lovOptions:{url:"/inventory/service/ajax",ajax:"supplier",scrollEnabled:true,searchFromList:false,dsi:2,params:[],results:[{tgt:"suppname",tt:true,id:"0"},{tgt:"suppname",tt:false,id:"1"},{tgt:"name",tt:false,id:"1"},{tgt:"address",tt:false,id:"3,4,5,6",m:true},{tgt:"address1",tt:false,id:"3"},{tgt:"address2",tt:false,id:"4"},{tgt:"city",tt:false,id:"5"},{tgt:"pincode",tt:false,id:"6"},{tgt:"mobile",tt:false,id:"2"},{tgt:"creditdays",tt:false,id:"7"},{tgt:"showmobile",tt:false,id:"2"},{tgt:"showcreditdays",tt:false,id:"7"}]}},  
  {colno:0,name:"name",inputType:0,type:"TEXT",caption:"Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address1"},
  {colno:0,name:"address",inputType:4,type:"SPAN",caption:"Address",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address2"},
  {colno:0,name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address2"},
  {colno:0,name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"city"},
  {colno:0,name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"pincode"},
  {colno:0,name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"returntype"},
  {colno:0,name:"mobile",inputType:0,type:"TEXT",caption:"Mobile",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"returntype"}
  ]},
    {name:"group2",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{name:"showmobile",inputType:4,type:"LABEL",caption:"Mobile",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"invno"},
  {name:"showcreditdays",inputType:4,type:"LABEL",caption:"Credit Days",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf"},
  {name:"dummy1",inputType:4,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf"}
  ]},
  
  {name:"branch",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"returntype",lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}}
  ]},
  {name:"purdetail",title:"",pcolumns:4,colcss:"col-sm-4 col-md-4 col-lg-4",height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"dummy2",inputType:4,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"pf"},
  {colno:0,name:"returnno",inputType:0,type:"INT",caption:"No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"returndate"},
  {colno:2,name:"dummy3",inputType:4,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"pf"},
  {colno:2,name:"showreturnno",inputType:4,type:"INT",caption:"ReturnNo",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"returndate"},
  {colno:1,name:"dummy4",inputType:4,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf"},
  {colno:1,name:"returndate",inputType:0,type:"DATE",caption:"Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"return_data"},
  {colno:0,name:"returntype",inputType:1,type:"TEXT",caption:"Type",keys:"Damage~Wastage",values:"D~W",defaultValue:"D","readOnly":false,"chkTag":false,nf:"returndate",visible:true}  
  ]},
  {name:"return",title:"Products",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"wastageproducts",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[
        {tgt:"return_data",tt:false,row:"cr",col:"1",id:"0"},
    {tgt:"return_data",tt:true,row:"cr",col:"1",id:"1"},
    {tgt:"return_data",tt:false,row:"cr",col:"2",id:"2"},
    {tgt:"return_data",tt:false,row:"cr",col:"6",id:"8"},
    {tgt:"return_data",tt:false,row:"cr",col:"8",id:"12"},
    {tgt:"return_data",tt:false,row:"cr",col:"7",id:"10"},
    {tgt:"return_data",tt:false,row:"cr",col:"3",id:"17"},
    {tgt:"return_data",tt:false,row:"cr",col:"4",id:"18"},
    {tgt:"return_data",tt:false,row:"cr",col:"23",id:"13"},
    {tgt:"return_data",tt:false,row:"cr",col:"13",id:"14"},
    {tgt:"return_data",tt:false,row:"cr",col:"25",id:"15"},
    {tgt:"return_data",tt:false,row:"cr",col:"26",id:"19"},
    {tgt:"return_data",tt:false,row:"cr",col:"27",id:"20"}
    ]},width:200,chkTag:true,validation:"getAttributeDetail"},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "attribid", name: "AttributeId", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},        
    {order:"6",id: "unitgroup", name: "UnitGroup", field: "unitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "unitname", name: "Units", field: "unitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[
    {n:"unitgroup",src:"return_data",row:"cr",col:"6",ft:false}],
    results:[
    {tgt:"return_data",tt:false,row:"cr",col:"7",id:"0"},
    {tgt:"return_data",tt:false,row:"cr",col:"8",id:"1"},
    {tgt:"return_data",tt:false,row:"cr",col:"23",id:"2"}]},width:80,chkTag:false,validation:""},
    {order:"8",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "batchno", name: "BatchNo", field: "batchno",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"10",id: "batchdt", name: "BatchDt", field: "batchdt",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"11",id: "expdt", name: "ExpDt", field: "expdt",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"12",id: "qty", name: "Qty", field: "quantity",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:100,onchange:"onRateQuantityChange",cTotal:true,validation:"getSerialDetail"},    
    {order:"13",id: "unit", name: "Unit", field: "unit",defaultValue:"1","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"14",id: "stock", name: "Stock", field: "stock",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"15",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:100,onchange:"onRateQuantityChange",align:"right"},
    {order:"16",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"17",id: "netamount", name: "NetAmount", field: "netamount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"18",id: "csdid", name: "CsdId", field: "csdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"19",id: "impno", name: "impno", field: "impno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"20",id: "impsno", name: "impsno", field: "impsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"21",id: "imptype", name: "imptype", field: "imptype",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":2,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"22",id: "isdid", name: "IsdId", field: "isdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"23",id: "conversionvalue", name: "conversionvalue", field: "conversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"24",id: "basequantity", name: "BaseQuantity", field: "basequantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"25",id: "allownegative", name: "AllowNegative", field: "allownegative",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"26",id: "composite", name: "Composite", field: "composite",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"27",id: "updatestock", name: "UpdateStock", field: "updatestock",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false}
    ]}},
  {name:"group4",height:20,width:45,minWidth:250,minHeight:50,colWidth:98,float:"right",backColor:"biege",contentType:"Fields",
  fields:[    
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
  var screenProps=changeScreenAttributes(210006,sProps);

  var wastagescreen=new FlexUI.Screen("xyz",screenProps);
  setDefaultBranch();
  <%if(mode!=null && mode.equals("VIEW")){%>
	  loadDataView(<%=code%>);
    $('#saveGrp').html('<button type="button" class="btn btn-clear mx-2" onclick="closeScreen()"><span class="mdi mdi-close-box"></span>Close</button>');
	<%}%>
 </script>
<iframe src='' style='display:none' id="ppurchase">
</iframe> 
</body>
</html>
