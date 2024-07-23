<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String status=request.getParameter("status");
%>
<body>
	<div class="clearfix"></div>
	<div id="branchcontainer" class="brTp" style="display:block;z-index:999">
		<select class="form-control" id='branch' onchange="changeBranchCodeAndClearSubScreenData()"></select>
    </div>		
	<div class="col-sm-12 col-md-12 col-lg-12 mpZero marTp">
	    <div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
			Patient Details
		
	</div>
	<div class="clearfix"></div>	
	<div class="col-md-12 col-sm-12 mpZero">

		<div class="col-md-12 col-sm-12 mpZero" id="callback" >
				<div style="margin: 0px;">
				<div class="panelBx">
			    <div id='container'>
				<div class="col-md-12 panelOrange hcH" >
					   <div class="col-md-12 col-sm-12 mpZero" id="patientsearchcont">
							<div  class="col-md-6 col-sm-6 mpZero">
							<div class="form-group mbotto">
								<div class="col-md-4"><label>Search By </label></div>
								<div class="col-md-8"><select class="form-control" id="searchpatient"><option value="regno">Reg No</option><option value="mobile">Mobile No</option></select></div>
							</div>
							</div>
							<div  class="col-md-6 col-sm-6 mpZero">		
							<div class="form-group mbotto">
								<div class="col-md-12"><input type="text" class="form-control" id="smobileno"/></div>
							</div>
							</div>								
						</div>				
						<div class="col-md-12 col-sm-12 mpZero">
							<div  class="col-md-12 col-sm-12 mpZero" id="patientcont">
							<div class="form-group mbotto">
								<div class="col-md-2" id="npatient"><label>Patient Name </label></div>
								<div class="col-md-2"><select class="form-control" id="prefix"></select></div>
								<div class="col-md-8" id="npatientv"><input type="text" class="form-control" id="patientname"><input type="hidden" class="form-control" id="code"><input type="hidden" class="form-control" id="branchcode" value="1"><input type="hidden" class="form-control" id="ipno"><input type="hidden" class="form-control" id="refcode"><input type="hidden" class="form-control" id="hospregcode"><input type="hidden" class="form-control" id="bucode"><input type="hidden" class="form-control" id="claimno"></div>
							</div>
							</div>
														
						</div>
						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 mpZero">
							<div  class="col-md-6 col-sm-6 mpZero">		
							<div class="form-group mbotto">
								<div class="col-md-4"><label>Age</label></div>
								<div class="col-md-6"><input type="text" class="form-control" id="patientage"></div>
								<div class="col-md-2"><select class="form-control" id="agetype"></select></div>
							</div>
							</div>	
							<div  class="col-md-6 col-sm-6 mpZero">		
							<div class="form-group mbotto">
								<div class="col-md-4"><label>Gender</label></div>
								<div class="col-md-8"><select class="form-control" id="gender"></select></div>
							</div>
							</div>
						</div>
						<div class="clearfix"></div>
						
						<div class="col-md-12 col-sm-12 mpZero">
							<div class="col-md-6 col-sm-6 mpZero">
								<div class="form-group mbotto">
									<div class="col-md-4"><label>Consuting Doctor </label></div>
									<div class="col-md-8"><input type="text" class="form-control" id="consultingdr"/><input type="hidden" class="form-control" id="doctorcode"/></div>
								</div>
							</div>
							<div class="col-md-6 col-sm-6 mpZero">
								<div class="form-group mbotto">
									<div class="col-md-4"><label>Refered By</label></div>
									<div class="col-md-8"><input type="text" class="form-control" id="referredby"><input type="hidden" class="form-control" id="referralcode"></div>
								</div>
							</div>
						</div>
					<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 mpZero">
							<div class="col-md-6 col-sm-6 mpZero">
								<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-4"><label>Gaurdian</label></div>
										<div class="col-md-2"><select class="form-control" id="guardiantype"></select></div>
										<div class="col-md-6"><input type="text" class="form-control" id="guardianname"></div>
									</div>
								</div>
								
								<div class="clearfix"></div>
								<div class="col-md-12 col-sm-12 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-4"><label>Mobile No.</label></div>
										<div class="col-md-8"><input type="text" class="form-control" id="mobileno"></div>
									</div>
								</div>
							</div>
							<div class="col-md-6 col-sm-6 mpZero">
								<div class="col-md-12 col-sm-12 mpZero">
								<div class="form-group mbotto">
								<div class="col-md-4"><label>Address</label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="address1"></div>
								</div>
								</div>	
								<div class="clearfix"></div>
								<div class="col-md-12 col-sm-12 mpZero">
								<div class="form-group mbotto">
								<div class="col-md-4"><label> </label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="address2"></div>
								</div>
								</div>	
								<div class="clearfix"></div>
								<div class="col-md-12 col-sm-12 mpZero">
								<div class="form-group mbotto">
								<div class="col-md-4"><label></label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="address3"></div>
								</div>
								</div>	
							</div>
									
								<div class="clearfix"></div>
																									
						</div>
						<div class="col-md-12 col-sm-12 mpZero">
							<div class="subHe">Test Details</div>
								<div class="row">
									<div class="col-lg-6">
						            	<div class="panel panel-info">
						              		<div class="panel-heading">
						                		<h3 class="panel-title"><i class="fa fa-long-arrow-right"></i>Test Details</h3>
						              		</div>
						              		<div class="panel-body">
						                		<div class="flot-chart">
						                  			<div class="flot-chart-content"  style="height:150px"><table id="patienttests" width="100%" ></table></div>
						                		</div>
		  					                </div>
						                </div>
						            </div>
							    
							          <div class="col-lg-3">
							            <div class="panel panel-info">
							              <div class="panel-heading">
								                <div class="row">
								                   <div class="col-xs-1 mpZero">
								                    <i class="fa fa-dollar fa-5x"></i>
								                  </div>
								                  <div class="col-xs-11 text-right">
								                    <p class="announcement-text">Prescriped Tests</p>
								                    <p id="todaytests" class="announcement-heading">0</p>
								                    
								                  </div>
								                </div>
							              </div>
							            </div>
							          </div>
							           <div class="col-lg-3">
							            <div class="panel panel-info">
							              <div class="panel-heading">
								                <div class="row">
								                   
								                  <div class="col-xs-12 text-right">
								                    <i class="fa fa-print fa-5x" onclick="printPrescription()" style="cursor:pointer"></i>
								                    <p class="announcement-text">Print Prescription</p>
								                  </div>
								                </div>
							              </div>
							            </div>
							          </div>
							          
							      </div>        
						</div>
				<div class="clearfix"></div>	
				
				
			            	<div id="actButton" class="col-md-12 ">
			                	<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="saveAdmission()">Save</button>
				                <button id="btnClear" class="btn btn-default" type="button" onclick="hideMasterData()">Cancel</button>
			            	</div>
			       </div>  <!-- Pannel Box1 -->	
				</div> <!-- Container -->
			            </div> <!-- Panel box -->
			       </div>
		</div>
	</div>
	
    <script>
    var ajaxObj=new FlexUI.Ajax();
 	loadBranchData();
	
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
  	{name:"prefix",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientname",values:"Mr~Mrs~Ms~Miss~Master",keys:"Mr~Mrs~Ms~Miss~Master"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"agetype"},
  	{name:"agetype",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"gender",values:"Yrs~Month",keys:"Yrs~Month"},
  	{name:"gender",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"accounttype",values:"M~F",keys:"Male~Female"},
  	{name:"consultingdr",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":true,nf:"referredby",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"doctorcode",tt:false,id:"dr_code"},{tgt:"consultingdr",tt:false,id:"dr_name"},{tgt:"consultingdr",tt:true,id:"dr_name"},{tgt:"referralcode",tt:false,id:"dr_code"},{tgt:"referredby",tt:false,id:"dr_name"},{tgt:"referredby",tt:true,id:"dr_name"}]}},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referredby",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":true,nf:"admissiondate",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"referralcode",tt:false,id:"dr_code"},{tgt:"referredby",tt:false,id:"dr_name"},{tgt:"referredby",tt:true,id:"dr_name"}]}},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"admissiontype"},
	{name:"guardiantype",inputType:1,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"guardianname",values:"S/o~D/o~H/o~W/o~C/o~M/o~F/o",keys:"S/o~D/o~H/o~W/o~C/o~M/o~F/o"},
	{name:"guardianname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address1"},  	
	{name:"address1",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address2"},
	{name:"address2",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address3"},
	{name:"address3",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"mobileno"},
	{name:"mobileno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"sponsorname"},
	{name:"btnSave",inputType:3,caption:"",visible:false},
    {name:"btnClear",inputType:3,caption:"",visible:false}	  		
  	]}]};
	var admission=null;
	$('#screentitle').text("Patient Detail");
    $(document).ready(function () {
    	admission=new FlexUI.Screen("admission",sProps);
    	//screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
    	screenObjects.getScreenObject("branchcode").setValue(1);
    	screenObjects.getScreenObject("smobileno").focus();
    	screenObjects.getScreenObject("prefix").setEnabled(false);
    	screenObjects.getScreenObject("patientname").setEnabled(false);
    	screenObjects.getScreenObject("patientage").setEnabled(false);
    	screenObjects.getScreenObject("agetype").setEnabled(false);
    	screenObjects.getScreenObject("gender").setEnabled(false);
    	screenObjects.getScreenObject("consultingdr").setEnabled(false);
    	screenObjects.getScreenObject("referredby").setEnabled(false);
    	
    	screenObjects.getScreenObject("guardiantype").setEnabled(false);
    	screenObjects.getScreenObject("guardianname").setEnabled(false);
    	screenObjects.getScreenObject("address1").setEnabled(false);
    	screenObjects.getScreenObject("address2").setEnabled(false);
    	screenObjects.getScreenObject("address3").setEnabled(false);
    	screenObjects.getScreenObject("mobileno").setEnabled(false);
    	
    	
    });
    function loadOrderData(url,code,did){
    	
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
	  		screenObjects.getScreenObject("admissiondate").setEnabled(false);
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
		function onPatientClose(e,args){
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
			
			screenObjects.getScreenObject("prefix").setValue(result[23]);
			screenObjects.getScreenObject("agetype").setValue(result[24]);
			
			if($('#searchpatient').val()=="mobile"){
				screenObjects.getScreenObject("smobileno").setValue(result[0]);
			}else{
				screenObjects.getScreenObject("smobileno").setValue(result[1]);
			}	
			screenObjects.getScreenObject("smobileno").goToNextField();			
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
		function printPrescription(code){
	   		var l=new FlexUI.Ajax();
	   		//var v=l.callAjax("GET","/waggle/service/screen/data?screencode=300013","&appid="+$('#dappid').val());
	   		var v=l.callAjax("GET","/waggle/service/screen/data?screencode=300013","&appid="+code);
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
		/*
		,lovOptions:{url:"/waggle/service/ajax",ajax:"hosppatients",scrollEnabled:true,searchFromList:false,dsi:0,invokeLovOnClick:false,params:[{n:"branchcode",src:"branchcode",tt:false}],results:[
  	{tgt:"patientname",tt:false,id:"prm_name"},  	
  	{tgt:"hospregcode",tt:false,id:"prm_code"},
  	{tgt:"patientage",tt:false,id:"prm_age"},
  	{tgt:"gender",tt:false,id:"prm_gender"},
  	{tgt:"doctorcode",tt:false,id:"prm_consulting_dr"},
  	{tgt:"doctorname",tt:false,id:"dr_name"},
  	{tgt:"referralcode",tt:false,id:"prm_referral_dr"},
  	{tgt:"referredby",tt:false,id:"refdoctor"},
  	{tgt:"mobileno",tt:false,id:"prm_mobileno"},
  	{tgt:"address1",tt:false,id:"prm_address1"},
  	{tgt:"address2",tt:false,id:"prm_address2"},
  	{tgt:"address3",tt:false,id:"prm_address3"},
  	{tgt:"guardiantype",tt:false,id:"prm_guardian_type"},
  	{tgt:"guardianname",tt:false,id:"prm_guardian_name"},
  	{tgt:"refcode",tt:false,id:"prm_ref_code"}
  	]}*/
	</script>
</body>
</html>