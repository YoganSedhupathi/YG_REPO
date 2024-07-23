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
   String screenCode=request.getParameter("screencode");
%>
<body>

	<div class="card border-0 shadow">
		<div class="card-body ">
		  <!--Header-->
		  <!-- <div id="branchcontainer" class="brTp" style="display:block;z-index:999">
			<select class="form-control" id='branch' onchange="changeBranchCodeAndClearSubScreenData()"></select>
		  </div> -->
		  <div class="row w-100">
					  <div class="col-md-6 d-flex align-items-center">
						  <h4 class="header-title">IP Billing</h4>
					  </div>
					  <div  class="col-md-6 text-right">
			  </div>
		  </div>
		  <!--Header End-->
		  <!--Content -->
				
			<div id="" class="mt-3">
			  <div class="row w-100 cBor">
				
				<div class="col-sm-12 col-md-12 col-lg-12">                     
					<div class="input-group mb-1">
						<div class="col-md-2">	<label for="buname" class="form-lable">Business Unit</label>	</div>
						<div class="col-md-4"><input type="text" class="form-control" id="buname"><input type="hidden" class="form-control" id="bucode"><input type="hidden" class="form-control" id="butype"><input type="hidden" class="form-control" id="allowedtypes"><input type="hidden" class="form-control" id="hospregcode" value="0"> </div>
						<div class="col-md-2"><label for="patientname" class="form-lable">Patient Name </label></div>
						<div class="col-md-4"><input type="text" class="form-control" id="patientname"><input type="hidden" class="form-control" id="patientcode"><input type="hidden" class="form-control" id="hospregcode"><input type="hidden" class="form-control" id="appid"><input type="hidden" class="form-control" id="casualityno"><input type="hidden" class="form-control" id="csno"><input type="hidden" class="form-control" id="claimno"></div>
						
					</div>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12">  
					<div class="input-group mb-1">
						           <div class="col-md-2"><label for="" class="form-lable">IP No </label></div>
								   <div class="col-md-4 "><input type="text" class="form-control" id="ipno"><input type="hidden" id="sponsorname"/><input type="hidden" id="sponsorcode"/><input type="hidden" id="billno"/><input type="hidden" id="code"/><input type="hidden" id="billdate"/></div>
								   <div class="col-md-2"><label for="" class="form-lable">Room No  </label></div>
								   <div class="col-md-4 form-lable"><label id="roomno"></label><input  type="hidden" id="roomcode"/></div>
					</div>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12">  
					<div class="input-group mb-1">
						<div class="col-md-2"><label for="patientage" class="form-lable">Age </label></div>
						<div class="col-md-4"><input type="text" class="form-control" id="patientage"></div>
						<div class="col-md-2"><label for="gender" class="form-lable">Gender</label></div>
						<div class="col-md-4 "><label id="gender" class="form-lable">Gender</label></div>
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
	  
			   <div class="row ">
				  <div class="table-container">
					  <div class="col-md-12 col-sm-12 garea" id="billgrid"></div>
				  </div>
				</div>
				<div class="row w-100 mt-3">
					<div class="col-md-6">
					  <div class="hstack justify-content-start">
						<div id="">
							<button id="btnClearScr" class="btn btn-clear mx-3" type="button" onclick="clearInnerScreen()"><span class="mdi mdi-refresh me-2"></span>Clear</button>
					
      		 				<button id="btnCancelScr" class="btn btn-default" type="button" onclick="hideMasterData()">Back</button>
						</div>
					  </div>
					</div>
					<div class="col-md-6">

						<div class="hstack justify-content-end">
                            <div class="">
                                <div class="card-total px-3 rounded-3">
                                    <h6 class="dicount-type hstack gap-1">
                                        <span class="text-dark"><h3>Net Amount:</h3></span>
                                        <h3><span class="net-amount" style="color:Green" id="netAmt"></span></h3>
                                    </h6>
                                </div>
        				 		 <div class="col-md-8" style="display:none"><label id="totalamt"></label></div>
                            </div>
                        </div>

						
					</div>
				</div>
				
		  </div>
		 <!--Content End-->
		</div>
	  </div>


	<div style="display:none">
		<div id='tenderdlg' class='pop_lov_box'>
			<div id='tendertitle' class='pop_lov_hed_box'>
			<div class='pop_lov_clos'>
				<a href='#'>
					<span class='fa fa-times-circle'>
					</span>
				</a>
			</div>
			<div class='pop_lov_hed_txt'>Bill Amount Rs. <span id="dispTotalAmt"></span></div>
			</div>
			<div id='tender' class='pop_lov_inp_box'>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Cash</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="tcashamount"><input type="hidden" class="form-control" id="cashamount"></div>
					</div>
					</div>
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Machine</label></div>
						<div class="col-md-8"><select class="form-control" id="cardbank"></select></div>
					</div>
					</div>																																							
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero" style="display:none">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Credit</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="creditamount"></div>
					</div>
					</div>
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Credit Card</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="tcardamount"></div>
					</div>
					</div>
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Service Charge</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="srvchgamount"></div>
					</div>
					</div>
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Card Amount</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="cardamount"></div>
					</div>
					</div>																			
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero" style="display:none">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Corporate</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="sponsoramount"></div>
					</div>
					</div>
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Tendered</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="tenderamount" disabled><input type="hidden" class="form-control" id="netamount"></div>
					</div>
					</div>
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Balance</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="balanceamount" disabled></div>
					</div>
					</div>																																										
				</div>
				<div id="actButton" class="col-md-12 text-right">
                	<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="saveBill()">Save</button>
	                <button id="btnClear" class="btn btn-default" type="button" onclick="cancelTenderDlg()">Cancel</button>
            	</div>							
			</div>
		</div>
	</div>	
	<script>
		loadBranchData();
		var banks=loadCardBankData();
		var sProps={js:"",screen:[
		  {name:"group1",predesigned:true,contentType:"Fields",
		  fields:[{name:"bucode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"code"},
		  {name:"code",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billno"},
		  {name:"billno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
		  {name:"billtype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
		  {name:"patienttype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
		  {name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
		  {name:"buname",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":true,nf:"ipno",lovOptions:{url:"/waggle/service/ajax",ajax:"ipbusinessunits",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unittypes",src:"allowedtypes",ft:false}],results:[
		  {tgt:"buname",tt:false,id:"bum_buname"},
		  {tgt:"buname",tt:true,id:"bum_buname"},  	  	
		  {tgt:"bucode",tt:false,id:"bum_code"},
		  {tgt:"butype",tt:false,id:"bum_type"}
		  ]}},
		  {name:"ipno",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":true,nf:"patientname",lovOptions:{url:"/waggle/service/ajax",ajax:"inpatient",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branchcode",src:"branchcode",tt:false}],results:[
		  {tgt:"ipno",tt:false,id:"pam_no"},
		  {tgt:"ipno",tt:true,id:"pam_no"},
		  {tgt:"patientname",tt:false,id:"pam_name"},  	
		  {tgt:"patientcode",tt:false,id:"pam_code"},
		  {tgt:"patientage",tt:false,id:"pam_age"},
		  {tgt:"gender",tt:false,id:"pam_gender"},
		  {tgt:"doctorcode",tt:false,id:"pam_consulting_dr"},
		  {tgt:"doctorname",tt:false,id:"dr_name"},
		  {tgt:"referralcode",tt:false,id:"pam_referral_dr"},
		  {tgt:"referredby",tt:false,id:"refdoctor"},  	
		  {tgt:"roomno",tt:false,id:"rm_roomname"},
		  {tgt:"roomcode",tt:false,id:"pam_roomno"},
		  {tgt:"sponsorcode",tt:false,id:"pam_sponsor_code"},
		  {tgt:"sponsorname",tt:false,id:"icm_name"},
		  {tgt:"sponsorcardno",tt:false,id:"pam_sponsor_cardno"},
		  {tgt:"sponsorapprovalno",tt:false,id:"pam_sponsor_approvalno"},
		  {tgt:"hospregcode",tt:false,id:"pam_hospreg_code"}
		  ]}},
		  {name:"roomno",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientname"},
		  {name:"roomcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
		  {name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientage"},
		  {name:"patientcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientage"},
		  {name:"patientage",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"doctorname"},
		  {name:"gender",inputType:4,type:"SPAN",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"doctorname"},
		  {name:"doctorname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"referredby"},
		  {name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
		  {name:"sponsorname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
		  {name:"sponsorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
		  {name:"sponsorcardno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
		  {name:"sponsorapprovalno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
		  {name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
		  {name:"referredby",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"totalamt",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"cashamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"cardbank"},
		  {name:"tcashamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"cardbank",onchange:"onTenderDetailChange"},
		  {name:"creditamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"btnSave",onchange:"onTenderDetailChange"},
		  {name:"sponsoramount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"btnSave",onchange:"onTenderDetailChange"},
		  {name:"cardbank",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"tcardamount",values:banks.values,keys:banks.keys},
		  {name:"tcardamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"sponsoramount",onchange:"onTenderDetailChange"},
		  {name:"srvchgamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsoramount"},
		  {name:"cardamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsoramount"},
		  {name:"tenderamount",inputType:0,type:"DECIMAL",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"netamount",inputType:0,type:"DECIMAL",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"balanceamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"billdate",inputType:0,type:"TDATE",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},  	
		  {name:"butype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"allowedtypes",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"hospregcode",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"appid",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"crno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"crsno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"casualityno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"csno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
		  {name:"claimno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},  	
		  {name:"btnSave",inputType:3,caption:"",visible:false},
		{name:"btnClear",inputType:3,caption:"",visible:false}
		  ]},
		  {name:"billgrid",title:"",contentType:"Table",tableProperties:{rowObject:true,serialNumberColumn:"sno",rowEmptyCheckColumn:"productcode",optional:false,columns:[
		{order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
		{order:"1",id: "productcode", name: "ItemCode", field: "productcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:0,"chkTag":false},    
		{order:"2",id: "product", name: "Test", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,"chkTag":true,lovOptions:{url:"/waggle/service/ajax",ajax:"buitems",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"bucode",src:"bucode",tt:false}],results:[
		  {tgt:"billgrid_data",tt:false,row:"cr",id:"buim_code",col:"productcode"},
		  {tgt:"billgrid_data",tt:false,row:"cr",id:"buim_itemname",col:"product"},
		  {tgt:"billgrid_data",tt:true,row:"cr",id:"buim_itemname",col:"product"},  	  	
		  {tgt:"billgrid_data",tt:false,row:"cr",id:"buim_itemrate",col:"rate"}
		  ]},validation:"validateBillItem"},
		{order:"3",id: "quantity", name: "No Of Test", field: "quantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:150,onchange:"onRateQuantityChange",align:"center",cTotal:true},
		{order:"4",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,onchange:"onRateQuantityChange",align:"right"},
		{order:"5",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"right"}
		]
		}}]};
		var billing=new FlexUI.Screen("billing",sProps);	
		//ajax columns
		var showTender=true;
		
		var l=new FlexUI.Ajax();
		$(document).ready(function () {
				screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
				screenObjects.getScreenObject("billgrid_data").getInputField().onTextKeyDown.subscribe(tableTextKeyDown);
				screenObjects.getScreenObject("billgrid_data").onAfterDeleteRow.subscribe(tableRowDelete);
				$('#subtitle').text("");
				if($('#callback').length>0){
					$('#screentitle').text("Clinical Request");
					var rowData=$('#callback').data('row');
					showTender=false;
					screenObjects.getScreenObject("ipno").setValue(rowData.pam_no);
					screenObjects.getScreenObject("ipno").setTag(rowData.pam_no);
					  screenObjects.getScreenObject("roomno").setValue(rowData.rm_roomname);
					  screenObjects.getScreenObject("patientcode").setValue(rowData.pam_code);
					  screenObjects.getScreenObject("patientname").setValue(rowData.pam_name);
					  screenObjects.getScreenObject("patientage").setValue(rowData.pam_age);
					  screenObjects.getScreenObject("gender").setValue(rowData.pam_gender);
					  screenObjects.getScreenObject("doctorname").setValue(rowData.dr_name);
					  screenObjects.getScreenObject("doctorcode").setValue(rowData.pam_consulting_dr);
					  screenObjects.getScreenObject("referredby").setValue(rowData.referraldr);
					  screenObjects.getScreenObject("referralcode").setValue(rowData.pam_referral_dr);;
					  screenObjects.getScreenObject("sponsorcode").setValue(rowData.pam_sponsor_code);;
					  screenObjects.getScreenObject("sponsorname").setValue(rowData.icm_name);;
					  screenObjects.getScreenObject("sponsorcardno").setValue(rowData.pam_sponsor_cardno);;
					  screenObjects.getScreenObject("sponsorapprovalno").setValue(rowData.pam_sponsor_approvalno);;
					  screenObjects.getScreenObject("roomcode").setValue(rowData.pam_roomno);;
					  screenObjects.getScreenObject("ipno").setEnabled(false);
					  screenObjects.getScreenObject("allowedtypes").setValue("1,2");
					  screenObjects.getScreenObject("hospregcode").setValue(rowData.pam_hospreg_code);
					  $('#heading').css("display","none");
					  $('#btnCancelScr').css("display","inline-block");
				}else{
					$('#btnCancelScr').css("display","none");
					$('#screentitle').text("Billing");
					screenObjects.getScreenObject("allowedtypes").setValue("0,3");
					$('#heading').css("display","block");
				}
				screenObjects.getScreenObject("buname").focus();
				if('<%=mode%>'=="View"){
					loadBillData("/waggle/service/screen/data?screencode=<%=screenCode%>&branchcode=<%=branch%>&code=<%=code%>");
					$('#btnSave').css("display","none");
				}else{
					$('#btnSave').css("display","inline-block");
				}            
			});
			function saveBill(){
				if('<%=mode%>'=="View") return;
				if(billing.getSaveInProgress()) return;
				var r=null;
				var butype=screenObjects.getScreenObject("butype").getValue();
				billing.setOperation("ADD");
				billing.setScreenCode(<%=screenCode%>);
				if(toNumber(screenObjects.getScreenObject("cardamount").getValue())>0 && screenObjects.getScreenObject("cardbank").getValue()=="0"){
					alert("Please select card machine to continue");
					return;
				}
				if(toNumber(screenObjects.getScreenObject("cardamount").getValue())==0 && screenObjects.getScreenObject("cardbank").getValue()!="0"){
					screenObjects.getScreenObject("cardbank").setValue("0");    			
				}     		
				if(toNumber(screenObjects.getScreenObject("totalamt").getValue())>toNumber(screenObjects.getScreenObject("tenderamount").getValue())){
					alert("Tender Amount cannot be less than the Bill Amount");
					return;
				}
				var d=billing.processDataToSave();
				billing.setSaveInProgress(true);    		
				if("FAILED"!=d){
					var s=new FlexUI.Ajax();
					showLoader();
					r=s.callAjax("POST","/waggle/service/screen/save",d);
					hideLoader();
				 }else{
					 alert("Please correct the validation errors and continue...");
					 billing.setSaveInProgress(false);		 		
					 return;
				 }		 
				 if(r.result=="Success"){
					alert(r.message+" [No:"+r.code+"]");
					if(showTender && (butype=="0" || butype=="3")){
						$('#tenderdlg').dialog('close');
						$('#tenderdlg').dialog('destroy');
					}							
					clearInnerScreen();
					if(showTender){
						var ps=JSON.parse(d.replace("data=","")).savedata;
						ps["billno"]=r.billno;
						printBill(ps);
					}
					if(!showTender){
						//hideMasterData();
					}
					return r.key;			
				}else{
					billing.setSaveInProgress(false);
					alert(r.message);		
				}
			}
			function clearInnerScreen(){
				$('#overlapdiv').css('display','none');
				billing.clearScreen();
				billing.setSaveInProgress(false);
				if($('#callback').length>0){
					var rowData=$('#callback').data('row');
					showTender=false;
					screenObjects.getScreenObject("ipno").setValue(rowData.pam_no);
					screenObjects.getScreenObject("ipno").setTag(rowData.pam_no);
					  screenObjects.getScreenObject("roomno").setValue(rowData.rm_roomname);
					  screenObjects.getScreenObject("patientcode").setValue(rowData.pam_code);
					  screenObjects.getScreenObject("patientname").setValue(rowData.pam_name);
					  screenObjects.getScreenObject("patientage").setValue(rowData.pam_age);
					  screenObjects.getScreenObject("gender").setValue(rowData.pam_gender);
					  screenObjects.getScreenObject("doctorname").setValue(rowData.dr_name);
					  screenObjects.getScreenObject("doctorcode").setValue(rowData.pam_consulting_dr);
					  screenObjects.getScreenObject("referredby").setValue(rowData.referraldr);
					  screenObjects.getScreenObject("referralcode").setValue(rowData.pam_referral_dr);;
					  screenObjects.getScreenObject("sponsorcode").setValue(rowData.pam_sponsor_code);;
					  screenObjects.getScreenObject("sponsorname").setValue(rowData.icm_name);;
					  screenObjects.getScreenObject("sponsorcardno").setValue(rowData.pam_sponsor_cardno);;
					  screenObjects.getScreenObject("sponsorapprovalno").setValue(rowData.pam_sponsor_approvalno);;
					  screenObjects.getScreenObject("roomcode").setValue(rowData.pam_roomno);;
					  screenObjects.getScreenObject("ipno").setEnabled(false);
					  screenObjects.getScreenObject("allowedtypes").setValue("1,2");
					  screenObjects.getScreenObject("hospregcode").setValue(rowData.pam_hospreg_code);
				}else{
					screenObjects.getScreenObject("allowedtypes").setValue("0,3");
				}        	
				screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
				screenObjects.getScreenObject("buname").focus();
				if("<%=mode%>"=="View"){
					$('.ui-dialog').children().remove();
					$('.ui-dialog').remove();
					$("#bodyContainer").children().remove();
					$("#bodyContainer").html("");
					$("#bodyContainer").load("/waggle/billPrintRequest.do?id=11&title=Bills");
				}
			}
			function onRateQuantityChange(id,me){
				var t=me.getParent();
				calculateAmount(t.getCurrentRow());
				calculateTotal();
				return true;
			}
			function calculateTotal(){
				var total=0;
				var t=screenObjects.getScreenObject("billgrid_data");
				var cols=t.getCols();
				var s=t.getSize();
				for(var i=0;i<s;i++){
					total+=toNumber(t.getText(i,cols.amount));
				}
				screenObjects.getScreenObject("totalamt").setValue(roundOff(total,2));
				screenObjects.getScreenObject("netamount").setValue(roundOff(total,2));
				$("#netAmt").html("Net Amount   "+roundOff(total,2));
			}
			function calculateAmount(row){
				var t=screenObjects.getScreenObject("billgrid_data");
				var cols=t.getCols();	
				var baseqty=0;
				baseqty=toNumber(t.getText(row,cols.quantity));
				var amt=roundOff(toNumber(t.getText(row,cols.rate))*baseqty,2);
				t.setText(row,cols.amount,amt);
			}
			function tableTextKeyDown(e,args){
				var butype=screenObjects.getScreenObject("butype").getValue();		
				var key=e.which || e.keyCode;
				if(key==113){
					if(showTender){
						if(butype=="0" || butype=="3"){
							$('#dispTotalAmt').text($('#totalamt').text());				
							$('#tenderdlg').dialog({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:600,position:'center'});
							$('#tenderdlg').dialog('open');					
						}
					}
					e.preventDefault();
					if(showTender && (butype=="0" || butype=="3")){
						screenObjects.getScreenObject("tcashamount").focus();
					}else{
						screenObjects.getScreenObject("creditamount").setValue($('#totalamt').text());
						onTenderDetailChange();
						saveBill();
					}
				}
			}
			function tableRowDelete(e,args){
				calculateTotal();
			}
			function onTenderDetailChange(){
				var totalAmount=toNumber(roundOff(screenObjects.getScreenObject("totalamt").getValue(),2));
				var cashAmount=toNumber(roundOff(screenObjects.getScreenObject("tcashamount").getValue(),2));
				var creditAmount=toNumber(roundOff(screenObjects.getScreenObject("creditamount").getValue(),2));
				var cardAmount=toNumber(roundOff(screenObjects.getScreenObject("tcardamount").getValue(),2));
				var sponsorAmount=toNumber(roundOff(screenObjects.getScreenObject("sponsoramount").getValue(),2));
				var totalCardAmount=cardAmount;
				var netAmount=totalAmount;
				if(cardAmount>0){
					var cardServChg=cardAmount*2/100;
					var totalCardAmount=cardAmount+cardServChg;
					var netAmount=totalAmount+cardServChg;
					screenObjects.getScreenObject("cardamount").setValue(roundOff(totalCardAmount,2));
					screenObjects.getScreenObject("srvchgamount").setValue(roundOff(cardServChg,2));
					screenObjects.getScreenObject("netamount").setValue(roundOff(netAmount,2));
				}else{
					screenObjects.getScreenObject("srvchgamount").setValue("0.00");
					screenObjects.getScreenObject("netamount").setValue(roundOff(totalAmount,2));
					screenObjects.getScreenObject("cardamount").setValue("0.00");
				}			
				var tenderedAmount=cashAmount+creditAmount+totalCardAmount+sponsorAmount;
				var balanceAmount=tenderedAmount-netAmount;
				//console.log(cashAmount+" "+creditAmount+" "+cardAmount+" "+sponsorAmount+" "+totalAmount);
				if(cashAmount>totalAmount){
					screenObjects.getScreenObject("cashamount").setValue(roundOff(totalAmount,2));
				}else{
					screenObjects.getScreenObject("cashamount").setValue(roundOff(cashAmount,2));
				}
				screenObjects.getScreenObject("tenderamount").setValue(roundOff(tenderedAmount,2));
				screenObjects.getScreenObject("balanceamount").setValue(roundOff(balanceAmount,2));
			}
			function cancelTenderDlg(){
				$('#tenderdlg').dialog('close');
				$('#tenderdlg').dialog('destroy');
				screenObjects.getScreenObject("billgrid_data").getInputField().focus();
			}
			function validateBillItem(id,me,row,col){
				if(!billing.getSaveInProgress()){
					var t=screenObjects.getScreenObject("billgrid_data");
					var butype=screenObjects.getScreenObject("butype").getValue();
					var cols=t.getCols();
					var columnProps=t.getColumnProperties();
					if(butype!=1){
						columnProps[cols.rate].readOnly=false;
						columnProps[cols.quantity].readOnly=true;
					}else{
						columnProps[cols.rate].readOnly=true;
						columnProps[cols.quantity].readOnly=false;
					}
					t.setText(row,cols.quantity,"1");
				}
				return true;
			}
			function loadBillData(url,code,did){
				  showLoader();
				var l=new FlexUI.Ajax();
				var v=l.callAjax("GET",url,"");
				billing.loadObjectData(v);
				calculateTotal();			
				  hideLoader();
			}
			function printBill(data){
				var t=screenObjects.getScreenObject("billgrid_data");
				var cols=t.getCols();		
				var printData={};
				printData["type"]="IPBILL";
				printData["branchname"]=$('#branch option:selected').text();
				printData["address1"]="27,Javulikara Street";
				printData["address2"]="Tiruvarur - 610 001";
				printData["address3"]="Phone - 242292,240292";
				printData["tin"]="";
				printData["buname"]=data["buname"];
				printData["billno"]=data["billno"];
				printData["billdate"]=data["billdate"]+" "+formatTimeHHMM(new Date());
				printData["totalamt"]=data["totalamt"]+"";
				printData["netamount"]=data["netamount"]+"";
				printData["srvchgamount"]=data["srvchgamount"]+"";
				printData["tenderamount"]=data["tenderamount"]+"";
				printData["balanceamount"]=data["balanceamount"]+"";
				printData["roundoff"]="0.00";
				printData["sponsorname"]=data["sponsorname"]+"";
				printData["doctorname"]=data["doctorname"]+"";
				printData["referredby"]=data["referredby"]+"";
				printData["roundoff"]="0.00";
				printData["patientname"]=data["patientname"];		
				printData["patientage"]=data["patientage"];
				printData["ipno"]=data["ipno"];
				printData["userid"]="<%=userId%>";
				printData["gender"]=data["gender"];
				printData["invtype"]="CASH";
				printData["items"]=[];
				for(var x=0;x<data["billgrid_data"].length;x++){
					var item={};
					item.name=data["billgrid_data"][x].product+"";
					item.rate=roundOff(data["billgrid_data"][x].rate,2)+"";
					item.qty=data["billgrid_data"][x].quantity+"";
					item.amount=data["billgrid_data"][x].amount+"";;				
					printData.items.push(item);
				}
				$.ajax({
					url: "http://localhost:9191",
					type: "POST",
					async: true,
					contentType:"application/x-www-form-urlencoded",
					data:"printdata="+JSON.stringify(printData),
					dataType: "json",
					success: function (r) {
						//alert(r.result);		
					}
				});						
			}
		</script>
	</body>
	</html>