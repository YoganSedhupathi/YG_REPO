<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Invoice</title>
</head>
<body>
<script>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String userId=(String)session.getAttribute("LOGIN_ID");
%>
var userName='<%=userId%>';
</script>
<script src="js/attributedialog.js"></script>
<script src="js/serialentrydialog.js"></script>
<script src="js/inputvalidation.js"></script>
<script src="js/tenderdialog.js"></script>


 <div class="card border-0 shadow">
        <div class="card-body lpage">
          <!--Header-->
          <div class="row w-100">
            <div class="col-md-6 d-flex align-items-center">
              <h4 class="header-title">Stock Update</h4>
            </div>
            <div  class="col-md-6 text-right" id="addGrp"></div>
            <div  class="col-md-6 text-right" id="saveGrp" style='display:none'>
              <div class="mb-3">
                <button type="button" class="btn btn-edit" onclick='onSaveClicked()'><span class="mdi mdi-check-circle-outline me-2"></span>Save</button>
                <button type="button" class="btn btn-clear mx-3" onclick='hideMasterData()'><span class="mdi mdi-refresh me-2"></span>Cancel</button>
              </div>
            </div>
          </div>
          <!--Header End-->
          <!--Content -->
            <div class="row" id="jqcontainer" style="display:none;">
              <div class="table-container">
                <div id="xyz" class="w-100">
      
                </div>
              </div>
            </div>	
            <div id="callback">
              <div class="row w-100">
                <div class="col-sm-4 col-md-4 col-lg-4">                    
                  <div id="group1" class=""></div>
                </div>
                
                <div class="col-sm-3 col-md-3 col-lg-3" style="display:block" >                    
                 <div id="branch" class="">
                 </div>
                </div>
              </div> 
               <div class="row">
                       <div class="table-container">
                           <div class="col-md-12 col-sm-12 garea" id="stocks"></div>
                           <div class="col-md-12 col-sm-12 garea" id="group3" style="display:none"></div>
                      </div>
                </div>
                <div class="row w-100 mt-3">
                  <div class="col-md-3">
                    <div class="hstack justify-content-start">
                      <div id="saveGrp">
                          <button type="button" class="btn btn-clear" onclick='add()'><span class="mdi mdi-refresh"></span>Clear</button>
                          <button type="button" class="btn btn-save" onclick='save()'><span class="mdi mdi-check-circle-outline me-2"></span>Save</button>
                      </div>
                    </div>
                  </div>
               </div>
              </div>
           </div>
      
          <!--Content End-->
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


  var sProps={title:{height:25,width:100,name:"Sales Return"},initfocus:"custtype",container:{id:"callback",isdialog:false},js:"js/validations/stockupdate.js",screen:[
  {name:"group1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {colno:0,name:"tranno",inputType:0,type:"INT",caption:"Tran No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billdate"},
  {colno:0,name:"billdate",inputType:0,type:"DATE",caption:"Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"stocks_data"}
  ]},
  {name:"branch",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"billdate",lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}}
  ]},
  {name:"stocks",title:"Products",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"saleproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[
    {tgt:"stocks_data",tt:false,row:"cr",col:"1",id:"0"},
    {tgt:"stocks_data",tt:true,row:"cr",col:"1",id:"1"},
    {tgt:"stocks_data",tt:false,row:"cr",col:"2",id:"2"},
    {tgt:"stocks_data",tt:false,row:"cr",col:"6",id:"8"},
    {tgt:"stocks_data",tt:false,row:"cr",col:"7",id:"10"},
    {tgt:"stocks_data",tt:false,row:"cr",col:"8",id:"12"},
    {tgt:"stocks_data",tt:false,row:"cr",col:"12",id:"12"},
    {tgt:"stocks_data",tt:false,row:"cr",col:"23",id:"13"},
    {tgt:"stocks_data",tt:false,row:"cr",col:"3",id:"17"},
    {tgt:"stocks_data",tt:false,row:"cr",col:"4",id:"18"}
    ]},width:200,chkTag:true,validation:"getAttributeDetail"},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "attribid", name: "AttributeId", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},            
    {order:"6",id: "unitgroup", name: "UnitGroup", field: "unitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "unitname", name: "Units", field: "unitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"stocks_data",row:"cr",col:"3",ft:false}],results:[
    {tgt:"stocks_data",tt:false,row:"cr",col:"7",id:"0"},
    {tgt:"stocks_data",tt:false,row:"cr",col:"8",id:"1"},
    {tgt:"stocks_data",tt:false,row:"cr",col:"23",id:"2"}
    ]},width:80,chkTag:false,validation:""},
    {order:"8",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "batchno", name: "BatchNo", field: "batchno",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"10",id: "batchdt", name: "BatchDt", field: "batchdt",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"11",id: "expdt", name: "ExpDt", field: "expdt",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"12",id: "unit", name: "Unit", field: "unit",defaultValue:"1","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"13",id: "stock", name: "Stock", field: "stock",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:100,chkTag:false},
    {order:"14",id: "mrp", name: "Mrp", field: "mrp",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:100,align:"right"},    
    {order:"15",id: "selling", name: "Selling", field: "selling",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:100,align:"right"},
    {order:"16",id: "nbatchno", name: "New BatchNo", field: "nbatchno",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":false,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"17",id: "nbatchdt", name: "New BatchDt", field: "nbatchdt",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"18",id: "nexpdt", name: "New ExpDt", field: "nexpdt",defaultValue:"","inputType":0,"type":"TDATE","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":false,"mandatory":showExpiry,width:ew,chkTag:false,validation:"checkdate"},
    {order:"19",id: "nqty", name: "Actual Qty", field: "nquantity",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:100,chkTag:false},            
    {order:"20",id: "nmrp", name: "New Mrp", field: "nmrp",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:100,align:"right"},    
    {order:"21",id: "nselling", name: "New Selling", field: "nselling",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:100,onchange:"onRateQuantityChange",align:"right"},
    {order:"22",id: "csdid", name: "CsdId", field: "csdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"23",id: "conversionvalue", name: "conversionvalue", field: "conversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"24",id: "basequantity", name: "BaseQuantity", field: "basequantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false}
    ]}}]};
  //var screenProps=changeScreenAttributes(210008,sProps);
  var stockupdate=new FlexUI.Screen("stockupdate",sProps);
  add('');



 </script>
</body>
</html>
