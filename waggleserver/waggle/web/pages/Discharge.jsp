<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>
</head>
<%String mode=request.getParameter("mode");
String branch=request.getParameter("branch");
String dhno=request.getParameter("dhno");
String rptId=request.getParameter("id");
String fromDate=request.getParameter("fromdate");
String toDate=request.getParameter("todate");
%>
<body>
<div class="card border-0 shadow">
	<div class="card-body lpage">	
				  <!--Header-->
				<div class="row w-100">
					<div class="col-md-6 d-flex align-items-center">
						<h4 class="header-title"> Discharge </h4>
					</div>
					<div  class="col-md-6 text-right">
					</div>
				</div>
				<div class="col-md-12 col-sm-12 mpZero marTp" id="xyz" style="display:none" >
		
				</div>
		<!--Header End-->
		<!--Content -->
	    <div id="callback" class="mt-3">
		  <div class="bline"><h6>Patient Details</h6></div>
		  <div class="row  cBor">
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
							  <div class="col-md-12 form-lable">Reg No:&nbsp;<label  class="form-lable" id="lcsno"></label>&nbsp;|&nbsp;Room No:&nbsp;<label class="form-lable" id="roomno"></label></div>
						  </div>
				  </div>
			  </div>
			  
			  <div class="col-sm-12 col-md-12 col-lg-12">  
				  <div class="input-group mb-1">
								 <div class="col-md-2"><label for="patientname" class="form-lable">Patient Name </label></div>
								 <div class="col-md-4"><input type="text" class="form-control" id="patientname"><input type="hidden" class="form-control" id="patientcode"></div>
								 
								  <div class="col-md-2"><label class="form-lable">IP No</label></div>
								  <div class="col-md-4"><input type="text" class="form-control" id="ipno"><input type="hidden" id="refcode"/><input type="hidden" id="dischargedate"/><input type="hidden" id="hospregcode"/></div>
				  </div>
			  </div>
			  <div class="col-sm-12 col-md-12 col-lg-12">  
				  <div class="input-group mb-1">
					  <div class="col-md-2"><label for="patientage" class="form-lable">Age </label></div>
					  <div class="col-md-4"><input type="text" class="form-control" id="patientage"></div>
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
			  <div class="col-sm-12 col-md-12 col-lg-12">  
				<div class="input-group mb-1">
					<div class="col-md-2"><label for="" class="form-lable">Admission Date</label></div>
							   <div class="col-md-4"><input type="text" class="form-control" id="admissiondate"></div>
							   
							   <div class="col-md-2"><label for="" class="form-lable">Discharge Date</label></div>
							   <div class="col-md-4"><input type="text" class="form-control" id="dischargetime"></div>
					</div>
			</div>
		  </div>
		</div>
		  <!-- New Tabs -->

		  <div class="card border-0 bg-white  " style="margin-left: -10px;margin-right: -10px;" >
			<div class="card-header ">
				<nav class="mt-3">
					<div class="nav nav-pills" id="nav-tab" role="tablist" >
						<button class="nav-link btn btn-secondary  ml-2 mt-1 active "  type="button" id="pills-bill-tab" data-bs-toggle="pill" data-bs-target="#nav-bill" role="tab" aria-controls="nav-bill" aria-selected="true">
							<span class="mdi mdi-home-outline"></span>
							Bill Amount
						</button>
						<button class="nav-link  btn btn-secondary  ml-2 mt-1" type="button" id="pills-advance-tab" data-bs-toggle="pill" data-bs-target="#nav-advance" role="tab" aria-controls="nav-advance" aria-selected="false">
							<span class="mdi mdi-home-outline"></span>
							Advances & Co-Payments
						</button>
						
						<button class="nav-link  btn btn-secondary ml-2  mt-1" type="button" id="pills-nursing-tab" data-bs-toggle="pill" data-bs-target="#nav-nursing" role="tab" aria-controls="nav-nursing" aria-selected="false">
							<span class="mdi mdi-home-outline"></span>
							Nursing Home Charges
						</button>
						
						<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button"  id="pills-investigation-tab" role="tab" data-bs-toggle="pill" data-bs-target="#nav-investigation" aria-controls="nav-investigation" aria-selected="false">
							<span class="mdi mdi-home-outline"></span>
						   Investigation
						</button>
						<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button" id="pills-pharmacy-tab" role="tab" data-bs-toggle="pill" data-bs-target="#nav-pharmacy" aria-controls="nav-pharmacy" aria-selected="false">
							<span class="mdi mdi-home-outline"></span>
						   Pharmacy
						</button>
						
						<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button" id="pills-professional-tab" role="tab" data-bs-toggle="pill" data-bs-target="#nav-professional" aria-controls="nav-professional" aria-selected="false">
							<span class="mdi mdi-home-outline"></span>
						   Professional Charges
						</button>
						
						<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button" onclick="showLabBillDetail()" id="pills-investigation-tab" role="tab" data-bs-toggle="pill" data-bs-target="#nav-investigation" aria-controls="nav-investigation-detail" aria-selected="false">
							<span class="mdi mdi-home-outline"></span>
						   Investigation Detail
						</button>
						<button class="nav-link btn btn-secondary  ml-2 mt-1" type="button"  onclick="showPharmacyBillDetail()" id="pills-pharmacy-detail-tab" role="tab" data-bs-toggle="pill" data-bs-target="#nav-pharmacy-detail" aria-controls="nav-pharmacy-detail" aria-selected="false">
							<span class="mdi mdi-home-outline"></span>
						   Pharmacy Detail
						</button>
						<button class="nav-link btn btn-secondary  ml-2 mt-1" type="button" onclick="showProfBillDetail()" id="pills-doctor-fees" role="tab" data-bs-toggle="pill" data-bs-target="#nav-doctor-fees" aria-controls="nav-doctor-fees" aria-selected="false">
							<span class="mdi mdi-home-outline"></span>
						  Doctor Fees
						</button>
					</div>
				</nav>
			 </div>
			<div class="card-body " style="height: calc(100vh - 34rem);overflow: auto;" >
				<div class="tab-content" id="nav-tabContent">

					<div class="tab-pane fade show active" id="nav-bill" role="tabpanel" aria-labelledby="nav-bill-tab"  tabindex="0">
					   <div class="mpZero" id="billamount" style="display:block">
							<div class="">
								<div class="row">
									<div class="col-md-6 col-sm-6 mpZero">
										<div  class="col-md-12 col-sm-12 mpZero">		
											<div class="form-group mbotto">
												<div class="col-md-4"><label>Total Rent</label></div>
												<div class="col-md-8"><input type="text" class="form-control" id="totalrent" disabled></div>
											</div>
										</div>
										<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Total Investigation</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="totallab" disabled></div>
										</div>
										</div>								
										<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Total Pharmacy</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="totalpharmacy" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Total Professional</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="totalprofessional" disabled></div>
										</div>
										</div>					
										<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Total Amount</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="totalamt" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Total Discount</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="totaldiscount" disabled></div>
										</div>
										</div>															
									</div>
									<div class="col-md-6 col-sm-6 mpZero">
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Investigation Balance</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="labbalance" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Pharmacy Balance</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="pharmacybalance" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Professional Balance</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="professionalbalance" disabled></div>
										</div>
										</div>					
										<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Advances</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="advanceamount" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Co-Payment</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="copayamount" disabled></div>
										</div>
										</div>					
										<div class="col-md-12 col-sm-12 mt-3 mpZero" style="display:none">
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Approval Status</label></div>
											<div class="col-md-8"><select class="form-control" id="sponsorappstatus" disabled></select></div>
										</div>
										</div>
										<div class="col-md-12 col-sm-12 mt-3 mpZero">
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Approval Amount</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="approvedamt" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mt-3 mpZero" style="display:none ;">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Total Payable</label></div>
											<div class="col-md-8"><input type="text"  class="form-control" id="totalpayable" disabled></div>
										</div>
										</div>

										<div class="col-md-12 mt-3" style="display:block">
											<div class="hstack justify-content-end">
												<div class="">
													<div class="card-total px-3 rounded-3">
														<h6 class="dicount-type hstack gap-1">
															<span class="text-dark"><h3 class="netAmt">Total Payable:  &nbsp;&nbsp;</h3></span>
															<h3><span class="net-amount" style="color:Green" id="netAmt">0.00</span></h3>
														</h6>
													</div>
												</div>
											</div>
										</div>	
										
									</div>
								</div>
							</div>
						</div>
					 </div>
		 
					 <div class="tab-pane fade" id="nav-advance" role="tabpanel" aria-labelledby="nav-advance-tab" tabindex="1">	
						<table width="100%" border="0" cellspacing="0" cellpadding="0" id="advancebills" ></table>  
						    <!-- <div class="col-md-12 col-sm-12 " id="advances" style="height:400px;">
					        </div > -->
					 </div>
					 
					 <div class="tab-pane fade" id="nav-nursing" role="tabpanel" aria-labelledby="nav-nursing-tab" tabindex="2">
						  <div class="col-md-12 col-sm-12 mpZero" id="roomrents" style="height:400px;display:block">
							   <div class="col-md-12 col-sm-12 mpZero" id="rentcont" style="display:none">
								   <table width="100%" border="0" cellspacing="0" cellpadding="0" id="rentdetails"></table>
							   </div>
							 <div class="col-md-12 col-sm-12 mpZero" id="rents" style="height:300px">
							 </div>				
							 <div class="clearfix"></div>
							 <div id="rentbut" class="col-md-12 text-right">
								 <button id="btnRent" class="btn btn-primary" type="button" onclick="saveTemporaryRent()">Save Rents</button>
							 </div>
						   </div>
					 </div>

					 <div class="tab-pane fade" id="nav-investigation" role="tabpanel" aria-labelledby="nav-investigation-tab"tabindex="3">
						  <!-- <div class="col-md-12 col-sm-12 mpZero" id="lbills" style="height:400px;display:block">		 
						 </div> -->
						 	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="labbills"></table>
					 </div>


					 <div class="tab-pane fade" id="nav-pharmacy" role="tabpanel" aria-labelledby="nav-pharmacy-tab" tabindex="4">
					   <!-- <div class="col-md-12 col-sm-12 mpZero" id="pbills" style="height:400px;display:block">
						  </div> -->
						  <table width="100%" border="0" cellspacing="0" cellpadding="0" id="pharmacybills"></table>
						
					 </div>
					 <div class="tab-pane fade" id="nav-professional" role="tabpanel" aria-labelledby="nav-professional-tab" tabindex="5">
						  <!-- <div class="col-md-12 col-sm-12 mpZero" id="professionals" style="height:400px;display:block">
							 </div> -->
							 <table width="100%" border="0" cellspacing="0" cellpadding="0" id="professionalbills"></table>
						
					 </div>
					  <div class="tab-pane fade" id="nav-investigation-detail" role="tabpanel" aria-labelledby="nav-investigation-detail-tab" tabindex="6">
						    <!-- <div class="col-md-12 col-sm-12 mpZero" id="lbilldetails" style="height:400px;display:block">
							</div> -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="labbilldetails"></table>
					  </div>
					  <div class="tab-pane fade" id="nav-pharmacy-detail" role="tabpanel" aria-labelledby="nav-pharmacy-detail-tab"  tabindex="7">
						 <!-- <div class="col-md-12 col-sm-12 mpZero" id="pbilldetails" style="height:400px;display:block">
							 </div> -->
							 <table width="100%" border="0" cellspacing="0" cellpadding="0" id="pharmacybilldetails"></table>
						</div>
					 <div class="tab-pane fade" id="nav-doctor-fees" role="tabpanel" aria-labelledby="nav-doctor-fees-tab" tabindex="8">
						 
						  <!-- <div class="row" id="profbilldetails" style="height:400px;display:block">
							 </div> -->
							 <table width="100%" border="0" cellspacing="0" cellpadding="0" id="profbills"></table>
						
					  </div>
				 </div>
			</div>

			<div class="card-footer">
				<div class="tab-content" >
					<div class="row w-100 mt-3">
						<div class="col-md-4">
							<div class="hstack justify-content-start">
							<div id="actButton">
								<div class="mb-3">
									<button id="Discharge" class="btn btn-primary priBut" type="button" onclick="showTenderDialog()" style="display:none">Discharge</button>
									<button id="PrintSummary" class="btn btn-primary priBut" type="button" onclick="printDischargeSummary()" style="display:none">Print Summary</button>
									<button  id="btnCancel" type="button" class="btn btn-clear" onclick='hideMasterData()'><span class="mdi mdi-refresh me-2">Cancel</span></button>
								</div>
							</div>
							</div>
						</div>
						
					</div>
				</div>
		    </div>
		  </div>
	
		<!-- New Tabs Completed -->

	

	 

  </div>
</div>

<div id='tenderdlg' class='modal' style="display:none">
	<div class="modal-dialog modal-lg  modal-dialog-scrollable">
	  <div class="modal-content">
			<div id='tendertitle' class='modal-header'>
				<div class='pop_lov_hed_txt'>Bill Amount Rs. <span id="dispTotalAmt"></span></div>
				<button type="button" class="btn-close" onclick="cancelTenderDlg()" data-bs-dismiss="modal"></button>
			</div>
			<div class='modal-body'>
				<div class="col-md-12 col-sm-12 mpZero" id='tender'>
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
						<div  class="col-md-12 col-sm-12 mpZero">		
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
					<div class="col-md-12 col-sm-12 mpZero">
						<div class="col-md-12 col-sm-12 mpZero">
						<div class="form-group mbotto">
						<div class="col-md-4"><label>Corporate</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="sponsorname"><input type="hidden" class="form-control" id="sponsorcode"></div>
						</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 mpZero">
						<div class="form-group mbotto">
						<div class="col-md-4"><label>Card No</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="sponsorcardno"></div>
						</div>
						</div>					
						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 mpZero">
						<div class="form-group mbotto">
						<div class="col-md-4"><label>Approval No</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="sponsorapprovalno"></div>
						</div>
						</div>															
					</div>
					
											
				</div>
				
			</div>
			<div id="actButton" class="modal-footer">
						<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="saveDischarge()">Save</button>
						<button id="btnClear" class="btn btn-default" type="button" onclick="cancelTenderDlg()">Cancel</button>
			</div>
	  </div>
	</div>
</div>




	<script>

		// Tab  change 
			$("#nav-tab button ").click(function() {
			$("#nav-tab button").removeClass('active');
			$(this).addClass('active');
		      });


	var manualRentEntry=false;
	loadBranchData();
	var banks=loadCardBankData();
	if("<%=mode%>"!="View"){
		jqReport(13,"#xyz","&branchcode="+$('#branch').val());
	}
	var l1=new FlexUI.Ajax();
	var	v=l1.callAjax("GET","/waggle/service/ajax","ic=0&ro=true&id=getconfig&code=MRED");
	if(v.data && v.data.length>0){
		manualRentEntry=v.data[0].config_value=="0"?false:true;						
	}					
	var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"refcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"ipno",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"roomno",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"doctorname"},
  	{name:"gender",inputType:4,type:"SPAN",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"doctorname"},
  	{name:"doctorname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referredby",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:""},
  	{name:"cashamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"cardbank"},
  	{name:"tcashamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"cardbank",onchange:"onTenderDetailChange"},
  	{name:"cardbank",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"tcardamount",values:banks.values,keys:banks.keys},
  	{name:"tcardamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"sponsoramount",onchange:"onTenderDetailChange"},
  	{name:"srvchgamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsoramount"},  	
  	{name:"cardamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"sponsoramount"},  	  	  	
  	{name:"sponsoramount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"btnSave",onchange:"onTenderDetailChange",validation:"validateSponsorAmount"},
  	{name:"sponsorname",inputType:0,type:"LOV",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":true,nf:"sponsorcardno",lovOptions:{url:"/waggle/service/ajax",ajax:"insurancecompany",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"sponsorname",tt:false,id:"icm_name"},{tgt:"sponsorname",tt:true,id:"icm_name"},{tgt:"sponsorcode",tt:false,id:"icm_code"}]}},
  	{name:"sponsorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsorcardno"},
  	{name:"sponsorcardno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"sponsorapprovalno"},
  	{name:"sponsorapprovalno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"btnSave"},  	
  	{name:"tenderamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"netamount",inputType:0,type:"DECIMAL",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"balanceamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"totalamt",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},  	
  	{name:"totaldiscount",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"totalrent",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"totallab",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"totalpharmacy",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"pharmacybalance",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"labbalance",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"totalpayable",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"sponsorappstatus",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"",values:"R~AD~A~D",keys:"Requested~Required Additional Details~Approved~Declined"},
  	{name:"approvedamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"advanceamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"copayamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"totalprofessional",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"dischargedate",inputType:0,type:"TDATE",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},  	
  	{name:"dischargetime",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"admissiondate",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"hospregcode",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"professionalbalance",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"smobileno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"",validation:"checkDischargePatientExists"},  	
  	{name:"btnSave",inputType:3,caption:"",visible:false},
    {name:"btnClear",inputType:3,caption:"",visible:false}
  	]},
  	{name:"rents",title:"",contentType:"Table",tableProperties:{rowObject:true,serialNumberColumn:"sno",rowEmptyCheckColumn:"roomcode",optional:false,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "roomcode", name: "RoomCode", field: "roomcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:0,"chkTag":false},    
    {order:"2",id: "roomname", name: "Room", field: "roomname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,"chkTag":true,lovOptions:{url:"/waggle/service/ajax",ajax:"rooms",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branchcode",src:"branchcode",tt:false}],results:[
  	{tgt:"rents_data",tt:false,row:"cr",id:"rm_code",col:"roomcode"},
  	{tgt:"rents_data",tt:false,row:"cr",id:"rm_roomname",col:"roomname"},
  	{tgt:"rents_data",tt:true,row:"cr",id:"rm_roomname",col:"roomname"},
  	{tgt:"rents_data",tt:false,row:"cr",id:"rm_rentperday",col:"rate"}
  	]}},
  	{order:"3",id: "category", name: "Category", field: "category",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
  	{order:"4",id: "categoryid", name: "CategoryID", field: "categoryid",defaultValue:"2","inputType":0,"type":"INT","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "rsdid", name: "Shift ID", field: "rsdid",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0},
    {order:"6",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"right"},
    {order:"7",id: "noofdays", name: "Days", field: "noofdays",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:150,onchange:"onRateQuantityChange",align:"right"},
    {order:"8",id: "noofhours", name: "Hours", field: "noofhours",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:0,align:"right"},
    {order:"9",id: "diffhours", name: "Diff.Hours", field: "diffhours",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"mandatory":false,width:0,align:"right"},
    {order:"10",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"right"}
    ]
    }}
  	]};
	//ajax columns
	var discharge=new FlexUI.Screen("discharge",sProps);
    $(document).ready(function () {
            $('#subtitle').text("");
            $('#screentitle').text("Discharge");
            ConstructLabGrid();
            ConstructPharmacyGrid();
            ConstructRentGrid();
            ConstructAdvanceGrid();
            ConstructProfessionalGrid();
            ConstructLabBillDetailGrid();
            ConstructPharmacyBillDetailGrid();
            ConstructProfBillDetailGrid();
            addMasterData();
            if('<%=mode%>'=="View"){
            	loadOrderData("/waggle/service/discharge/view?branchcode=<%=branch%>&dhno=<%=dhno%>");
            	$('#ddatecaption').text("Discharge Date");
            	$('#PrintSummary').css("display","inline-block");
            }else{
            	//$('#PrintSummary').css("display","inline-block");
            	$('#ddatecaption').text("Generated Date");
            	loadActions(200004);
            }
     });
     function saveDischarge(){
     		if(!checkPatientStatus()) return;
     		if(discharge.getSaveInProgress()) return;
        	var r=null;
        	discharge.setOperation("ADD");
    		discharge.setScreenCode(15);
    		if(toNumber(screenObjects.getScreenObject("cardamount").getValue())>0 && screenObjects.getScreenObject("cardbank").getValue()=="0"){
    			alert("Please select card machine to continue");
    			return;
    		}
    		if(toNumber(screenObjects.getScreenObject("cardamount").getValue())==0 && screenObjects.getScreenObject("cardbank").getValue()!="0"){
    			screenObjects.getScreenObject("cardbank").setValue("0");    			
    		}     		
    		if(!(toNumber(screenObjects.getScreenObject("totalpayable").getValue())<0) && toNumber(screenObjects.getScreenObject("totalpayable").getValue())>toNumber(screenObjects.getScreenObject("tenderamount").getValue())){
    			alert("Tender Amount cannot be less than the Bill Amount");
    			return;
    		}
    		if(!(toNumber(screenObjects.getScreenObject("totalpayable").getValue())<0) && !(toNumber(screenObjects.getScreenObject("sponsoramount").getValue())==0) && toNumber(screenObjects.getScreenObject("totalpayable").getValue())!=toNumber(screenObjects.getScreenObject("sponsoramount").getValue())){
    			alert("Corporate Amount should be equal to the Bill Amount");
    			return;
    		}
    		if(!manualRentEntry){
	    		$grid = $("#rentdetails");
	    		var rentDetails=$grid.getRowData();
	    		for(var ff1=0;ff1<rentDetails.length;ff1++){
	    			if(rentDetails[ff1].amount==""){
	    				rentDetails.splice(ff1,1);
	    			}
	    		}
	    		var rs=',"rents_data":'+JSON.stringify(rentDetails);
    		}
    		var d=discharge.processDataToSave(rs);
    		discharge.setSaveInProgress(true);
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",d);
				hideLoader();
		 	}else{
		 		alert("Please correct the validation errors and continue...");
		 		discharge.setSaveInProgress(false);		 		
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				alert(r.message);
				$('#tenderdlg').modal('hide');
				$('#tenderdlg').modal('dispose');
				printDischargeBill(r.code);
				clearInnerScreen();
				hideMasterData();
				return r.key;		
			}else{
				discharge.setSaveInProgress(false);			
				alert(r.message);		
			}
      }
    function clearInnerScreen(){
    	discharge.clearScreen();
    	discharge.setSaveInProgress(false);    	
		$grid = $("#rentdetails");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
	
		$grid = $("#labbills");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");		

		$grid = $("#pharmacybills");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
    	
    	$grid = $("#advancebills");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
    	
    	$grid = $("#professionalbills");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
    	
    	$grid = $("#labbilldetails");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
		screenObjects.getScreenObject("branchcode").setValue($('#branch').val());    					
    }
	function addMasterData(){
		clearInnerScreen(); 
  		$('#callback').css('display','block');
  		$('#xyz').css('display','none');
  		$('#addGrp').css('display','none');
  	}
	function hideMasterData(){
		if("<%=mode%>"=="View"){
			$('.ui-dialog').children().remove();
			$('.ui-dialog').remove();
			$("#bodyContainer").children().remove();
			$("#bodyContainer").html("");
			$("#bodyContainer").load("/waggle/dischargeHistory.do?id=<%=rptId%>&fromdate=<%=fromDate%>&todate=<%=toDate%>");	  				
	  	}else{
	  		clearInnerScreen();
	  		$('#smobileno').focus();
	  		//$('#callback').css('display','none');
	  		//$('#xyz').css('display','block');
	  		//$('#addGrp').css('display','block');
	  		//reloadGrid(13);
	  	}
  	}
	function toggleHeaderRow(){
  		toggleSearchToolBar(13);
  	}
  	if("<%=mode%>"!="View"){
  		toggleHeaderRow();
  	}  
  function loadOrderData(url,code,did){
  	showLoader();
	var l=new FlexUI.Ajax();
	var v=l.callAjax("GET",url,"");
	discharge.loadObjectData(v);
	for(prop in v){
		if(prop=="rentdetails"){
			$grid = $("#rentdetails");
        	$grid.clearGridData();
        	$grid.jqGrid('setGridParam', { data: v["rentdetails"] });
        	$grid[0].refreshIndex();
        	$grid.trigger("reloadGrid");
		}else if(prop=="labbills"){
			$grid = $("#labbills");
        	$grid.clearGridData();
        	$grid.jqGrid('setGridParam', { data: v["labbills"] });
        	$grid[0].refreshIndex();
        	$grid.trigger("reloadGrid");		
		}else if(prop=="pharmacybills"){
			$grid = $("#pharmacybills");
        	$grid.clearGridData();
        	$grid.jqGrid('setGridParam', { data: v["pharmacybills"] });
        	$grid[0].refreshIndex();
        	$grid.trigger("reloadGrid");				
		}else if(prop=="advancebills"){
			$grid = $("#advancebills");
        	$grid.clearGridData();
        	$grid.jqGrid('setGridParam', { data: v["advancebills"] });
        	$grid[0].refreshIndex();
        	$grid.trigger("reloadGrid");				
		}else if(prop=="professionalbills"){
			$grid = $("#professionalbills");
        	$grid.clearGridData();
        	$grid.jqGrid('setGridParam', { data: v["professionalbills"] });
        	$grid[0].refreshIndex();
        	$grid.trigger("reloadGrid");				
		}else if(prop=="sponsorname"){
			if(v["sponsorname"]==""){
				$('#sname').text("N/A");
			}else{
				$('#sname').text(v["sponsorname"]);
			}
		}
	}
	
	if("<%=mode%>"!="View"){
		if(manualRentEntry){
			$('#rents').css("display","block");
			$('#rentbut').css("display","block");
			$('#rentcont').css("display","none");
		}else{
			$('#rents').css("display","none");
			$('#rentbut').css("display","none");
			$('#rentcont').css("display","block");				
		}
		screenObjects.getScreenObject("totalamt").setTag(screenObjects.getScreenObject("totalamt").getValue());
		screenObjects.getScreenObject("totalpayable").setTag(screenObjects.getScreenObject("totalpayable").getValue());
		screenObjects.getScreenObject("netamount").setValue(screenObjects.getScreenObject("totalpayable").getValue());
		if(manualRentEntry){
			calculateTotal();							
		}
	}else{
		$('#rents').css("display","none");
		$('#rentbut').css("display","none");
		$('#rentcont').css("display","block");		
	}
	$('#netAmt').html(screenObjects.getScreenObject("totalpayable").getValue());
	$('#callback').css('display','block');
  	$('#xyz').css('display','none');
  	$('#addGrp').css('display','none');  	
  	hideLoader();
  }  
  function ConstructLabGrid() {
        var areaWidth = $(window).width() - 150;
        $("#labbills").jqGrid({
            datatype: "local",
            width: areaWidth,
            height:390,
            autowidth: false,
            shrinktofit:true,
            colNames: ['BillNo', 'BillDate', 'BuName', 'BillAmount'],
            colModel: [
                        { name: 'billno', index: 'billno', sorttype: "integer", sortable: false, width: 100, align: 'left'},
                        { name: 'billdate', index: 'billdate', sorttype: "text", sortable: false, width: 100, align: 'left' },
						{ name: 'bum_buname', index: 'bum_buname', sorttype: "integer", sortable: false, width: 200, align: 'left'},
						{ name: 'billamount', index: 'billamount', sorttype: "text", sortable: false, width: 200, align: 'left' }                        
            ],
            rowNum: 500,
            datatype: "jsonstring",
            jsonReader: { repeatitems: false },
            viewrecords: true,
            gridview: true,
            loadtext: "Loading....",
            multiselect: false,
        });
    }
    function ConstructAdvanceGrid() {
        var areaWidth = $(window).width() - 150;
        $("#advancebills").jqGrid({
            datatype: "local",
            width: areaWidth,
            height:390,
            autowidth: false,
            shrinktofit:true,
            colNames: ['BillNo', 'BillDate', 'BuName', 'BillAmount'],
            colModel: [
                        { name: 'billno', index: 'billno', sorttype: "integer", sortable: false, width: 100, align: 'left'},
                        { name: 'billdate', index: 'billdate', sorttype: "text", sortable: false, width: 100, align: 'left' },
						{ name: 'bum_buname', index: 'bum_buname', sorttype: "integer", sortable: false,width: 200,  align: 'left'},
						{ name: 'billamount', index: 'billamount', sorttype: "text", sortable: false,width: 200,align: 'left' }                        
            ],
            rowNum: 500,
            datatype: "jsonstring",
            jsonReader: { repeatitems: false },
            viewrecords: true,
            gridview: true,
            loadtext: "Loading....",
            multiselect: false,
        });
    }
    function ConstructProfessionalGrid() {
		var areaWidth = $(window).width() - 150;
        $("#professionalbills").jqGrid({
            datatype: "local",
            width: areaWidth,
            height:390,
            autowidth: false,
            shrinktofit:true,
            colNames: ['BillNo', 'BillDate', 'BuName', 'BillAmount'],
            colModel: [
                        { name: 'billno', index: 'billno', sorttype: "integer", sortable: false, width: 100, align: 'left'},
                        { name: 'billdate', index: 'billdate', sorttype: "text", sortable: false, width: 100, align: 'left' },
						{ name: 'bum_buname', index: 'bum_buname', sorttype: "integer", sortable: false, width: 200, align: 'left'},
						{ name: 'billamount', index: 'billamount', sorttype: "text", sortable: false, width: 200, align: 'left' }                        
            ],
            rowNum: 500,
            datatype: "jsonstring",
            jsonReader: { repeatitems: false },
            viewrecords: true,
            gridview: true,
            loadtext: "Loading....",
            multiselect: false,
        });
    }
    function ConstructPharmacyGrid() {
        var areaWidth = $(window).width() - 150;
        $("#pharmacybills").jqGrid({
            datatype: "local",
            width: areaWidth,
            height:390,
            autowidth: false,
            shrinktofit:true,
            colNames: ['BillNo', 'BillDate', 'BillAmount','Received','Balance'],
            colModel: [
                        { name: 'billno', index: 'billno', sorttype: "integer", sortable: false, width: 100, align: 'left'},
                        { name: 'billdate', index: 'billdate', sorttype: "text", sortable: false, width: 100, align: 'left' },
						{ name: 'billamount', index: 'billamount', sorttype: "text", sortable: false, width: 200, align: 'left' },
						{ name: 'received', index: 'billamount', sorttype: "text", sortable: false, width: 200, align: 'left' },
						{ name: 'balance', index: 'billamount', sorttype: "text", sortable: false, width: 200, align: 'left' }
            ],
            rowNum: 500,
            datatype: "jsonstring",
            jsonReader: { repeatitems: false },
            viewrecords: true,
            gridview: true,
            loadtext: "Loading....",
            multiselect: false,
        });
    }
    function ConstructRentGrid() {
        var areaWidth = $(window).width() - 150;
        $("#rentdetails").jqGrid({
            datatype: "local",
            width: areaWidth,
            height:390,
            autowidth: false,
            shrinktofit:true,
            colNames: ['RoomCode', 'RoomNo', 'Category', 'BillAmount','CategoryID','rsdid','noofdays','noofhours','diffhours'],
            colModel: [
                        { name: 'roomcode', index: 'roomcode', sorttype: "integer", sortable: false, width: 0, align: 'left',hidden:true,visible:false},
                        { name: 'roomname', index: 'roomname', sorttype: "text", sortable: false, width: 100, align: 'left' },
						{ name: 'category', index: 'category', sorttype: "integer", sortable: false, width: 200, align: 'left'},
						{ name: 'amount', index: 'amount', sorttype: "text", sortable: false, width: 200, align: 'left' },
						{ name: 'categoryid', index: 'categoryid', sorttype: "text", sortable: false, align: 'left',width:0,visible:false,hidden:true },
						{ name: 'rsdid', index: 'rsdid', sorttype: "text", sortable: false, align: 'left',width:0,visible:false,hidden:true },
						{ name: 'noofdays', index: 'noofdays', sorttype: "text", sortable: false, align: 'left',width:0,visible:false,hidden:true },
						{ name: 'noofhours', index: 'noofhours', sorttype: "text", sortable: false, align: 'left',width:0,visible:false,hidden:true },
						{ name: 'diffhours', index: 'noofhours', sorttype: "text", sortable: false, align: 'left',width:0,visible:false,hidden:true }
            ],
            rowNum: 500,
            datatype: "jsonstring",
            jsonReader: { repeatitems: false },
            viewrecords: true,
            gridview: true,
            loadtext: "Loading....",
            multiselect: false,
        });
    }
    function ConstructLabBillDetailGrid() {
        var areaWidth = $(window).width() - 150;
        $("#labbilldetails").jqGrid({
            datatype: "local",
            width: areaWidth,
            height:390,
            autowidth: false,
            shrinktofit:true,
            colNames: ['BuName', 'BillNo', 'BillDate', 'TestName','TestQty','TestRate','TestAmount'],
            colModel: [
                        { name: 'bum_buname', index: 'bum_buname', sorttype: "text", sortable: false, width: 200, align: 'left' },
                        { name: 'billno', index: 'billno', sorttype: "integer", sortable: false, width: 100, align: 'left' },
						{ name: 'billdate', index: 'billdate', sorttype: "text", sortable: false, width: 150, align: 'left'},
						{ name: 'buim_itemname', index: 'buim_itemname', sorttype: "text", sortable: false, width: 200, align: 'left'},
						{ name: 'bd_test_qty', index: 'bd_test_qty', sorttype: "integer", sortable: false, width: 100, align: 'left'},
						{ name: 'bd_test_rate', index: 'bd_test_rate', sorttype: "number", sortable: false, width: 100, align: 'left' },
						{ name: 'bd_test_amount', index: 'bd_test_amount', sorttype: "number", sortable: false, width: 100, align: 'left' }
            ],
            rowNum: 500,
            datatype: "jsonstring",
            jsonReader: { repeatitems: false },
            viewrecords: true,
            gridview: true,
            loadtext: "Loading....",
            multiselect: false,
        });
    }
    function ConstructPharmacyBillDetailGrid() {
        var areaWidth = $(window).width() - 150;
        $("#pharmacybilldetails").jqGrid({
            datatype: "local",
            width: areaWidth,
            height:390,
            autowidth: false,
            shrinktofit:true,
            colNames: ['BillNo', 'BillDate', 'ProductName','Qty','Rate','Amount'],
            colModel: [
                        { name: 'billno', index: 'billno', sorttype: "integer", sortable: false, width: 100, align: 'left' },
						{ name: 'billdate', index: 'billdate', sorttype: "text", sortable: false, width: 150, align: 'left'},
						{ name: 'pm_name', index: 'pm_name', sorttype: "text", sortable: false, width: 200, align: 'left'},
						{ name: 'sd_qty', index: 'sd_qty', sorttype: "integer", sortable: false, width: 100, align: 'left'},
						{ name: 'sd_sale_rate', index: 'sd_sale_rate', sorttype: "number", sortable: false, width: 100, align: 'left' },
						{ name: 'sd_net_amount', index: 'sd_net_amount', sorttype: "number", sortable: false, width: 100, align: 'left' }
            ],
            rowNum: 500,
            datatype: "jsonstring",
            jsonReader: { repeatitems: false },
            viewrecords: true,
            gridview: true,
            loadtext: "Loading....",
            multiselect: false,
        });
    }
    function ConstructProfBillDetailGrid() {
        var areaWidth = $(window).width() - 150;
        $("#profbills").jqGrid({
            datatype: "local",
            width: areaWidth,
            height:390,
            autowidth: false,
            shrinktofit:true,
            colNames: ['BillNo', 'BillDate', 'Doctor','Amount'],
            colModel: [
                        { name: 'billno', index: 'billno', sorttype: "integer", sortable: false, width: 100, align: 'left' },
						{ name: 'billdate', index: 'billdate', sorttype: "text", sortable: false, width: 150, align: 'left'},
						{ name: 'doctorname', index: 'doctorname', sorttype: "text", sortable: false, width: 200, align: 'left'},
						{ name: 'doctoramount', index: 'doctoramount', sorttype: "number", sortable: false, width: 100, align: 'left' }
            ],
            rowNum: 500,
            datatype: "jsonstring",
            jsonReader: { repeatitems: false },
            viewrecords: true,
            gridview: true,
            loadtext: "Loading....",
            multiselect: false,
        });
    }
    // function showBill(){
    // 	$('#billamount').css('display','block');
    // 	$('#roomrents').css('display','none');
    // 	$('#lbills').css('display','none');
    // 	$('#pbills').css('display','none');
    // 	$('#advances').css('display','none');
    // 	$('#professionals').css('display','none');
    // 	$('#lbilldetails').css('display','none');
    // 	$('#pbilldetails').css('display','none');
    // 	$('#profbilldetails').css('display','none');
    // 	$('#navg').find("li>span").removeClass('selTab');
    // 	$('#navg').find("li>span").eq(0).addClass('selTab');
    // }
    // function showLab(){
    // 	$('#billamount').css('display','none');
    // 	$('#roomrents').css('display','none');
    // 	$('#lbills').css('display','block');
    // 	$('#pbills').css('display','none');
    // 	$('#advances').css('display','none');
    // 	$('#professionals').css('display','none');
    // 	$('#lbilldetails').css('display','none');
    // 	$('#pbilldetails').css('display','none');   
    // 	$('#profbilldetails').css('display','none'); 	
    // 	$('#navg').find("li>span").removeClass('selTab');
    // 	$('#navg').find("li>span").eq(3).addClass('selTab');
    // }
    // function showRent(){
    // 	$('#billamount').css('display','none');
    // 	$('#roomrents').css('display','block');
    // 	$('#lbills').css('display','none');
    // 	$('#pbills').css('display','none');
    // 	$('#advances').css('display','none');
    // 	$('#professionals').css('display','none');
    // 	$('#lbilldetails').css('display','none');
    // 	$('#pbilldetails').css('display','none');   
    // 	$('#profbilldetails').css('display','none'); 	    	
    // 	$('#navg').find("li>span").removeClass('selTab');
    // 	$('#navg').find("li>span").eq(2).addClass('selTab');
    // }
    // function showPharmacy(){
    //    	$('#billamount').css('display','none');
    // 	$('#roomrents').css('display','none');
    // 	$('#lbills').css('display','none');
    // 	$('#pbills').css('display','block');
    // 	$('#advances').css('display','none');
    // 	$('#professionals').css('display','none');
    // 	$('#lbilldetails').css('display','none');
    // 	$('#pbilldetails').css('display','none');   
    // 	$('#profbilldetails').css('display','none'); 	    	
    // 	$('#navg').find("li>span").removeClass('selTab');
    // 	$('#navg').find("li>span").eq(4).addClass('selTab');
    // }
    // function showAdvances(){
    //    	$('#billamount').css('display','none');
    // 	$('#roomrents').css('display','none');
    // 	$('#lbills').css('display','none');
    // 	$('#pbills').css('display','none');
    // 	$('#advances').css('display','block');
    // 	$('#professionals').css('display','none');
    // 	$('#lbilldetails').css('display','none');
    // 	$('#pbilldetails').css('display','none');   
    // 	$('#profbilldetails').css('display','none'); 	    	
    // 	$('#navg').find("li>span").removeClass('selTab');
    // 	$('#navg').find("li>span").eq(1).addClass('selTab');
    // }
    // function showProfessional(){
    //    	$('#billamount').css('display','none');
    // 	$('#roomrents').css('display','none');
    // 	$('#lbills').css('display','none');
    // 	$('#pbills').css('display','none');
    // 	$('#advances').css('display','none');
    // 	$('#professionals').css('display','block');
    // 	$('#pbilldetails').css('display','none');
    // 	$('#lbilldetails').css('display','none');   
    // 	$('#profbilldetails').css('display','none'); 	    	
    // 	$('#navg').find("li>span").removeClass('selTab');
    // 	$('#navg').find("li>span").eq(5).addClass('selTab');
    // }
    function showLabBillDetail(){
       
    	$grid = $("#labbilldetails");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");    	
    	var s=new FlexUI.Ajax();
		showLoader();
		r=s.callAjax("GET","/waggle/service/ajax","&ic=0&ro=true&id=patientbills&branchcode="+screenObjects.getScreenObject("branchcode").getValue()+"&patientcode="+screenObjects.getScreenObject("patientcode").getValue());
    	$grid.jqGrid('setGridParam', { data: r.data });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
		hideLoader();
    }
    function showPharmacyBillDetail(){
       	
    	$grid = $("#pharmacybilldetails");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");    	
    	var s=new FlexUI.Ajax();
		showLoader();
		r=s.callAjax("GET","/Fruits/service/ajax","&ic=0&ro=true&id=customerbills&branch="+screenObjects.getScreenObject("branchcode").getValue()+"&custcode="+screenObjects.getScreenObject("ipno").getValue());
    	$grid.jqGrid('setGridParam', { data: r.data });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
		hideLoader();
    }
    function showProfBillDetail(){
       	
    	$grid = $("#profbills");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");    	
    	var s=new FlexUI.Ajax();
		showLoader();
		r=s.callAjax("GET","/waggle/service/ajax","&ic=0&ro=true&id=professionalamount&branch="+screenObjects.getScreenObject("branchcode").getValue()+"&patientcode="+screenObjects.getScreenObject("patientcode").getValue());
    	$grid.jqGrid('setGridParam', { data: r.data });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
		hideLoader();
    }
    function showTenderDialog(){
    	var scode=screenObjects.getScreenObject("sponsorcode").getValue();
    	var total=screenObjects.getScreenObject("totalpayable").getValue();
		$('#dispTotalAmt').text(total);				
		$('#tenderdlg').modal({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:700,position:'center'});
		$('#tenderdlg').modal('show');
		screenObjects.getScreenObject("sponsorname").setEnabled(false);
		screenObjects.getScreenObject("sponsorcardno").setEnabled(false);
		screenObjects.getScreenObject("sponsorapprovalno").setEnabled(false);
		screenObjects.getScreenObject("sponsoramount").setEnabled(false);					
		screenObjects.getScreenObject("tcashamount").focus();
		if(toNumber(total)<=0){
			screenObjects.getScreenObject("tcashamount").setEnabled(false);
			screenObjects.getScreenObject("tcardamount").setEnabled(false);
			screenObjects.getScreenObject("cardamount").setEnabled(false);
			screenObjects.getScreenObject("srvchgamount").setEnabled(false);
			screenObjects.getScreenObject("tcashamount").setValue("0");
		}
		if(scode!="0" && scode!=""){
			screenObjects.getScreenObject("sponsoramount").setValue(screenObjects.getScreenObject("approvedamt").getValue());
			validateSponsorAmount();
			onTenderDetailChange();
		}
    }
    function onTenderDetailChange(){
		var totalAmount=toNumber(roundOff(screenObjects.getScreenObject("totalpayable").getValue(),2));
		var cashAmount=toNumber(roundOff(screenObjects.getScreenObject("tcashamount").getValue(),2));
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
		var tenderedAmount=cashAmount+totalCardAmount+sponsorAmount;
		var balanceAmount=tenderedAmount-netAmount;
		if(cashAmount>totalAmount){
			screenObjects.getScreenObject("cashamount").setValue(roundOff(totalAmount,2));
		}else{
			screenObjects.getScreenObject("cashamount").setValue(roundOff(cashAmount,2));
		}
		screenObjects.getScreenObject("tenderamount").setValue(roundOff(tenderedAmount,2));
		screenObjects.getScreenObject("balanceamount").setValue(roundOff(balanceAmount,2));
	}
	function validateSponsorAmount(){
		var amt=screenObjects.getScreenObject("sponsoramount").getValue();
		var total=screenObjects.getScreenObject("totalpayable").getValue();
		if(Number(amt)!=0){
			if(Number(total)>0){
				sProps.screen[0].fields[19].mandatory=true;					
				sProps.screen[0].fields[21].mandatory=true;
				sProps.screen[0].fields[22].mandatory=true;
			}else{
				sProps.screen[0].fields[19].mandatory=false;					
				sProps.screen[0].fields[21].mandatory=false;
				sProps.screen[0].fields[22].mandatory=false;
			}
			screenObjects.getScreenObject("sponsorname").setAttributes(sProps.screen[0].fields[19]);
			screenObjects.getScreenObject("sponsorcardno").setAttributes(sProps.screen[0].fields[21]);
			screenObjects.getScreenObject("sponsorapprovalno").setAttributes(sProps.screen[0].fields[22]);			
			screenObjects.getScreenObject("sponsorname").setEnabled(true);
			screenObjects.getScreenObject("sponsorcardno").setEnabled(true);
			screenObjects.getScreenObject("sponsorapprovalno").setEnabled(true);
			screenObjects.getScreenObject("sponsoramount").setEnabled(true);
			screenObjects.getScreenObject("sponsoramount").setNextFocus("sponsorname");	
			if(toNumber(roundOff(screenObjects.getScreenObject("totalpayable").getValue(),2))<=toNumber(roundOff(screenObjects.getScreenObject("approvedamt").getValue(),2))){
				screenObjects.getScreenObject("tcashamount").setEnabled(false);
				screenObjects.getScreenObject("cardamount").setEnabled(false);
				screenObjects.getScreenObject("tcardamount").setEnabled(false);
				screenObjects.getScreenObject("srvchgamount").setEnabled(false);
				screenObjects.getScreenObject("sponsorname").focus();
			}			
		}else if(toNumber(total)>0){
			sProps.screen[0].fields[18].mandatory=false;					
			sProps.screen[0].fields[20].mandatory=false;
			sProps.screen[0].fields[21].mandatory=false;
			screenObjects.getScreenObject("sponsorname").setValue("");
			screenObjects.getScreenObject("sponsorcode").setValue("");
			screenObjects.getScreenObject("sponsorcardno").setValue("");
			screenObjects.getScreenObject("sponsorapprovalno").setValue("");
			screenObjects.getScreenObject("sponsorname").setAttributes(sProps.screen[0].fields[19]);
			screenObjects.getScreenObject("sponsorcardno").setAttributes(sProps.screen[0].fields[21]);
			screenObjects.getScreenObject("sponsorapprovalno").setAttributes(sProps.screen[0].fields[22]);			
			screenObjects.getScreenObject("sponsorname").setEnabled(false);
			screenObjects.getScreenObject("sponsorcardno").setEnabled(false);
			screenObjects.getScreenObject("sponsorapprovalno").setEnabled(false);
			screenObjects.getScreenObject("sponsoramount").setEnabled(false);
			screenObjects.getScreenObject("tcashamount").setEnabled(true);
			screenObjects.getScreenObject("cardamount").setEnabled(false);
			screenObjects.getScreenObject("srvchgamount").setEnabled(false);
			screenObjects.getScreenObject("tcardamount").setEnabled(true);
			screenObjects.getScreenObject("sponsoramount").setNextFocus("btnSave");
			screenObjects.getScreenObject("tcashamount").focus();				
		}else{
			screenObjects.getScreenObject("btnSave").focus();
		}
		return true;
	}
	function cancelTenderDlg(){
		$('#tenderdlg').modal('hide');
		$('#tenderdlg').modal('dispose');
	}
	function printDischargeBill(code){
		var data;
	    var branch=screenObjects.getScreenObject("branchcode").getValue();
		$.ajax({
            url: "/waggle/service/discharge/print?branchcode="+branch+"&code="+code,
            type: "GET",
            async: false,
            contentType:"application/json",
            dataType: "json",
            success: function (r) {
				data=r;		
            }
        });		
        data["type"]="DLBILL";	
		data["address1"]="27,Javulikara Street";
		data["address2"]="Tiruvarur - 610 001";
		data["address3"]="Phone - 242292,240292";	
		$.ajax({
            url: "http://localhost:9191",
            type: "POST",
            async: true,
            contentType:"application/x-www-form-urlencoded",
            data:"printdata="+JSON.stringify(data),
            dataType: "json",
            success: function (r) {
				//alert(r.result);		
            }
        });
	}
	function printDischargeSummary(){
		var branch=screenObjects.getScreenObject("branchcode").getValue();
		var code=screenObjects.getScreenObject("patientcode").getValue();
		var url="/waggle/service/discharge/printsummary?branchcode="+branch+"&patientcode="+code;
		window.open(url,"_blank");
	}
	function checkPatientStatus(){
		var result=true;
		var code=screenObjects.getScreenObject("patientcode").getValue();
		var l=new FlexUI.Ajax();
		v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=patientstatus&code="+code);
		if(v!=null && v.data.length>0){
			if(v.data[0][0]==2){
				alert("Patient already discharged. Please exit the screen to continue");
				result=false;
			}
		}				
		return result;	
	}
	function checkDischargePatientExists(id,me){
			if(!discharge.getSaveInProgress()){
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
					alert( v.data);
					if(v!=null){
						alert("inside 1");
						if(v.data && v.data.length==1){
							getDischargePatientInfo(branch,v.data[0]);					
							return true;
						}else if(v.data && v.data.length>1){
							alert("inside 2");
							screenObjects.getScreenObject("smobileno").setTag(stext);
							var d=null;
							d={url:"/waggle/service/ajax",ajax:"hospinpatients",scrollEnabled:true,searchFromList:false,dsi:dsi,edsi:1,params:[{n:"branchcode",src:"branchcode",ft:false},{n:"searchtxt",src:"smobileno",ft:false}],results:[],standalone:true};
							var lov=new FlexUI.LOV("s_lov",me,d,v.data);
							lov.onLovClose.subscribe(onDischargePatientClose);
							lov.show();					
							return false;
						}		
					}
				}
				clearInnerScreen();
				return false;				
			}else{
				alert("inside 3");
				screenObjects.getScreenObject("smobileno").setTag("");
				return true;
			}	
		}
		function onDischargePatientClose(e,args){
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			loadOrderData("/waggle/service/discharge?branchcode="+branch+"&patientcode="+args.result[20],0,"")
			$('#ipno').focus();
		}		
		function getDischargePatientInfo(branch,result){
			$('#lcsno').text(result[1]);
			loadOrderData("/waggle/service/discharge?branchcode="+branch+"&patientcode="+result[20],0,"");
			$('#ipno').focus();
		}
		function onRateQuantityChange(id,me){
			var t=me.getParent();
			calculateAmount(t.getCurrentRow());
			calculateTotal();
			return true;
		}
		function calculateTotal(){
			var total=0;
			var t=screenObjects.getScreenObject("rents_data");
			var cols=t.getCols();
			var s=t.getSize();
			for(var i=0;i<s;i++){
				total+=toNumber(t.getText(i,cols.amount));
			}
			screenObjects.getScreenObject("totalrent").setValue(roundOff(total,2));
			screenObjects.getScreenObject("totalamt").setValue(roundOff(Number(screenObjects.getScreenObject("totalamt").getTag())+total,2));
			screenObjects.getScreenObject("totalpayable").setValue(roundOff(Number(screenObjects.getScreenObject("totalpayable").getTag())+total,2));
			screenObjects.getScreenObject("netamount").setValue(screenObjects.getScreenObject("totalpayable").getValue());
			$("#netAmt").html("Net Amount   "+screenObjects.getScreenObject("netamount").getValue());
		}
		function calculateAmount(row){
			var t=screenObjects.getScreenObject("rents_data");
			var cols=t.getCols();	
			var baseqty=0;
			baseqty=toNumber(t.getText(row,cols.noofdays));
			var amt=roundOff(toNumber(t.getText(row,cols.rate))*baseqty,2);
			t.setText(row,cols.amount,amt);
		}
		function saveTemporaryRent(){
			if(!checkPatientStatus()) return;
     		if(discharge.getSaveInProgress()) return;
        	var r=null;
        	discharge.setOperation("ADD");
    		discharge.setScreenCode(200004);
    		if(screenObjects.getScreenObject("patientcode").getValue()=="" || screenObjects.getScreenObject("patientcode").getValue()=="0") return;
    		if(screenObjects.getScreenObject("branchcode").getValue()=="" || screenObjects.getScreenObject("branchcode").getValue()=="0") return;
    		var data='data={"screencode":"200004","operation":"ADD","savedata":{';
    		data+='"patientcode":"'+screenObjects.getScreenObject("patientcode").getValue()+'",';
    		data+='"branchcode":"'+screenObjects.getScreenObject("branchcode").getValue()+'",';    		
    		var t=screenObjects.getScreenObject("rents_data");
    		if(t.validateAllRows()){
    			data+=t.getObjectData();
    		}else{
    			return;
    		}
			data+='}';		
			data+='}';    	
			alert(data);	
    		discharge.setSaveInProgress(true);
			if("FAILED"!=data){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",data);
				hideLoader();
		 	}else{
		 		alert("Please correct the validation errors and continue...");
		 		discharge.setSaveInProgress(false);		 		
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				alert(r.message);
			}else{
				discharge.setSaveInProgress(false);			
				alert(r.message);		
			}
		}

	    	
  </script>
</body>
</html>