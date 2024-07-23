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
<style>
.selectedTreatmentRow{
  background:#ffecc6;
}
</style>
<body>
	
	<div class="card border-0 shadow">
		<div class="card-body lpage">

			<div class="row" id="jqcontainer" style="display:none;">
				<div class="table-container">
				<div id="xyz" class="w-100">
	
				</div>
				</div>
			 </div>	

			<div id="callback" class="mt-3">
				<div class="bline"><h3>Discharge Summary</h3></div>

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
									<div class="col-md-12 form-lable">Reg No:&nbsp;<label  class="form-lable" id="lcsno"></label>&nbsp;|&nbsp;Room No:&nbsp;<label class="form-lable" id="roomno">RoomNo</label></div>
								</div>
						</div>
					</div>
					
					<div class="col-sm-12 col-md-12 col-lg-12">  
						<div class="input-group mb-1">
									   <div class="col-md-2"><label for="patientname" class="form-lable">Patient Name </label></div>
									   <div class="col-md-4"><input type="text" class="form-control" id="patientname"><input type="hidden" class="form-control" id="patientcode"><input type="hidden" class="form-control" id="hospregcode"><input type="hidden" class="form-control" id="appid"><input type="hidden" class="form-control" id="casualityno"><input type="hidden" class="form-control" id="csno"><input type="hidden" class="form-control" id="claimno"></div>
									   
										<div class="col-md-2"><label class="form-lable">IP No</label></div>
										<div class="col-md-4"><input type="text" class="form-control" id="ipno"><input type="hidden" id="sponsorname"/><input type="hidden" id="sponsorcode"/></div>
						</div>
					</div>
					<div class="col-sm-12 col-md-12 col-lg-12">  
						<div class="input-group mb-1">
							<div class="col-md-2"><label for="patientage" class="form-lable">Age </label></div>
							<div class="col-md-4"><input type="text" class="form-control" id="patientage"></div>
							<div class="col-md-2"><label for="gender" class="form-lable">Gender</label></div>
							<div class="col-md-4"><label class="form-lable" id="sname"></label></div>
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
						  <div class="col-md-2"><label for="doctorname" class="form-lable">Admission Date</label></div>
									 <div class="col-md-4"><input type="text" class="form-control" id="admissiondate"><input type="hidden" id="doctorcode"/></div>
									 
									 <div class="col-md-2"><label for="referredby" class="form-lable">Discharge Date</label></div>
									 <div class="col-md-4"><input type="text" class="form-control" id="dischargetime"><input type="hidden" id="referralcode"/></div>
						  </div>
				  </div>
				</div>

				<!-- New Tabs -->

				<div class="card border-0 bg-white " style="margin-left: -10px;margin-right: -10px;" >
					<!--tabs-->
					<div class="card-header">
						
						<nav class="mt-3">
							<div class="nav nav-pills" id="nav-tab" role="tablist" >
								<!-- ID reasons -->
								    <button class="nav-link btn btn-secondary  ml-2  mt-1 active "  type="button" id="pills-consul-tab" data-bs-toggle="pill" data-bs-target="#nav-consul" role="tab" aria-controls="nav-consul" aria-selected="true">
									<span class="mdi mdi-home-outline"></span>
									Consultants
								</button>
								<!-- ID findings -->
								<button class="nav-link btn btn-secondary  ml-2  mt-1 "  type="button" id="pills-history-tab" data-bs-toggle="pill" data-bs-target="#nav-history" role="tab" aria-controls="nav-history" aria-selected="false">
									<span class="mdi mdi-home-outline"></span>
									History & Course
								</button>
								<!-- ID diagnosis -->
								<button class="nav-link btn btn-secondary  ml-2  mt-1"  type="button" role="tab" id="pills-diagnosis-tab" data-bs-toggle="pill" data-bs-target="#nav-diagnosis"  aria-controls="nav-diagnosis" aria-selected="false">
									<span class="mdi mdi-home-outline"></span>
									Diagnosis
								</button>
								<!-- ID splopinion -->
								<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button"   role="tab"  id="pills-splopinion-tab" data-bs-toggle="pill" data-bs-target="#nav-splopinion"  aria-controls="nav-splopinion" aria-selected="false">
									<span class="mdi mdi-home-outline"></span>
								   Specialist Opinion
								</button>
								<!-- ID procedure -->
								<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button"  role="tab" id="pills-procdper-tab" data-bs-toggle="pill" data-bs-target="#nav-procdper"   aria-selected="false" aria-controls="nav-procdper">
									<span class="mdi mdi-home-outline"></span> 
									Procedure Performed
								</button>
								<!-- ID treatments -->
								<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button"  role="tab" id="pills-treatment-tab" data-bs-toggle="pill" data-bs-target="#nav-treatment"   aria-selected="false" aria-controls="nav-treatment">
									<span class="mdi mdi-home-outline"></span>
									Treatment Given
								</button>
								<!-- ID dischargecondition -->
								<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button"  role="tab" id="pills-discharge-condition-tab" data-bs-toggle="pill" data-bs-target="#nav-discharge-condition"   aria-selected="false" aria-controls="nav-discharge-condition">
									<span class="mdi mdi-home-outline"></span>
									Discharge Condition
								</button>
								<!-- ID followup -->
								<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button"  role="tab" id="pills-discharge-advice-tab" data-bs-toggle="pill" data-bs-target="#nav-discharge-advice"   aria-selected="false"  aria-controls="nav-discharge-advice">
									<span class="mdi mdi-home-outline"></span>
									Discharge Advice
								</button>
								<!-- ID specialinstructions -->
								<button class="nav-link btn btn-secondary  ml-2  mt-1" type="button"  role="tab" id="pills-discharge-notes-tab" data-bs-toggle="pill" data-bs-target="#nav-discharge-notes"   aria-selected="false" aria-controls="nav-discharge-notes">
									<span class="mdi mdi-home-outline"></span>
									Discharge Notes
								</button>
								<!-- ID urgentcare -->
								<button class="nav-link btn btn-secondary  ml-2  mt-1" style="display:none" type="button"  role="tab" id="pills-urgentcare-tab" data-bs-toggle="pill" data-bs-target="#nav-urgentcare"   aria-selected="false" aria-controls="nav-urgentcare">
									<span class="mdi mdi-home-outline"></span>
									Review & Contact
								</button>
							</div>
						</nav>
					</div>
					<!--tabs end-->
					<div class="card-body " style="height: calc(100vh - 34rem);overflow: auto;">
						<div class="tab-content" id="nav-tabContent">

							<div class="tab-pane fade show active" id="nav-consul" role="tabpanel" aria-labelledby="nav-consul-tab"  tabindex="0">
								<div class="mpZero" id="reasons" style="display:block">

									
									<div class="">
									<div class="row" id="reasons" >
										<textarea id="reason" row="200" col="100" style="height:250px;display:none"></textarea>
										
										<div class="col-md-6 col-sm-6 mpZero">
											<div  class="col-md-12 col-sm-12 mpZero">		
												<div class="">
													<div class="col-md-12"><label>Opinion Consultant-1</label></div>
													<div class="col-md-12 mt-3"><input type="text" class="form-control" id="opinionconsultant1"></div>
													
												</div>
											</div>
											<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
												<div class="">
													<div class="col-md-12"><label>Opinion Consultant-2</label></div>
													<div class="col-md-12 mt-3"><input type="text" class="form-control" id="opinionconsultant2"></div>
													
												</div>
											</div>
											<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
												<div class="">
													<div class="col-md-12"><label>Opinion Consultant-3</label></div>
													<div class="col-md-12 mt-3"><input type="text" class="form-control" id="opinionconsultant3"></div>
													
												</div>
											</div>
										</div>

										<div class="col-md-6 col-sm-6 mpZero">
											<div  class="col-md-12 col-sm-12 mpZero">		
												<div class="">
													<div class="col-md-12"><label>Referral Doctor</label></div>
													<div class="col-md-12 mt-3"><input type="text" class="form-control" id="referraldoctor"></div>
												</div>
											</div>						
											<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
												<div class="">
													<div class="col-md-12"><label>Anaesthetist Name</label></div>
													<div class="col-md-12 mt-3"><input type="text" class="form-control" id="anaesthetist"></div>
												</div>
											</div>
											<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
												<div class="">
													<div class="col-md-12"><label>DOS</label></div>
													<div class="col-md-12 mt-3"><input type="text" class="form-control" id="dos"></div>
												</div>
											</div>
										</div>

										
										
								  </div>
								</div>

								</div>
							</div>

							<div class="tab-pane fade " id="nav-history" role="tabpanel" aria-labelledby="nav-history-tab"  tabindex="1">
								<div class="mpZero" id="findings" style="display:block">
									

										<div class="row">
											<div class="col-md-4">
													
													<div class="" >

														<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
															<div class="form-group mbotto">
																<div class="col-md-2"><label>BP</label></div>
																<div class="col-md-9"><input class="form-control" type="text" id="admissionbp"/></div>
																<div class="col-md-1"></div>
															</div>
														</div>
														<div class="clearfix"></div>
														<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
															<div class="form-group mbotto">
																<div class="col-md-2"><label>PR</label></div>
																<div class="col-md-9"><input class="form-control" type="text" id="admissionpr"/></div>
																<div class="col-md-1"></div>
															</div>
														</div>
														<div class="clearfix"></div>
														<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
															<div class="form-group mbotto">
																<div class="col-md-2"><label>SPO2</label></div>
																<div class="col-md-9"><input class="form-control" type="text" id="admissionspo"/></div>
																<div class="col-md-1"></div>
															</div>
														</div>
														<div class="clearfix"></div>
														<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
															<div class="form-group mbotto">
																<div class="col-md-2"><label>TEMP</label></div>
																<div class="col-md-9"><input class="form-control" type="text" id="admissiontemp"/></div>
																<div class="col-md-1"></div>
															</div>
														</div>
														<div class="clearfix"></div>
														<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
															<div class="form-group mbotto">
																<div class="col-md-2"><label>RR</label></div>
																<div class="col-md-9"><input class="form-control" type="text" id="admissionrr"/></div>
																<div class="col-md-1"></div>
															</div>
														</div>
														<div class="clearfix"></div>
														<div  class="col-md-12 col-sm-12 mt-3 mpZero">		
															<div class="form-group mbotto">
																<div class="col-md-2"><label>TEM</label></div>
																<div class="col-md-9"><input class="form-control" type="text" id="admissiontem"/></div>
																<div class="col-md-1"></div>
															</div>
														</div>
														<div class="clearfix"></div>
														<div class=" ">
															<div class="col-md-12 mt-3"><label>Examination </label></div>
															<div class="col-md-11"><textarea id="examination" row="100" col="100" style="height:50px;width:100%" ></textarea></div>		
															<div class="col-md-1"></div>	
														</div>								
													</div>
												
											</div>
											<div class="col-md-4">
													
													<div class=" ">
														<div class="col-md-12 "><label>Findings </label></div>
														<div class="col-md-12"><textarea id="finding" row="200" col="100" style="height:100px;width:100%"></textarea></div>
													</div>
													<div class=" ">
														<div class="col-md-12 mt-3"><label>Complaints </label></div>
														<div class="col-md-12"><textarea id="complaints" row="200" col="100" style="height:100px;width:100%"></textarea></div>
													</div>
													
													<div class=" ">
														<div class="col-md-12 mt-3"><label>Past History </label></div>
														<div class="col-md-12"><textarea id="pasthistory" row="200" col="100" style="height:100px;width:100%"></textarea></div>
													</div>
											
												
											</div>
											<div class="col-md-4">
												<div class="col-md-12 col-sm-12 mpZero">
													<div class="col-md-12 col-sm-12 mpZero">
														Investigations:
													</div>
													<div class="clearfix"></div>
													<div class="col-md-12 col-sm-12 mpZero" id="investigationgrid" style="height:300px">
													</div>
												</div>
											</div>
										</div>
									
									
								</div>
							</div>

							<div class="tab-pane fade " id="nav-diagnosis" role="tabpanel" aria-labelledby="nav-diagnosis-tab"  tabindex="2">
								<div class="mpZero" id="diagnosis" style="display:block">
									<div class="col-md-12 col-sm-12 mpZero" id="diagnosis" style="display:block">
										<textarea id="diagnose" row="200" col="100" style="height:250px;"></textarea>
									</div>
									<div class="col-md-12 col-sm-12 mt-3 mpZero" >
										  <div class="col-md-12 mpZero"><label>ICD Codes </label></div>
										  <div class="col-md-12 mpZero"><textarea id="icdcodes" row="100" col="100" style="height:50px;width:100%;"></textarea></div>
								    </div>
								</div>
							</div>

							<div class="tab-pane fade " id="nav-splopinion" role="tabpanel" aria-labelledby="nav-splopinion-tab"  tabindex="3">
								<div class="mpZero" id="splopinion" style="display:block">
									
									<div class="col-md-12 col-sm-12 mpZero" id="splopinion" style="height:400px;display:block">
										<div class="col-md-10 col-sm-10 mpZero">
												  <strong>Specialist Opinion - 1</strong>
												  <textarea id="specialistopinion" row="200" col="100" style="height:100px;width:100%"></textarea> 
										  </div>
										 
										  <div class="col-md-10 col-sm-10 mt-3 mpZero">
												  <strong>Specialist Opinion - 2</strong>
												  <textarea id="specialistopinion1" row="200" col="100" style="height:100px;width:100%"></textarea> 
										  </div>
										  <div class="col-md-10 col-sm-10 mt-3 mpZero">
												  <strong>Specialist Opinion - 3</strong>
												  <textarea id="specialistopinion2" row="200" col="100" style="height:100px;width:100%"></textarea> 
										  </div>
									  </div>

								</div>
							</div>

							<div class="tab-pane fade " id="nav-procdper" role="tabpanel" aria-labelledby="nav-bill-tab"  tabindex="4">
								<div class="mpZero" id="procedure" style="display:block">
									
									<div class="col-md-12 col-sm-12 mpZero" id="procedures" style="height:400px;display:block">
										<textarea id="procedure" row="200" col="100" style="height:250px;width:100%"></textarea>
									</div>

								</div>
							</div>

							<div class="tab-pane fade " id="nav-discharge-condition" role="tabpanel" aria-labelledby="nav-bill-tab"  tabindex="5">
								<div class="mpZero" id="dischargecondition" style="display:block">
									
									<div class="row">
										<div class="col-md-4">
											<div class="" >         
												<div class="col-md-2"><label>BP </label></div>
												<div class="col-md-10"><input class="form-control" type="text" id="dischargebp"/></div>
												<div class="clearfix"></div>
												<div class="col-md-2 mt-3"><label>PR </label></div>
												<div class="col-md-10"><input class="form-control" type="text" id="dischargepr"/></div>
												<div class="clearfix"></div>
												<div class="col-md-2 mt-3"><label>SPO2 </label></div>
												<div class="col-md-10"><input class="form-control" type="text" id="dischargespo"/></div>
												<div class="clearfix"></div>
												<div class="col-md-2 mt-3"><label>TEMP </label></div>
												<div class="col-md-10"><input class="form-control" type="text" id="dischargetemp"/></div>												
											</div>
										</div>
										<div class="col-md-8">
											<div class="col-md-12"><label>Discharge Condition Notes</label></div>
										 	 <div class="col-md-12"><textarea id="dischargecondnotes" row="200" col="100" style="height:250px;width:100%"></textarea></div>
										</div>

										<div class="col-md-12 col-sm-12 mpZero" id="discondgrid" style="height:300px;display:none"></div>
									</div>

									

									


								</div>
							</div>

							<div class="tab-pane fade " id="nav-discharge-advice" role="tabpanel" aria-labelledby="nav-bill-tab"  tabindex="6">
								<div class="mpZero" id="followup" style="display:block">
									
									<div class="col-md-12 col-sm-12 mpZero" id="followup" style="height:400px;display:block">
										<div class="col-md-12 col-sm-12 mpZero" id="followupgrid" style="height:300px">
										</div>
								</div>

								</div>
							</div>

							<div class="tab-pane fade " id="nav-treatment" role="tabpanel" aria-labelledby="nav-bill-tab"  tabindex="7">
								<div class="mpZero" id="treatments" style="display:block">
									
									<div class="col-md-12 col-sm-12 mpZero" id="treatments" style="height:400px;display:block">
										<div class="col-md-12 col-sm-12 mpZero" id="treatmentgrid" style="height:300px">
										</div>
									</div>

								</div>
							</div>

							<div class="tab-pane fade " id="nav-discharge-notes" role="tabpanel" aria-labelledby="nav-bill-tab"  tabindex="8">
								<div class="mpZero" id="specialinstructions" style="display:block">
									
									<div class="row">
										<div class="col-md-8">
											<div class="">
												<div class="col-md-12"><label>Discharge Advice Notes</label></div>
												<div class="col-md-12"><textarea id="instructions" row="200" col="100" style="height:250px"></textarea></div>					
											</div>
										</div>
										<div class="col-md-4">
											<div class="">
												<div class="col-md-12 "><label>Review After</label></div>
												<div class="col-md-12"><input class="form-control" type="text" id="reviewafter"/></div>
												<div class="col-md-12 mt-3"><label>Contact</label></div>
												<div class="col-md-12"><input class="form-control" type="text" id="contact"/></div>					
											</div>
										</div>
									</div>
								
								</div>
							</div>

							<div class="tab-pane fade show active" id="nav-urgentcare" role="tabpanel" aria-labelledby="nav-bill-tab"  tabindex="9">
								<div class="mpZero" id="urgentcare" style="display:block">
									
									<div class="col-md-12 col-sm-12 mpZero" id="urgentcare" style="height:400px;display:none">
										<div  class="col-md-6 col-sm-6 mpZero">
									  <div class="form-group mbotto">
										  <div class="col-md-2"><label>Urgent Care Notes</label></div>
										  <div class="col-md-10"><textarea id="emergencynotes" row="200" col="100" style="height:250px"></textarea></div>
									  </div>
									  </div>
								</div>

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
											<button id="Save" class="btn btn-primary priBut" type="button" onclick="saveDischargeSummary()" style="display:none">Save</button>
											<button id="PrintSummary" class="btn btn-primary priBut" type="button" onclick="printDischargeSummary()">Print</button>
											<button id="PrintSummary" class="btn btn-primary priBut" type="button" onclick="printDischargeAdvice()">Print Discharge Advice</button>
											<button id="btnCancel" class="btn btn-clear" type="button" onclick="clearInnerScreen()">Clear/Other Patient</button>
								    </div>
									</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>


				</div>

			</div>
		</div>
	</div>	

	
<!-----------------end----------------------->	



	</body>
	</html>
	<script>

// Tab color change 
$("#nav-tab button ").click(function() {
			
			  $("#nav-tab button").removeClass('active');
			  $(this).addClass('active');
			});

	loadBranchData();
	if("<%=mode%>"!="View"){
		jqReport(13,"#xyz","&branchcode="+$('#branch').val());
	}
	var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"refcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"ipno",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":true,nf:"patientname",lovOptions:{url:"/waggle/service/ajax",ajax:"allinpatients",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branchcode",src:"branchcode",tt:false}],results:[
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
  	{tgt:"roomno",tt:false,id:"rm_roomname"}
  	]},validation:"loadDischargeData"},
  	{name:"roomno",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"doctorname"},
  	{name:"gender",inputType:4,type:"SPAN",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"doctorname"},
  	{name:"doctorname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referredby",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:""},
  	{name:"reason",inputType:0,type:"TEXTAREA",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"opinionconsultant1",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"opinionconsultant2",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"opinionconsultant3",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"referraldoctor",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"anaesthetist",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"dos",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":15,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"admissionbp",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"admissionpr",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"admissionspo",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"admissiontemp",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"diagnose",inputType:0,type:"TEXTAREA",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"specialistopinion",inputType:0,type:"TEXTAREA",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"specialistopinion1",inputType:0,type:"TEXTAREA",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"specialistopinion2",inputType:0,type:"TEXTAREA",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"procedure",inputType:0,type:"TEXTAREA",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"instructions",inputType:0,type:"TEXTAREA",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"dischargebp",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"dischargepr",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"dischargespo",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"dischargetemp",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"dischargecondnotes",inputType:0,type:"TEXTAREA",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},  	
  	{name:"emergencynotes",inputType:0,type:"TEXTAREA",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"reviewafter",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"contact",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":15,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	{name:"dischargedate",inputType:0,type:"TDATE",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},  	
  	{name:"dischargetime",inputType:0,type:"DATETIME",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"admissiondate",inputType:0,type:"DATETIME",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"sponsorname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:""},
  	{name:"smobileno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"",validation:"checkDischargeSummaryPatientExists"},
  	{name:"btnSave",inputType:3,caption:"",visible:false},
    {name:"btnClear",inputType:3,caption:"",visible:false}
  	]},
  	{name:"investigationgrid",title:"",contentType:"Table",tableProperties:{optional:true,rowObject:true,serialNumberColumn:"isno",rowEmptyCheckColumn:"investigation",columns:[
    {order:"0",id: "isno", name: "SNo", field: "isno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "investigation", name: "Investigation", field: "investigation",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,"chkTag":false},    
    {order:"2",id: "results", name: "Results", field: "results",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:200}
    ]
    }},
  	{name:"treatmentgrid",title:"",contentType:"Table",tableProperties:{optional:true,enableAddRow:true,rowObject:true,serialNumberColumn:"tsno",rowEmptyCheckColumn:"productname",columns:[
  	{order:"0",id: "tselected", name: "Select", field: "tselected",defaultValue:"1","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,"chkTag":false,width:0},
    {order:"1",id: "tsno", name: "SNo", field: "tsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"2",id: "billno", name: "BillNo", field: "billno",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,"chkTag":false},
    {order:"3",id: "bsno", name: "BillSNo", field: "bsno",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,"chkTag":false},
    {order:"4",id: "billdate", name: "Date", field: "billdate",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,"chkTag":false},
    {order:"5",id: "productcode", name: "Code", field: "productcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,"chkTag":false},
    {order:"6",id: "productname", name: "Treatment", field: "productname",defaultValue:"","inputType":0,"type":"LOV","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:250,"chkTag":false,lovOptions:{url:"/Fruits/service/ajax",ajax:"saleproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branchcode",tt:false}],results:[
  	{tgt:"treatmentgrid_data",tt:false,row:"cr",id:"a.pm_code",col:"productcode"},
  	{tgt:"treatmentgrid_data",tt:false,row:"cr",id:"a.pm_name",col:"productname"},
  	{tgt:"treatmentgrid_data",tt:true,row:"cr",id:"a.pm_name",col:"productname"}  	  	
  	]}},    
    {order:"7",id: "type", name: "Type", field: "type",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:100},
    {order:"8",id: "abmeal", name: "ABMeal", field: "abmeal",defaultValue:"AM","inputType":0,"type":"TEXT","maxValue":0,"textLength":4,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:100},
    {order:"9",id: "course1", name: "Morning", field: "course1",defaultValue:"0","inputType":2,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:70},
    {order:"10",id: "course2", name: "Afternoon", field: "course2",defaultValue:"0","inputType":2,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:70},
    {order:"11",id: "course3", name: "Evening", field: "course3",defaultValue:"0","inputType":2,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:70},
    {order:"12",id: "course4", name: "Night", field: "course4",defaultValue:"0","inputType":2,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:70},
    {order:"13",id: "dtinstructions", name: "Notes", field: "dtinstructions",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:200},
    ]
    }},
  	{name:"discondgrid",title:"",contentType:"Table",tableProperties:{optional:true,rowObject:true,serialNumberColumn:"dcsno",rowEmptyCheckColumn:"conditionname",columns:[
    {order:"0",id: "dcsno", name: "SNo", field: "dcsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "conditionname", name: "Investigation", field: "conditionname",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,"chkTag":false},    
    {order:"2",id: "condresults", name: "Results", field: "condresults",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:150}
    ]
    }},
  	{name:"followupgrid",title:"",contentType:"Table",tableProperties:{optional:true,rowObject:true,serialNumberColumn:"fsno",rowEmptyCheckColumn:"followupname",columns:[
    {order:"0",id: "fsno", name: "SNo", field: "fsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "followupcode", name: "Code", field: "followupcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,"chkTag":false},
    {order:"2",id: "followupname", name: "Product", field: "followupname",defaultValue:"","inputType":0,"type":"LOV","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:250,"chkTag":false,lovOptions:{url:"/Fruits/service/ajax",ajax:"saleproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branchcode",tt:false}],results:[
  	{tgt:"followupgrid_data",tt:false,row:"cr",id:"a.pm_code",col:"followupcode"},
  	{tgt:"followupgrid_data",tt:false,row:"cr",id:"a.pm_name",col:"followupname"},
  	{tgt:"followupgrid_data",tt:true,row:"cr",id:"a.pm_name",col:"followupname"}  	  	
  	]}},    
    {order:"3",id: "ftype", name: "Type", field: "ftype",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:100},
    {order:"4",id: "fabmeal", name: "ABMeal", field: "fabmeal",defaultValue:"AM","inputType":0,"type":"TEXT","maxValue":0,"textLength":4,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:100},
    {order:"5",id: "fcourse1", name: "Morning", field: "fcourse1",defaultValue:"0","inputType":2,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:70},
    {order:"6",id: "fcourse2", name: "Afternoon", field: "fcourse2",defaultValue:"0","inputType":2,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:70},
    {order:"7",id: "fcourse3", name: "Evening", field: "fcourse3",defaultValue:"0","inputType":2,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:70},
    {order:"8",id: "fcourse4", name: "Night", field: "fcourse4",defaultValue:"0","inputType":2,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:70},
    {order:"9",id: "dfinstructions", name: "Notes", field: "dfinstructions",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:200}
    ]
    }}
  	]};
	//ajax columns
	var dischargesum=new FlexUI.Screen("dischargesum",sProps);
    $(document).ready(function () {
            $('#subtitle').text("");
            $('#screentitle').text("Discharge Summary");
            screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
            loadActions(200010);
     });
     function saveDischargeSummary(){
     		if(dischargesum.getSaveInProgress()) return;
        	var r=null;
        	dischargesum.setOperation("ADD");
    		var d=dischargesum.processDataToSave();
    		if(d.indexOf('&')!=-1){
    			d=d.replace(/&/g,'%26');
    		}
    		dischargesum.setSaveInProgress(true);
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/discharge/savesummary",d);
				hideLoader();
		 	}else{
		 		alert("Please correct the validation errors and continue...");
		 		dischargesum.setSaveInProgress(false);		 		
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				alert(r.message+". Please clear the screen and continue for next patient");
				//printDischargeBill(r.code);
				//clearInnerScreen();
				dischargesum.setSaveInProgress(false);
				return r.key;		
			}else{
				dischargesum.setSaveInProgress(false);			
				alert(r.message);		
			}
      }
    function clearInnerScreen(){
    	dischargesum.clearScreen();
    	dischargesum.setSaveInProgress(false);
    	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());    	
    }
  function loadDischargeData(){
   if(!dischargesum.getSaveInProgress()){
	  	showLoader();
		var l=new FlexUI.Ajax();
		var v=l.callAjax("GET","/waggle/service/discharge/summaryentry","&branchcode="+screenObjects.getScreenObject("branchcode").getValue()+"&patientcode="+screenObjects.getScreenObject("patientcode").getValue() );
		clearInnerScreen();
		dischargesum.loadObjectData(v);
	  	hideLoader();
	  	/*var trs=$('#treatmentgrid').find('tr');
	    for (i=0;i<trs.length;i++){
			var x=trs[i];
			$(x).find('td').eq(0).find('input[type="checkbox"]').bind('click',function(e){
				var tgt=$(this);
				if(tgt.prop('checked')){
					tgt.parent().parent().addClass('selectedTreatmentRow');
				}else{
					tgt.parent().parent().removeClass('selectedTreatmentRow');
				}
			});	
			$(x).find('td').eq(0).find('input[type="checkbox"]:checked').parent().parent().addClass('selectedTreatmentRow');
		}*/
	 }
	 return true;
  }  
    function showReasons(){
    	$('#reasons').css('display','block');
    	$('#findings').css('display','none');
    	$('#diagnosis').css('display','none');
    	$('#splopinion').css('display','none');
    	$('#procedures').css('display','none');
    	$('#treatments').css('display','none');
    	$('#dischargecondition').css('display','none');
    	$('#followup').css('display','none');
    	$('#specialinstructions').css('display','none');
    	$('#urgentcare').css('display','none');    	
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(0).addClass('selTab');
    }
    function showProcedure(){
    	$('#reasons').css('display','none');
    	$('#findings').css('display','none');
    	$('#diagnosis').css('display','none');
    	$('#splopinion').css('display','none');
    	$('#procedures').css('display','block');
    	$('#treatments').css('display','none');
    	$('#dischargecondition').css('display','none');
    	$('#followup').css('display','none');
    	$('#specialinstructions').css('display','none');
    	$('#urgentcare').css('display','none');    	
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(4).addClass('selTab');
    }
    function showDiagnosis(){
    	$('#reasons').css('display','none');
    	$('#findings').css('display','none');
    	$('#diagnosis').css('display','block');
    	$('#splopinion').css('display','none');
    	$('#procedures').css('display','none');
    	$('#treatments').css('display','none');
    	$('#dischargecondition').css('display','none');
    	$('#followup').css('display','none');
    	$('#urgentcare').css('display','none');
    	$('#specialinstructions').css('display','none');    	    	
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(2).addClass('selTab');
    }
    function showSpecialistOpinion(){
    	$('#reasons').css('display','none');
    	$('#findings').css('display','none');
    	$('#diagnosis').css('display','none');
    	$('#splopinion').css('display','block');
    	$('#procedures').css('display','none');
    	$('#treatments').css('display','none');
    	$('#dischargecondition').css('display','none');
    	$('#followup').css('display','none');
    	$('#urgentcare').css('display','none');
    	$('#specialinstructions').css('display','none');    	    	
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(3).addClass('selTab');
    }
    function showTreatment(){
       	$('#reasons').css('display','none');
    	$('#findings').css('display','none');
    	$('#diagnosis').css('display','none');
    	$('#splopinion').css('display','none');
    	$('#procedures').css('display','none');
    	$('#treatments').css('display','block');
    	$('#dischargecondition').css('display','none');
    	$('#followup').css('display','none');
    	$('#specialinstructions').css('display','none');
    	$('#urgentcare').css('display','none');    	    	
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(5).addClass('selTab');
    }
    function showFindings(){
       	$('#reasons').css('display','none');
    	$('#findings').css('display','block');
    	$('#diagnosis').css('display','none');
    	$('#splopinion').css('display','none');
    	$('#procedures').css('display','none');
    	$('#treatments').css('display','none');
    	$('#dischargecondition').css('display','none');
    	$('#followup').css('display','none');
    	$('#urgentcare').css('display','none');
    	$('#specialinstructions').css('display','none');    	    	
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(1).addClass('selTab');
    }
    function showDischargeCondition(){
       	$('#reasons').css('display','none');
    	$('#findings').css('display','none');
    	$('#diagnosis').css('display','none');
    	$('#splopinion').css('display','none');
    	$('#procedures').css('display','none');
    	$('#treatments').css('display','none');
    	$('#dischargecondition').css('display','block');
    	$('#specialinstructions').css('display','none');
    	$('#urgentcare').css('display','none');
    	$('#followup').css('display','none');    	    	
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(6).addClass('selTab');
    }
    function showFollowupAdvice(){
       	$('#reasons').css('display','none');
    	$('#findings').css('display','none');
    	$('#diagnosis').css('display','none');
    	$('#splopinion').css('display','none');
    	$('#procedures').css('display','none');
    	$('#treatments').css('display','none');
    	$('#dischargecondition').css('display','none');
    	$('#followup').css('display','block');    	
    	$('#specialinstructions').css('display','none');
    	$('#urgentcare').css('display','none');    	    	
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(7).addClass('selTab');
    }
    function showSpecialInstructions(){
       	$('#reasons').css('display','none');
    	$('#findings').css('display','none');
    	$('#diagnosis').css('display','none');
    	$('#splopinion').css('display','none');
    	$('#procedures').css('display','none');
    	$('#treatments').css('display','none');
    	$('#dischargecondition').css('display','none');
    	$('#followup').css('display','none');    	    	
    	$('#specialinstructions').css('display','block');
    	$('#urgentcare').css('display','none');
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(8).addClass('selTab');
    }
    function showUrgentCare(){
       	$('#reasons').css('display','none');
    	$('#findings').css('display','none');
    	$('#diagnosis').css('display','none');
    	$('#splopinion').css('display','none');
    	$('#procedures').css('display','none');
    	$('#treatments').css('display','none');
    	$('#dischargecondition').css('display','none');
    	$('#followup').css('display','none');    	    	
    	$('#specialinstructions').css('display','none');
    	$('#urgentcare').css('display','block');
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(9).addClass('selTab');
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
	function printDischargeSummary(){
		var branch=screenObjects.getScreenObject("branchcode").getValue();
		var code=screenObjects.getScreenObject("patientcode").getValue();
		var url="/waggle/service/discharge/printsummary?branchcode="+branch+"&patientcode="+code;
		window.open(url,"_blank");
	}	
	function printDischargeAdvice(){
		var branch=screenObjects.getScreenObject("branchcode").getValue();
		var code=screenObjects.getScreenObject("patientcode").getValue();
		var url="/waggle/service/discharge/printdischargeadvice?branchcode="+branch+"&patientcode="+code;
		window.open(url,"_blank");
	}

		function checkDischargeSummaryPatientExists(id,me){
			if(!dischargesum.getSaveInProgress()){
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
							getDischargeSummaryPatientInfo(branch,v.data[0]);					
							return true;
						}else if(v.data && v.data.length>1){
							screenObjects.getScreenObject("smobileno").setTag(stext);
							var d=null;
							d={url:"/waggle/service/ajax",ajax:"hospinpatients",scrollEnabled:true,searchFromList:false,dsi:dsi,edsi:1,params:[{n:"branchcode",src:"branchcode",ft:false},{n:"searchtxt",src:"smobileno",ft:false}],results:[],standalone:true};
							var lov=new FlexUI.LOV("s_lov",me,d,v.data);
							lov.onLovClose.subscribe(onDischargeSummaryPatientClose);
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
		function onDischargeSummaryPatientClose(e,args){
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			screenObjects.getScreenObject("patientcode").setValue(args.result[20]);
			loadDischargeData();
			$('#ipno').focus();
		}		
		function getDischargeSummaryPatientInfo(branch,result){
			$('#lcsno').text(result[1]);
			screenObjects.getScreenObject("patientcode").setValue(result[20]);
			loadDischargeData();
			$('#ipno').focus();
		}

		


  </script>
</body>
</html>