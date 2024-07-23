<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Professional Product Master</title>
</head>
<body>
<script src="js/attributedialog.js"></script>
<script src="js/serialentrydialog.js"></script>
<script>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
%>
</script>

    	 

<div class="card border-0" id="callback">
		<div class="card-body">
          <div class="row w-100 mb-3">
            <div class="col-md-6 d-flex align-items-center">
              <h4 class="header-title">Professional Products</h4>
            </div>
            <div class="col-md-6 d-flex text-right">                    
                <div id="group1" class="col-md-7">
                </div>
            </div>
          </div>
          <div class="row" id="jqcontainer" >
            <div class="table-container" >
              <div id="products" class="bpage" > </div>
            </div>  
          </div>

          <div class="row w-100 mt-3">
            <div class="col-md-3">
              <div class="hstack justify-content-start">
                <div id="saveGrp">
                    <button type="button" class="btn btn-save" onclick='onSaveClicked()'><span class="mdi mdi-check-circle-outline me-2"></span>Save</button>
                </div>
              </div>
            </div>
          </div>

    </div>
</div>


<script>
  	var l=new FlexUI.Ajax();
  var sProps={
    title:{height:30,width:100,name:"AMC"},
    container:{id:"callback",isdialog:false},
    js:"",
    screen:[
  {name:"group1",title:"",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",pcolumns:2,
  fields:[
    {colno:0,name:"mobile",inputType:0,type:"TEXT",caption:"Mobile",mandatory:false,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"name"},  
    {colno:0,name:"name",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"go",lovOptions:{url:"/inventory/service/ajax",ajax:"professional",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"name",tt:false,id:"0"},{tgt:"name",tt:true,id:"1"}]}},  
    {colno:1,name:"go",inputType:3,caption:"Go",onclick:"loadProfessionalProduct",visible:true},
    
  ]
  },
  {name:"products",title:"Product Details",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",
  tableProperties:{rowEmptyCheckColumn:1,optional:true,
    columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:20,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"y","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"productwotax",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"products_data",tt:false,row:"cr",col:"1",id:"0"},{tgt:"products_data",tt:true,row:"cr",col:"1",id:"1"},{tgt:"products_data",tt:false,row:"cr",col:"2",id:"2"},{tgt:"products_data",tt:false,row:"cr",col:"3",id:"3"},{tgt:"products_data",tt:false,row:"cr",col:"4",id:"4"}]},width:100,chkTag:true},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "minqty", name: "Min.Qty", field: "minqty",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"right"},
    {order:"6",id: "maxqty", name: "Max.Qty", field: "maxqty",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"right"}
    ]
    }}
  ]};
  var profProduct=new FlexUI.Screen("prof",sProps);
  function onSaveClicked(id,me){
    profProduct.setOperation("EDIT");
	var d=profProduct.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		var r=s.callAjax("POST","/inventory/service/professional/products",d);
		if(r.result=="Success"){
			setErrorMessage(r.message);
			profProduct.clearScreen();
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadProfessionalProduct(){
    var code=screenObjects.getScreenObject("name").getTag();
    if(code!='0' && code!=""){
	  	var	url="/inventory/service/professional/products";
	  	var	data="code="+code+"";
		var v=l.callAjax("GET",url,data);
		profProduct.loadData(v);
	 }
	 return true;
  }
</script> 
</body>
</html>