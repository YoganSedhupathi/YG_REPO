<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Manage Insurance Patients</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String rptId=request.getParameter("id");
String userId=(String)session.getAttribute("LOGIN_ID");
String title=request.getParameter("title");
%>
<body>
	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Manage Insurance Patients</h4>
				</div>

			

				<div  class="col-md-6" id="addGrp">
					<div class="row">
						<div class="col-md-7 d-flex text-right">
							<div class="input-group">
								<span class="input-group-text">From</span>
								<input id="fromdate" name="fromdate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
								<span class="input-group-text">To</span>
								<input id="todate" name="todate" inputType="date"  type="text" mandatory="1"  class="form-control"/> &ensp;
								<button type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button> &ensp;
							</div>

							<div  class="col-md-3 col-sm-3 mpZero" style="display:none">		
								<div class="form-group mbotto" style="display:none">
									<div class="col-md-4"><label>Corporate</label></div>
									<div class="col-md-8">
										<input class="form-control" id="nsponsorname"/>
										<input type="hidden" class="form-control" id="nsponsorcode" value="0"/>
									</div>
								</div>
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
				 <div id="patientlist" class="w-100"></div>
			  </div>
			</div>	
			<div id="callback" class="row " style="display:none;"></div>
		</div>
	</div>

	
	 <div id="callback" style="display:none;">	 	
			<div class="col-md-12 col-sm-12 mpZero">
			<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
				<div class="subHe">Patient Details</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Patient Name</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="patientname">
						<input type="hidden" id="branchcode" value="0"/>
						<input type="hidden" id="claimno" value="0"/>
						<input type="hidden" id="patienttype" value=""/>												
						<input type="hidden" id="patientcode" value=""/>
						<input type="hidden" id="sponsorcode" value=""/>
						</div>
					</div>
					</div>	
					<div  class="col-md-3 col-sm-3 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>IP No</label></div>
						<div class="col-md-8"><input class="form-control" id="ipno"/></div>
					</div>					
					</div>
					<div  class="col-md-3 col-sm-3 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Bill Amount</label></div>
						<div class="col-md-8"><input class="form-control" id="billamount"/></div>
					</div>
					</div>
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Age</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="patientage"></div>
					</div>
					</div>	
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Gender</label></div>
						<div class="col-md-8"><select class="form-control" id="gender"></select></div>
					</div>
					</div>
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Corporate</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="sponsorname"></div>
					</div>
					</div>	
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Card No</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="sponsorcardno"></div>
					</div>
					</div>
				</div>
			</div>
			<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
				<div class="subHe">Approval Details</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Approval Status</label></div>
						<div class="col-md-8"><select class="form-control" id="approvalstatus"></select>
						</div>
					</div>
					</div>	
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Requested Amount</label></div>
						<div class="col-md-8"><input class="form-control" id="preauthamount"/></div>
					</div>
					</div>
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Pre-Auth Sent Date</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="preauthsentdate"></div>
					</div>
					</div>					
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Pre-Auth Remarks</label></div>
						<div class="col-md-8"><textarea row=20 col=500 id="preauthremarks"></textarea>
						</div>
					</div>
					</div>	
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Additional Details Sent Date</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="preauthaddsentdate"></div>
					</div>
					</div>					
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Additional Details Requested</label></div>
						<div class="col-md-8"><textarea row=20 col=500 id="preauthaddremarks"></textarea>
						</div>
					</div>
					</div>	
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Request No</label></div>
						<div class="col-md-8"><input class="form-control" id="requestno"/></div>
					</div>
					</div>
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Approval No</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="approvalno"></div>
					</div>
					</div>						
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Approval/Rejected/Cancelled Date</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="approveddate"></div>
					</div>
					</div>	
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Approved Amount</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="approvedamt"/></div>
					</div>
					</div>
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Final Approved Amount</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="finalapprovedamt"/></div>
					</div>
					</div>				
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Approval/Rejected/Cancelled Remarks</label></div>
						<div class="col-md-8"><textarea row=20 col=200 id="approvalremarks"></textarea>
						</div>
					</div>
					</div>	
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Claimed Date</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="claimeddate"></div>
					</div>
					</div>	
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Claimed Amount</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="claimedamt"/></div>
					</div>
					</div>
				</div>
			</div>
			<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
				<div class="subHe">Additional Amount Request Details</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Request Status</label></div>
						<div class="col-md-8"><select class="form-control" id="addlstatus"></select>
						</div>
					</div>
					</div>	
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Requested Amount</label></div>
						<div class="col-md-8"><input class="form-control" id="addlreqamount"/></div>
					</div>
					</div>
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Request Date</label></div>
						<div class="col-md-8"><input class="form-control" id="addlrequestdate"/></div>
					</div>
					</div>
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Approved Amount</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="addlapprovedamt"></div>
					</div>
					</div>						
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-2"><label>Remarks</label></div>
						<div class="col-md-10"><textarea row=20 col=500 id="addlremarks"></textarea>
						</div>
					</div>
					</div>	
				</div>
			</div>
			<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
				<div class="subHe">Co-Pay Request Details</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Request Status</label></div>
						<div class="col-md-8"><select class="form-control" id="copaystatus"></select>
						</div>
					</div>
					</div>	
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Requested Amount</label></div>
						<div class="col-md-8"><input class="form-control" id="copayreqamount"/></div>
					</div>
					</div>
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Request Date</label></div>
						<div class="col-md-8"><input class="form-control" id="copayrequestdate"/></div>
					</div>
					</div>
					<div  class="col-md-6 col-sm-6 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Approved Amount</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="copayapprovedamt"></div>
					</div>
					</div>						
				</div>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-2"><label>Remarks</label></div>
						<div class="col-md-10"><textarea row=20 col=500 id="copayremarks"></textarea>
						</div>
					</div>
					</div>	
				</div>
			</div>																		
			<div id="actButton" class="col-md-12 text-right">
            	<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="saveInsurancePatient()">Save</button>
            	<button id="btnOPBills" class="btn btn-primary priBut" type="button" onclick="showBillDetail()">O/P Bill Detail</button>
                <button id="btnCancel" class="btn btn-default" type="button" onclick="hideMasterData()">Cancel</button>
        	</div>
        </div>
	</div>
	<div style="display:none">
		<div id='billdetaildlg' class='pop_lov_box'>
			<div id='billdetailtitle' class='pop_lov_hed_box'>
			<div class='pop_lov_clos'>
				<a href='#'>
					<span class='fa fa-times-circle'>
					</span>
				</a>
			</div>
			<div class='pop_lov_hed_txt'>Bill Details</div>			
			</div>
			<div id='billdetail' class='pop_lov_inp_box'>
				 <div class="col-md-12 col-sm-12 panelOrange hcH">
				 	 <div class="tabMenu1">
		                <ul id="navg">
		                    <li onclick="showClaimLab()"><span class="selTab">Investigation Bills </span></li>
		                    <li onclick="showClaimLabBillDetail()"><span >Investigation Bill Detail</span></li>
		                </ul>
		                <div class="borTp"></div>
		            </div>
				  <div class="col-md-12 col-sm-12 mpZero" id="clbills" style="height:400px;display:block">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" id="clabbills"></table>
				  </div>
				  <div class="col-md-12 col-sm-12 mpZero" id="clbilldetails" style="height:400px;display:none">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" id="clabbilldetails"></table>
				  </div>
				</div>
				<div class="clearfix"></div>
				<div id="actButton" class="col-md-12 text-right">
	                <button id="btnClear" class="btn btn-default" type="button" onclick="closeBillDetailDlg()">Close</button>
            	</div>							
			</div>
		</div>
	</div>
	<script>

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
	var sPropsFilter={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[{name:"fromdate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"todate"},
  	{name:"todate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"nsponsorname"},
  	{name:"nsponsorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"nsponsorname"},
  	{name:"nsponsorname",inputType:0,type:"LOV",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"",lovOptions:{url:"/waggle/service/ajax",ajax:"insurancecompany",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"nsponsorname",tt:false,id:"icm_name"},{tgt:"nsponsorname",tt:true,id:"icm_name"},{tgt:"nsponsorcode",tt:false,id:"icm_code"}]}},  	
  	]}]};	    	
  	var insfilter=new FlexUI.Screen("insfilter",sPropsFilter);
  	
	var newParams="&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&sponsorcode="+$('#nsponsorcode').val();
	jqReport(600002,"#patientlist",newParams);
	var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[{name:"patientcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"sponsorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"ipno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"gender"},
  	{name:"gender",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"sponsorname",values:"M~F",keys:"Male~Female"},
  	{name:"sponsorname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":true,nf:"sponsorcardno"},  	
  	{name:"sponsorcardno",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"approvalno"},
  	{name:"approvalstatus",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"preauthamount",values:"0~1~2~3~4~5~6",keys:"Pre-Auth Not Sent~Pre-Auth Sent~Additional Details Sent~Approved~Rejected~Cancelled~Claimed","onchange":"onChangeApprovalStatus"},
  	{name:"preauthamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"preauthsentdate"},
  	{name:"preauthsentdate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"Null","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"preauthremarks"},
  	{name:"preauthremarks",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":200,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"preauthaddsentdate"},
  	{name:"preauthaddsentdate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"Null","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"preauthaddremarks"},
  	{name:"preauthaddremarks",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":200,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"requestno"},  	
  	{name:"requestno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"approvalno"},  	
  	{name:"approvalno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"approveddate"},  	
  	{name:"approveddate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"Null","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"approvedamt"},
  	{name:"approvedamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"finalapprovedamt"},
  	{name:"finalapprovedamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"approvalremarks"},
  	{name:"approvalremarks",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":200,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"claimeddate"},
  	{name:"claimeddate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"Null","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"claimedamt"},
  	{name:"claimedamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"addlstatus"},  	
  	{name:"addlstatus",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"addlreqamount",values:"0~1~2~3",keys:"Not Requested~Requested~Approved~Rejected"},
  	{name:"addlreqamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"addlrequestdate"},
  	{name:"addlrequestdate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"Null","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"addlapprovedamt"}, 
  	{name:"addlapprovedamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"addlremarks"},
  	{name:"addlremarks",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"copaystatus"},
  	{name:"copaystatus",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"copayreqamount",values:"0~1~2~3",keys:"Not Requested~Requested~Approved~Rejected"},
  	{name:"copayreqamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"copayrequestdate"},
  	{name:"copayrequestdate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"Null","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"copayapprovedamt"}, 
  	{name:"copayapprovedamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"copayremarks"},
  	{name:"copayremarks",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:""}, 	  	  	 	  	
  	{name:"billamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"claimno",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},  	
  	{name:"patienttype",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""}
  	]}]};
  	var inspatients=new FlexUI.Screen("inspatients",sProps);
    $(document).ready(function () {
            $('#subtitle').text("");
            $('#screentitle').text("Bills");
            ConstructClaimLabGrid();
    		ConstructClaimLabBillDetailGrid();            
     });
  	function toggleHeaderRow(){
  		toggleSearchToolBar(600002);
  	}
  
  	toggleHeaderRow();
    function loadOrderData(url,name,did){
	  	var rowData=$("#report_600002").getRowData(did);
		if(name=="Manage"){
				addMasterData();
				showLoader();
				var l=new FlexUI.Ajax();
				var v=l.callAjax("GET","/waggle/service/screen/data?screencode=27","&sponsorcode="+rowData.cp_sponsor_code+"&claimno="+rowData.cp_claim_no);
				inspatients.loadObjectData(v);
				hideLoader();				
				var appstatus=screenObjects.getScreenObject("approvalstatus");
				var patienttype=screenObjects.getScreenObject("patienttype").getValue();
				if(patienttype==2){
					$('#btnOPBills').css("display","inline-block");
				}else{
					$('#btnOPBills').css("display","none");
				}
				onChangeApprovalStatus("approvalstatus",appstatus);
				if(appstatus.getValue()==1){
					appstatus.getSelect().find("option[value='0']").prop('disabled',true);
				}else if(appstatus.getValue()==2){
					appstatus.getSelect().find("option[value='0']").prop('disabled',true);
					appstatus.getSelect().find("option[value='1']").prop('disabled',true);
				}else if(appstatus.getValue()==3){
					appstatus.getSelect().find("option[value='0']").prop('disabled',true);
					appstatus.getSelect().find("option[value='1']").prop('disabled',true);				
					appstatus.getSelect().find("option[value='2']").prop('disabled',true);
					appstatus.getSelect().find("option[value='4']").prop('disabled',true);
					appstatus.getSelect().find("option[value='5']").prop('disabled',true);
				}else if(appstatus.getValue()==4){
					appstatus.getSelect().find("option[value='0']").prop('disabled',true);
					appstatus.getSelect().find("option[value='1']").prop('disabled',true);				
					appstatus.getSelect().find("option[value='2']").prop('disabled',true);
					appstatus.getSelect().find("option[value='3']").prop('disabled',true);
					appstatus.getSelect().find("option[value='5']").prop('disabled',true);
					appstatus.getSelect().find("option[value='6']").prop('disabled',true);
				}else if(appstatus.getValue()==5){
					appstatus.getSelect().find("option[value='0']").prop('disabled',true);
					appstatus.getSelect().find("option[value='1']").prop('disabled',true);				
					appstatus.getSelect().find("option[value='2']").prop('disabled',true);
					appstatus.getSelect().find("option[value='3']").prop('disabled',true);
					appstatus.getSelect().find("option[value='4']").prop('disabled',true);
					appstatus.getSelect().find("option[value='6']").prop('disabled',true);				
				}else if(appstatus.getValue()==6){
					appstatus.getSelect().find("option[value='0']").prop('disabled',true);
					appstatus.getSelect().find("option[value='1']").prop('disabled',true);				
					appstatus.getSelect().find("option[value='2']").prop('disabled',true);
					appstatus.getSelect().find("option[value='3']").prop('disabled',true);
					appstatus.getSelect().find("option[value='4']").prop('disabled',true);
					appstatus.getSelect().find("option[value='5']").prop('disabled',true);								
				}
	      }	      					
	 }
	 function saveInsurancePatient(){
	 		var s=new FlexUI.Ajax();	 			
	 		var v=s.callAjax("GET","/waggle/service/ajax","ro=true&ic=0&id=checkclaimapprovalno&sponsorcode="+screenObjects.getScreenObject("sponsorcode").getValue()+"&claimno="+screenObjects.getScreenObject("claimno").getValue()+"&claimid="+screenObjects.getScreenObject("approvalno").getValue());
			if(v!=null && v.data.length>0){
				if(v.data[0].cp_claim_no>0){
					alert("Duplicate Approval Number. Please check the approval number and continue...");
					return false;
				}													
			}
	 	    if(inspatients.getSaveInProgress()) return;
        	var r=null;
    		inspatients.setOperation("MOD");
    		inspatients.setScreenCode(27);
    		var d=inspatients.processDataToSave();
    		inspatients.setSaveInProgress(true);    		
			if("FAILED"!=d){
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",d);
				hideLoader();
		 	}else{
		 		alert("Please correct the validation errors and continue...");
		 		inspatients.setSaveInProgress(false);
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				alert(r.message);
				hideMasterData();
				inspatients.setSaveInProgress(false);
			}else{
				inspatients.setSaveInProgress(false);								
				alert(r.message);	
			}
	 }
	 function reportGo(id){
		showLoader();
		var newParams="&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&sponsorcode="+$('#nsponsorcode').val();
		changeUrlAndReloadGrid(id,"",newParams);	
		hideLoader();
	}
		function clearScreen(){
  			inspatients.clearScreen();
  			var preauthsentdate=screenObjects.getScreenObject("preauthsentdate");
  			var preauthaddsentdate=screenObjects.getScreenObject("preauthaddsentdate");
  			var approveddate=screenObjects.getScreenObject("approveddate");
  			var claimeddate=screenObjects.getScreenObject("claimeddate");
  			var addlrequestdate=screenObjects.getScreenObject("addlrequestdate");
  			var copayrequestdate=screenObjects.getScreenObject("copayrequestdate");
  			preauthsentdate.setValue("");
  			preauthaddsentdate.setValue("");
  			approveddate.setValue("");
  			claimeddate.setValue("");
  			addlrequestdate.setValue("");
  			copayrequestdate.setValue("");
  			onChangeApprovalStatus("approvalstatus",screenObjects.getScreenObject("approvalstatus"));		
		}
	    function addMasterData(){
	    	clearScreen(); 
  			$('#callback').css('display','block');
  			$('#reportcont').css('display','none');
  		}
  
  		function hideMasterData(){
  			clearScreen();
  			$('#callback').css('display','none');
  			$('#reportcont').css('display','block');
  			reloadGrid(600002);  			
  		}
	 function onChangeApprovalStatus(id,me){
	 	if(!inspatients.getSaveInProgress()){
	 		var status=me.getValue();
	 		var preauthamount=screenObjects.getScreenObject("preauthamount");
			var preauthsentdate=screenObjects.getScreenObject("preauthsentdate");
			var preauthremarks=screenObjects.getScreenObject("preauthremarks");
			var preauthaddsentdate=screenObjects.getScreenObject("preauthaddsentdate");
			var preauthaddremarks=screenObjects.getScreenObject("preauthaddremarks");
			var requestno=screenObjects.getScreenObject("requestno");
			var approvalno=screenObjects.getScreenObject("approvalno");
			var approveddate=screenObjects.getScreenObject("approveddate");
			var approvedamt=screenObjects.getScreenObject("approvedamt");
			var finalapprovedamt=screenObjects.getScreenObject("finalapprovedamt");
			var approvalremarks=screenObjects.getScreenObject("approvalremarks");
			var claimeddate=screenObjects.getScreenObject("claimeddate");
			var claimedamt=screenObjects.getScreenObject("claimedamt");
			var addlstatus=screenObjects.getScreenObject("addlstatus");
			var addlreqamount=screenObjects.getScreenObject("addlreqamount");
			var addlrequestdate=screenObjects.getScreenObject("addlrequestdate");
			var addlapprovedamt=screenObjects.getScreenObject("addlapprovedamt");
			var addlremarks=screenObjects.getScreenObject("addlremarks");
			var copaystatus=screenObjects.getScreenObject("copaystatus");
			var copayreqamount=screenObjects.getScreenObject("copayreqamount");
			var copayrequestdate=screenObjects.getScreenObject("copayrequestdate");
			var copayapprovedamt=screenObjects.getScreenObject("copayapprovedamt");
			var copayremarks=screenObjects.getScreenObject("copayremarks");
			preauthamount.setEnabled(false);
			preauthsentdate.setEnabled(false);
			preauthremarks.setEnabled(false);
			preauthaddsentdate.setEnabled(false);
			preauthaddremarks.setEnabled(false);
			requestno.setEnabled(false);
			approvalno.setEnabled(false);
			approveddate.setEnabled(false);
			approvedamt.setEnabled(false);
			finalapprovedamt.setEnabled(false);
			approvalremarks.setEnabled(false);
			claimeddate.setEnabled(false);
			claimedamt.setEnabled(false);
			addlstatus.setEnabled(false);
			addlreqamount.setEnabled(false);
			addlrequestdate.setEnabled(false);
			addlapprovedamt.setEnabled(false);
			addlremarks.setEnabled(false);
			copaystatus.setEnabled(false);
			copayreqamount.setEnabled(false);
			copayrequestdate.setEnabled(false);
			copayapprovedamt.setEnabled(false);
			copayremarks.setEnabled(false);
	 		if(status==0){
	 		}else if(status==1){
	 				preauthamount.setEnabled(true);
					preauthsentdate.setEnabled(true);
					preauthremarks.setEnabled(true); 				 			 		
	 		}else if(status==2){
	 				preauthaddsentdate.setEnabled(true);
					preauthaddremarks.setEnabled(true);	 			 		
	 		}else if(status==3){
					requestno.setEnabled(true);
					approvalno.setEnabled(true);
					approveddate.setEnabled(true);
					approvedamt.setEnabled(true);
					finalapprovedamt.setEnabled(true);
					approvalremarks.setEnabled(true);
					addlstatus.setEnabled(true);
					addlreqamount.setEnabled(true);
					addlrequestdate.setEnabled(true);
					addlapprovedamt.setEnabled(true);
					addlremarks.setEnabled(true);
					copaystatus.setEnabled(true);
					copayreqamount.setEnabled(true);
					copayrequestdate.setEnabled(true);
					copayapprovedamt.setEnabled(true);
					copayremarks.setEnabled(true);	 		
	 		}else if(status==4){
	 				approveddate.setEnabled(true);
	 				approvalremarks.setEnabled(true);
	 		}else if(status==5){
	 				approveddate.setEnabled(true);
	 				approvalremarks.setEnabled(true);	 		
	 		}else if(status==6){
					claimeddate.setEnabled(true);
					claimedamt.setEnabled(true);	 		
	 		}
	 	
	 	}
	 
	 }
	 function closeBillDetailDlg(){
		$('#billdetaildlg').dialog('close');
		$('#billdetaildlg').dialog('destroy');
	}
	function showBillDetail(){
		$('#billdetaildlg').dialog({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:900,position:'center'});
		$('#billdetaildlg').dialog('open');
		showClaimLab();
	}
	function showClaimLab(){
    	$('#clbills').css('display','block');
    	$('#clbilldetails').css('display','none');
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(0).addClass('selTab');
    	$grid = $("#clabbills");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");    	
    	var s=new FlexUI.Ajax();
		showLoader();
		r=s.callAjax("GET","/waggle/service/ajax","&ic=0&ro=true&id=oppatientbillhdr&branchcode="+screenObjects.getScreenObject("branchcode").getValue()+"&claimno="+screenObjects.getScreenObject("claimno").getValue());
    	$grid.jqGrid('setGridParam', { data: r.data });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
		hideLoader();    	    	    	
    }
    function showClaimLabBillDetail(){
    	$('#clbills').css('display','none');
    	$('#clbilldetails').css('display','block');
    	$('#navg').find("li>span").removeClass('selTab');
    	$('#navg').find("li>span").eq(1).addClass('selTab');
    	$grid = $("#clabbilldetails");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");    	
    	var s=new FlexUI.Ajax();
		showLoader();
		r=s.callAjax("GET","/waggle/service/ajax","&ic=0&ro=true&id=oppatientbills&branchcode="+screenObjects.getScreenObject("branchcode").getValue()+"&claimno="+screenObjects.getScreenObject("claimno").getValue());
    	$grid.jqGrid('setGridParam', { data: r.data });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
		hideLoader();    	    	
    }
    function ConstructClaimLabGrid() {
        var areaWidth = 800;
        $("#clabbills").jqGrid({
            datatype: "local",
            //width: areaWidth,
            height:390,
            autowidth: true,
            shrinktofit:true,
            colNames: ['BillNo', 'BillDate', 'BuName', 'BillAmount'],
            colModel: [
                        { name: 'billno', index: 'billno', sorttype: "integer", sortable: false, width: 100, align: 'left'},
                        { name: 'billdate', index: 'billdate', sorttype: "text", sortable: false, width: 100, align: 'left' },
						{ name: 'bum_buname', index: 'bum_buname', sorttype: "integer", sortable: false, width: 200, align: 'left'},
						{ name: 'bh_total_amount', index: 'bh_total_amount', sorttype: "text", sortable: false, width: 200, align: 'left' }                        
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
    function ConstructClaimLabBillDetailGrid() {
        var areaWidth = 800;
        $("#clabbilldetails").jqGrid({
            datatype: "local",
            //width: areaWidth,
            height:390,
            autowidth: true,
            shrinktofit:true,
            colNames: ['BuName', 'BillNo', 'BillDate', 'Test','Qty','Rate','Amount'],
            colModel: [
                        { name: 'bum_buname', index: 'bum_buname', sorttype: "text", sortable: false, width: 150, align: 'left' },
                        { name: 'billno', index: 'billno', sorttype: "integer", sortable: false, width: 100, align: 'left' },
						{ name: 'billdate', index: 'billdate', sorttype: "text", sortable: false, width: 100, align: 'left'},
						{ name: 'buim_itemname', index: 'buim_itemname', sorttype: "text", sortable: false, width: 200, align: 'left'},
						{ name: 'bd_test_qty', index: 'bd_test_qty', sorttype: "integer", sortable: false, width: 80, align: 'left'},
						{ name: 'bd_test_rate', index: 'bd_test_rate', sorttype: "number", sortable: false, width: 80, align: 'left' },
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
  </script>
</body>
</html>