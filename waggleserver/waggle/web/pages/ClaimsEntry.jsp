<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>
</head>
<%
   String mode=request.getParameter("mode");
   String code=request.getParameter("code");
   String userId=(String)session.getAttribute("LOGIN_ID");
   String branch=request.getParameter("branch");
   String rptId=request.getParameter("id");
%>
<body>	

	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Claims</h4>
				</div>
				<div  class="col-md-6" id="addGrp">
					<div class="row">
						<div class="col-md-7 d-flex text-right">
							
							<div class="input-group">
								<span class="input-group-text">From</span>
								<input id="fromDate" name="fromDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
								<span class="input-group-text">To</span>
								<input id="toDate" name="toDate" inputType="date"  type="text" mandatory="1"  class="form-control"/> &ensp;
								<button type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button> &ensp;
								
							</div>
						</div>
						<div class="col-md-5" style="text-align: right;">
							<button type="button" class="btn btn-clear" onclick='toggleHeaderRow()'><span class="mdi mdi-filter-variant">Search</span></button>	
						</div>
					</div>
				</div>
				
			</div>
			<div class="row " id="jqcontainer" >
			  <div class="table-container" >
				 <div id="xyz" class="w-100"></div>
			  </div>
			</div>	
			<div id="callback" class="row " style="display:none;">
				<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
					<div class="col-md-12 col-sm-12 mpZero">
					<div class="col-md-12 col-sm-12 mpZero">
					 <div  class="col-md-12 col-sm-12 mpZero">		
					 <div class="form-group mbotto">
						 <div class="col-md-2"><label>Corporate Name</label></div>
						 <div class="col-md-10"><input type="text" class="form-control" id="corporatename"><input type="hidden" class="form-control" id="corporatecode"><input type="hidden" class="form-control" id="claimcode"></div>
					 </div>
					 </div>	
				 </div>
				 <div class="clearfix"></div>	
				 <div class="col-md-12 col-sm-12 mpZero">
					 <div class="form-group mbotto">
					 <div class="col-md-2"><label>Claim Amount</label></div>
					 <div class="col-md-10"><input type="text" class="form-control" id="claimamount"><input type="hidden" id="claimdate"/></div>
					 </div>
				 </div>
				 <div class="clearfix"></div> 
				 <div class="col-md-12 col-sm-12 mpZero">
					 <div  class="col-md-6 col-sm-6 mpZero" style="display:block">		
					 <div class="form-group mbotto">
						 <div class="col-md-4"><label>TDS Amount</label></div>
						 <div class="col-md-8"><input type="text" class="form-control" id="tdsamount"></div>
					 </div>
					 </div>	
					 <div  class="col-md-6 col-sm-6 mpZero" style="display:block">		
					 <div class="form-group mbotto">
						 <div class="col-md-4"><label>Mischellenous Amount</label></div>
						 <div class="col-md-8"><input type="text" class="form-control" id="mischamount"></div>
					 </div>
					 </div>
				 </div>
				 
				 <div class="clearfix"></div>	
				 <div class="col-md-12 col-sm-12 mpZero">
					 <div  class="col-md-6 col-sm-6 mpZero">		
					 <div class="form-group mbotto">
						 <div class="col-md-4"><label>Cheque No</label></div>
						 <div class="col-md-8"><input type="text" class="form-control" id="chequeno"></div>
					 </div>
					 </div>	
					 <div  class="col-md-6 col-sm-6 mpZero">		
					 <div class="form-group mbotto">
						 <div class="col-md-4"><label>Cheque Date</label></div>
						 <div class="col-md-8"><input type="text" class="form-control" id="chequedate"></div>
					 </div>
					 </div>
				 </div>
				 <div class="clearfix"></div>	
				 <div class="col-md-12 col-sm-12 mpZero">
					 <div  class="col-md-6 col-sm-6 mpZero">		
					 <div class="form-group mbotto">
						 <div class="col-md-4"><label>Cheque Bank Name</label></div>
						 <div class="col-md-8"><input type="text" class="form-control" id="bankname"></div>
					 </div>
					 </div>	
					 <div  class="col-md-6 col-sm-6 mpZero">		
					 <div class="form-group mbotto">
						 <div class="col-md-4"><label>Deposited Bank</label></div>
						 <div class="col-md-8"><input type="text" class="form-control" id="depbankname"><input type="hidden" id="depbankcode"/></div>
					 </div>
					 </div>
				 </div>
			  </div>
			 </div>
			 <div class="clearfix"></div>	
			  <div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
					<div class="col-md-12 col-sm-12 mpZero" id="claimgrid" style="height:300px">
			   </div>
			 </div>
			 <div class="clearfix"></div>	
			  <div class="col-md-12 col-sm-12 mpZero">
					<div class="col-md-12 col-sm-12 mpZero">
						<div class="col-md-6 text-center mpZero">
							<div style="background:#fedc34; display:inline-block; width:100%; padding-top:5px;" >
							 <div class="netAm" id="netAmt">Total Amount 0.00</div>
						 </div>
						 <div class="form-group mbotto" style="display:none">
							 <div class="col-md-4"><label>Total</label></div>
							 <div class="col-md-8"><label id="totalamt"></label>
							 </div>						
						 </div>
						</div>
						<div class="col-md-6 text-right mpZero">
							<button id="btnClear" class="btn btn-default" type="button" onclick="hideMasterData()">Close</button>
							<button id="btnSave" class="btn btn-default" type="button" onclick="saveBill()">Save</button>
						</div>
				 </div>
			 </div>
			</div>
		</div>
		</div>

	<script>
	$('#fromDate').datepicker({
				 language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy'
	});
	if($('#fromDate').val()==""){
		var cd=new Date();
		$('#fromDate').datepicker("setDate",cd);
	}
	$('#todate').datepicker({
				 language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy'
	});			
	if($('#toDate').val()==""){
		var cd=new Date();
		$('#toDate').datepicker("setDate",cd);
	}	
	loadBranchData();
	jqReport(500011,"#xyz","&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val());
    var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[
  	{name:"claimcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"corporatename"},
  	{name:"corporatename",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"claimamount",lovOptions:{url:"/waggle/service/ajax",ajax:"insurancecompany",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"corporatename",tt:false,id:"icm_name"},{tgt:"corporatename",tt:true,id:"icm_name"},{tgt:"corporatecode",tt:false,id:"icm_code"}]}},
  	{name:"corporatecode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"claimamount"},  	
  	{name:"claimamount",inputType:0,type:"DECIMAL",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"tdsamount"},
  	{name:"tdsamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"mischamount"},
  	{name:"mischamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"chequeno"},
  	{name:"chequeno",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"chequedate"},
  	{name:"chequedate",inputType:0,type:"DATE",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"bankname"},
  	{name:"bankname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":40,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"depbankname"},
  	{name:"depbankname",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"depbankcode",lovOptions:{url:"/waggle/service/ajax",ajax:"banks",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"depbankname",tt:false,id:"lm_name"},{tgt:"depbankname",tt:true,id:"lm_name"},{tgt:"depbankcode",tt:false,id:"lm_code"}]}},
  	{name:"depbankcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"btnSave"},
  	{name:"totalamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},  	  	
  	{name:"claimdate",inputType:0,type:"TDATE",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},  	
  	{name:"btnSave",inputType:3,caption:"",visible:false,readOnly:true},
    {name:"btnClear",inputType:3,caption:"",visible:false,readOnly:true}
  	]},
  	{name:"claimgrid",title:"",contentType:"Table",tableProperties:{rowObject:true,serialNumberColumn:"sno",rowEmptyCheckColumn:"patienttypecode",optional:false,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "patienttypecode", name: "PatientType", field: "patienttypecode",defaultValue:"1","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,"chkTag":false},
    {order:"2",id: "patienttype", name: "IP/OP", field: "patienttype",defaultValue:"","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,"chkTag":true,lovOptions:{url:"/waggle/service/ajax",ajax:"patienttype",scrollEnabled:true,searchFromList:false,dsi:1,params:[],results:[
  	{tgt:"claimgrid_data",tt:true,row:"cr",id:"pt_shortname",col:"patienttype"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"pt_shortname",col:"patienttype"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"pt_code",col:"patienttypecode"}
  	]},validation:"validatePatientType"
    },
    {order:"3",id: "patientcode", name: "PatientCode", field: "patientcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,"chkTag":false},
    {order:"4",id: "patientname", name: "Patient Name", field: "patientname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,"chkTag":true,lovOptions:{url:"/waggle/service/ajax",ajax:"inspatients",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"corporate",src:"corporatecode",tt:false},{n:"searchtxt",src:"claimgrid_data",row:"cr",col:"patientname",tt:false}],results:[
    {tgt:"claimgrid_data",tt:false,row:"cr",id:"patienttype",col:"patienttypecode"},
    {tgt:"claimgrid_data",tt:false,row:"cr",id:"pt_shortname",col:"patienttype"},
    {tgt:"claimgrid_data",tt:true,row:"cr",id:"pt_shortname",col:"patienttype"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"pam_code",col:"patientcode"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"pam_no",col:"ipno"},  	
  	{tgt:"claimgrid_data",tt:true,row:"cr",id:"pam_name",col:"patientname"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"pam_name",col:"patientname"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"pam_sponsor_approvalno",col:"claimno"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"dh_no",col:"billkey"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"dh_bill_no",col:"billno"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"dh_total_rent",col:"nursing"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"dh_total_lab",col:"invest"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"dh_total_pharmacy",col:"pharmacy"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"dh_profesional_charges",col:"professional"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"dh_total_amount",col:"totalamount"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"cp_approved_amount",col:"approvedamount"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"hospregcode",col:"hospregcode"},
  	{tgt:"claimgrid_data",tt:false,row:"cr",id:"claimno",col:"claimsno"}
  	]}
  	},    
    {order:"5",id: "claimno", name: "Claim No", field: "claimno",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:150,"chkTag":false},    
    {order:"6",id: "ipno", name: "IP No", field: "ipno",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:100,"chkTag":false},
    {order:"7",id: "billkey", name: "Bill Key", field: "billkey",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,"chkTag":false},
  	{order:"8",id: "billno", name: "Bill No", field: "billno",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,"chkTag":false},
  	{order:"9",id: "nursing", name: "Nursing", field: "nursing",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:150,align:"right"},
  	{order:"10",id: "invest", name: "Investigation", field: "invest",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:150,align:"right"},
  	{order:"11",id: "professional", name: "Professional", field: "professional",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:150,align:"right"},
  	{order:"12",id: "pharmacy", name: "Pharmacy", field: "pharmacy",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:150,align:"right"},
  	{order:"13",id: "totalamount", name: "Bill Amount", field: "totalamount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"right"},
  	{order:"14",id: "approvedamount", name: "Approved Amount", field: "approvedamount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"right"},
  	{order:"15",id: "approvalamount", name: "Claim Amount", field: "approvalamount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:150,align:"right",onchange:"onAppAmountChange"},
  	{order:"16",id: "pharmacyamount", name: "Pharmacy Share", field: "pharmacyamount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:150,align:"right"},
  	{order:"17",id: "nursingamount", name: "Nursing Share", field: "nursingamount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:150,align:"right"},
  	{order:"18",id: "doctoramount", name: "Doctor", field: "doctoramount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:150,align:"right"},
  	{order:"19",id: "hospregcode", name: "HospCode", field: "hospregcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,align:"right"}  	,
  	{order:"20",id: "claimsno", name: "Claim No", field: "claimsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,align:"right"}
    ]
    }}]};
	var claims=new FlexUI.Screen("claims",sProps);	
	var l=new FlexUI.Ajax();
    $(document).ready(function () {
            screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
            screenObjects.getScreenObject("claimgrid_data").getInputField().onTextKeyDown.subscribe(tableTextKeyDown);
            screenObjects.getScreenObject("claimgrid_data").onAfterDeleteRow.subscribe(tableRowDelete);
            $('#subtitle').text("");
            $('#screentitle').text("Billing");
            $('#btnSave').css("display","inline-block");
            loadActions(500011);
        });
        function saveBill(){
        	if(claims.getSaveInProgress()) return;
        	var r=null;
    		claims.setOperation("ADD");
    		claims.setScreenCode(21);
    		var d=claims.processDataToSave();
    		claims.setSaveInProgress(true);    		
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",d);
				hideLoader();
		 	}else{
		 		alert("Please correct the validation errors and continue...");
		 		claims.setSaveInProgress(false);
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				alert(r.message+" [No:"+r.code+"]");
				hideMasterData();
				return r.key;			
			}else{
				claims.setSaveInProgress(false);								
				alert(r.message);	
			}
        }
        function clearInnerScreen(){
        	claims.clearScreen();
        	claims.setSaveInProgress(false);        	
        	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
        }
        function onAppAmountChange(id,me){
			var t=me.getParent();
			calculateAmount(t.getCurrentRow());
			calculateTotal();
			return true;
		}
		function calculateTotal(){
			var total=0;
			var t=screenObjects.getScreenObject("claimgrid_data");
			var cols=t.getCols();
			var s=t.getSize();
			for(var i=0;i<s;i++){
				total+=toNumber(t.getText(i,cols.approvalamount));
			}
			screenObjects.getScreenObject("totalamt").setValue(roundOff(total,2));
			$("#netAmt").html("Total Amount   "+roundOff(total,2));
		}
		function calculateAmount(row){
			var t=screenObjects.getScreenObject("claimgrid_data");
			var cols=t.getCols();
			var pharmacyAmount=0;
			var nursingAmount=0;
			var professionalAmount=0;
			var nursing=toNumber(t.getText(row,cols.nursing))+toNumber(t.getText(row,cols.invest));
			var professional=toNumber(t.getText(row,cols.professional));
			var pharmacy=toNumber(t.getText(row,cols.pharmacy));
			var claimAmt=toNumber(t.getText(row,cols.totalamount));
			var appAmt=toNumber(t.getText(row,cols.approvalamount));
			if(t.getText(row,cols.patienttypecode)=="1"){
				if(appAmt>claimAmt){
					pharmacyAmount=pharmacy;
					appAmt=appAmt-pharmacy;
					professionalAmount=professional;
					appAmt=appAmt-professional;
					nursingAmount=appAmt;
				}else{
					if(appAmt>=pharmacy){
						pharmacyAmount=pharmacy;
						appAmt=appAmt-pharmacy;
					}else{
						pharmacyAmount=appAmt;
						appAmt=0;
					}
					if(appAmt>0){
						var nursingPerc=nursing/(claimAmt-pharmacy);
						nursingAmount=appAmt*nursingPerc;
						professionalAmount=appAmt-nursingAmount;
					}
				}
				t.setText(row,cols.pharmacyamount,pharmacyAmount);
				t.setText(row,cols.nursingamount,nursingAmount);
				t.setText(row,cols.doctoramount,professionalAmount);
			}else{
				t.setText(row,cols.nursingamount,appAmt);
			}
			//calculate shares	
		}
		function tableTextKeyDown(e,args){
			var key=e.which || e.keyCode;
			if(key==113){
				saveBill();
			}
		}
		function tableRowDelete(e,args){
			calculateTotal();
		}
		function preValidatePatientName(id,me,row,col){
			if(!claims.getSaveInProgress()){
				var t=screenObjects.getScreenObject("claimgrid_data");
				var corporate=screenObjects.getScreenObject("corporatecode").getValue();
				var cols=t.getCols();
				var sTxt=t.getText(row,cols.patientname);				
				var v=null;
				if(t.getText(row,cols.patienttypecode)=="1"){
					v=l.callAjax("GET","/waggle/service/ajax?id=inspatients&ic=0&corporate="+corporate+"&searchtxt="+sTxt,"");
				}else{
					v=l.callAjax("GET","/waggle/service/ajax?id=insoutpatients&ic=0&corporate="+corporate+"&searchtxt="+sTxt,"");
				}
				if(v!=null && v.data.length==1){
					t.setText(row,cols.patientcode,v.data[0][0]);
					t.setText(row,cols.ipno,v.data[0][1]);
					t.setText(row,cols.patientname,v.data[0][2]);
					t.setCellTag(row,cols.patientname,v.data[0][2]);
					t.setText(row,cols.claimno,v.data[0][3]);
					t.setText(row,cols.billkey,v.data[0][4]);
					t.setText(row,cols.billno,v.data[0][5]);
					t.setText(row,cols.nursing,v.data[0][6]);
					t.setText(row,cols.invest,v.data[0][7]);
					t.setText(row,cols.pharmacy,v.data[0][8]);
					t.setText(row,cols.professional,v.data[0][9]);
					t.setText(row,cols.totalamount,v.data[0][10]);
				}else{
					t.setText(row,cols.patientname,"");				
					if(t.getText(row,cols.patienttypecode)=="1"){
						screenObjects.getScreenObject("claimgrid_data").getColumnProperties()[cols.patientname].lovOptions.dsi=1;					
						screenObjects.getScreenObject("claimgrid_data").getColumnProperties()[cols.patientname].lovOptions.ajax="inspatients";
					}else{
						screenObjects.getScreenObject("claimgrid_data").getColumnProperties()[cols.patientname].lovOptions.dsi=2;					
						screenObjects.getScreenObject("claimgrid_data").getColumnProperties()[cols.patientname].lovOptions.ajax="insoutpatients";
					}
				}
			}
			return true;
		}
	function addMasterData(){
		clearInnerScreen(); 
  		$('#callback').css('display','block');
  		$('#xyz').css('display','none');
  		$('#datefilters').css('display','none');
  		$('#addGrp').css('display','none');
  		$('#btnSave').css("display","inline-block");
  	}
	function hideMasterData(){
  		clearInnerScreen();
  		$('#callback').css('display','none');
  		$('#xyz').css('display','block');
  		$('#datefilters').css('display','block');
  		$('#addGrp').css('display','block');
  		reloadGrid(500011);
  	}
	function toggleHeaderRow(){
  		toggleSearchToolBar(500011);
  	}
  	function loadOrderData(url,code,did){
	  	showLoader();
		var l=new FlexUI.Ajax();
		var v=l.callAjax("GET",url,"&screencode=21");
		claims.loadObjectData(v);
		calculateTotal();
		$('#netAmt').html(screenObjects.getScreenObject("totalamt").getValue());
		$('#callback').css('display','block');
	  	$('#xyz').css('display','none');
	  	$('#datefilters').css('display','none');
	  	$('#addGrp').css('display','none');
	  	$('#btnSave').css("display","none");  	
	  	hideLoader();
  	} 
  	function reportGo(id){
		showLoader();
		var newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val();
		changeUrlAndReloadGrid(id,"",newParams);
		hideLoader();
	}
	toggleHeaderRow();
	</script>
</body>
</html>