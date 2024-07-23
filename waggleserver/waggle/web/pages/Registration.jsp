<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Registration</title>
  <style>
	.input-group-append {
		flex: 0 0 30%;
	}	
  </style>
</head>
<%
String screencode=(String)request.getParameter("id");
String rptTitle=(String)request.getParameter("title");
String mode=request.getParameter("mode");
String code=request.getParameter("code");
String status=request.getParameter("status");
status="1";
String id=request.getParameter("id");
if(id==null){
	id="300006";
}
%>
<body>

	<div class="card border-0 shadow">
		<div class="card-body lpage" >
				

			<div class="row w-100" >
				<div class="col-md-6 d-flex align-items-center">
						<h4 class="header-title"><%=rptTitle%>  </h4>
				</div>
				<div  class="col-md-6 text-right" id="addGrp"  style='display:block'>
					<div class="btn-group pull-right" id="actionicons">
						<button onclick="addMasterData()" class="btn btn-edit"><i class="mdi mdi-plus"></i>Add</button>
						<button onclick="toggleHeaderRow()" class="btn btn-clear mx-3"><i class="mdi mdi-filter"></i>Search</button>
					</div>
				</div>
				<div  class="col-md-6 text-right" id="saveGrp" style='display:none'>
					<div class="mb-3" id="actButton">
					        	<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="saveRegistration()">Save</button>
				                <button id="btnClear" class="btn btn-default" type="button" onclick="hideMasterData()">Cancel</button>
					</div>
				</div>
			</div>
			<div class="row" id="jqcontainer" style="display:block"><div class="table-container" ><div id="xyz" class="w-100"></div></div></div>	
			

			
			<div id="callback" style="display:none;font-size:13px" >
				<div class="table-container">
					
					<div class="row" >

						<div class="col-md-6 col-sm-6 mpZero">
							<div class="form-group mbotto">
								<div class="col-md-3" id="npatient"><label>Patient Name <span>*</span></label></div>
								<div class="col-md-2"><select class="form-control" id="prefix"></select></div>
								<div class="col-md-6" id="npatientv"><input type="text" class="form-control" id="patientname"><input type="hidden" class="form-control" id="code"><input type="hidden" class="form-control" id="patienttype"><input type="hidden" class="form-control" id="branchcode"><input type="hidden" class="form-control" id="refcode"><input type="hidden" class="form-control" id="grouptype"><input type="hidden" class="form-control" id="groupseqid"><input type="hidden" class="form-control" id="dvmid"><input type="hidden" class="form-control" id="tokenno"></div>
							</div>
						</div>

						
						<div class="col-md-6 col-sm-6 mpZero">
							<div class="form-group mbotto">
								<div class="col-md-1"><label></label></div>
								<div class="col-md-3"><label>Age<span>*</span></label></div>
								<div class="col-md-6"><input type="text" class="form-control" id="patientage"></div>
								<div class="col-md-2"><select class="form-control" id="agetype"></select></div>
							</div>	
						</div>

						<div  class="col-md-6 col-sm-6 mpZero">		
							<div class="form-group mbotto">
								<div class="col-md-3"><label>Gender</label></div>
								<div class="col-md-8"><select class="form-control" id="gender"></select></div>
							</div>
						</div>

						<div  class="col-md-6 col-sm-6 mpZero">		
							<div class="form-group mbotto">
								<div class="col-md-1"><label></label></div>
								<div class="col-md-3"><label>Consulting Doctor <span>*</span></label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="consultingdr"/><input type="hidden" class="form-control" id="doctorcode"/></div>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-md-6 col-sm-6 mpZero" style="display:block">
							<div class="form-group mbotto">
								<div class="col-md-3"><label>Referred By</label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="referredby"><input type="hidden" class="form-control" id="referralcode"></div>
							</div>
						</div>
					  <div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 mpZero mt-2">
							<div class="row">
								<div class="col-md-6 col-sm-6 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-3"><label>Gaurdian</label></div>
										<div class="col-md-2"><select class="form-control" id="guardiantype"></select></div>
										<div class="col-md-6"><input type="text" class="form-control" id="guardianname"></div>
									</div>
								</div>	
								
								<div class="col-md-6 col-sm-6 mpZero">
								<div class="form-group mbotto">
								<div class="col-md-1"><label></label></div>
								<div class="col-md-3"><label>Address</label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="address1"></div>
								</div>
								</div>	
								
								<div class="col-md-6 col-sm-6 mpZero"  style="display:none">
								<div class="form-group mbotto">
								<div class="col-md-3"><label> </label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="address2"></div>
								</div>
								</div>	
								
								<div class="col-md-6 col-sm-6 mpZero"  style="display:none">
								<div class="form-group mbotto">
								<div class="col-md-3"><label></label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="address3"></div>
								</div>
								</div>	
								
								<div class="col-md-6 col-sm-6 mpZero" >
								<div class="form-group mbotto">
								<div class="col-md-3"><label>Mobile No.</label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="mobileno" maxlength="10"></div>
								</div>
								</div>																	
							</div>
						</div>

						<div class="col-md-12 col-sm-12 mpZero mt-3" id="corporatedetails" style="display:none">
							<div class="subHe bline"><h5>Corporate Details</h5></div>
							<div class="row mpZero">
								<div class="clearfix"></div>
								<div class="col-md-6 col-sm-6 mpZero">
								<div class="form-group mbotto">
								<div class="col-md-3"><label>Corporate</label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="sponsorname"><input type="hidden" class="form-control" id="sponsorcode"></div>
								</div>
								</div>
								<div class="col-md-6 col-sm-6 mpZero">
								<div class="form-group mbotto">
								<div class="col-md-1"><label></label></div>
								<div class="col-md-3"><label>Corporate Card No</label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="sponsorcardno"></div>
								</div>
								</div>					
							</div>
						</div>
						<div class="clearfix"></div>
					
						<div class="col-md-12 col-sm-12 mpZero mt-3" id="patientstatus">
							<div class="subHe bline"><h5>Initial Observation</h5></div>
							<div class="row mpZero">
								<div class="col-md-6 col-sm-6 mpZero mb-3">
									<div class="form-group mbotto">
										<div class="col-md-3"><label>Appointment  Date</label></div>
										<div class="col-md-2"><input type="text" class="form-control" id="appdate" ></div>
										<div class="col-md-6">&nbsp;</div>
									</div>
								</div>
								<div class="col-md-6 col-sm-6 mpZero mb-3"></div>

								
								<div class="col-md-4 col-sm-4 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-2">
										  <label>Weight</label>
										</div>
										<div class="col-md-6">
										  <input type="text" class="form-control" id="weight"  placeholder="Kgs">
										 
										</div>
										<div class="col-md-2 ms-2 ">
											<lebel>kgs</lebel>
										</div>
									</div>
								</div>
								<div class="col-md-4 col-sm-4 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-2">
										<label>Height</label>
									  </div>
									  <div class="col-md-6">
										<input type="text" class="form-control" id="height"  placeholder="cm">
									  </div>
									  <div class="col-md-2 ms-2 ">
										  <lebel>cm</lebel>
									  </div>
									</div>
								</div>

								
								<div class="col-md-4 col-sm-4 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-2">
										<label>PR</label>
									  </div>
									  <div class="col-md-6">
										<input type="text" class="form-control" id="pr"  placeholder="/mt">
									  </div>
									  <div class="col-md-2 ms-2 ">
										  <lebel>/mt</lebel>
									  </div>
									</div>
								</div>
								<div class="col-md-4 col-sm-4 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-2">
										  <label>BP</label>
										</div>
										<div class="col-md-6">
										  <input type="text" class="form-control" id="bp"  placeholder="mm/Hg">
										  
										</div>
										<div class="col-md-2 ms-2 ">
											<label>mm/Hg</label>
										  </div>
									</div>
								</div>
								<div class="col-md-4 col-sm-4 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-2">
										  <label>BS</label>
										</div>
										<div class="col-md-6">
										  <input type="text" class="form-control" id="bs"  placeholder="mgs/di">
										  
										</div>
										<div class="col-md-2 ms-2 ">
											<label>mgs/di</label>
										  </div>
									</div>
								</div>
								<div class="col-md-4 col-sm-4 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-2">
										  <label>Temp</label>
										</div>
										<div class="col-md-6">
										  <input type="text" class="form-control" id="temp"  placeholder="F">
										 
										</div>
										<div class="col-md-2 ms-2 ">
											<label>F</label>
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

    <script>
    var ajaxObj=new FlexUI.Ajax();
 	loadBranchData();
 	<%if("300012".equals(id)){%>
 		jqReport(300012,"#xyz","&branchcode="+$('#branch').val()+"&status=<%=status%>");
 		$('#corporatedetails').css("display","none");
 	<%}else{%>
 		jqReport(23,"#xyz","&branchcode="+$('#branch').val()+"&status=<%=status%>");
 	<%}%> 	
    var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[{name:"code",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"refcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patienttype"},
  	{name:"patienttype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"prefix"},
  	{name:"prefix",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"patientname",values:"Mr~Mrs~Ms~Miss~Master",keys:"Mr~Mrs~Ms~Miss~Master"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"Patient Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"INT",caption:"Age",mandatory:true,defaultValue:"0","maxValue":0,"textLength":3,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"agetype"},
  	{name:"agetype",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"gender",values:"Yrs~Month",keys:"Yrs~Month"},
  	{name:"gender",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"consultingdr",values:"M~F",keys:"Male~Female"},
  	{name:"consultingdr",inputType:0,type:"LOV",caption:"Consulting Doctor",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"guardiantype",lovOptions:{url:"/waggle/service/ajax",ajax:"consultdoctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"doctorcode",tt:false,id:"dr_code"},{tgt:"consultingdr",tt:false,id:"dr_name"},{tgt:"consultingdr",tt:true,id:"dr_name"},{tgt:"referralcode",tt:false,id:"dr_code"},{tgt:"referredby",tt:false,id:"dr_name"},{tgt:"referredby",tt:true,id:"dr_name"}]}},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referredby",inputType:0,type:"LOV",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"admissiondate",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"referralcode",tt:false,id:"dr_code"},{tgt:"referredby",tt:false,id:"dr_name"},{tgt:"referredby",tt:true,id:"dr_name"}]}},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"admissiontype"},
	{name:"guardiantype",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"guardianname",values:"S/o~D/o~H/o~W/o~C/o~M/o~F/o",keys:"S/o~D/o~H/o~W/o~C/o~M/o~F/o"},
	{name:"guardianname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"address1"},  	
	{name:"address1",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"mobileno"},
	{name:"address2",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address3"},
	{name:"address3",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mobileno"},
	{name:"mobileno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"appdate"},
	{name:"appdate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"height"},
	{name:"weight",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"weight"},
	{name:"height",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pr"},
	{name:"pr",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"bp"},
	{name:"bp",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"bs"},
	{name:"bs",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"temp"},
	{name:"temp",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"btnSave"},
	{name:"sponsorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsorname"},
  	{name:"sponsorname",inputType:0,type:"LOV",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":true,nf:"sponsorcardno",lovOptions:{url:"/waggle/service/ajax",ajax:"insurancecompany",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"sponsorname",tt:false,id:"icm_name"},{tgt:"sponsorname",tt:true,id:"icm_name"},{tgt:"sponsorcode",tt:false,id:"icm_code"}]}},  	
  	{name:"sponsorcardno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"sponsorapprovalno"},
  	{name:"grouptype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"groupseqid",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"dvmid",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"tokenno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
	{name:"btnSave",inputType:3,caption:"",visible:false},
    {name:"btnClear",inputType:3,caption:"",visible:false}	  		
  	]}]};
	var registration=null;
	$('#screentitle').text("Admission");
    function saveRegistration(){
    	if(registration.getSaveInProgress()) return;
    	var r=null;
    	var code=screenObjects.getScreenObject("code").getValue();
    	if(code!="" && code!="0"){
	    	registration.setOperation("MOD");
	    }else{
	    	registration.setOperation("ADD");
	    }
    	registration.setScreenCode(23);
    	var d=registration.processDataToSave();
    	registration.setSaveInProgress(true);
		if("FAILED"!=d){
			var s=new FlexUI.Ajax();
			showLoader();
			r=s.callAjax("POST","/waggle/service/screen/save",d);
			hideLoader();
		 }else{
		 	registration.setSaveInProgress(false);
		 	alert("Please correct the validation errors and continue...");
		 	return;
		 }	
		 if(r.result=="Success"){
		 	<%if("300012".equals(id)){%>
				if(code!=0){
				setErrorMessage(r.message+" [No:"+ groupseqid.value+"]")   ;
			}else{
				setErrorMessage(r.message+" [No:"+r.groupseqid+"]")   ;
			}
			<%}else{%>
				if(code!=0){
				setErrorMessage(r.message+" [No:"+code+"]")   ;
				}else{
				setErrorMessage(r.message+" [No:"+r.code+"]") ;
				}
				
				if(window.confirm("Do you want to print the bill?")){
					printPrescription(r.code);
				}
			<%}%>
			var ps=JSON.parse(d.replace("data=","")).savedata;
			clearInnerScreen();
			hideMasterData();
			return r.key;			
		}else{
			registration.setSaveInProgress(false);
			alert(r.message);		
		}
    }
    function loadOrderData(url,code,did){
    	var rowData=undefined;
		 <%if("300012".equals(id)){%>
    		rowData=$("#report_300012").getRowData(did);
		<%}else{%>
	    	rowData=$("#report_23").getRowData(did);
		<%}%>
  		showLoader();
		var l=new FlexUI.Ajax();
		var v=l.callAjax("GET","/waggle/service/screen/data?screencode=23","&branchcode="+$('#branch').val()+"&patientcode="+rowData.prm_code);
		registration.loadObjectData(v);
		$('#callback').css('display','block');
		$('#xyz').css('display','none');
  		$('#jqcontainer').css('display','none');
  		$('#addGrp').css('display','none');
		$('#saveGrp').css('display','block');
  		hideLoader();
  		screenObjects.getScreenObject("patientname").focus();
  		$('#btnSave').css('display','inline-block');
    }
    function clearInnerScreen(){
    	registration.clearScreen();
    	registration.setSaveInProgress(false);
    	$("patientname").focus();
    	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
    	<%if("300012".equals(id)){%>
			screenObjects.getScreenObject("grouptype").setValue("1");
		<%}%>
	screenObjects.getScreenObject("address1").setValue("ARUPPUKOTTAI");
    	screenObjects.getScreenObject("patientname").focus();
    }
  function addMasterData(){ 
  	clearInnerScreen();
  	$('#callback').css('display','block');
  	$('#xyz').css('display','none');
	$('#jqcontainer').css('display','none');
  	$('#addGrp').css('display','none');
	$('#saveGrp').css('display','block');
  }
  function hideMasterData(){
  	clearInnerScreen();
  	$('#callback').css('display','none');
  	$('#xyz').css('display','block');
	$('#jqcontainer').css('display','block');
  	$('#addGrp').css('display','block');
	$('#saveGrp').css('display','none');
  	<%if("300012".equals(id)){%>
  		reloadGrid(300012);
  	<%}else{%>
  		reloadGrid(23);
  	<%}%>
  }
  function toggleHeaderRow(){
  	<%if("300012".equals(id)){%>
  		toggleSearchToolBar(300012);
  	<%}else{%>
  		toggleSearchToolBar(23);
  	<%}%>  	
  }
  toggleHeaderRow();
  $(document).ready(function () {
		registration=new FlexUI.Screen("registration",sProps);
		screenObjects.getScreenObject("branchcode").setValue(1);
		<%if("300012".equals(id)){%>
			screenObjects.getScreenObject("grouptype").setValue("1");
		<%}%>
		screenObjects.getScreenObject("patientname").focus();
   });
   function printPrescription(code){
   		var ccode=screenObjects.getScreenObject("code").getValue();
   		if(ccode=="" || ccode=="0") ccode=code;
   		var l=new FlexUI.Ajax();
   		var v=l.callAjax("GET","/waggle/service/screen/data?screencode=23","&branchcode="+$('#branch').val()+"&patientcode="+ccode);
   		v["type"]="RECP";
   		$.ajax({
            url: "http://localhost:9191",
            type: "POST",
            async: true,
            contentType:"application/x-www-form-urlencoded",
            data:"printdata="+JSON.stringify(v),
            dataType: "json",
            success: function (r) {
				//alert(r.result);		
            }
        });
   }
  </script>
</body>
</html>