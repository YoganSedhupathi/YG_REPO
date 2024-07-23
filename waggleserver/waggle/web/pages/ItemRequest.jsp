<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
%>
<body>

	<div class="card border-0 shadow">
		<div class="card-body lpage">
		  <!--Header-->
		  <div class="row w-100">
					  <div class="col-md-6 d-flex align-items-center">
						  <h4 class="header-title">Medicine request</h4>
					  </div>
					  <div  class="col-md-6 text-right">
			   
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
			<div id="callback" class="mt-3">
			  <div class="row w-100">

				<div class="col-sm-12 col-md-12 col-lg-12 ">     
					<div  class="col-md-2 col-sm-2 mpZero " style="display:none">
						<div class="form-group mbotto">
							<div class="col-md-12"><label>Search By </label></div>
						</div>
					</div>
					<div class="input-group mb-1"> 
							<div class="col-md-2"><label for="smobileno" class="form-lable">Search By </label></div>
							<div class="col-md-4"><input type="text" class="form-control" id="smobileno"/></div>
							<div  class="col-md-6 col-sm-6 mpZero">
								<div class="col-md-12 form-lable">Reg No:&nbsp;<label  class="form-lable" id="lcsno"></label>&nbsp;|&nbsp;Room No:&nbsp;<label class="form-lable" id="roomno">RoomNo</label></div>
							</div>
					</div>
				</div>
				
				<div class="col-sm-12 col-md-12 col-lg-12">  
					<div class="input-group mb-1">
								   <div class="col-md-2"><label for="custname" class="form-lable">Patient Name </label></div>
								   <div class="col-md-4"><input type="text" class="form-control" id="custname"><input type="hidden" class="form-control" id="patientcode"><input type="hidden" class="form-control" id="hospregcode"><input type="hidden" class="form-control" id="appid"><input type="hidden" class="form-control" id="casualityno"><input type="hidden" class="form-control" id="csno"><input type="hidden" class="form-control" id="claimno"></div>
								   
									<div class="col-md-2"><label class="form-lable">IP No</label></div>
									<div class="col-md-4"><input type="text" class="form-control" id="ipno"><input type="hidden" id="sponsorname"/><input type="hidden" id="sponsorcode"/></div>
					</div>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12">  
					<div class="input-group mb-1">
						<div class="col-md-2"><label for="custage" class="form-lable">Age </label></div>
						<div class="col-md-4"><input type="text" class="form-control" id="custage"></div>
						<div class="col-md-2"><label for="gender" class="form-lable">Gender</label></div>
						<div class="col-md-4"><label class="form-lable" id="gender"></label></div>
					</div>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12">  
					<div class="input-group mb-1">
						<div class="col-md-2"><label for="doctorname" class="form-lable">Doctor name</label></div>
								   <div class="col-md-4"><input type="text" class="form-control" id="doctorname"><input type="hidden" id="doctorcode"/></div>
								   
								   <div class="col-md-2"><label for="referredby" class="form-lable">Refer By</label></div>
								   <div class="col-md-4"><input type="text" class="form-control" id="referredby"><input type="hidden" id="referralcode"/></div>
						</div>
				</div>
			   </div>
			   <div class="row">
				  <div class="table-container">
					  <div class="col-md-12 col-sm-12 garea" id="ordergrid"></div>
				  </div>
				</div>
	  
				<div class="row w-100 mt-3">
				  <div class="col-md-4">
					<div class="hstack justify-content-start">
					  <div id="actButton">
						<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="saveItemRequest()">Save</button>
						<button id="btnClear" class="btn btn-default" type="button" onclick="hideMasterData()">Cancel</button>
					  </div>
					</div>
				  </div>
				</div>
		  </div>
		 <!--Content End-->
		</div>
	</div>

	
	<script>
	loadBranchData();
	jqReport(16,"#xyz","&branchcode="+$('#branch').val());
    var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"locationcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"orderno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"ordertype",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"IR","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"ipno",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"roomno",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"custname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"custcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"custage",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"doctorname"},
  	{name:"gender",inputType:4,type:"SPAN",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"doctorname"},
  	{name:"doctorname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"sponsorname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"sponsorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referredby",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"ordergrid_data"},
  	{name:"totalamt",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"ordergrid_data"},
  	{name:"remarks",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"ordergrid_data"},
  	{name:"status",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"P","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"ordergrid_data"},
  	{name:"smobileno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"ordergrid_data",validation:"checkMRPatientExists"},
  	{name:"appid",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ordergrid_data"},
  	{name:"btnSave",inputType:3,caption:"",visible:false},
    {name:"btnClear",inputType:3,caption:"",visible:false}
  	]},
  	{name:"ordergrid",title:"",contentType:"Table",tableProperties:{rowObject:true,serialNumberColumn:"sno",rowEmptyCheckColumn:"productcode",optional:false,enableAddRow:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "productcode", name: "ItemCode", field: "productcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:0,"chkTag":false},    
    {order:"2",id: "product", name: "Item", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,"chkTag":true,lovOptions:{url:"/inventory/service/ajax",ajax:"saleproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branchcode",tt:false}],results:[
  	{tgt:"ordergrid_data",tt:false,row:"cr",id:"a.pm_code",col:"productcode"},
  	{tgt:"ordergrid_data",tt:false,row:"cr",id:"a.pm_name",col:"product"},
  	{tgt:"ordergrid_data",tt:true,row:"cr",id:"a.pm_name",col:"product"},  	  	
  	{tgt:"ordergrid_data",tt:false,row:"cr",id:"a.pm_saleunit",col:"unitid"},
  	{tgt:"ordergrid_data",tt:false,row:"cr",id:"a.ptc_inclusive",col:"taxincl"},
  	{tgt:"ordergrid_data",tt:false,row:"cr",id:"a.ptc_stax",col:"staxperc"}
  	]},validation:"onValidateItem"},
    {order:"3",id: "quantity", name: "Quantity", field: "quantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:150,onchange:"onRateQuantityChange",align:"center"},
    {order:"4",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,onchange:"onRateQuantityChange",align:"right"},
    {order:"5",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"right"},
    {order:"6",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "expdt", name: "ExpDt", field: "expdt",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"8",id: "taxincl", name: "TaxInclu", field: "taxincl",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"9",id: "staxperc", name: "S.Tax%", field: "staxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,align:"right"}
    ]
    }}
    
    ]};
	var itemreq=new FlexUI.Screen("itemreq",sProps);	
	//ajax columns
	var l=new FlexUI.Ajax();
    $(document).ready(function () {
    		addMasterData();
            screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
            screenObjects.getScreenObject("locationcode").setValue($('#branch').find("option:selected").data("location"));
            screenObjects.getScreenObject("ordergrid_data").getInputField().onTextKeyDown.subscribe(tableTextKeyDown);
            $('#subtitle').text("");
            $('#screentitle').text("Medicine Request");
     });
     function saveItemRequest(){
     		if(itemreq.getSaveInProgress()) return;
        	var r=null;
    		itemreq.setOperation("ADD");
    		itemreq.setScreenCode(14);
    		var d=itemreq.processDataToSave();
    		itemreq.setSaveInProgress(true);
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/inventory/service/salesorder/itemrequest",d);
				hideLoader();
		 	}else{
		 		itemreq.setSaveInProgress(false);
				
		 		alert("Please correct the validation errors and continue...");
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				setErrorMessage(r.message+" [ Request No:"+r.orderno+"]")   ;
				// alert(r.message+" [Request No: "+r.orderno+"]");
				hideMasterData();
				return r.key;		
			}else{
				itemreq.setSaveInProgress(false);
				alert(r.message);	
					
			}
      }
    function clearInnerScreen(){
    	$('#overlapdiv').css('display','none');
    	itemreq.clearScreen();
    	itemreq.setSaveInProgress(false);
    	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
    	screenObjects.getScreenObject("locationcode").setValue($('#branch').find("option:selected").data("location"));
    }
  function addMasterData(){
  	clearInnerScreen();
  	$('#callback').css('display','block');
  	$('#xyz').css('display','none');
  	$('#addGrp').css('display','none');
  	reloadGrid(16);
  }
  
  function hideMasterData(){
  	//$('#callback').css('display','none');
  	//$('#xyz').css('display','block');
  	//$('#addGrp').css('display','block');
  	clearInnerScreen();
  	$('#smobileno').focus();
  }
    
  function toggleHeaderRow(){
  	toggleSearchToolBar(16);
  }
  
  toggleHeaderRow();
  
  function loadOrderData(url,code,did){
  	var rowData=$("#report_16").getRowData(did);
  	screenObjects.getScreenObject("ipno").setValue(rowData.pam_no);
  	screenObjects.getScreenObject("roomno").setValue(rowData.rm_roomname);
  	screenObjects.getScreenObject("custcode").setValue(rowData.pam_ref_code);
  	screenObjects.getScreenObject("custname").setValue(rowData.pam_name);
  	screenObjects.getScreenObject("custage").setValue(rowData.pam_age);
  	screenObjects.getScreenObject("gender").setValue(rowData.pam_gender);
  	screenObjects.getScreenObject("doctorname").setValue(rowData.dr_name);
  	screenObjects.getScreenObject("doctorcode").setValue(rowData.pam_consulting_dr);
  	screenObjects.getScreenObject("referredby").setValue(rowData.referraldr);
  	screenObjects.getScreenObject("referralcode").setValue(rowData.pam_referral_dr);;
  	screenObjects.getScreenObject("sponsorcode").setValue(rowData.pam_sponsor_code);;
  	screenObjects.getScreenObject("sponsorname").setValue(rowData.icm_name);;
  	$('#callback').css('display','block');
  	$('#xyz').css('display','none');
  	$('#addGrp').css('display','none');
  }
  function onValidateItem(id,me,row,col){
  	if(!itemreq.getSaveInProgress()){
		var cols=screenObjects.getScreenObject("ordergrid_data").getCols();
		var branch=screenObjects.getScreenObject("branchcode");
		var location=screenObjects.getScreenObject("locationcode");
		var r=l.callAjax("GET","/inventory/service/ajax","ic=0&id=productrate&pmcode="+me.getText(row,cols.productcode));
		
		if(r!=null){
			if(r.data && r.data.length==1){
				setRateDetails(me,cols,r)
			}
		}
	}
	return true;
  }
  function setRateDetails(me,cols,v){
	me.setCurrentRowText(cols.rate,v.data[0][3]);
  }
  function onRateQuantityChange(id,me){
			var t=me.getParent();
			calculateAmount(t.getCurrentRow());
			calculateTotal();
			return true;
  }
  function calculateTotal(){
		var total=0;
		var t=screenObjects.getScreenObject("ordergrid_data");
		var cols=t.getCols();
		var s=t.getSize();
		for(var i=0;i<s;i++){
			total+=toNumber(t.getText(i,cols.amount));
		}
		screenObjects.getScreenObject("totalamt").setValue(roundOff(total,2));
	}
	function calculateAmount(row){
		var t=screenObjects.getScreenObject("ordergrid_data");
		var cols=t.getCols();	
		var baseqty=0;
		baseqty=toNumber(t.getText(row,cols.quantity));
		var amt=roundOff(toNumber(t.getText(row,cols.rate))*baseqty,2);
		t.setText(row,cols.amount,amt);
	}
	function tableTextKeyDown(e,args){
		var key=e.which || e.keyCode;
		if(key==113){
			saveItemRequest();
			e.preventDefault();
		}
	}
	function checkMRPatientExists(id,me){
			if(!itemreq.getSaveInProgress()){
				var branch=screenObjects.getScreenObject("branchcode").getValue();
				var stext=screenObjects.getScreenObject("smobileno").getValue();
				var params="";
				var paramName="F1";
				var dsi=0;
				var searchType=$('#searchtype').val();
				params="&F2="+stext;
				paramName="F2";
				dsi=1;					
				if(stext!=""){
					var v=null;
					var l=new FlexUI.Ajax();
					v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=hospinpatients&branchcode="+branch+"&searchtxt="+escape(stext));
					if(v!=null){
						if(v.data && v.data.length==1){
							getMRPatientInfo(branch,v.data[0]);					
							return true;
						}else if(v.data && v.data.length>1){
							screenObjects.getScreenObject("smobileno").setTag(stext);
							var d=null;
							d={url:"/waggle/service/ajax",ajax:"hospinpatients",scrollEnabled:true,searchFromList:false,dsi:dsi,edsi:1,params:[{n:"branchcode",src:"branchcode",ft:false},{n:"searchtxt",src:"smobileno",ft:false}],results:[],standalone:true};
							var lov=new FlexUI.LOV("s_lov",me,d,v.data);
							lov.onLovClose.subscribe(onMRPatientClose);
							lov.show();					
							return false;
						}		
					}
				}
				clearInnerScreen();
				return false;				
			}else{
				screenObjects.getScreenObject("smobileno").setTag("");
				return true;
			}	
		}
		function onMRPatientClose(e,args){
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			getMRPatientInfo(branch,args.result);
		}		
		function getMRPatientInfo(branch,result){		
		  	screenObjects.getScreenObject("ipno").setValue(result[19]);
		  	screenObjects.getScreenObject("roomno").setValue(result[22]);
		  	screenObjects.getScreenObject("custcode").setValue(result[17]);
		  	screenObjects.getScreenObject("custname").setValue(result[2]);
		  	screenObjects.getScreenObject("custage").setValue(result[3]);
		  	screenObjects.getScreenObject("gender").setValue(result[4]);
		  	screenObjects.getScreenObject("doctorname").setValue(result[6]);
		  	screenObjects.getScreenObject("doctorcode").setValue(result[5]);
		  	screenObjects.getScreenObject("referredby").setValue(result[8]);
		  	screenObjects.getScreenObject("referralcode").setValue(result[7]);
		  	screenObjects.getScreenObject("sponsorcode").setValue(result[9]);
		  	screenObjects.getScreenObject("sponsorname").setValue(result[10]);
		  	$('#lcsno').text(result[1]);			
		}	
  </script>
</body>
</html>