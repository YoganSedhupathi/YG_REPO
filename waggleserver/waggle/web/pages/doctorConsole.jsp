<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Manage Insurance Patients</title>
  	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="assets/css/demo/bootstrap.min.css">
</head>


<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String rptId=request.getParameter("id");
String userId=(String)session.getAttribute("LOGIN_ID");
String title=request.getParameter("title");
%>
<body>
	<div class="clearfix"></div>
	<div class="card border-0 shadow">
		<div class="card-body lpage">	

			<div class="col-sm-12 col-md-12 col-lg-12 mpZero marTp">
				<!-- DATE SEARCH START -->
					<div class="col-md-12 col-sm-12 " id='addGrp' style="display: block;">
						<div class="fotSizBg mpZero"><h4>Doctor Console of : &nbsp;<span id="drname"></span></h4></div>
						<input type="hidden" id="drcode"/>
						
						
						<div class="row">
							<div  class="col-md-5 col-sm-5 mpZero">	
								<div class="input-group">
									<span class="input-group-text">From</span>
									<input id="fromdate" name="fromdate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
									<span class="input-group-text">To</span>
									<input id="todate" name="todate" inputType="date"  type="text" mandatory="1"  class="form-control"/> &ensp;
									<button type="button" class="btn btn-primary"  onclick="reportGo(300014)">Go</button> &ensp;
								</div>
							</div>	
							<div  class="col-md-7 col-sm-7 mpZero text-right" >	
								<div id="addGrp" class="btn-group pull-right">
									<div class="btn-group pull-right" id="actionicons">
										<button onclick="toggleHeaderRow()" class="btn btn-clear mx-3" style="background-color: #a7bec8;"><span class="mdi mdi-filter">Search</span></button>
									</div>
									</div>
							</div>	
						</div>
					</div>
				<!-- DATE SEARCH END -->
				
					   <div class="mt-3" id="xyz" ></div>
						
				
				<div class="col-md-12 col-sm-12 mpZero">
						
						<!-- ID CALLBACK START-->
						<div class="col-md-12 col-sm-12 mpZero" id="callback" style="display:none">
							<div class="">
								<!--headerlogin-->
									<div class=" row">
										<div class="col-md-6 col-xs-6 mpZero">
											<div class="fotSizBg1"><span id="dpatientname">Patient Name</span><input type="hidden" id="dpatientcode"/><input type="hidden" id="dappid"/><input type="hidden" id="dcustcode"/></div>
											<div class="prTxt3"><span id="dage">Age</span> | <span id="dgender">M</span> | <span id="dheight"></span></div>
										</div>
										<div class="col-md-4 col-xs-4 text-right fotSizBg1" style="color:#fff;display:none;">
											<div class="fotSizBg" id="ovisit"></div>
										</div>
										<div class="col-md-6 row">
											<div class="col-md-2"><label>Refer to</label></div>
											<div class="col-md-8"><select class="form-control" id="doclist" style="border-width: 1px; border-color: rgb(204, 204, 204);"></select></div>
											<div class="col-md-2"><button id="btnRefer" class="btn btn-primary priBut" type="button" onclick="app.referDoctor(this)">Refer</button> </div>
										</div>
									</div>   
								<!--headerlogin End-->
								<!-- TABS STARTS-->

									<div class="card border-0 bg-white mt-3 " >
										<div class="card-header ">
											<nav class="mt-3">
												<div class="nav nav-pills" id="nav-tab" role="tablist" >
													<button class="nav-link btn btn-secondary  ml-2  mt-1 active "  onclick="app.showDiagnose(this)"  type="button" id="pills-diagnosis-tab" data-bs-toggle="pill" data-bs-target="#nav-diagnosis" role="tab" aria-controls="nav-diagnosis" aria-selected="true">
														<span class="mdi mdi-home-outline"></span>
														Diagnosis
													</button>
													<button class="nav-link btn btn-secondary  ml-2  mt-1" onclick="app.showClinicalTests(this)"  type="button" id="pills-testunit-tab" data-bs-toggle="pill" data-bs-target="#nav-testunit" role="tab" aria-controls="nav-testunit" aria-selected="false">
															<span class="mdi mdi-home-outline"></span>
														Tests
													</button>
													
													<button class="nav-link btn btn-secondary  ml-2  mt-1" onclick="app.showPrescription(this)" type="button"   id="pills-Prescription-tab" data-bs-toggle="pill" data-bs-target="#nav-Prescription"  role="tab" aria-controls="nav-Prescription" aria-selected="false">
														<span class="mdi mdi-home-outline"></span>
														Prescription
													</button>
													
													<button class="nav-link btn btn-secondary  ml-2  mt-1" onclick="app.showFees(this)" type="button"  role="tab" aria-controls="nav-next" data-bs-toggle="pill" data-bs-target="#nav-next"  role="tab" aria-controls="nav-next" aria-selected="false">
														<span class="mdi mdi-home-outline"></span>
														Fees/Next Visit
													</button>
													<button class="nav-link btn btn-secondary  ml-2  mt-1" style="width:25%;display:none;text-align:center" onclick="app.showNextVisit(this)"  type="button" role="tab" aria-controls="nav-pharmacy">
														<span class="mdi mdi-home-outline"></span>
														Next Visit
													</button>
													
												</div>
											</nav>
										</div>
										<div class="card-body " style="height: calc(100vh - 24rem);overflow: auto;" >
											<div class="tab-content" id="nav-tabContent">
										<!-- TAB 1 --> 
												<div class="tab-pane fade show active  " id="nav-diagnosis" role="tabpanel" aria-labelledby="nav-diagnosis-tab"  tabindex="0">
												<div class="mpZero" id="diagnose" style="display:block">
														
													<div class="row">
														<div class="col-md-6">
															<div class="col-md-12 col-xs-12">
																<div class="row">
																	<div class="col-md-2 col-xs-2"><div ><label for="dweight">Weight</label><input type="text" id="dweight" class="form-control" placeholder="weight" inputType="NUMERIC"  decimal="0" mandatory="0"   maxlength="3" onkeydown='return validate(this,event)' onchange="CalculateBmi()"/><input type="hidden" id="dheight" class="form-control" placeholder="height" inputType="NUMERIC"  decimal="0" mandatory="0"   maxlength="3" onkeydown='return validate(this,event)'/><label for="dweight" class="text-muted" style="font-size: 80%" >kgs</label></div></div>
																	<div class="col-md-2 col-xs-2"><div ><label for="dtemperature">Temp</label><input type="text" id="dtemperature" class="form-control" placeholder="Temp" inputType="DECIMAL"  decimal="2" mandatory="1"   maxlength="5" onkeydown='return validate(this,event)'/><label class=" text-muted" style="font-size: 80%" for="dtemperature">&deg;F</label></div></div>
																	<div class="col-md-2 col-xs-2"><div ><label for="dpr">PR</label><input type="text" id="dpr" class="form-control" placeholder="PR" inputType="DECIMAL"  decimal="2" mandatory="1"   maxlength="5" onkeydown='return validate(this,event)'/><label class=" text-muted" style="font-size: 80%" for="dpr ">/mt</label></div></div>
																	<div class="col-md-2 col-xs-2"><div ><label for="dbp">BP</label><input type="text" id="dbp" class="form-control" placeholder="BP" inputType="DECIMAL"  decimal="2" mandatory="1"   maxlength="5" onkeydown='return validate(this,event)'/><label class="text-muted"  style="font-size: 80%"  for="dbp">mm/Hg</label></div>  </div>  						
																	<div class="col-md-2 col-xs-2"><div ><label for="dbs">BS</label><input type="text" id="dbs" class="form-control" placeholder="BS" inputType="NUMERIC"  decimal="0" mandatory="0"   maxlength="10" onkeydown='return validate(this,event)'/><label class=" text-muted" style="font-size: 80%" for="dps">mgs/di </label><input  type="hidden" id="dbstime" class="form-control" placeholder="BS Time"  /><input type="hidden" id="dvisitdate" class="form-control" placeholder="vd"/></div></div>
																	<div class="col-md-2 col-xs-2"><div ><label for="dbmi">BMI</label><input type="text" id="dbmi" class="form-control" placeholder="BMI" inputType="DECIMAL"  decimal="2" mandatory="1" disabled  maxlength="5" onkeydown='return validate(this,event)'/><label for="bmi" style="font-size: 80%"  class=" text-muted" ></label></div>  </div>
																</div>
															</div>
														
															<div class="col-md-12  mt-3">
																<div class="col-md-12 col-xs-12">
																	<div class="col-md-12 col-xs-12">
																	<textarea id="diagnosenotes" class="form-control" data-role="none" ></textarea>
																	<br/>
																	<textarea id="diagnosenotes1" class="form-control" data-role="none" col='200' row='75' style="min-height:200px!important;min-width:200px"></textarea>
																	<input type="hidden" id="pdnid" value="0"/>
																	</div>
																	<div class="col-md-12 col-xs-12">
																		<button class="btn  mt-3" style="background-color: #0095e2;color: white;" type="button" onclick="app.saveDiagnose()" data-toggle="dropdown">Save</button>
																	</div>
																</div>  
															</div>
														</div>

														<div class="col-md-6">
															<div class="listTp " id="historylist" >
																	  <div class="col-md-12 col-xs-12 mpZ borBot1 borBot2 " >
																	<div class="col-md-12 col-xs-12">
																		<h3 class="prhead1"></h3>
																		<div id="previous_1">
																			asfnsfjbsfb sf
																			sf,sm f sg
																			sgsgn sm gsg
																			sglsngdlksdn
																		</div>
																	</div>
																 	  </div>
																	  <div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																	<div class="col-md-12 col-xs-12">
																		<h3 class="prhead1"></h3>
																		<div id="Div1">
																			asfnsfjbsfb sf
																			sf,sm f sg
																			sgsgn sm gsg
																			sglsngdlksdn
																		</div>
																	</div>
																	  </div>
																 	  <div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																	<div class="col-md-12 col-xs-12">
																		<h3 class="prhead1"></h3>
																		<div id="Div2">
																			asfnsfjbsfb sf
																			sf,sm f sg
																			sgsgn sm gsg
																			sglsngdlksdn
																		</div>
																	</div>
																      </div>
															</div> 
														</div>

													</div>
												</div>
												</div>
										<!-- TAB 1 END-->
										<!-- TAB 2-->								
												<div class="tab-pane fade " id="nav-testunit"  role="tabpanel" aria-labelledby="nav-testunit-tab" tabindex="1">	
													<div  id="tests" style="height:400px;display:blononeck">

														<div class="row">
																<div class="col-md-4 col-xs-4"  >
																	<div class="col-md-12 col-xs-12 mpZero " style=" border-bottom: 1px solid #d4d4d4;height:50px">
																		Test Units
																	</div>
																	<div class="col-md-12 col-xs-12 mt-3" data-role="none" name="adjhgt" >
																		<div class="col-md-12 col-xs-12" name="adjmhgt" style="min-height:450px" id="bunames">
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2  " onclick="app.showBUItems()">
																				<div class="col-md-12 col-xs-12 ">
																						<h3 class="prhead1 ">BU1</h3>
																						<div> </div>
																				</div>
																			</div>
																			<!-- <div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																				<div class="col-md-12 col-xs-12">
																				<h3 class="prhead1">BU1</h3>
																				<div> </div>
																				</div>
																			</div>
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																				<div class="col-md-12 col-xs-12">
																				<h3 class="prhead1">BU1</h3>
																				<div> </div>
																				</div>
																			</div>
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																				<div class="col-md-12 col-xs-12">
																				<h3 class="prhead1">BU1</h3>
																				<div> </div>
																				</div>
																			</div>
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																				<div class="col-md-12 col-xs-12">
																				<h3 class="prhead1">BU1</h3>
																				<div> </div>
																				</div>
																			</div>
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																				<div class="col-md-12 col-xs-12">
																				<h3 class="prhead1">BU1</h3>
																				<div> </div>
																				</div>
																			</div>
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																				<div class="col-md-12 col-xs-12">
																				<h3 class="prhead1">BU1</h3>
																				<div> </div>
																				</div>
																			</div>
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																				<div class="col-md-12 col-xs-12">
																				<h3 class="prhead1">BU1</h3>
																				<div> </div>
																				</div>
																			</div>
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																				<div class="col-md-12 col-xs-12">
																				<h3 class="prhead1">BU1</h3>
																				<div> </div>
																				</div>
																			</div> -->
																			
																		</div>
																	</div>    					
																</div>

																<div class="col-md-8"  id="bitemsearch">
																	<div class="row" style="border-bottom: 1px solid #d4d4d4;height:50px">
																		<div class="col-md-6 borBot">
																			Test Items :&nbsp; <b><span id="buname" ></span></b> </span>	 
																		</div>
																		<div class="col-md-6">
																			<button class="btn btn-default p-1 mb-1 bg-light" style="float: right" onclick="app.showSelectedItems()"><span class="mdi mdi-format-list-checkbox">Selected Tests</span></button>
	                                                                    </div>
																	</div>
																	<div class="row mt-3">
																		<div class="col-md-2">
																			<label for="buitemssearch">SEARCH  </label>	 
																		</div>
																		<div class="col-md-6">
																			<input id="buitemsearch" type="text" class="form-control" onkeydown="app.testSearchKeyDown(event,this)"/>
																		</div>
																		<div class="col-md-4">
																			<span class="mdi mdi-magnify" onclick="app.searchBUItems()"></span><input type="hidden" id="bucode"/> 
																		</div>
																	</div>
																	<div class="row mt-3">
																		<div class="col-md-12 " name="adjbihgt"  id="buitems"></div>
																	</div>
																</div>

																<div class="col-md-8"  id="selectedtests" style="display:none">
																	<div class="row" style="border-bottom: 1px solid #d4d4d4; padding: 5px;height:50px">
																		<div class="col-md-6 borBot">
																			Selected Tests
																		</div>
																		<div class="col-md-6 text-right">
																			<button class="btn " style="background-color: #a7bec8;color: white;" onclick="app.showSearchItems()"><span class="mdi mdi-arrow-left me-2">Back to Test Listing</span></button>
																		    <button class="btn " style="background-color: #0095e2;color: white;"   onclick="app.confirmTests()"><span class="mdi mdi-check-circle-outline me-2">Confirm Tests</span></button>    							    					
																	
	                                                                    </div>
																	</div>
																	<div class="row mt-3">
																		<div class="listTp" id="buitemslist" style=" margin-left:20px;margin-right:20px;">
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																			<div class="col-md-11 col-xs-11">
																				  <h3 class="prhead1">BU Item 1</h3>
																				  <div id="Div3">
																					  Notes 1
																				  </div>
																			  </div>
																			  <div class="col-md-1 col-xs-1">
																				  <span class="ti-trash"></span>
																			  </div>
																			  </div>
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																			<div class="col-md-11 col-xs-11">
																				  <h3 class="prhead1">BU Item 2</h3>
																				  <div id="Div4">
																					  Notes 2
																				  </div>
																			  </div>
																			  <div class="col-md-1 col-xs-1">
																				  <span class="ti-trash"></span>
																			  </div>
																			  </div>
																			<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">
																			<div class="col-md-11 col-xs-11">
																				  <h3 class="prhead1">BU Item 3</h3>
																				  <div id="Div5">
																					  Notes 3
																				  </div>
																			  </div>
																			  <div class="col-md-1 col-xs-1">
																				  <span class="ti-trash"></span>
																			  </div>
																			  </div>
																		</div> 
																	</div>
																</div>

														</div>
													</div>
												</div>
										<!-- TAB 2 END-->
										<!-- TAB 3-->
												<div class="tab-pane fade" id="nav-Prescription" role="tabpanel" aria-labelledby="nav-Prescription-tab" tabindex="2" >
													<div class="" id="prescription" style="height:400px;display:none">

														<div class="row">
															<div class="col-md-8 col-xs-8" >
																<div class="row" style="border-bottom: 1px solid #d4d4d4;height:45px">
																	<div class="col-md-6 borBot mt-3">
																		Medicines 
																	</div>
																	<div class="col-md-6"></div>
																</div>

																<div class="row mt-3">
																	<div class="col-md-3 col-xs-2 text-right">
																		<select id="searchtype" class="form-control form-select">
																			<option value='medicine'>Medicine</option>
																			<option value='generic'>Generic</option>
																		</select>
																	</div>
																	<div class="col-md-7 col-xs-7">
																		<input id="medicinesearch" type="text" class="form-control" onkeydown="app.medicineSearchKeyDown(event,this)"/>
																	</div>
																	<div class="col-md-1 col-xs-1 text-center">
																		<span class="mdi mdi-magnify"  data-role="none"  onclick="app.constructMedicineItemsLov()"></span>
																	</div>
																</div>

																<div class="row mt-3">
																	<div class="col-md-12 col-xs-12 mpZero" data-role="none" name="adjhgt" style="overflow:auto">
																		<div class="col-md-11 col-xs-11" name="adjmhgt" id="doctormedicines" >

																		</div>
																	</div>
																</div>
															</div>

															

															<div class="col-md-4"  id="selectedtests" style="display:block">
																<div class="col-md-12" style="border-bottom: 1px solid #d4d4d4;height:45px">
																
																	<div class="row">
																		<div class="col-md-6 borBot">
																			Selected Medicines 	
																		</div>
																		<div class="col-md-6 text-right">
																			<button class="btn btn-success " onclick="ShowConfirmMedicine()"><span class="mdi mdi-eye mr-r">Preview</span></button>
																			<button class="btn " style="background-color: #0095e2;color: white;"  onclick="app.confirmMedicines()"><span class="mdi mdi-check-circle-outline mr-1">Confirm </span></button>    							    					
																	
																		</div>
																	</div>
																	<div class="row" >
																		<div class="listTp" id="medicineslist" >	
	
																		</div>
																	</div>

																</div>
																
															</div>
														</div>

													</div>
												</div>
										<!-- TAB 3 END-->			
										<!-- TAB 4-->									
												<div class="tab-pane fade" id="nav-next" role="tabpanel" aria-labelledby="nav-next-tab"tabindex="3">
													<div  id="fees" style="height:400px;display:none">

														<div class="row">
															<div class="col-md-12">

																<div class="col-md-6 col-xs-6">
																	<label for="dfees">Fees</label>
																	<input type="text" id="dfees" class="form-control mt-2" placeholder="Fees" inputType="NUMERIC"  decimal="0" mandatory="0"   maxlength="5" onkeydown='return validate(this,event)'/>
																</div>
																<div class="col-md-6 col-xs-6 mt-3">
																	<label for="dfeestatus">Fee Status</label>
																	<select class="form-control form-select mt-2" data-role="none" id="dfeestatus"><option value='0'>Pending</option><option value='1'>Received</option></select>
																</div>
																<div class="col-md-6 col-xs-6 mt-3">
																	<label for="nextvisit">Next Visit</label>
																	<input type="text" id="dnextvisit" class="form-control mt-2" placeholder="Number of Days" inputType="NUMERIC"  decimal="0" mandatory="0"   maxlength="3" onkeydown='return validate(this,event)'/>
																</div>

															</div>
															<div class="col-md-6 col-xs-6 mt-3">
																<button class="btn  mt-3" style="background-color: #0095e2;color: white;"  type="button" onclick="app.saveFees()" data-toggle="dropdown">Save</button>
															</div>
														</div>


														
													</div>			
												</div>
										<!-- TAB 4 END-->
										<!-- TAB 5 -->
												<div class="tab-pane fade" id="nav-pharmacy" role="tabpanel" aria-labelledby="nav-pharmacy-tab" tabindex="4">
													<div class="col-md-12 col-sm-12 mpZero" id="nextvisit" style="height:400px;display:block">
														Next Visit
													</div>
													
												</div>
										<!-- TAB 5 END-->												
												
											</div>
										</div>

										<div class="card-footer">
											<div class="tab-content" >
												<div class="row w-100 mt-3">
													<div class="col-md-8"></div>
													<div class="col-md-4 " >
														<div class="hstack justify-content-end">
														<div id="actButton">
															<div class="mb-3 " >
																<button id="btnCancel" class="btn " style="background-color: #a7bec8;" type="button" onclick="hideMasterData()">Cancel</button>
															</div>
														</div>
														</div>
													</div>
													
												</div>
											</div>
										</div>
									</div>

								<!--TABS ENDS -->

							</div>
						</div>
						<!-- ID CALLBACK END-->


				</div>
			</div>

		</div>
	</div>

	<!-- MODAL  START-->
	<div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog modal-lg">
	    
	      <!-- Modal content-->
	      <div class="modal-content">
	        <div class="modal-header">
				<h4 class="modal-title" id="modHeader"></h4>
	            <button type="button" class="close" onclick="cancelPreviewDlg()" data-dismiss="modal">&times;</button>
	        </div>
	        <div class="modal-body" style="min-height:500px;">
	          <div class="col-md-12 col-xs-12" id="preselectedtests"  ></div>
	        </div>
	        <div class="modal-footer">
	          <button class="btn"  style="background-color: #0095e2;color: white;"  type="button" id="btnConfirmMed" style="display:none"  data-dismiss="modal" onclick="app.confirmMedicines()">Confirm</button>
	          <button type="button" onclick="cancelPreviewDlg()" class="btn" style="background-color: #a7bec8;"  data-dismiss="modal" >Close</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
	<!-- MODAL END -->
  
	
	<script type="text/javascript" src="app/prescription/js/index.js"></script>	
	<script>
	// Tab  change 
			$("#nav-tab button ").click(function() {
			$("#nav-tab button").removeClass('active');
			$(this).addClass('active');
					});

	//MODAL HIDE
	
	function cancelPreviewDlg(){
	 	$('#myModal').modal('hide');
	 } 

	var s=new FlexUI.Ajax();
	var r=s.callAjax("GET","/waggle/service/ajax","&ic=0&ro=true&id=getlogindoctor");
	$('#drname').text(r.data[0].dr_name);
	$('#drcode').val(r.data[0].dr_code);
	userCode=r.data[0].dr_code;
	doctorName=r.data[0].dr_name;
	$('#fromdate').datepicker({
				language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy'
	});
	if($('#fromdate').val()==""){
		var cd=new Date();
		$('#fromdate').datepicker("setDate",cd);
	}
	$('#todate').datepicker({
				language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy'
	});			
	if($('#todate').val()==""){
		var cd=new Date();
		$('#todate').datepicker("setDate",cd);
	}	
    $(document).ready(function () {
            $('#subtitle').text("");
            $('#screentitle').text("Bills");
            // $('[name="adjhgt"]').css("height",($(window).height()-350)+"px");
            // $('[name="adjmhgt"]').css("min-height",($(window).height()-430)+"px");
            // $('[name="adjbihgt"]').css("min-height",($(window).height()-430)+"px");
     });
    jqReport(300014,"#xyz","&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&drcode="+$('#drcode').val(),);

  	function toggleHeaderRow(){
  		toggleSearchToolBar(300014);
  	}
  
  	toggleHeaderRow();
	 function reportGo(id){
		showLoader();
		var newParams="&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&drcode="+$('#drcode').val();
		changeUrlAndReloadGrid(id,"",newParams);	
		hideLoader();
	}
		function clearScreen(){
		}
	    function addMasterData(){
	    	clearScreen(); 
  			$('#callback').css('display','block');
  			$('#xyz').css('display','none');
  			$('#addGrp').css('display','none');
  		}
  
  		function hideMasterData(){
  			clearScreen();
  			$('#callback').css('display','none');
  			$('#xyz').css('display','block');
  			$('#addGrp').css('display','block');
  			reloadGrid(300014);  			
  		}
  		function loadOrderData(url,name,did){
  			addMasterData();
  			var rowData=$("#report_300014").getRowData(did);  			
	    	$('#dpatientname').text(rowData.prm_name);
	    	$('#dpatientcode').val(rowData.prm_code);
	    	$('#dcustcode').val(rowData.prm_ref_code);
	    	$('#dgender').text(rowData.prm_gender);
	    	$('#dheight').text(rowData.app_patient_height);
	    	$('#dage').text(rowData.prm_age);
	    	$('#dappid').val(rowData.app_id);
	    	//ap.app_patient_height,ap.app_patient_weight,ap.app_patient_bp,ap.app_patient_temp,ap.app_patient_pr,ap.app_patient_bp,ap.app_patient_bs
	    	$('#dtemperature').val(rowData.app_patient_temp);
	    	$('#dweight').val(rowData.app_patient_weight);
	    	$('#dbp').val(rowData.app_patient_bp);
	    	$('#dbs').val(rowData.app_patient_bs);
	    	$('#dpr').val(rowData.app_patient_pr);
	    	$('#dvisitdate').val(rowData.dvm_date);
	    	$('#ovisit').text(rowData.dvm_date);
	    	$('#dbstime').val(rowData.prmbstime);
	    	$('#dbmi').val(rowData.prm_bmi);
	    	app.showDiagnose($('#dctopnav').find("li").eq(0));  			
  		}
  		
  		function ShowPreviousTests(appid,patientcode){
  			//$('#myModal').style.display = "block";
  			$( "#myModal" ).modal('show');
  			$('#modHeader').html("Tests");
  			var v=app.callAjax("GET","/waggle/service/prescription/patienttests","page=1&rows=100&appid="+appid+"&doctorcode="+userCode+"&patientcode="+patientcode+"&hospitalcode=1","");
	    	var s=v.rows.length;
	    	var action="";  
	    	$('#btnConfirmMed').css("display","none");
	    	var vl=$('#preselectedtests');  	
	    	$('#preselectedtests').children().remove();
	    	for(var i=0;i<s;i++){
	    		    vl.append('<div class="col-md-12 col-xs-12 mpZero borBot1 borBot2">'+
						  '<div class="col-md-11 col-xs-11">'+
      					  '<h3 class="prhead1">'+v.rows[i].buim_itemname+'</h3>'+
      					  '<div>'+v.rows[i].bum_buname+'</div>'+
      					  '<div>'+v.rows[i].pci_notes+
      					  '&nbsp;&nbsp;</div>'+
      					  '</div>'+
      					  '<div class="col-md-1 col-xs-1">'+
      					  '<button type="button" class="btn btn-info" id="btnBuItemAdd_'+v.rows[i].pci_test_code+'" onclick="app.saveBUItem('+v.rows[i].buim_code+')">Add</button>'+
      					  '</div>'+
      					  '</div>');
      			

	    	} 
  			
  		}
  		function ShowConfirmMedicine(){
  			//$('#myModal').style.display = "block";
  			$( "#myModal" ).modal('show');
  			$('#modHeader').html("Prescription");
  			var v=app.callAjax("GET","/waggle/service/screen/data?screencode=300013&appid="+$('#dappid').val());
	    	var s=v.mitems_data.length;
	    	var action="";  
	    	
	    	$('#btnConfirmMed').css("display","inline-block");
	    	var vl=$('#preselectedtests');  	
	    	$('#preselectedtests').children().remove();
	    	
	    	vl.append("<div style='border-bottom:1px solid #eee;padding-bottom:5px;' class='row'><div class='col-md-1'>S.No</div><div class='col-md-3'>Item Name</div><div class='col-md-1'>Total</div><div class='col-md-2'>Morning</div><div class='col-md-2'>After Noon</div><div class='col-md-2'>Evening</div><div class='col-md-1'>Night</div></div>");
	    	
	    	for(var i=0;i<s;i++){
	    		  vl.append("<div style='border-bottom:1px solid #eee;padding-bottom:5px;' class='col-md-12'><div class='col-md-1'>"+(i+1)+"</div><div class='col-md-5'>"+v.mitems_data[i].productname+"</div><div class='col-md-1'>"+v.mitems_data[i].total+"</div><div class='col-md-1'>"+getNumber(v.mitems_data[i].pdp_course1,v.mitems_data[i].suffix)+"</div><div class='col-md-2'>"+getNumber(v.mitems_data[i].pdp_course2,v.mitems_data[i].suffix)+"</div><div class='col-md-1'>"+getNumber(v.mitems_data[i].pdp_course3,v.mitems_data[i].suffix)+"</div><div class='col-md-1'>"+getNumber(v.mitems_data[i].pdp_course4,v.mitems_data[i].suffix)+"</div></div>");

	    	} 
  		}
  		function getNumber(val,suffix){
  		var res="-";
	  		if(Number(val)>0){
	  			res=Number(val)+suffix;
	  		}
	  		return res;
  		}
  		function ShowTestResults(branch,code){
  			var url="/waggle/service/discharge/printlabbill?branchcode="+branch+"&billno="+code;
				window.open(url,"_blank");
  		}
  		function ShowPreviousPrescription(appid,patientcode){
			
  			//$('#myModal').style.display = "block";
  			$('#btnConfirmMed').css("display","none");
  			var vl=$('#preselectedtests');
  			var v=app.callAjax("GET","/waggle/service/prescription/patientmedicines","page=1&rows=100&appid="+appid+"&doctorcode="+userCode+"&patientcode="+patientcode+"&hospitalcode=1","");
	    	var s=v.rows.length;
	    	var action="";    	
	    	$('#preselectedtests').children().remove();
	    	if(s>0){
	    		$('#modHeader').html("Prescriptions - Dt: "+v.rows[0].pdp_date);
	    	}else{
	    		$('#modHeader').html("Prescriptions");
	    	}
	    	for(var i=0;i<s;i++){
    		    vl.append('<div class="col-md-12 col-xs-12 mpZero borBot1 borBot2">'+
						  '<div class="col-md-8 col-xs-8 mpZero">'+
      					  '<h3 class="prhead1">'+v.rows[i].productname+'</h3>'+
      					  '<div class="prTxt">'+v.rows[i].genericname+'</div>'+
      					  '<div class="prTxt"><span>'+v.rows[i].pdp_course1+'-'+v.rows[i].pdp_course2+'-'+v.rows[i].pdp_course3+'-'+v.rows[i].pdp_course4+'&nbsp;&nbsp;<span class="badge">'+v.rows[i].pdp_ABMeal+'</span></div>'+
      					  '</div>'+
      					  '<input type="hidden" id="pc1_'+v.rows[i].pdp_medicine_code+'" value="'+v.rows[i].pdp_course1+'">'+
      					  '<input type="hidden" id="pc2_'+v.rows[i].pdp_medicine_code+'" value="'+v.rows[i].pdp_course2+'">'+
      					  '<input type="hidden" id="pc3_'+v.rows[i].pdp_medicine_code+'" value="'+v.rows[i].pdp_course3+'">'+
      					  '<input type="hidden" id="pc4_'+v.rows[i].pdp_medicine_code+'" value="'+v.rows[i].pdp_course4+'">'+
      					  '<input type="hidden" id="pam_'+v.rows[i].pdp_medicine_code+'" value="'+v.rows[i].pdp_ABMeal+'">'+
      					  '<input type="hidden" id="pnod_'+v.rows[i].pdp_medicine_code+'" value="'+v.rows[i].pdp_numbers+'">'+
      					  '<input type="hidden" id="pmedtype_'+v.rows[i].pdp_medicine_code+'" value="'+v.rows[i].pdp_medtype+'">'+
      					  '<input type="hidden" id="pmedtypeid_'+v.rows[i].pdp_medicine_code+'" value="'+v.rows[i].pdp_medtype+'">'+
      					  '<input type="hidden" id="phidecourse_'+v.rows[i].pdp_medicine_code+'" value="'+v.rows[i].pct_hidecourse+'">'+
      					  '<input type="hidden" id="ptot_'+v.rows[i].pdp_medicine_code+'" value="'+v.rows[i].pdp_total+'">'+
      					  '<div class="col-md-3 col-xs-3 text-right mpZero">'+
      					  '<span class="badge">'+v.rows[i].pdp_numbers+'</span>&nbsp;&nbsp;&nbsp;'+
      					  '<button class="btn btn-info ui-btn ui-shadow ui-corner-all" type="button" onclick="app.addPreviousMedicineItem('+v.rows[i].pdp_medicine_code+')">Add</button>'+
      					  '</div>'+
      					  '<div class="col-md-12 col-xs-12 mpZero  ">Note : '+v.rows[i].pdp_ifreqnotes+'</div>'+
      					  
      					  '</div>');
    		}  
    	$( "#myModal" ).modal('show'); 
  			
  		}
		function CloseDialog(){
		   
		}
		
    	function loadDoctorList(){
	    	var vl=$('#doclist');
	    	var v=app.callAjax("GET","/waggle/service/ajax","ic=0&id=consultdoctors");
	    	var s=v.data.length;
	    	var action="";    	
	    	$('#doclist').children().remove();
	    	for(var i=0;i<s;i++){
	    		if(v.data[i][1]!=$('#drcode').val()){
	    			vl.append('<option value="'+v.data[i][1]+'">'+v.data[i][0]+'</option>');
	    		}
	    	}
    	}
    	loadDoctorList();
  </script>
</body>
</html>