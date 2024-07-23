<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Discharge Summary</title>
</head>
<%String mode=request.getParameter("mode");
String branch=request.getParameter("branch");
String dhno=request.getParameter("dhno");
String rptId=request.getParameter("id");
%>
<body>
	<div class="card border-0 shadow">
		<div class="card-body lpage">
		  <!--Header-->
		  <div class="row w-100">
					  <div class="col-md-6 d-flex align-items-center">
						  <h4 class="header-title">Claim Bill</h4>
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
				<div class="col-sm-4 col-md-4 col-lg-4 "> 
				  <div id="" class="cBor">                 
					<div class="form-group mbotto">
						<div class="col-md-4"><label>IP No</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="ipno"><input type="hidden" id="claimno"/></div>
					</div>
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Age</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="patientage"></div>
					</div>
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Gender</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="gender"></div>
					</div>
					<div class=""  style="display:none">
						<div class="col-md-4"><label>Room No</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="roomno"></div>
					</div>
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Name </label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="patientname"></div>
					</div>
					<div class="form-group mbotto">
						<div class="col-md-4"><label>DOA</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="admissiondate"></div>
					</div>
				  </div>  
				</div>
				<div class="col-sm-4 col-md-4 col-lg-4"  >                    
					<div id="" class="cBor">
						<div class="form-group mbotto">
							<div class="col-md-4"><label>DOD</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="dischargetime"></div>
						</div>
						<div class="form-group mbotto">
							<div class="col-md-4"><label>Doctor name </label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="doctorname"><input type="hidden" id="doctorcode"/></div>
							</div>
						<div class="form-group mbotto">
							<div class="col-md-4"><label>Corporate</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="sponsorname"/></div>
						</div>
						<div class="form-group mbotto">
							<div class="col-md-4"><label>Refer By  </label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="referredby"><input type="hidden" id="referralcode"/></div>
						</div>
						<div class="form-group mbotto">
							<div class="col-md-4"><label>App. Date</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="approveddate"></div>
						</div>
						
					</div>
				</div>
				<div class="col-sm-4 col-md-4 col-lg-4"  >
					<div id="" class="cBor">
						<div class="form-group mbotto">
							<div class="col-md-4"><label>App. Amount</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="approvedamt"></div>
						</div>
						<div class="form-group mbotto">
							<div class="col-md-4"><label>Approval No</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="approvalno"></div>
						</div>
						<div class="form-group mbotto">
							<div class="col-md-4"><label>Request No</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="requestno"></div>
						</div>
						<div class="form-group mbotto">
							<div class="col-md-4"><label>Bill Amount</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="billamount"></div>
						</div>
						<div class="form-group mbotto">
							<div class="col-md-4"><label>Total Amount</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="claimamount"></div>
						</div>

					</div>
				</div>
			   </div>

			   		  <!-- New Tabs -->

		  <div class="card border-0 bg-white  " style="margin-left: -10px;margin-right: -10px;" >
			<div class="card-header ">
				<nav class="mt-3">
					<div class="nav nav-pills" id="nav-tab" role="tablist" >
						<button class="nav-link btn btn-secondary  ml-2  mt-1 active "  type="button"  role="tab" aria-controls="nav-rent" id="pills-rent-tab" data-bs-toggle="pill" data-bs-target="#nav-rent" aria-selected="true">
							<span class="mdi mdi-home-outline"></span>
							Rent & Pharmacy Charges
						</button>
						<button class="nav-link btn btn-secondary  ml-2  mt-1"  type="button"  role="tab" aria-controls="nav-prof-charge" id="pills-prof-charge-tab" data-bs-toggle="pill" data-bs-target="#nav-prof-charge" aria-selected="false">
							<span class="mdi mdi-home-outline"></span>
							Professional Charges
						</button>
						
						<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button"  role="tab" aria-controls="nav-investigation" id="pills-investigation-tab" data-bs-toggle="pill" data-bs-target="#nav-investigation" aria-selected="false">
							<span class="mdi mdi-home-outline"></span>
							Investigations
						</button>
					</div>
				</nav>
			 </div>
			 <div class="card-body " style="height: calc(100vh - 34rem);overflow: auto;" >
				<div class="tab-content" id="nav-tabContent">

					<div class="tab-pane fade show active" id="nav-rent" role="tabpanel" aria-labelledby="nav-rent-tab"  tabindex="0">
					   <div class="mpZero" id="billdetails" style="display:block">
							 
							<div class="">
								<div class="row">
									<div class="col-md-6 col-sm-6 mpZero">
										<div  class="col-md-12 col-sm-12 mpZero">		
											<div class="form-group mbotto">
												<div class="col-md-4"><label>Actual Rent</label></div>
												<div class="col-md-8"><input type="text" class="form-control" id="totalrent" disabled></div>
											</div>
										</div>
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>No of Days</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="totaldays" disabled></div>
										</div>
										</div>								
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Display Name</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="rentname" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Rate</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="rentperday" disabled></div>
										</div>
										</div>					
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Rent Amount</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="rentamount" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Doctor Name</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="cdoctorname" disabled></div>
										</div>
										</div>		
										<div  class="col-md-12 col-sm-12 mpZero">		
											<div class="form-group mbotto">
												<div class="col-md-4"><label> Consultations</label></div>
												<div class="col-md-8"><input type="text" class="form-control" id="consultations" disabled></div>
											</div>
											</div>														
									</div>
									<div class="col-md-6 col-sm-6 mpZero">
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Rate</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="consultationamount" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label> Amount</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="doctorfees" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Opinion By</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="opinionby" disabled></div>
										</div>
										</div>					
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Doctor Name</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="odoctorname" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Opinions</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="opinionconsultations" disabled></div>
										</div>
										</div>					
										<div class="col-md-12 col-sm-12 mpZero" >
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Rate</label></div>
											<div class="col-md-8"><select class="form-control" id="opinionamount" disabled></select></div>
										</div>
										</div>
										<div class="col-md-12 col-sm-12 mpZero">
										<div class="form-group mbotto">
											<div class="col-md-4"><label> Amount</label></div>
											<div class="col-md-8"><input type="text" class="form-control" id="opinionfees" disabled></div>
										</div>
										</div>
										<div  class="col-md-12 col-sm-12 mpZero"  >		
										<div class="form-group mbotto">
											<div class="col-md-4"><label>Pharmacy Charges</label></div>
											<div class="col-md-8"><input type="text" style="background-color: #d1d1d1;" class="form-control" id="totalpharmacy" disabled></div>
										</div>
										</div>

										<div class="col-md-12" style="display:none;">
											<div class="hstack justify-content-end">
												<div class="">
													<div class="card-total px-3 rounded-3">
														<h6 class="dicount-type hstack gap-1">
															<span class="text-dark"><h3 class="netAmt">Pharmacy Charges:  &nbsp;&nbsp;</h3></span>
															<h3><span class="net-amount" style="color:Green" id="totalpharmacy">0.00</span></h3>
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
		 
					 <div class="tab-pane fade" id="nav-prof-charge" role="tabpanel" aria-labelledby="nav-prof-charge-tab" tabindex="1">	
						<div class="mpZero" id="professional" style="display:block">
							<div class="col-md-12 col-sm-12 mpZero" id="professionalgrid" style="height:300px"></div>
						
						</div>
					 </div>
					
					 <div class="tab-pane fade" id="nav-investigation" role="tabpanel" aria-labelledby="nav-investigation-tab"tabindex="2">
						<div class="mpZero" id="investigations" style="display:block">
					    	<div class="col-md-12 col-sm-12 mpZero" id="investigationgrid" style="height:300px"> </div>	
						
					    </div>
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
									<button id="ClaimPatients" class="btn btn-primary priBut" type="button" onclick="loadClaimBill()">Claim Patients</button>
									<button id="Save" class="btn btn-primary priBut" type="button" onclick="saveClaimBill()">Save</button>
									<button id="Print" class="btn btn-primary priBut" type="button" onclick="printClaimBill()">Print</button>
									<button id="btnCancel" class="btn btn-clear" type="button" onclick="clearInnerScreen()">Cancel</button>
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
		 <!--Content End-->
		</div>
	  </div>
</div>
	</body>
	</html>
	<script>

		// Tab  change 
		$("#nav-tab button ").click(function() {
			$("#nav-tab button").removeClass('active');
			$(this).addClass('active');
		      });

			  
	loadBranchData();
	var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"claimno",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"ipno",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"roomno",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"doctorname"},
  	{name:"gender",inputType:4,type:"SPAN",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"doctorname"},
  	{name:"doctorname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referredby",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"approvalno"},
  	{name:"approvalno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"requestno"},  	  	  	
  	{name:"requestno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"admissiondate"},
  	{name:"admissiondate",inputType:0,type:"DATETIME",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"dischargetime"},  	  	
  	{name:"dischargetime",inputType:0,type:"DATETIME",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsorname"},
  	{name:"sponsorname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"approveddate"},  	
  	{name:"approveddate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"Null","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"approvedamt"},
  	{name:"approvedamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"billamount"},  	
  	{name:"billamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"claimamount"},
  	{name:"claimamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:""},
  	{name:"totalrent",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"totaldays"},
  	{name:"totaldays",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"rentname","onchange":"onRentChange"},
  	{name:"rentname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"rentperday"},
  	{name:"rentperday",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"rentamount","onchange":"onRentChange"},
  	{name:"rentamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"cdoctorname"},
  	{name:"cdoctorname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"consultations"},
  	{name:"consultations",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"consultationamount","onchange":"onDoctorFeeChange"},
  	{name:"consultationamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"doctorfees","onchange":"onDoctorFeeChange"},
  	{name:"doctorfees",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"odoctorname"},
  	{name:"opinioncode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"opinionby"},
  	{name:"opinionby",inputType:0,type:"LOV",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"odoctorname",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"opinioncode",tt:false,id:"dr_code"},{tgt:"opinionby",tt:false,id:"dr_name"},{tgt:"opinionby",tt:true,id:"dr_name"}]}},  	  	
  	{name:"odoctorname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"opinionconsultations"},
  	{name:"opinionconsultations",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"opinionamount","onchange":"onOpinionFeeChange"},
  	{name:"opinionamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"opinionfees","onchange":"onOpinionFeeChange"},
  	{name:"opinionfees",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"totalpharmacy"},  	  	  	
  	{name:"totalpharmacy",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:""},
  	{name:"btnSave",inputType:3,caption:"",visible:false},
    {name:"btnClear",inputType:3,caption:"",visible:false}
  	]},
  	{name:"investigationgrid",title:"",contentType:"Table",tableProperties:{optional:true,enableAddRow:false,rowObject:true,serialNumberColumn:"sno",rowEmptyCheckColumn:"itemcode",columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "billno", name: "BillNo", field: "billno",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,"chkTag":false},
    {order:"2",id: "bsno", name: "BillSNo", field: "bsno",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,"chkTag":false},
    {order:"3",id: "billdate", name: "Date", field: "billdate",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:100,"chkTag":false},
    {order:"4",id: "itemcode", name: "Code", field: "itemcode",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:0,"chkTag":false},
    {order:"5",id: "itemname", name: "Investigation", field: "itemname",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:250,"chkTag":false},
    {order:"6",id: "quantity", name: "Numbers", field: "quantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:80,"chkTag":false,"onchange":"onRateQuantityChange"},
    {order:"7",id: "insitemcode", name: "Company Code", field: "insitemcode",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:120,"chkTag":false},
    {order:"8",id: "insitemname", name: "Company Name", field: "insitemname",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:250,"chkTag":false},
    {order:"9",id: "insitemrate", name: "Rate", field: "insitemrate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:120,"chkTag":false,"onchange":"onRateQuantityChange"},
    {order:"10",id: "amount", name: "Amount", field: "amount",defaultValue:"","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:120,"chkTag":false}            
    ]
    }},
  	{name:"professionalgrid",title:"",contentType:"Table",tableProperties:{optional:true,enableAddRow:false,rowObject:true,serialNumberColumn:"tsno",rowEmptyCheckColumn:"pdoctorcode",columns:[
    {order:"0",id: "tsno", name: "SNo", field: "tsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "pbillno", name: "BillNo", field: "pbillno",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,"chkTag":false},
    {order:"2",id: "pbsno", name: "BillSNo", field: "pbsno",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,"chkTag":false},
    {order:"3",id: "pbilldate", name: "Date", field: "pbilldate",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:80,"chkTag":false},
    {order:"4",id: "pdoctorcode", name: "Code", field: "pdoctorcode",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:0,"chkTag":false},
    {order:"5",id: "pdoctorname", name: "Doctor", field: "pdoctorname",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:250,"chkTag":false},
    {order:"6",id: "pquantity", name: "Consultations", field: "pquantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:100,"chkTag":false,"onchange":"onProfessionalRateQuantityChange"},
    {order:"7",id: "insdoctorcode", name: "Company Code", field: "insdoctorcode",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:120,"chkTag":false},
    {order:"8",id: "insdoctorname", name: "Company Name", field: "insdoctorname",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:250,"chkTag":false},
    {order:"9",id: "insdoctorrate", name: "Rate", field: "insdoctorrate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:120,"chkTag":false,"onchange":"onProfessionalRateQuantityChange"},
    {order:"10",id: "doctoramount", name: "Amount", field: "doctoramount",defaultValue:"","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:120,"chkTag":false}            
    ]
    }}
  	]};
	//ajax columns
	var claimbill=new FlexUI.Screen("claimbill",sProps);
    $(document).ready(function () {
            $('#subtitle').text("");
            $('#screentitle').text("Claim Bill");
            screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
            
     });
     function saveClaimBill(){
     		if(claimbill.getSaveInProgress()) return;
        	var r=null;
        	claimbill.setOperation("ADD");
        	claimbill.setScreenCode(600003);
    		var d=claimbill.processDataToSave();
    		claimbill.setSaveInProgress(true);
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",d);
				hideLoader();
		 	}else{
		 		alert("Please correct the validation errors and continue...");
		 		claimbill.setSaveInProgress(false);		 		
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				alert(r.message);
				clearInnerScreen();
				return r.key;		
			}else{
				claimbill.setSaveInProgress(false);			
				alert(r.message);		
			}
      }
    function clearInnerScreen(){
    	claimbill.clearScreen();
    	claimbill.setSaveInProgress(false);
    	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());    	
    }
    // function showRentAndPharmacy(){
    // 	$('#billdetails').css('display','block');
    // 	$('#investigations').css('display','none');
    // 	$('#professional').css('display','none');
    // 	$('#navg').find("li>span").removeClass('selTab');
    // 	$('#navg').find("li>span").eq(0).addClass('selTab');
    // }
    // function showProfessional(){
    // 	$('#billdetails').css('display','none');
    // 	$('#investigations').css('display','none');
    // 	$('#professional').css('display','block');
    // 	$('#navg').find("li>span").removeClass('selTab');
    // 	$('#navg').find("li>span").eq(1).addClass('selTab');
    // }
    // function showInvestigation(){
    // 	$('#billdetails').css('display','none');
    // 	$('#professional').css('display','none');
    // 	$('#investigations').css('display','block');
    // 	$('#navg').find("li>span").removeClass('selTab');
    // 	$('#navg').find("li>span").eq(2).addClass('selTab');
    // }
    function loadClaimBill(id,me){
    	clearInnerScreen();
		var l={url:"/waggle/service/ajax",ajax:"claimpatients",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branchcode",src:"branchcode",ft:false}],results:[],standalone:true};
		var lov=new FlexUI.LOV("cp_lov",me,l);
		lov.onLovClose.subscribe(onClaimBillLoad);
		lov.show();
	}
	function onClaimBillLoad(e,args){
			showLoader();
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			var code=args.result[7];
			var spcode=args.result[3];
			var l=new FlexUI.Ajax();
			var v=l.callAjax("GET","/waggle/service/screen/data?screencode=600003&branchcode="+branch+"&claimno="+code+"&sponsorcode="+spcode,"");
			claimbill.loadObjectData(v);
			//calculateTotal();			
		  	hideLoader();
	}
	function onProfessionalRateQuantityChange(id,me){
		var t=me.getParent();
		calculateProfessionalAmount(t.getCurrentRow());
		calculateTotal();
		return true;
	}
	function onRateQuantityChange(id,me){
		var t=me.getParent();
		calculateAmount(t.getCurrentRow());
		calculateTotal();
		return true;
	}
	function onRentChange(id,me){
		var rentPerDay=toNumber(screenObjects.getScreenObject("rentperday").getValue());
		var totaldays=toNumber(screenObjects.getScreenObject("totaldays").getValue());
		var rent=screenObjects.getScreenObject("rentamount");
		rent.setValue(roundOff(rentPerDay*totaldays,2));
		calculateTotal();
		return true;
	}
	function onDoctorFeeChange(id,me){
		var rate=toNumber(screenObjects.getScreenObject("consultationamount").getValue());
		var qty=toNumber(screenObjects.getScreenObject("consultations").getValue());
		var doctorFee=screenObjects.getScreenObject("doctorfees");
		doctorFee.setValue(roundOff(rate*qty,2));	
		calculateTotal();
		return true;
	}
	function onOpinionFeeChange(id,me){
		var rate=toNumber(screenObjects.getScreenObject("opinionamount").getValue());
		var qty=toNumber(screenObjects.getScreenObject("opinionconsultations").getValue());
		var opinionFee=screenObjects.getScreenObject("opinionfees");
		opinionFee.setValue(roundOff(rate*qty,2));	
		calculateTotal();
		return true;
	}
	function calculateTotal(){
		var total=0;		
		var t=screenObjects.getScreenObject("investigationgrid_data");
		var t1=screenObjects.getScreenObject("professionalgrid_data");
		var rent=toNumber(screenObjects.getScreenObject("rentamount").getValue());
		var doctorFee=toNumber(screenObjects.getScreenObject("doctorfees").getValue());
		var opinionFee=toNumber(screenObjects.getScreenObject("opinionfees").getValue());
		var totalPharmacy=toNumber(screenObjects.getScreenObject("totalpharmacy").getValue());
		var cols=t.getCols();
		var s=t.getSize();
		for(var i=0;i<s;i++){
			total+=toNumber(t.getText(i,cols.amount));
		}
		cols=t1.getCols();
		s=t1.getSize();
		for(var i=0;i<s;i++){
			total+=toNumber(t1.getText(i,cols.doctoramount));
		}
		total=total+rent+doctorFee+opinionFee+totalPharmacy;
		screenObjects.getScreenObject("claimamount").setValue(roundOff(total,2));
	}
	function calculateAmount(row){
		var t=screenObjects.getScreenObject("investigationgrid_data");
		var cols=t.getCols();	
		var baseqty=0;
		baseqty=toNumber(t.getText(row,cols.quantity));
		var rate=t.getText(row,cols.insitemrate);
		var amt=roundOff(toNumber(rate)*baseqty,2);
		t.setText(row,cols.amount,amt);
	}
	function calculateProfessionalAmount(row){
		var t=screenObjects.getScreenObject("professionalgrid_data");
		var cols=t.getCols();	
		var baseqty=0;
		baseqty=toNumber(t.getText(row,cols.pquantity));
		var amt=roundOff(toNumber(t.getText(row,cols.insdoctorrate))*baseqty,2);
		t.setText(row,cols.doctoramount,amt);
	}
	function printClaimBill(){
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			var code=screenObjects.getScreenObject("claimno").getValue();
			if(toNumber(code)!=0){
				var url="/waggle/service/discharge/printclaimbill?branchcode="+branch+"&claimno="+code;
				window.open(url,"_blank");
			}
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
  </script>
</body>
</html>