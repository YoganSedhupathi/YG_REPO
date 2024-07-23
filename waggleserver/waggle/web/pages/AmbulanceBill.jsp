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
   String screenCode=request.getParameter("screenCode");
   if(screenCode==null){
   		screenCode="11";
   }
%>
<body>	

	<div class="card border-0 shadow">
		<div class="card-body ">
		  <!--Header-->
		  <div class="row w-100">
					  <div class="col-md-6 d-flex align-items-center">
						  <h4 class="header-title">Ambulance Billing</h4>
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

				<div class="col-sm-4 col-md-4 col-lg-4">                    
				  <div id="" class="cBor">
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Search By </label></div>
						<div class="col-md-4"><select class="form-control" id="searchtype"><option value="all">All</option><option value="appointments">Appointments</option></select></div>
						<div class="col-md-4"><select class="form-control" id="searchpatient"><option value="mobile">Mobile No</option><option value="regno">Reg No</option></select></div>
					</div>

					<div class="form-group mbotto">
						<div class="col-md-4"></div>
						<div class="col-md-8"><input type="text" class="form-control" id="smobileno"/></div>
					</div>

					<div class="form-group mbotto">
						<div class="col-md-4"><label>Business Unit</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="buname"><input type="hidden" class="form-control" id="bucode"><input type="hidden" class="form-control" id="butype"><input type="hidden" class="form-control" id="allowedtypes"><input type="hidden" class="form-control" id="crno"><input type="hidden" class="form-control" id="crsno"><input type="hidden" class="form-control" id="crstatus" value="1"></div>
					</div>
					<div  style="display:none">
						<div class="form-group mbotto" style="display:none">
							<div class="col-md-4"><label>IP No</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="ipno"><input type="hidden" id="billno"/><input type="hidden" id="code"/><input type="hidden" id="billdate"/></div>
						</div>

						<div class="form-group mbotto" style="display:none">
							<div class="col-md-4"><label>Room No</label></div>
							<div class="col-md-8"><label id="roomno">Room No</label><input type="hidden" id="roomcode"/></div>
						</div>
					</div>

					<div class="form-group mbotto">
						<div class="col-md-4"><label>Patient Name </label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="patientname"><input type="hidden" class="form-control" id="patientcode"><input type="hidden" class="form-control" id="hospregcode"><input type="hidden" class="form-control" id="appid"><input type="hidden" class="form-control" id="casualityno"><input type="hidden" class="form-control" id="csno"><input type="hidden" class="form-control" id="claimno"></div>
					</div>

					<div class="form-group mbotto">
						<div class="col-md-4"><label>Mobile No</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="mobileno"></div>
					</div>

				  </div>
				</div>

				<div class="col-sm-4 col-md-4 col-lg-4"> 
					<div id="" class="cBor">
						

						<div class="form-group mbotto">
							<div class="col-md-4"><label>Age</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="patientage"></div>
						</div>

						<div class="form-group mbotto">
							<div class="col-md-4"><label>Gender</label></div>
							<div class="col-md-8"><select class="form-control" id="gender"></select></div>
						</div>

						<div class="form-group mbotto">
							<div class="col-md-4"><label>Doctor name </label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="doctorname"><input type="hidden" id="doctorcode"/></div>
						</div>

						<div class="form-group mbotto">
							<div class="col-md-4"><label>Refer By  </label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="referredby"><input type="hidden" id="referralcode"/></div>
						</div>
						

					</div>
				</div>
				<div class="col-sm-4 col-md-4 col-lg-4"> 
					<div id="" class="cBor">
						<div class="form-group mbotto">
							<div class="col-md-4"><label>From</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="fromplace"></div>
						</div>

						<div class="form-group mbotto">
							<div class="col-md-4"><label>To</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="toplace"></div>
						</div>

						<div class="form-group mbotto">
							<div class="col-md-4"><label>Start KM</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="fromkm" ></div>
						</div>

						<div class="form-group mbotto">
							<div class="col-md-4"><label>End KM</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="tokm"></div>
						</div>

					</div>
				</div>

			   </div>
	  
			   <div class="row">
				  <div class="table-container">
					  <div class="col-md-12 col-sm-12 garea" id="billgrid"></div>
				  </div>
				</div>
	  

				<div class="row w-100 mt-3">
					<div class="col-md-6">
					  <div class="hstack justify-content-start">
						<div id="saveGrp">
						  <button type="button" id="btnLoadCR" class="btn btn-edit" onclick="loadClinicalRequests()" style="display:none"><span class="mdi mdi-pencil me-2"></span>Clinical Requests</button>
						  <button type="button" id="btnClearScr" class="btn btn-clear mx-3" onclick="clearInnerScreen()"><span class="mdi mdi-refresh me-2"></span>Clear</button>
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
		  </div>
		 <!--Content End-->
		</div>
	  


			
		<div id='tenderdlg' class='modal'>
			<div class="modal-dialog modal-dialog-scrollable">
			  <div class="modal-content">
					<div id='tendertitle' class='modal-header'>
						<div class='pop_lov_hed_txt'> <h3>Bill Amount Rs. </h3><span id="dispTotalAmt"></span></div>
						<button type="button" class="btn-close" onclick="cancelDiscountDlg()" data-bs-dismiss="modal"></button>
					</div>
					<div class='modal-body'>
						<div class="col-md-12 col-sm-12 mpZero" >
							<div id='tender' class='pop_lov_inp_box'>
								<div class="col-md-12 col-sm-12 mpZero">
									<div  class="col-md-12 col-sm-12 mpZero">		
									<div class="form-group mbotto">
										<div class="col-md-4"><label>Cash</label></div>
										<div class="col-md-8"><input type="text" class="form-control" id="tcashamount"><input type="hidden" class="form-control" id="cashamount"></div>
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
										<div class="col-md-4"><label>Machine</label></div>
										<div class="col-md-8"><select class="form-control" id="cardbank"></select></div>
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
										<div class="col-md-8"><input type="text" class="form-control" id="srvchgamount" disabled></div>
									</div>
									</div>
									<div class='clearfix'></div>
									<div  class="col-md-12 col-sm-12 mpZero">		
									<div class="form-group mbotto">
										<div class="col-md-4"><label>Card Amount</label></div>
										<div class="col-md-8"><input type="text" class="form-control" id="cardamount" disabled></div>
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
								<div class="col-md-6 col-sm-6 mpZero" style="display:none">
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-5"><label>Corporate</label></div>
									<div class="col-md-7"><input type="text" class="form-control" id="sponsorname"><input type="hidden" class="form-control" id="sponsorcode"></div>
									</div>
									</div>
									<div class="clearfix"></div>
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-5"><label>Card No</label></div>
									<div class="col-md-7"><input type="text" class="form-control" id="sponsorcardno"></div>
									</div>
									</div>					
									<div class="clearfix"></div>
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-5"><label>Approval No</label></div>
									<div class="col-md-7"><input type="text" class="form-control" id="sponsorapprovalno"></div>
									</div>
									</div>															
								</div>
								<div class="clearfix"></div>
														
							</div>
						</div>
					</div>
					<div id="actButton" class="modal-footer">
						<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="saveBill()">Save</button>
						<button id="btnClear" class="btn btn-default" type="button" onclick="cancelTenderDlg()">Cancel</button>
					</div>
			  </div>
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
					<div  class="col-md-12 col-sm-12 mpZero" style="display:none">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Credit</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="creditamount"></div>
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
						<div class="col-md-8"><input type="text" class="form-control" id="srvchgamount" disabled></div>
					</div>
					</div>
					<div class='clearfix'></div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Card Amount</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="cardamount" disabled></div>
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
				<div class="col-md-6 col-sm-6 mpZero" style="display:none">
					<div class="col-md-12 col-sm-12 mpZero">
					<div class="form-group mbotto">
					<div class="col-md-5"><label>Corporate</label></div>
					<div class="col-md-7"><input type="text" class="form-control" id="sponsorname"><input type="hidden" class="form-control" id="sponsorcode"></div>
					</div>
					</div>
					<div class="clearfix"></div>
					<div class="col-md-12 col-sm-12 mpZero">
					<div class="form-group mbotto">
					<div class="col-md-5"><label>Card No</label></div>
					<div class="col-md-7"><input type="text" class="form-control" id="sponsorcardno"></div>
					</div>
					</div>					
					<div class="clearfix"></div>
					<div class="col-md-12 col-sm-12 mpZero">
					<div class="form-group mbotto">
					<div class="col-md-5"><label>Approval No</label></div>
					<div class="col-md-7"><input type="text" class="form-control" id="sponsorapprovalno"></div>
					</div>
					</div>															
				</div>
				<div class="clearfix"></div>
				<div id="actButton" class="col-md-5 text-right">
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
  	{name:"billtype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"2","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"patienttype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"2","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"smobileno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"buname",validation:"checkPatientExists"},
  	{name:"buname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"ipno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"patientname"},
  	{name:"roomno",inputType:4,type:"SPAN",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"roomcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"mobileno"},
  	{name:"patientcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"mobileno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"gender"},
  	{name:"gender",inputType:1,type:"TEXT",caption:"",mandatory:true,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"doctorname",values:"M~F",keys:"Male~Female"},
  	{name:"doctorname",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"referredby",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"doctorcode",tt:false,id:"dr_code"},{tgt:"doctorname",tt:true,id:"dr_name"},{tgt:"doctorname",tt:false,id:"dr_name"},{tgt:"referralcode",tt:false,id:"dr_code"},{tgt:"referredby",tt:false,id:"dr_name"},{tgt:"referredby",tt:true,id:"dr_name"}]}},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referredby",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"fromplace",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"referralcode",tt:false,id:"dr_code"},{tgt:"referredby",tt:false,id:"dr_name"},{tgt:"referredby",tt:true,id:"dr_name"}]}},
  	{name:"fromplace",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"toplace"},
  	{name:"toplace",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"tokm"},
  	{name:"fromkm",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"tokm"},
  	{name:"tokm",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"billgrid_data",validation:"validateToKM"},
  	{name:"totalamt",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"billgrid_data"},
  	{name:"tcashamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"cardbank",onchange:"onTenderDetailChange"},
  	{name:"cashamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"cardbank"},
  	{name:"creditamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"cardbank",onchange:"onTenderDetailChange"},
  	{name:"cardbank",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"tcardamount",values:banks.values,keys:banks.keys},
  	{name:"tcardamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"sponsoramount",onchange:"onTenderDetailChange"},
  	{name:"srvchgamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsoramount"},  	
  	{name:"cardamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"sponsoramount"},  	
  	{name:"sponsoramount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"sponsorname",onchange:"onTenderDetailChange"},
  	{name:"tenderamount",inputType:0,type:"DECIMAL",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsorname"},
  	{name:"netamount",inputType:0,type:"DECIMAL",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsorname"},
  	{name:"balanceamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsorname"},
  	{name:"sponsorname",inputType:0,type:"LOV",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"sponsorcardno",lovOptions:{url:"/waggle/service/ajax",ajax:"insurancecompany",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"sponsorname",tt:false,id:"icm_name"},{tgt:"sponsorname",tt:true,id:"icm_name"},{tgt:"sponsorcode",tt:false,id:"icm_code"}]}},
  	{name:"sponsorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"sponsorcardno"},
  	{name:"sponsorcardno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"sponsorapprovalno"},
  	{name:"sponsorapprovalno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"btnSave"},
  	{name:"billdate",inputType:0,type:"TDATE",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},  	
  	{name:"butype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"allowedtypes",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"hospregcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"appid",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"crno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"crsno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"crstatus",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"casualityno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"csno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"claimno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"btnSave",inputType:3,caption:"",visible:false,readOnly:true},
    {name:"btnClear",inputType:3,caption:"",visible:false,readOnly:true}
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
    {order:"3",id: "quantity", name: "No Of Test", field: "quantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:150,onchange:"onRateQuantityChange",align:"center"},
    {order:"4",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,onchange:"onRateQuantityChange",align:"right"},
    {order:"5",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"right"}
    ]
    }}]};
	var billing=new FlexUI.Screen("billing",sProps);	
	//ajax columns
	var showTender=true;
	var l=new FlexUI.Ajax();
	var businessUnitData = null;	
    $(document).ready(function () {
            screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
            screenObjects.getScreenObject("crstatus").setValue("1");
            screenObjects.getScreenObject("butype").setValue("1");
            screenObjects.getScreenObject("buname").setValue("Ambulance");
            screenObjects.getScreenObject("bucode").setValue("40");
            screenObjects.getScreenObject("billgrid_data").getInputField().onTextKeyDown.subscribe(tableTextKeyDown);
            screenObjects.getScreenObject("billgrid_data").onAfterDeleteRow.subscribe(tableRowDelete);
            $('#subtitle').text("");
            $('#screentitle').text("Billing");
            screenObjects.getScreenObject("allowedtypes").setValue("1");
            screenObjects.getScreenObject("smobileno").focus();
            if('<%=mode%>'=="View"){
            	loadBillData("/waggle/service/screen/data?screencode=<%=screenCode%>&branchcode=<%=branch%>&code=<%=code%>");
            	$('#btnSave').css("display","none");
            }else if('<%=mode%>'=="Edit"){
            	loadBillData("/waggle/service/screen/data?screencode=<%=screenCode%>&branchcode=<%=branch%>&code=<%=code%>");
            	$('#btnSave').css("display","block");
            }else{
            	$('#btnSave').css("display","block");
            	loadMaxKM();
            }
        });
        function saveBill(){
        	if('<%=mode%>'=="View") return;
        	if(billing.getSaveInProgress()) return;
        	var r=null;
        	var bucode=screenObjects.getScreenObject("bucode").getValue();
        	if('<%=mode%>'=="Edit"){
    			billing.setOperation("MOD");
        	}else{
    			billing.setOperation("ADD");
    		}
    		billing.setScreenCode(11);
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
				
				setErrorMessage(r.message+" [No:"+r.code+"]") ;
				if(showTender){
					// $('#tenderdlg').dialog('close');
					// $('#tenderdlg').dialog('destroy');
					$('#tenderdlg').modal('hide');
				}
				clearInnerScreen();
				var ps=JSON.parse(d.replace("data=","")).savedata;
				ps["billno"]=r.billno;
				printBill(ps);				
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
        	screenObjects.getScreenObject("fromkm").setEnabled(false);
        	screenObjects.getScreenObject("allowedtypes").setValue("1");
        	screenObjects.getScreenObject("crstatus").setValue("1");
        	screenObjects.getScreenObject("buname").setValue("Ambulance");
        	screenObjects.getScreenObject("bucode").setValue("37");
        	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
        	screenObjects.getScreenObject("smobileno").focus();
        	if("<%=mode%>"=="View" || "<%=mode%>"=="Edit"){
        		$('.ui-dialog').children().remove();
				$('.ui-dialog').remove();
				$("#bodyContainer").children().remove();
				$("#bodyContainer").html("");
				if(<%=screenCode%>==20){
					$("#bodyContainer").load("/waggle/billPrintRequest.do?id=<%=screenCode%>&title=ClinicalRequests");
				}else{
					$("#bodyContainer").load("/waggle/billPrintRequest.do?id=<%=screenCode%>&title=Bills");
				}
        	}else{
        			loadMaxKM();
        	}
        }
        function loadMaxKM(){
        	var v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=maxkm&branchcode="+$('#branch').val());
    		if(v!=null){
				if(v.data && v.data.length==1){
					screenObjects.getScreenObject("fromkm").setValue(v.data[0][0]);																
				}
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
			$("#netAmt").html(roundOff(total,2));
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
			var bucode=screenObjects.getScreenObject("bucode").getValue();		
			var key=e.which || e.keyCode;
			if(key==113){
				if(showTender){
					$('#dispTotalAmt').text($('#totalamt').text());				
					$('#tenderdlg').modal({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:700,position:'center'});
					$('#tenderdlg').modal('show');
					screenObjects.getScreenObject("sponsorname").setEnabled(false);
					screenObjects.getScreenObject("sponsorcardno").setEnabled(false);
					screenObjects.getScreenObject("sponsorapprovalno").setEnabled(false);					
				}
				e.preventDefault();
				if(showTender){
					screenObjects.getScreenObject("tcashamount").focus();
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
			if(cashAmount>totalAmount){
				screenObjects.getScreenObject("cashamount").setValue(roundOff(totalAmount,2));
			}else{
				screenObjects.getScreenObject("cashamount").setValue(roundOff(cashAmount,2));
			}
			screenObjects.getScreenObject("tenderamount").setValue(roundOff(tenderedAmount,2));
			screenObjects.getScreenObject("balanceamount").setValue(roundOff(balanceAmount,2));
		}
		function cancelTenderDlg(){
			$('#tenderdlg').modal('hide');
			$('#tenderdlg').modal('dispose');
			screenObjects.getScreenObject("billgrid_data").getInputField().focus();
		}
		function validateBillItem(id,me,row,col){
			if(!billing.getSaveInProgress()){
				var t=screenObjects.getScreenObject("billgrid_data");
				var bucode=screenObjects.getScreenObject("bucode").getValue();
				var cols=t.getCols();
				var columnProps=t.getColumnProperties();
				columnProps[cols.rate].readOnly=true;
				columnProps[cols.quantity].readOnly=false;
				if(t.getText(row,cols.productcode)==1127){
					var fromkm=screenObjects.getScreenObject("fromkm").getValue();
					var tokm=screenObjects.getScreenObject("tokm").getValue();				
					t.setText(row,cols.quantity,toNumber(tokm)-toNumber(fromkm));
				}else{
					t.setText(row,cols.quantity,"1");
				}
			}
			return true;
		}
		function loadBillData(url,code,did){
		  	showLoader();
			var l=new FlexUI.Ajax();
			var v=l.callAjax("GET",url,"");
			billing.disableInputs(true);
			billing.loadObjectData(v);
			calculateTotal();			
		  	hideLoader();
		}  		
		function printBill(data){
			var t=screenObjects.getScreenObject("billgrid_data");
			var cols=t.getCols();		
			var printData={};
			printData["type"]="OPBILL";
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
			printData["sponsorname"]=data["sponsorname"]+"";
			printData["doctorname"]=data["doctorname"]+"";
			printData["referredby"]=data["referredby"]+"";
			printData["fromplace"]=data["fromplace"]+"";
			printData["toplace"]=data["toplace"]+"";
			printData["fromkm"]=data["fromkm"]+"";
			printData["tokm"]=data["tokm"]+"";			
			printData["roundoff"]="0.00";
			printData["patientname"]=data["patientname"];		
			printData["patientage"]=data["patientage"];
			printData["gender"]=data["gender"];
			printData["userid"]="<%=userId%>";
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
				function onPatientClose(e,args){
			setPatientInfo(args.result);
		}		
		function checkPatientExists(id,me){
			if(!billing.getSaveInProgress() && screenObjects.getScreenObject("patientname").getValue()=="" && screenObjects.getScreenObject("smobileno").getTag()==""){
				var branch=screenObjects.getScreenObject("branchcode").getValue();
				var stext=screenObjects.getScreenObject("smobileno").getValue();
				var params="";
				var paramName="F1";
				var dsi=0;
				var searchType=$('#searchtype').val();
				if($('#searchpatient').val()=="mobile"){
					params="&F1="+stext;
					dsi=0;
				}else{
					params="&F2="+stext;
					paramName="F2";
					dsi=1;
				}
				if(stext!=""){
					var v=null;
					var l=new FlexUI.Ajax();
					if(searchType=="all"){
						v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=hosppatients&branchcode="+branch+params);
					}else{
						v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=hospapppatients&branchcode="+branch+params);
					}
					if(v!=null){
						if(v.data && v.data.length==1){
							setPatientInfo(v.data[0]);					
							return true;
						}else if(v.data && v.data.length>1){
							screenObjects.getScreenObject("smobileno").setTag(stext);
							var d=null;
							d={url:"/waggle/service/ajax",ajax:"hosppatients",scrollEnabled:true,searchFromList:false,dsi:dsi,params:[{n:"branchcode",src:"branchcode",ft:false},{n:paramName,src:"smobileno",ft:false}],results:[],standalone:true};
							var lov=new FlexUI.LOV("s_lov",me,d,v.data);
							lov.onLovClose.subscribe(onPatientClose);
							lov.show();					
							return false;
						}else{
							if($('#searchpatient').val()=="mobile"){
								screenObjects.getScreenObject("mobileno").setValue(stext);
							}
						}		
					}
				}
			}else{
				screenObjects.getScreenObject("smobileno").setTag("");
			}	
			return true;
		}
		function setPatientInfo(result){
			screenObjects.getScreenObject("patientname").setValue(result[2]);
			screenObjects.getScreenObject("hospregcode").setValue(result[1]);
			screenObjects.getScreenObject("gender").setValue(result[4]);
			screenObjects.getScreenObject("patientage").setValue(result[3]);
			screenObjects.getScreenObject("doctorcode").setValue(result[5]);
			screenObjects.getScreenObject("doctorname").setValue(result[6]);
			screenObjects.getScreenObject("doctorname").setTag(result[6]);
			screenObjects.getScreenObject("referralcode").setValue(result[7]);
			screenObjects.getScreenObject("referredby").setValue(result[8]);
			screenObjects.getScreenObject("referredby").setTag(result[8]);
			screenObjects.getScreenObject("mobileno").setValue(result[0]);
			if($('#searchpatient').val()=="mobile"){
				screenObjects.getScreenObject("smobileno").setValue(result[0]);
			}else{
				screenObjects.getScreenObject("smobileno").setValue(result[1]);
			}
			if($('#searchtype').val()=="appointments"){
				screenObjects.getScreenObject("appid").setValue(result[18]);
			}				
			screenObjects.getScreenObject("smobileno").goToNextField();			
		}
		function validateToKM(id,me){
			var fromkm=screenObjects.getScreenObject("fromkm").getValue();
			var tokm=screenObjects.getScreenObject("tokm").getValue();
			if(toNumber(fromkm)>=toNumber(tokm)){
				return false;
			}			
			return true;
		}			
	</script>
</body>
</html>