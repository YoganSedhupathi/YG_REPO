<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>

  <!-- <style>
	.form-control:focus {
  border-color: #66afe9;
  outline: 0;
  -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
          box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
}
</style> -->

</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String status=request.getParameter("status");
%>

<body>
	<div id="branchcontainer" class="brTp" style="display:none;z-index:999">
		<select class="form-control" id='branch' onchange="changeBranchCodeAndClearSubScreenData()"></select>
    </div>

	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Admission</h4>
				</div>
				<div  class="col-md-6 text-right" id="addGrp">
					<div class="mb-3">
						<button type="button" class="btn btn-edit" onclick='addMasterData()'><span class="mdi mdi-plus-box">New Admission</span></button>
						<button type="button" class="btn btn-clear" onclick='toggleHeaderRow()'><span class="mdi mdi-filter">Search</span></button>
					</div>
				</div>
				<div  class="col-md-6 text-right" id="saveGrp" style='display:none'>
					<div class="mb-3">
					<button id="btnsave" type="button" class="btn btn-edit" onclick='saveAdmission()'><span class="mdi mdi-check-circle-outline me-2">Save</span></button>
					<button id="btnClear" type="button" class="btn btn-clear" onclick='hideMasterData()'><span class="mdi mdi-refresh me-2">Cancel</span></button>
					</div>
				</div>
			</div>
			<div class="row " id="jqcontainer" ><div class="table-container" ><div id="xyz" class="w-100"></div></div></div>	
			<div id="callback" class="row lpage" style="display:none;">
				
					<div id='container'class="table-container">			
						
						<div>
						<div class="table-container">
						<div class="bline"><h6>Patient Details</h6></div>	
						<div class="row w-100" id="patientsearchcont">
							
							<div class="col-md-6">
								<div class="form-group mbotto">
									<div class="col-md-3"><label for="searchpatient" class="form-lable">Search By </label></div>
									<div class="col-md-2"><select class="form-select" id="searchpatient"><option value="regno">Reg No</option><option value="mobile">Mobile No</option></select></div>
									<div class="col-md-7"><input type="text" class="form-control" id="smobileno"/></div>
								</div>
							</div>
							<div  class="col-md-6" id="ipnodisp" style="display:none">		
								<div class="form-group mbotto">
									<div class="col-md-4"><label>IP No</label></div>
									<div class="col-md-8"><label id="ipnod"></label></div>
								</div>
							</div>
						</div>
						<div class="row w-100">
							<div class="col-md-6" id="patientcont">
								<div class="form-group mbotto">
									<div class="col-md-3" id="npatient"><label class="form-lable">Patient Name *</label></div>
									<div class="col-md-2"><select class="form-control" id="prefix"></select></div>
									<div class="col-md-7" id="npatientv"><input type="text" class="form-control" id="patientname"><input type="hidden" class="form-control" id="code"><input type="hidden" class="form-control" id="branchcode" value="1"><input type="hidden" class="form-control" id="ipno"><input type="hidden" class="form-control" id="refcode"><input type="hidden" class="form-control" id="hospregcode"><input type="hidden" class="form-control" id="bucode"><input type="hidden" class="form-control" id="claimno"></div>
								</div>
							</div>
							<div  class="col-md-6" id="ipnodisp">		
								<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Age*</label></div>
									<div class="col-md-2"><input type="text" class="form-control" id="patientage"></div>
									<div class="col-md-2"><select class="form-select" id="agetype"></select></div>
									<div class="col-md-2"><label class="form-lable">Gender</label></div>
									<div class="col-md-2"><select class="form-select" id="gender"></select></div>
								</div>
							</div>								
						</div>


					</div>	
							
					</div>	

							

					<div>
						<div class="table-container">
						<div class="bline"><h6>Admission Details</h6></div>		
						
							<div class="row w-100">
									<div class="col-md-6 col-sm-6 mpZero">
										<div class="form-group mbotto">
											<div class="col-md-3"><label class="form-lable">Consulting Doctor </label></div>
											<div class="col-md-9"><input  type="text" class="form-control " id="consultingdr"/><input type="hidden" class="form-control" id="doctorcode"/></div>
										</div>
									</div>
									<div class="col-md-6 col-sm-6 mpZero">
										<div class="form-group mbotto">
											<div class="col-md-3"><label class="form-lable">Referred By</label></div>
											<div class="col-md-9"><input  type="text" class="form-control" id="referredby"><input type="hidden" class="form-control" id="referralcode"></div>
										</div>
									</div>
								


									<div class="col-md-6 col-sm-6 mpZero">
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Is MLC ?</label></div>
									<div class="col-md-3"><select class="form-control" id="ismlc"></select></div>
									<div class="col-md-3"><label class="form-lable ml-8">Account Type</label></div>
									<div class="col-md-3"><select class="form-control" id="accounttype"></select></div>	
									
									</div>
									</div>													
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Admission Date</label></div>
									<div class="col-md-9"><input type="text" class="form-control" id="admissiondate"></div>
									</div>
									</div>					
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									
									<div class="col-md-3"><label class="form-lable">Room No</label></div>
									<div class="col-md-3"><input type="text" class="form-control" id="roomno"><input type="hidden" class="form-control" id="roomcode"></div>
									<div class="col-md-3"><label class="form-lable ml-8">Ward</label></div>
									<div class="col-md-3"><label id="wardno"></label><input type="hidden" class="form-control" id="wardcode"></div>
									</div>
									</div>					
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-3"><label class="form-lable">Admission Type</label></div>
										<div class="col-md-9"><input type="text" class="form-control " id="admissiontype"><input type="hidden" class="form-control" id="admissiontypecode"></div>
									</div>
									</div>
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Advance Amount</label></div>
									<div class="col-md-9"><input type="text" class="form-control form-control-lg" id="advanceamt"></div>
									</div>
									</div>
								</div>
								<div class="col-md-6 col-sm-6 mpZero">
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Gaurdian</label></div>
									<div class="col-md-2"><select class="form-control" id="guardiantype"></select></div>
									<div class="col-md-7"><input type="text" class="form-control" id="guardianname"></div>
									</div>
									</div>	
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Address</label></div>
									<div class="col-md-9"><input type="text" class="form-control" id="address1"></div>
									</div>
									</div>	
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable"> </label></div>
									<div class="col-md-9"><input type="text" class="form-control" id="address2"></div>
									</div>
									</div>	
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable"></label></div>
									<div class="col-md-9"><input type="text" class="form-control" id="address3"></div>
									</div>
									</div>	
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Mobile No.</label></div>
									<div class="col-md-9"><input type="text" class="form-control" id="mobileno"></div>
									</div>
									</div>																	
								</div>
							</div>
						</div>
					</div>

					<div>
						<div class="table-container">
						<div class="bline"><h6>Insurance Details</h6></div>	
							<div class="row w-100">
								
								<div class="col-md-6 col-sm-6 mpZero">
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable" >Corporate</label></div>
									<div class="col-md-9"><input type="text" class="form-control" id="sponsorname"><input type="hidden" class="form-control" id="sponsorcode"></div>
									</div>
									</div>
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Card No</label></div>
									<div class="col-md-9"><input type="text" class="form-control" id="sponsorcardno"></div>
									</div>
									</div>					
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Approval No</label></div>
									<div class="col-md-9"><input type="text" class="form-control" id="sponsorapprovalno"></div>
									</div>
									</div>
								</div>
								<div class="col-md-6 col-sm-6 mpZero">
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Requested Amount</label></div>
									<div class="col-md-9"><input type="text" class="form-control" id="sponsorreqamt"></div>
									</div>
									</div>															
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Approval Status</label></div>
									<div class="col-md-9"><select class="form-control" id="sponsorappstatus"></select></div>
									</div>
									</div>
									
									<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
									<div class="col-md-3"><label class="form-lable">Approval Amount</label></div>
									<div class="col-md-9"><input type="text" class="form-control" id="approvedamt"></div>
									</div>
									</div>																																						
								</div>
					
								
							</div>
							</div>
							</div>
							
					</div>
					
					
					   </div>  <!-- Pannel Box1 -->	
					</div> <!-- Container -->
				</div>	
			
			</div>
		</div>
		</div>



		


	
	<div id='inspatienttestdlg' class='modal'>
		<div class="modal-dialog modal-lg  modal-dialog-scrollable">
		  <div class="modal-content">
				<div id='inspatienttitle' class='modal-header'>
					<div class='pop_lov_hed_txt'><span id="patientno"></span></div>
					<button type="button" class="btn-close" onclick="cancelCancelPatientDlg()" data-bs-dismiss="modal"></button>
				</div>
				<div class='modal-body'>
					<div class="col-md-12 col-sm-12 mpZero" id='inspatientd'>
						<h1>No Tests</h1>
					</div>
				</div>
				<div id="actButton" class="modal-footer">
					<button id="btnCancel" class="btn btn-default btn-outline-dark" type="button" onclick="cancelCancelPatientDlg()">Close</button>
				</div>
		  </div>
		</div>
	</div>

	<div id='inspatientdiscountdlg' class='modal'>
		<div class="modal-dialog modal-dialog-scrollable">
		  <div class="modal-content">
				<div id='inspatienttitle' class='modal-header'>
					<div class='pop_lov_hed_txt'><span id="patientno"></span> <h3>Discount </h3></div>
					<button type="button" class="btn-close" onclick="cancelDiscountDlg()" data-bs-dismiss="modal"></button>
				</div>
				<div class='modal-body'>
					<div class="col-md-12 col-sm-12 mpZero" >
						<h5>Discount Amount</h5>
						<div class="col-md-8"><input type="text" class="form-control" id="discountamount"></div>
					</div>
				</div>
				<div id="actButton" class="modal-footer">
					<button  class="btn btn-primary" type="button" onclick="updateDiscountDlg()">Save</button>
					<button  class="btn btn-default" type="button" onclick="cancelDiscountDlg()">Cancel</button>
				</div>
		  </div>
		</div>
	</div>
	

	
    <script>
     var ajaxObj=new FlexUI.Ajax();
 	loadBranchData();
 	jqReport(14,"#xyz","&branchcode="+$('#branch').val()+"&status=<%=status%>"); 	
    var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[{name:"code",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"bucode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"refcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"claimno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"hospregcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"smobileno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"patientname",validation:"checkPatientExists"},  	
  	{name:"ipno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"prefix",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"Mr","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"patientname",values:"Mr~Mrs~Ms~Miss~Master",keys:"Mr~Mrs~Ms~Miss~Master"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"Patient Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"INT",caption:"Age",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"agetype"},
  	{name:"agetype",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"Yrs","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"gender",values:"Yrs~Month",keys:"Yrs~Month"},
  	{name:"gender",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"accounttype",values:"M~F",keys:"Male~Female"},
  	{name:"consultingdr",inputType:0,type:"LOV",caption:"Consulting Doctor",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"referredby",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"doctorcode",tt:false,id:"dr_code"},{tgt:"consultingdr",tt:false,id:"dr_name"},{tgt:"consultingdr",tt:true,id:"dr_name"},{tgt:"referralcode",tt:false,id:"dr_code"},{tgt:"referredby",tt:false,id:"dr_name"},{tgt:"referredby",tt:true,id:"dr_name"}]}},
  	{name:"referredby",inputType:0,type:"LOV",caption:"Referred by",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"admissiondate",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"referralcode",tt:false,id:"dr_code"},{tgt:"referredby",tt:false,id:"dr_name"},{tgt:"referredby",tt:true,id:"dr_name"}]}},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"admissiontype"},
  	{name:"ismlc",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"consultingdr",values:"0~1",keys:"No~Yes"},
    {name:"accounttype",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"ismlc",values:"1~2",keys:"Self~Cashless",onchange:"accountTypeChange"},
	{name:"admissiondate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"roomno"},
	{name:"roomno",inputType:0,type:"LOV",caption:"Room No",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"guardiantype",lovOptions:{url:"/waggle/service/ajax",ajax:"rooms",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branchcode",src:"branchcode",tt:false}],results:[{tgt:"roomno",tt:false,id:"rm_roomname"},{tgt:"roomno",tt:true,id:"rm_roomname"},{tgt:"roomcode",tt:false,id:"rm_code"},{tgt:"wardno",tt:false,id:"wm_wardname"},{tgt:"wardcode",tt:false,id:"rm_wardcode"}]}},
	{name:"admissiontype",inputType:0,type:"LOV",caption:"Admission Type",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"admissiondate",lovOptions:{url:"/waggle/service/ajax",ajax:"admissiontype",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"admissiontypecode",tt:false,id:"at_code"},{tgt:"admissiontype",tt:false,id:"at_name"},{tgt:"admissiontype",tt:true,id:"at_name"}]}},
	{name:"advanceamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"guardiantype"},	  	
	
	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"admissiontypecode",inputType:0,type:"INT",caption:"Admissiontype code",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"admissiontype"},
  	{name:"roomcode",inputType:0,type:"INT",caption:"Room No",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"roomno"},
  	{name:"guardiantype",inputType:1,type:"TEXT",caption:"Guardian type",mandatory:true,defaultValue:"S/o","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"guardianname",values:"S/o~D/o~H/o~W/o~C/o~M/o~F/o",keys:"S/o~D/o~H/o~W/o~C/o~M/o~F/o"},
	{name:"guardianname",inputType:0,type:"TEXT",caption:"Guardian Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"address1"},  	
	{name:"address1",inputType:0,type:"TEXT",caption:"Address",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"address2"},
	{name:"address2",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"address3"},
	{name:"address3",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"mobileno"},
	{name:"mobileno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"sponsorname"},
	{name:"sponsorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsorname"},
  	{name:"sponsorname",inputType:0,type:"LOV",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"sponsorcardno",lovOptions:{url:"/waggle/service/ajax",ajax:"insurancecompany",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"sponsorname",tt:false,id:"icm_name"},{tgt:"sponsorname",tt:true,id:"icm_name"},{tgt:"sponsorcode",tt:false,id:"icm_code"}]}},
  	{name:"sponsorcardno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"sponsorapprovalno"},
  	{name:"sponsorapprovalno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"sponsorreqamt"},
  	{name:"sponsorreqamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"sponsorappstatus"},
  	{name:"sponsorappstatus",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"approvedamt",values:"R~AD~A~D",keys:"Requested~Required Additional Details~Approved~Declined"},
  	{name:"approvedamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"btnSave"},
  	{name:"wardno",inputType:4,type:"SPAN",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:""},
	{name:"wardcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
	{name:"discountamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
	{name:"btnSave",inputType:3,caption:"",visible:false},
    {name:"btnClear",inputType:3,caption:"",visible:false}	  		
  	]}]};
	var admission=null;
	$('#screentitle').text("Admission");
    function saveAdmission(){
		
    	if(!checkApprovalNo()) return;
        if(admission.getSaveInProgress()) return;
        var hospRegCode=screenObjects.getScreenObject("hospregcode").getValue();
        if(hospRegCode=="0" || hospRegCode==""){
        	var regcode=saveRegistration();
        	if(regcode==""){
        		return;
        	}
        }     
    	var r=null;
    	var code=screenObjects.getScreenObject("code").getValue();
    	if(code!="" && code!="0"){
    		if(!checkPatientStatus(code)){
    			alert("Patient already discharged. Please exit the screen to continue");
    			return;
    		}
	    	admission.setOperation("MOD");
	    }else{
	    	admission.setOperation("ADD");
	    }
    	admission.setScreenCode(10);
    	var d=admission.processDataToSave();
    	admission.setSaveInProgress(true);
		if("FAILED"!=d){
			var s=new FlexUI.Ajax();
			showLoader();
			r=s.callAjax("POST","/waggle/service/screen/save",d);
			hideLoader();
		 }else{
		 	 admission.setSaveInProgress(false);
			 setErrorMessage(" Please correct the validation errors and continue...")   ;
		 	return;
		 }		 
		 if(r.result=="Success"){
			
			if(code!=0){
				setErrorMessage(r.message+" [No:"+code+"]")   ;
			}else{
				setErrorMessage(r.message+" [No:"+r.code+"]") ;
			}

			if(code=="" || code=="0"){
				var ps=JSON.parse(d.replace("data=","")).savedata;
				ps["billno"]=r.billno;
				printBill(ps,r.code);
			}
			clearInnerScreen();
			hideMasterData();
			return r.key;			
		}else{
			alert("inside 2");
			admission.setSaveInProgress(false);
			alert("ALERT"+" "+r.message);		
		}
    }
    function saveRegistration(){
		
	    admission.setOperation("ADD");
    	admission.setScreenCode(23);
    	var d=admission.processDataToSave();
    	admission.setSaveInProgress(true);
		if("FAILED"!=d){
			var s=new FlexUI.Ajax();
			showLoader();
			r=s.callAjax("POST","/waggle/service/screen/save",d);
			hideLoader();
		 }else{
		 	admission.setSaveInProgress(false);
		 	return;
		 }		 
		 if(r.result=="Success"){
		 	screenObjects.getScreenObject("hospregcode").setValue(r.code);
		 	screenObjects.getScreenObject("refcode").setValue(r.refcode);
			return r.code;		
				
		}else{
			admission.setSaveInProgress(false);
			alert("check"+" "+ r.message);
			return "";		
		}
    }
    function updateDiscountDlg(){
	    admission.setOperation("ADD");
    	admission.setScreenCode(200007);
    	var code=screenObjects.getScreenObject("code").getValue();
    	var data='data={"screencode":"200007","operation":"ADD","savedata":{';
    		data+='"discountamount":"'+screenObjects.getScreenObject("discountamount").getValue()+'",';
    		data+='"code":"'+code+'",';
    		data+='"branchcode":"'+screenObjects.getScreenObject("branchcode").getValue()+'"';    		
			data+='}';		
			data+='}';    	
    		admission.setSaveInProgress(true);
    	
    	
		if("FAILED"!=data){
			var s=new FlexUI.Ajax();
			showLoader();
			r=s.callAjax("POST","/waggle/service/screen/save",data);
			hideLoader();
		 }else{
		 	admission.setSaveInProgress(false);
		 	alert("Please correct the validation errors and continue...");
		 	return;
		 }		
		  
		 if(r.result=="Success"){
		 	alert(r.message);
		 	cancelDiscountDlg();
			return r.code;			
		}else{
			admission.setSaveInProgress(false);
			alert(r.message);
			return "";		
		}
    }
    function cancelCancelPatientDlg(){
	 	$('#inspatienttestdlg').modal('hide');	 	
	 }
	function cancelDiscountDlg(){
	 	$('#inspatientdiscountdlg').modal('hide');
		$('#inspatientdiscountdlg').modal('dispose');	 	
	 } 
	 
	 function ShowTestResults(branch,code){
  			var url="/waggle/service/discharge/printlabbill?branchcode="+branch+"&billno="+code;
				window.open(url,"_blank");
  		}
    function loadOrderData(url,code,did){
    	if(code=="Discount"){
    		var rowData=$("#report_14").getRowData(did);
    		screenObjects.getScreenObject("code").setValue(rowData.pam_code);
    		screenObjects.getScreenObject("discountamount").setValue(rowData.pam_discount);
    		$('#inspatientdiscountdlg').modal({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:600,position:'center'});
			$('#inspatientdiscountdlg').modal('show');
    	}else if(code=="ViewTest"){
	    	var hl=$('#inspatientd');
	    	hl.children().remove();
    	
    		$('#inspatienttestdlg').modal({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:600,position:'center'});
			$('#inspatienttestdlg').modal('show');
			var l=new FlexUI.Ajax();
			var v=l.callAjax("GET","/waggle/service/discharge/ippatienttest",url,"");
			
			hl.append('<table class="table"><thead><tr><th  >Request No</th><th>Date </th><th>Test Name</th><th>Process Status</th><th>View</th></tr></thead><tbody></tbody>');
	    	if(v!=null){
	    		var s=v.requestdata.length;
	    		$('#inspatienttestdlg').find("[class='pop_lov_hed_txt']").html('Patient : '+v.patientname +'['+v.ipno+']');
	    		for(var i=0;i<s;i++){
	    			var status="Pending";
	    			var resultlink="<td></td>";
	    			if(v.requestdata[i].billno>0){
	    				status="Processed";
	    				resultlink='<td onclick="ShowTestResults('+v.requestdata[i].branchcode+','+v.requestdata[i].billno+')"><span class="mdi mdi-eye"></span></td>';
	    			}
	    			hl.find("tbody").append('<tr><td>'+v.requestdata[i].requestno+'</td><td>'+v.requestdata[i].requestdate+'</td>'+
	      					  '<td>'+v.requestdata[i].testname+'</td>'+
	      					  '<td>'+status+'</td>'+resultlink+
	      					  '</tr>');
							  
		    		}
		    	}
			
    	}else{
	    	var rowData=$("#report_14").getRowData(did);
	  		showLoader();
			var l=new FlexUI.Ajax();
			var v=l.callAjax("GET","/waggle/service/screen/data?screencode=10","&branchcode="+$('#branch').val()+"&patientcode="+rowData.pam_code);
			admission.loadObjectData(v);
			$('#ipnod').text(v["ipno"]);
			//$('#patientcont').removeClass("col-md-12 col-sm-12 mpZero");
			//$('#patientcont').addClass("col-md-6 col-sm-6 mpZero");
			//$('#npatient').removeClass("col-md-2");
			//$('#npatient').addClass("col-md-4");		
			//$('#npatientv').removeClass("col-md-7");
			//$('#npatientv').addClass("col-md-7");						
			$('#ipnodisp').css("display","block");
			$('#patientsearchcont').css("display","none");
			$('#callback').css('display','block');
	  		$('#xyz').css('display','none');
	  		$('#addGrp').css('display','none');
			 $('#saveGrp').css('display','block');
	  		screenObjects.getScreenObject("admissiondate").setEnabled(true);
	    	screenObjects.getScreenObject("roomno").setEnabled(false);
	    	//screenObjects.getScreenObject("consultingdr").setEnabled(false);  		
	    	//screenObjects.getScreenObject("referredby").setEnabled(false);
	    	screenObjects.getScreenObject("advanceamt").setEnabled(false);
	  		hideLoader();
	  		accountTypeChange();
	  		screenObjects.getScreenObject("patientname").focus();
	  		if("<%=status%>"=="1,2"){
	  			$('#btnSave').css('display','none');
	  		}else{
	  			$('#btnSave').css('display','inline-block');
	  		}
  		}
    }
    function clearInnerScreen(){
    	admission.clearScreen();
    	admission.setSaveInProgress(false);
    	$("patientname").focus();
    	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
    	//screenObjects.getScreenObject("branchcode").setValue(1);
    	screenObjects.getScreenObject("advanceamt").setEnabled(true);
    	screenObjects.getScreenObject("sponsorreqamt").setEnabled(false);
    	screenObjects.getScreenObject("sponsorappstatus").setEnabled(false);
    	screenObjects.getScreenObject("approvedamt").setEnabled(false);
    	accountTypeChange();
    	screenObjects.getScreenObject("patientname").focus();
    }
  function addMasterData(){ 
  	clearInnerScreen();
  	$('#patientsearchcont').css("display","block");
  	$('#ipnod').text("");
			  				  	
	$('#ipnodisp').css("display","none");    	  	    	
  	$('#callback').css('display','block');
  	$('#xyz').css('display','none');
	$('#jqcontainer').css('display','none');
  	$('#addGrp').css('display','none');
	$('#saveGrp').css('display','block');
  }
  function hideMasterData(){
  	clearInnerScreen();
  	$('#ipnod').text("");
				  				  	
	$('#ipnodisp').css("display","none");    	  	  
  	$('#callback').css('display','none');
	$('#xyz').css('display','block');
  	$('#jqcontainer').css('display','block');
  	$('#addGrp').css('display','block');
	$('#saveGrp').css('display','none');
  	reloadGrid(14);
  }
  function toggleHeaderRow(){
  	toggleSearchToolBar(14);
  }
  toggleHeaderRow();
   $(document).ready(function () {
    	admission=new FlexUI.Screen("admission",sProps);
    	//screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
    	screenObjects.getScreenObject("branchcode").setValue(1);
    	accountTypeChange();
    	screenObjects.getScreenObject("patientname").focus();
    });
    function accountTypeChange(){
    	var code=screenObjects.getScreenObject("code").getValue();
    	if(screenObjects.getScreenObject("accounttype").getValue()==1){
    		screenObjects.getScreenObject("sponsorname").setEnabled(false);
    		screenObjects.getScreenObject("sponsorcardno").setEnabled(false);
    		screenObjects.getScreenObject("sponsorapprovalno").setEnabled(false);
    		screenObjects.getScreenObject("sponsorreqamt").setEnabled(false);
    		screenObjects.getScreenObject("sponsorappstatus").setEnabled(false);
    		screenObjects.getScreenObject("approvedamt").setEnabled(false);    		
    		screenObjects.getScreenObject("advanceamt").setEnabled(true);
    		sProps.screen[0].fields[29].mandatory=false;
    	}else{
    		screenObjects.getScreenObject("sponsorname").setEnabled(true);
    		screenObjects.getScreenObject("sponsorcardno").setEnabled(true);
    		screenObjects.getScreenObject("sponsorapprovalno").setEnabled(true);
    		if(code!="" && code!="0"){
    			screenObjects.getScreenObject("sponsorreqamt").setEnabled(true);
    			screenObjects.getScreenObject("sponsorappstatus").setEnabled(true);
    			screenObjects.getScreenObject("approvedamt").setEnabled(true);    		
    			
    		}
    		screenObjects.getScreenObject("advanceamt").setEnabled(false);    		
    		sProps.screen[0].fields[29].mandatory=true;    	
    	}
    }
    function printBill(data,ipcode){
			var printData={};
			if(toNumber(data["advanceamt"])!=0){
				printData["type"]="IPBILL";
				printData["branchname"]=$('#branch option:selected').text();
				printData["address1"]="27,Javulikara Street";
				printData["address2"]="Tiruvarur - 610 001";
				printData["address3"]="Phone - 242292,240292";
				printData["tin"]="";
				printData["buname"]="Advance Receipts";
				printData["billno"]=data["billno"];
				printData["billdate"]=formatDateddMMyyyy(new Date())+" "+formatTimeHHMM(new Date());
				printData["totalamt"]=data["advanceamt"]+"";
				printData["tenderamount"]=data["advanceamt"]+"";
				printData["balanceamount"]="0.00";
				printData["roundoff"]="0.00";
				printData["sponsorname"]="";
				printData["doctorname"]=data["consultingdr"]+"";
				printData["referredby"]=data["referredby"]+"";
				printData["roundoff"]="0.00";
				printData["patientname"]=data["patientname"];		
				printData["patientage"]=data["patientage"];
				printData["ipno"]="IP"+ipcode;
				printData["gender"]=data["gender"];
				printData["invtype"]="CASH";
				printData["items"]=[];
				var item={};
				item.name="Advance Amount";
				item.rate=data["advanceamt"]+"";
				item.qty="1";
				item.amount=data["advanceamt"]+"";				
				printData.items.push(item);
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
		}
		function onPatientClose(e,args){                           //check the function
			alert("result"+" "+args.result ) ;
			setPatientInfo(args.result);
		}	

		function checkPatientExists(id,me){
			if(!admission.getSaveInProgress() && screenObjects.getScreenObject("patientname").getValue()=="" && screenObjects.getScreenObject("smobileno").getTag()==""){
				var branch=screenObjects.getScreenObject("branchcode").getValue();
				var stext=screenObjects.getScreenObject("smobileno").getValue();
				var params="";
				var paramName="F1";
				var dsi=0;
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
					v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=hosppatients&branchcode="+branch+params);
					alert("V V"+" "+ v ) ;
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
						}		
					}
				}
			}else{
				screenObjects.getScreenObject("smobileno").setTag("");
			}	
			return true;
		}
		function setPatientInfo(result){
			screenObjects.getScreenObject("prefix").setValue(result[23]);
			screenObjects.getScreenObject("agetype").setValue(result[24]);
			screenObjects.getScreenObject("patientname").setValue(result[2]);
			screenObjects.getScreenObject("hospregcode").setValue(result[1]);
			screenObjects.getScreenObject("gender").setValue(result[4]);
			screenObjects.getScreenObject("patientage").setValue(result[3]);
			screenObjects.getScreenObject("doctorcode").setValue(result[5]);
			screenObjects.getScreenObject("consultingdr").setValue(result[6]);
			screenObjects.getScreenObject("consultingdr").setTag(result[6]);
			screenObjects.getScreenObject("referralcode").setValue(result[7]);
			screenObjects.getScreenObject("referredby").setValue(result[8]);
			screenObjects.getScreenObject("referredby").setTag(result[8]);
			screenObjects.getScreenObject("mobileno").setValue(result[0]);
			screenObjects.getScreenObject("address1").setValue(result[14]);
			screenObjects.getScreenObject("address2").setValue(result[15]);
			screenObjects.getScreenObject("address3").setValue(result[16]);
			screenObjects.getScreenObject("guardiantype").setValue(result[12]);
			screenObjects.getScreenObject("guardianname").setValue(result[13]);
			screenObjects.getScreenObject("refcode").setValue(result[17]);
			
			
			
			if($('#searchpatient').val()=="mobile"){
				screenObjects.getScreenObject("smobileno").setValue(result[0]);
			}else{
				screenObjects.getScreenObject("smobileno").setValue(result[1]);
			}	
			screenObjects.getScreenObject("smobileno").goToNextField();			
		}
		function checkApprovalNo(){
			var result=true;
			var l=new FlexUI.Ajax();
			var sponsorcode=screenObjects.getScreenObject("sponsorcode").getValue();
			var sponsorapprovalno=screenObjects.getScreenObject("sponsorapprovalno").getValue();
			var patientcode=screenObjects.getScreenObject("code").getValue()==""?"0":screenObjects.getScreenObject("code").getValue();
			if(sponsorcode!="0" && sponsorcode!="" && sponsorapprovalno!="" && sponsorapprovalno!="0"){
				v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=checkapprovalno&sponsorcode="+sponsorcode+"&sponsorapprovalno="+sponsorapprovalno+"&patientcode="+patientcode);
				if(v!=null && v.data.length>0){
					alert("Duplicate Approval Number");
					result=false;
				}
			}
			return result;
		}
		function checkPatientStatus(code){
			var result=true;
			var l=new FlexUI.Ajax();
			v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=patientstatus&code="+code);
			if(v!=null && v.data.length>0){
				if(v.data[0][0]==2){
					result=false;
				}
			}				
			return result;	
		}

		$('#admissiondate').datepicker({
				 language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy'
		});
	
	</script>
</body>
</html>