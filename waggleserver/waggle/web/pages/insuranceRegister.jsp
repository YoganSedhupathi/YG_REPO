<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>
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
					<h4 class="header-title">Insurance Patients</h4>
				</div>

			

				<div  class="col-md-6" id="addGrp">
					<div class="row">
						<div class="col-md-7 d-flex text-right">
							
							<div class="input-group">
								<span class="input-group-text">From</span>
								<input id="fromdate" name="fromDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
								<span class="input-group-text">To</span>
								<input id="todate" name="toDate" inputType="date"  type="text" mandatory="1"  class="form-control"/> &ensp;
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
				 <div id="patientlist" class="w-100"></div>
			  </div>
			</div>	
			<div id="callback" class="row " style="display:none;"></div>
		</div>
		</div>



	
	 <div id='inspatientdlg' class='pop_lov_box' style="display:none">
			<div id='inspatienttitle' class='pop_lov_hed_box'>
			<div class='pop_lov_clos'>
				<a href='#'>
					<span class='fa fa-times-circle'>
					</span>
				</a>
			</div>
			<div class='pop_lov_hed_txt'><span id="patientno"></span></div>
			</div>
			<div id='inspatientd' class='pop_lov_inp_box'>
				<div class="col-md-12 col-sm-12 mpZero">
					<div  class="col-md-12 col-sm-12 mpZero" style="display:none">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>IP No</label></div>
						<div class="col-md-8">
							<input class="form-control" id="ipno" disabled/>
							<input type="hidden" id="branchcode" value="0"/>
							<input type="hidden" id="hospregcode" value="0"/>
							<input type="hidden" id="patientcode" value="0"/>
							<input type="hidden" id="claimno" value="0"/>
							<input type="hidden" id="patienttype" value=""/>
							<input type="hidden" id="refcode" value=""/>
						</div>
					</div>
					</div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Patient Name</label></div>
						<div class="col-md-8">
							<input class="form-control" id="patientname"/>
						</div>
					</div>
					</div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Patient Age</label></div>
						<div class="col-md-8">
							<input class="form-control" id="patientage"/>
						</div>
					</div>
					</div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Patient Gender</label></div>
						<div class="col-md-8">
							<select class="form-control" id="gender"></select>
						</div>
					</div>
					</div>
					<div class="col-md-12 col-sm-12 mpZero" style="display:none">
					<div class="col-md-4"><label>Gaurdian</label></div>
					<div class="col-md-2"><select class="form-control" id="guardiantype"></select></div>
					<div class="col-md-6"><input type="text" class="form-control" id="guardianname"></div>
					</div>
					</div>	
					<div class="col-md-12 col-sm-12 mpZero" style="display:none">
					<div class="form-group mbotto">
					<div class="col-md-4"><label>Address</label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="address1"></div>
					</div>
					</div>	
					<div class="col-md-12 col-sm-12 mpZero" style="display:none">
					<div class="form-group mbotto">
					<div class="col-md-4"><label> </label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="address2"></div>
					</div>
					</div>	
					<div class="col-md-12 col-sm-12 mpZero" style="display:none">
					<div class="form-group mbotto">
					<div class="col-md-4"><label></label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="address3"></div>
					</div>
					</div>	
					<div class="col-md-12 col-sm-12 mpZero">
					<div class="form-group mbotto">
					<div class="col-md-4"><label>Mobile No.</label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="mobileno"></div>
					</div>
					</div>																						
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Corporate</label></div>
						<div class="col-md-8">
							<input class="form-control" id="sponsorname" />
							<input type="hidden" class="form-control" id="sponsorcode" />
						</div>
					</div>
					</div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Card No</label></div>
						<div class="col-md-8">
							<input class="form-control" id="sponsorcardno" />
						</div>
					</div>
					</div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Approval No </label></div>
						<div class="col-md-8">
							<input class="form-control" id="approvalno" />
						</div>
					</div>
					</div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Request No </label></div>
						<div class="col-md-8">
							<input class="form-control" id="requestno" />
						</div>
					</div>
					</div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Approved Date </label></div>
						<div class="col-md-8">
							<input class="form-control" id="approveddate" />
						</div>
					</div>
					</div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Approved Amount </label></div>
						<div class="col-md-8">
							<input class="form-control" id="approvedamt" />
						</div>
					</div>
					</div>
				</div>
				<div id="actButton" class="col-md-12 text-right">
                	<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="savePatientList()">Save</button>
	                <button id="btnCancel" class="btn btn-default" type="button" onclick="cancelCancelPatientDlg()">Cancel</button>
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
	var newParams="&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val();
	loadBranchData();
	jqReport(600001,"#patientlist",newParams);
	var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[{name:"patientcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"refcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"hospregcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"ipno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"gender"},
  	{name:"gender",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"mobileno",values:"M~F",keys:"Male~Female"},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
	{name:"guardiantype",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"",values:"S/o~D/o~H/o~W/o~C/o",keys:"S/o~D/o~H/o~W/o~C/o"},
	{name:"guardianname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:""},  	
	{name:"address1",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:""},
	{name:"address2",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:""},
	{name:"address3",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"sponsorname"},
	{name:"mobileno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"sponsorname"},  	
	{name:"sponsorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsorname"},
  	{name:"sponsorname",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"sponsorcardno",lovOptions:{url:"/waggle/service/ajax",ajax:"insurancecompany",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"sponsorname",tt:false,id:"icm_name"},{tgt:"sponsorname",tt:true,id:"icm_name"},{tgt:"sponsorcode",tt:false,id:"icm_code"}]}},
  	{name:"sponsorcardno",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"approvalno"},
  	{name:"approvalno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"requestno"},
  	{name:"requestno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"approvedamt"},
  	{name:"approvedamt",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"approveddate"},
  	{name:"approveddate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},  	
  	{name:"claimno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},  	
  	{name:"patienttype",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""}
  	]}]};
  	var inspatients=new FlexUI.Screen("inspatients",sProps);
    $(document).ready(function () {
            $('#subtitle').text("");
            $('#screentitle').text("Bills");
     });
  	function toggleHeaderRow(){
  		toggleSearchToolBar(600001);
  	}
  
  	toggleHeaderRow();
    function loadOrderData(url,name,did){
	  	var rowData=$("#report_600001").getRowData(did);
		if(name=="Add"){
				if(rowData.patienttype=="IP" && rowData.claimno!=0 && rowData.claimstatus==0){				
					showInsPatientDialog(rowData,"DEL");
				}else if(rowData.claimno!=0 && rowData.claimstatus==1){
					showInsPatientDialog(rowData,"DEL");
				}else{
					alert("Claim Process Started for the Patient. Please cancel this from the Insurance Process Screen");
				}	  				
	      }	      					
	 }
	 function cancelCancelPatientDlg(){
	 	$('#inspatientdlg').dialog('close');
		$('#inspatientdlg').dialog('destroy');	 	
	 }
	 function showInsPatientDialog(){
	  		$('#inspatientdlg').dialog({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:600,position:'center'});
			$('#inspatientdlg').dialog('open');
			inspatients.clearScreen();
			screenObjects.getScreenObject("branchcode").setValue($('#branch').val());	 
	 }
	 /*function showInsPatientDialog(rowData,operation){
	  		$('#inspatientdlg').dialog({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:600,position:'center'});
			$('#inspatientdlg').dialog('open');
			inspatients.clearScreen();
			screenObjects.getScreenObject("ipno").setEnabled(false);			
			if(rowData.patienttype=="IP"){
				sProps.screen[0].fields[10].mandatory=false;					
				sProps.screen[0].fields[11].mandatory=false;
				sProps.screen[0].fields[12].mandatory=false;
				sProps.screen[0].fields[13].mandatory=false;
				screenObjects.getScreenObject("approvalno").setAttributes(sProps.screen[0].fields[10]);
  				screenObjects.getScreenObject("requestno").setAttributes(sProps.screen[0].fields[11]);
  				screenObjects.getScreenObject("approvedamt").setAttributes(sProps.screen[0].fields[12]);				  				
  				screenObjects.getScreenObject("approveddate").setAttributes(sProps.screen[0].fields[13]);
  				screenObjects.getScreenObject("patientname").setEnabled(false);
				screenObjects.getScreenObject("patientage").setEnabled(false);
				screenObjects.getScreenObject("gender").setEnabled(false);
				screenObjects.getScreenObject("approvalno").setEnabled(false);
				screenObjects.getScreenObject("approveddate").setEnabled(false);
				screenObjects.getScreenObject("requestno").setEnabled(false);
				screenObjects.getScreenObject("approvedamt").setEnabled(false);  				
			}else{
				sProps.screen[0].fields[10].mandatory=true;					
				sProps.screen[0].fields[11].mandatory=true;
				sProps.screen[0].fields[12].mandatory=true;
				sProps.screen[0].fields[13].mandatory=true;
				screenObjects.getScreenObject("approvalno").setAttributes(sProps.screen[0].fields[10]);
  				screenObjects.getScreenObject("requestno").setAttributes(sProps.screen[0].fields[11]);
  				screenObjects.getScreenObject("approvedamt").setAttributes(sProps.screen[0].fields[12]);
  				screenObjects.getScreenObject("approveddate").setAttributes(sProps.screen[0].fields[13]);
  				screenObjects.getScreenObject("patientname").setEnabled(true);
				screenObjects.getScreenObject("patientage").setEnabled(true);
				screenObjects.getScreenObject("gender").setEnabled(true);
				screenObjects.getScreenObject("approvalno").setEnabled(true);
				screenObjects.getScreenObject("approveddate").setEnabled(true);
				screenObjects.getScreenObject("requestno").setEnabled(true);
				screenObjects.getScreenObject("approvedamt").setEnabled(true);				  				  			
			}
			screenObjects.getScreenObject("ipno").setValue(rowData.ipno);
			screenObjects.getScreenObject("patienttype").setValue(rowData.patienttype);
			screenObjects.getScreenObject("claimno").setValue(rowData.claimno);
            screenObjects.getScreenObject("patientcode").setValue(rowData.patientcode);
  			screenObjects.getScreenObject("patientname").setValue(rowData.patientname);
  			screenObjects.getScreenObject("patientage").setValue(rowData.patientage);
  			screenObjects.getScreenObject("gender").setValue(rowData.gender);
  			screenObjects.getScreenObject("sponsorcode").setValue(rowData.sponsorcode);
  			screenObjects.getScreenObject("sponsorname").setValue(rowData.sponsorname);
  			screenObjects.getScreenObject("sponsorname").setTag(rowData.sponsorname);
  			screenObjects.getScreenObject("sponsorcardno").setValue(rowData.sponsorcardno);
  			screenObjects.getScreenObject("approvalno").setValue(rowData.approvalno);
  			screenObjects.getScreenObject("requestno").setValue(rowData.requestno);
  			screenObjects.getScreenObject("approveddate").setValue(rowData.approveddate);
  			screenObjects.getScreenObject("approvedamt").setValue(rowData.approvedamt);
  			screenObjects.getScreenObject("hospregcode").setValue(rowData.hospregcode);			
  			screenObjects.getScreenObject("branchcode").setValue(rowData.branchcode);
  			if(operation=="DEL"){
  				screenObjects.getScreenObject("sponsorname").setEnabled(false);
  				screenObjects.getScreenObject("sponsorcardno").setEnabled(false);
  				screenObjects.getScreenObject("patientname").setEnabled(false);
				screenObjects.getScreenObject("patientage").setEnabled(false);
				screenObjects.getScreenObject("gender").setEnabled(false);
				screenObjects.getScreenObject("approvalno").setEnabled(false);
				screenObjects.getScreenObject("approveddate").setEnabled(false);
				screenObjects.getScreenObject("requestno").setEnabled(false);
				screenObjects.getScreenObject("approvedamt").setEnabled(false);
				$('#btnSave').text("Remove");  				
  			}else{
  				$('#btnSave').text("Add");
  			}
	 }*/
	 function savePatientList(){
	 	    if(inspatients.getSaveInProgress()) return;
        	var r=null;
        	var claimno=screenObjects.getScreenObject("claimno").getValue();
        	var patientType=screenObjects.getScreenObject("patienttype").getValue();
        	if(claimno=="" || claimno=="0"){
        		var hospRegCode=screenObjects.getScreenObject("hospregcode").getValue();
        		if(hospRegCode=="0" || hospRegCode==""){
        			var regcode=saveRegistration();
        			if(regcode==""){
        				return;
        			}
        		}
    			inspatients.setOperation("ADD");
        	}
    		inspatients.setScreenCode(26);
    		var d=inspatients.processDataToSave();
    		inspatients.setSaveInProgress(true);    		
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",d);
				hideLoader();
		 	}else{
		 		alert("Please correct the validation errors and continue...");
		 		inspatients.setSaveInProgress(false);
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				alert(r.message+" [No:"+r.claimno+"]");
				inspatients.clearScreen();
				cancelCancelPatientDlg();
				reloadGrid(600001);
				inspatients.setSaveInProgress(false);
			}else{
				inspatients.setSaveInProgress(false);								
				alert(r.message);	
			}
	 }
	 function reportGo(id){
		showLoader();
		var newParams="&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val();
		changeUrlAndReloadGrid(id,"",newParams);	
		hideLoader();
	}
	function saveRegistration(){
	    inspatients.setOperation("ADD");
    	inspatients.setScreenCode(23);
    	var d=inspatients.processDataToSave();
    	inspatients.setSaveInProgress(true);
		if("FAILED"!=d){
			var s=new FlexUI.Ajax();
			showLoader();
			r=s.callAjax("POST","/waggle/service/screen/save",d);
			hideLoader();
		 }else{
		 	inspatients.setSaveInProgress(false);
		 	alert("Please correct the validation errors and continue...");
		 	return;
		 }		 
		 if(r.result=="Success"){
		 	screenObjects.getScreenObject("hospregcode").setValue(r.code);
		 	screenObjects.getScreenObject("refcode").setValue(r.refcode);
			return r.code;			
		}else{
			inspatients.setSaveInProgress(false);
			alert(r.message);
			return "";		
		}
    }
    function clearInnerScreen(){
    	inspatients.clearScreen();
    }
  </script>
</body>
</html>