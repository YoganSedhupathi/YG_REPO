<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8" name="viewport" content= "width=device-width, initial-scale=1.0">
  <title>Products</title>
</head>
<body>

	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Products</h4>
				</div>
				<div  class="col-md-6 text-right" id="addGrp"></div>
				<div  class="col-md-6 text-right" id="saveGrp" style='display:none'>
					<div class="mb-3">
						<button type="button" class="btn btn-edit" onclick='onSaveClicked()'><span class="mdi mdi-check-circle-outline me-2"></span>Save</button>
						<button type="button" class="btn btn-clear mx-3" onclick='hideMasterData()'><span class="mdi mdi-refresh me-2"></span>Cancel</button>
					</div>
				</div>
			</div>
			
			<div class="row w-100" id="jqcontainer" > <div class="table-container"><div id="xyz" class="w-100"></div></div></div>	
			<div id="callback" style="display:none">
				<div class="table-container">
					<div class="row w-100 ml-8">  
						<div class="row w-100"> 
							<div id="group1" class="row"></div>
						</div>
						<div class="row w-100"> 
							<div id="inventory" class="row"></div>
						</div>
						<div class="row w-100" style="display: none;">
							<div id="taxconfig" class="row w-100" style="height:200px;"> </div>					
						</div>
						<div class="row w-100">
							<div id="group2" class="row">
								<div class="subHe">Product Image</div>
								<div id="d_imagepath" class="form-group mbotto">
									<div class="col-sm-9 mpRes">
										<form id="uploadImage" name="uploadImage" action="/inventory/service/uploadimage" method="POST" enctype="multipart/form-data" target="uploader_iframe">
											<div class="row">
												<div class="col-sm-6 mpRes">
													<input type="file" name="fileUpload" id="fileUpload"/>
													<input type="hidden" name="groupid" name="groupid"/>
												</div>
												<div class="col-sm-3 mpRes">
													<button type="button" class="btn btn-clear mx-3"  onclick="saveDocuments()"><span class="mdi mdi-filter-variant">Upload Image</span></button>
												</div>
											</div>
										</form>
										<iframe id="uploader_iframe" name="uploader_iframe" style="display: none;"></iframe>
									</div>
								</div>
							</div>
					</div>
						<div class="row w-100">
							<div id="taxinfo" class="row w-100"></div>
						</div>
						<div class="row w-100">
							<div id="rackinfo" class="row"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
<script>
  	var l=new FlexUI.Ajax();
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Product Details",pcolumns:3,colcss:"col-sm-4 col-md-4 col-lg-4",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{colno:1,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"productname"},
  	{colno:0,name:"productname",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"group","validation":"validatespace"},
  	{colno:1,name:"group",inputType:0,type:"LOV",caption:"Group",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"manufacturer",lovOptions:{url:"/inventory/service/ajax",ajax:"productgroup",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"group",tt:true,id:"1"},{tgt:"group",tt:false,id:"0"},{tgt:"isserialized",tt:false,id:"2"},{tgt:"hasbatch",tt:false,id:"3"},{tgt:"hasexpiry",tt:false,id:"4"},{tgt:"isservice",tt:false,id:"5"},{tgt:"hasattribute",tt:false,id:"6"}]}},
  	{colno:2,name:"manufacturer",inputType:0,type:"LOV",caption:"Brand",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"maincategory",lovOptions:{url:"/inventory/service/ajax",ajax:"manufacturer",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"manufacturer",tt:true,id:"1"},{tgt:"manufacturer",tt:false,id:"0"}]}},
  	{colno:2,name:"imagepath",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mrp"},
  	
  	{colno:0,name:"maincategory",inputType:0,type:"LOV",caption:"Main Category",mandatory:true,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"subcategory1",lovOptions:{url:"/inventory/service/ajax",ajax:"maincategory",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"maincategory",tt:true,id:"1"},{tgt:"maincategory",tt:false,id:"0"}]}},
  	{colno:1,name:"subcategory1",inputType:0,type:"LOV",caption:"Sub Category11",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"subcategory2",lovOptions:{url:"/inventory/service/ajax",ajax:"subcategory",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"category",src:"maincategory",ft:true}],results:[{tgt:"subcategory1",tt:true,id:"1"},{tgt:"subcategory1",tt:false,id:"0"}]}},
  	{colno:2,name:"subcategory2",inputType:0,type:"LOV",caption:"Sub Category2",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"generic",lovOptions:{url:"/inventory/service/ajax",ajax:"subcategory",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"category",src:"subcategory1",ft:true}],results:[{tgt:"subcategory2",tt:true,id:"1"},{tgt:"subcategory2",tt:false,id:"0"}]}},
  	
  	{colno:0,name:"generic",inputType:0,type:"LOV",caption:"Generic",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"consumetype",lovOptions:{url:"/inventory/service/ajax",ajax:"generic",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"generic",tt:true,id:"1"},{tgt:"generic",tt:false,id:"0"}]}},
  	{colno:1,name:"consumetype",inputType:0,type:"LOV",caption:"Type",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"marketedby",lovOptions:{url:"/inventory/service/ajax",ajax:"consumetype",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"consumetype",tt:true,id:"1"},{tgt:"consumetype",tt:false,id:"0"}]}},
  	{colno:2,name:"marketedby",inputType:0,type:"LOV",caption:"Marketed By",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"unitgroup",lovOptions:{url:"/inventory/service/ajax",ajax:"manufacturer",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"marketedby",tt:true,id:"1"},{tgt:"marketedby",tt:false,id:"0"}]}}
  	]},
  	{name:"inventory",title:"Inventory Configuration",pcolumns:3,colcss:"col-sm-4 col-md-4 col-lg-4",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[
	{colno:1,name:"baseunit",inputType:0,type:"LOV",caption:"Base Unit",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"unitgroup",lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  	{colno:0,name:"unitgroup",inputType:0,type:"LOV",caption:"Unit Group",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"purchaseunit",lovOptions:{url:"/inventory/service/ajax",ajax:"unitgroup",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"unitgroup",tt:true,id:"1"},{tgt:"unitgroup",tt:false,id:"0"},{tgt:"baseunit",tt:false,id:"2"},{tgt:"purchaseunit",tt:true,id:"2"},{tgt:"saleunit",tt:true,id:"2"},{tgt:"transferunit",tt:true,id:"2"},{tgt:"purchaseunit",tt:false,id:"3"},{tgt:"saleunit",tt:false,id:"3"},{tgt:"transferunit",tt:false,id:"3"}]}},  
  	{colno:1,name:"purchaseunit",inputType:0,type:"LOV",caption:"Purchase Unit",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"saleunit",lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"unitgroup",ft:true}],results:[]}},
  	{colno:2,name:"saleunit",inputType:0,type:"LOV",caption:"Sales Unit",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"transferunit",lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"unitgroup",ft:true}],results:[]}},
  	{colno:0,name:"transferunit",inputType:0,type:"LOV",caption:"Transfer Unit",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"inventorytype",lovOptions:{url:"/inventory/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"unitgroup",ft:true}],results:[]}},
  	{colno:1,name:"inventorytype",inputType:0,type:"LOV",caption:"Inventory Type",mandatory:false,defaultValue:"1","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"purrate",lovOptions:{url:"/inventory/service/ajax",ajax:"inventorytypes",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"inventorytype",tt:true,id:"1"},{tgt:"inventorytype",tt:false,id:"0"},{tgt:"purchasable",tt:false,id:"2"},{tgt:"salable",tt:false,id:"3"},{tgt:"composite",tt:false,id:"4"},{tgt:"livestock",tt:false,id:"5"},{tgt:"isbulk",tt:false,id:"6"},{tgt:"costtype",tt:false,id:"7"}]},"validation":"validateInventoryType"},
  	{colno:1,name:"isserialized",inputType:0,type:"TEXT",caption:"Serialized?",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"isservice"},
  	{colno:1,name:"isservice",inputType:0,type:"TEXT",caption:"Service?",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"hasattribute"},
  	{colno:1,name:"hasattribute",inputType:0,type:"TEXT",caption:"Has Attributes",mandatory:false,defaultValue:"0","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"hasbatch"},
  	{colno:0,name:"hasbatch",inputType:0,type:"TEXT",caption:"Has Batch",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"hasexpiry"},
  	{colno:1,name:"hasexpiry",inputType:0,type:"TEXT",caption:"Has Expiry",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"selling"},
  	{colno:1,name:"purchasable",inputType:0,type:"TEXT",caption:"Purchasable?",mandatory:false,defaultValue:"1","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"isservice"},
  	{colno:1,name:"salable",inputType:0,type:"TEXT",caption:"Salable?",mandatory:false,defaultValue:"1","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"hasattribute"},
  	{colno:1,name:"composite",inputType:0,type:"TEXT",caption:"Composite",mandatory:false,defaultValue:"0","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"hasbatch"},
  	{colno:0,name:"livestock",inputType:0,type:"TEXT",caption:"Live Stock",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"hasexpiry"},  	
    {colno:0,name:"selling",inputType:0,type:"DECIMAL",caption:"Selling",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"mrp"},
  	{colno:2,name:"purrate",inputType:0,type:"DECIMAL",caption:"Purchase Rate",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"selling"},
  	{colno:1,name:"mrp",inputType:0,type:"DECIMAL",caption:"Mrp",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"offerhint"},  	
  	{colno:1,name:"offerhint",inputType:0,type:"TEXT",caption:"Offer Hint",mandatory:false,defaultValue:"","maxValue":0,"textLength":25,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"allownegative"},
  	{colno:2,name:"allownegative",inputType:1,type:"TEXT",caption:"Allow Negative Stcok",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"hasextras",keys:"Deny~Allow",values:"0~1"},  	
	{colno:1,name:"gkm",inputType:0,type:"DECIMAL",caption:"Margin",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"hasextras"},
	{colno:0,name:"hasextras",inputType:1,type:"TEXT",caption:"Has Extras",mandatory:true,defaultValue:"0","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"allowonline",keys:"No~Yes",values:"0~1"},	
  	{colno:1,name:"allowonline",inputType:1,type:"TEXT",caption:"Allow Online Selling",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"bulkitem",keys:"Allow~Deny",values:"1~0"},
  	{colno:2,name:"bulkitem",inputType:0,type:"LOV",caption:"Bulk Item",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"status",lovOptions:{url:"/inventory/service/ajax",ajax:"bulkitems",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},  	
	{colno:0,name:"hsncode",inputType:0,type:"TEXT",caption:"HSN Code",mandatory:false,defaultValue:"","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"status"},
  	{colno:0,name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"purtax",keys:"Active~InActive",values:"Active~InActive"},
  	{colno:0,name:"isbulk",inputType:0,type:"TEXT",caption:"Bulk Item",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"bulkitem"},
  	{colno:0,name:"costtype",inputType:0,type:"TEXT",caption:"Cost Type",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"bulkitem"}
  	]},
  	
  	{name:"taxconfig",title:"Tax Details",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,optional:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "location", name: "Branch", field: "location",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,"chkTag":true,lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
    {order:"2",id: "ptax", name: "PurchaseTax%", field: "ptax",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:150},
    {order:"3",id: "pinclusive", name: "Inclusive", field: "pinclusive",defaultValue:"0","inputType":1,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:150,keys:"No~Yes",values:"0~1"},
    {order:"4",id: "pservtax", name: "ServiceTax%", field: "pservtax",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:100},    
    {order:"5",id: "stax", name: "SaleTax%", field: "stax",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:150},
    {order:"6",id: "inclusive", name: "Inclusive", field: "inclusive",defaultValue:"0","inputType":1,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:150,keys:"Yes~No",values:"1~0"},
    {order:"7",id: "servtax", name: "ServiceTax%", field: "servtax",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:100},
    {order:"8",id: "minqty", name: "Min.Qty(in BaseUnit)", field: "minqty",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":9999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:150},
    {order:"9",id: "maxqty", name: "Max.Qty(in BaseUnit)", field: "maxqty",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":9999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:150}
    ]}},
    
    {name:"taxinfo",title:"Tax Configuration",pcolumns:3,colcss:"col-sm-4 col-md-4 col-lg-4",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[
  	{colno:0,name:"purtax",inputType:0,type:"DECIMAL",caption:"Purchase Tax",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"saltax"},	
  	{colno:1,name:"saltax",inputType:0,type:"DECIMAL",caption:"Sales Tax",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"isinclusive"},  	
  	{colno:2,name:"isinclusive",inputType:1,type:"TEXT",caption:"Tax Inclusive",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"minimumqty",keys:"Yes~No",values:"1~0"},  	
	{colno:0,name:"minimumqty",inputType:0,type:"DECIMAL",caption:"Min.Qty(in BaseUnit)",mandatory:false,defaultValue:"0","maxValue":9999999.99,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"maximumqty"},
	{colno:1,name:"maximumqty",inputType:0,type:"DECIMAL",caption:"Max.Qty(in BaseUnit)",mandatory:false,defaultValue:"0","maxValue":9999999.99,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"rack"}
  	]},
  	{name:"rackinfo",title:"Rack Info",pcolumns:3,colcss:"col-sm-4 col-md-4 col-lg-4",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[
  	{colno:0,name:"rack",inputType:0,type:"TEXT",caption:"Rack",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"shelf"},	
  	{colno:1,name:"shelf",inputType:0,type:"TEXT",caption:"Shelf",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"box"},  	
  	{colno:2,name:"box",inputType:0,type:"TEXT",caption:"Box",mandatory:false,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:""}  	
	
  	]}
  	]};

	 
  var screenProps=changeScreenAttributes(110003,sProps);
  var product=new FlexUI.Screen("productmaster",screenProps);
  jqReport(8,"#xyz");
  function addMasterData(){ 
  	product.clearScreen(); 
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
	$('#jqcontainer').css('display','none');
  	screenObjects.getScreenObject("productname").focus();
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#history').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
	$('#jqcontainer').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("8");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var cid=screenObjects.getScreenObject("code").getValue();
    if(cid!="0" && cid!=""){
    	product.setOperation("EDIT");
    }
	var d=product.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/product",d);
		hideLoader();
		if(r.result=="Success"){
			saveDocuments();
			setErrorMessage(r.message+" [No:"+r.code+"]");
			product.clearScreen();
			hideMasterData();
			reloadGrid("8");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/product";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
	var v=l.callAjax("GET",url,code);
	product.clearScreen();
	product.loadData(v);
	screenObjects.getScreenObject('group').setEnabled(false);
	screenObjects.getScreenObject('inventorytype').setEnabled(false);
	screenObjects.getScreenObject('bulkitem').setEnabled(false);
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
	$('#jqcontainer').css('display','none');
  	hideLoader();
  	screenObjects.getScreenObject("productname").focus();
  }
  function validateInventoryType(id,me){
  	if(screenObjects.getScreenObject('isbulk').getValue()==1){
  		screenObjects.getScreenObject('bulkitem').setEnabled(false);
  	}else{
  		screenObjects.getScreenObject('bulkitem').setEnabled(true);
  	}
	return true;  
  }


  function validatespace(){
		$("#productname").val($("#productname").val().trim());
	    return true;
  }

  /*$(document).ready(function()
	{  
        $('#uploadImage').ajaxForm({
	        success: function(data) {
	        	hideLoader();
        		if (data=="File uploaded"){
        		
				}
        	}
    	});
	})*/ 
	
	$('#uploadImage').submit(function (e) {
        e.preventDefault();
        var fd = new FormData($(this)[0]);
        $.ajax({
            url: '/inventory/service/uploadimage',
            data: fd,
            processData: false,
            contentType: false,
            type: 'POST',
            success: function(data){
            var r=JSON.parse(data);
            	hideLoader();
            	setErrorMessage(r.message,1);
        		if (r.result=="Success"){
        			screenObjects.getScreenObject("imagepath").setValue(r.path);
				}
            }
        });
});
   
function saveDocuments(){
	var importFileName=$.trim($("#fileUpload").val());
	/*var group=$.trim($("#group").val());
	if(group==null || group==""){
		setErrorMessage("Please Select Product Group",1);
		return;
	}
	$('#groupid').val(group);*/
	if(importFileName.indexOf("\\")){
		importFileName=importFileName.substr(importFileName.lastIndexOf('\\')+1);
	}	
	var ext=importFileName.substr(importFileName.lastIndexOf('.')+1).toLowerCase();
	if(ext=='png' || ext=='jpeg'|| ext=='jpg'){
		showLoader();
		$("#uploadImage").submit();
	}else{
		setErrorMessage("Please upload png/jpg format only",1);	
	}
}
	
</script> 
</body>
</html>