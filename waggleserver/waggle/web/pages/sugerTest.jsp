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

   
%>
<body>	

	<div class="card border-0 shadow">
		<div class="card-body lpage">
		  <!--Header-->
		  <div class="row w-100">
					  <div class="col-md-6 d-flex align-items-center">
						  <h4 class="header-title">Sugar Test</h4>
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

				<div class="col-sm-12 col-md-12 col-lg-12 " id="divsearch">   
					<div class="input-group mb-1">  
						<div class="col-md-2"><label for="smobileno" class="form-lable">Search By </label></div>
						<div class="col-md-4"><input type="text" class="form-control" id="smobileno"/></div>
						<div  class="col-md-6 col-sm-6 mpZero">
							<div class="col-md-12 form-lable">Reg No:&nbsp;<label  class="form-lable" id="lcsno"></label></div>
						</div>
					</div>  
				</div>  

				<div class="col-sm-12 col-md-12 col-lg-12 " id="divsearch">   
					<div class="input-group mb-1">  
						<div class="col-md-2"><label class="form-lable">IP No</label></div>
						<div class="col-md-4"><input type="text" class="form-control" id="ipno"><input type="hidden" id="sponsorname"/><input type="hidden" id="sponsorcode"/></div>
					
						
					</div>  
				</div> 
				 
				<div class="col-sm-12 col-md-12 col-lg-12">  
					<div class="input-group mb-1">
									<div class="col-md-2"><label for="patientname" class="form-lable">Patient Name </label></div>
									<div class="col-md-4"><input type="text" class="form-control" id="patientname"><input type="hidden" class="form-control" id="patientcode"><input type="hidden" class="form-control" id="hospregcode"><input type="hidden" class="form-control" id="crno"><input type="hidden" class="form-control" id="crsno"><input type="hidden" class="form-control" id="crstatus" value="1,2"></div>

								   <div class="col-md-2"><label for="testtime" class="form-lable">Date & Time  </label></div>
								   <div class="col-md-4"><input type="text" class="form-control" id="testtime"></div>
					</div>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12">  
					<div class="input-group mb-1">
						<div class="col-md-2"><label for="patientage" class="form-lable">Age </label></div>
						<div class="col-md-4"><input type="text" class="form-control" id="patientage"></div>
						<div class="col-md-2"><label for="gender" class="form-lable">Gender</label></div>
						<div class="col-md-4"><select class="form-control" id="gender"></select></div>
					</div>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-12">  
					<div class="input-group mb-1">
						<div class="col-md-2"><label for="doctorname" class="form-lable">Doctor name</label></div>
								   <div class="col-md-4"><input type="text" class="form-control" id="doctorname"><input type="hidden" id="doctorcode"/></div>
								   
								   <div class="col-md-2"><label for="technician" class="form-lable">Technician</label></div>
								   <div class="col-md-4"><input type="text" class="form-control" id="technician"><input type="hidden" id="referralcode"/></div>
						</div>
				</div>


				

			   </div>
	  
			   <div class="row">
				  <div class="table-container">
					  <div class="col-md-12 col-sm-12 garea" id="testgrid"></div>
				  </div>
				</div>
	  

				<div class="row w-100 mt-3">
					<div class="col-md-4">
					  <div class="hstack justify-content-start">
						<div id="saveGrp">
							<button id="btnPrintReport" class="btn btn-save mx-1" type="button" onclick="printLabReport()"><span class="mdi mdi-printer me-2"></span>Print Report</button>
							<button id="btnLoadCR" class="btn btn-edit mx-1" type="button" onclick="loadClinicalRequests()"><span class="mdi mdi-bell-plus me-2"></span>Test Requests</button>
							<button id="btnClearScr" class="btn btn-clear mx-1" type="button" onclick="clearInnerScreen()"><span class="mdi mdi-refresh me-2"></span>Clear</button>
						</div>
					  </div>
					</div>
					
				</div>
				</div>
		  </div>
		 <!--Content End-->
		</div>




	<script>
	loadBranchData();
	
		groupw=200;
		testunitw=100;
		testrangew=200;
		testactualw=150;
		testnamew=200;
		testnotesw=200;
		xrayv=true;
		
    var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[{name:"code",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billno"},
  	{name:"billno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"billtype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"2","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"patienttype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"2","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"ipno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"patientname"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"patientage"},
  	{name:"patientcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"gender"},
  	{name:"gender",inputType:1,type:"TEXT",caption:"",mandatory:true,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"testtime",values:"M~F",keys:"Male~Female"},
  	{name:"testtime",inputType:0,type:"DATETIME",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"doctorname"},
  	{name:"doctorname",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"technician",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"doctorcode",tt:false,id:"dr_code"},{tgt:"doctorname",tt:true,id:"dr_name"},{tgt:"doctorname",tt:false,id:"dr_name"}]}},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"technician"},  	  	  
  	{name:"technician",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"btnSave"},
  	{name:"grouptest",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"btnSave"},
  	{name:"billdate",inputType:0,type:"TDATE",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},  	
  	{name:"hospregcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"crno",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"crsno",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"crstatus",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"smobileno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"ipno",validation:"checkIPPatientExists"},
  	{name:"btnSave",inputType:3,caption:"",visible:false,readOnly:true},
    {name:"btnClear",inputType:3,caption:"",visible:false,readOnly:true}
  	]},
  	{name:"testgrid",title:"",contentType:"Table",tableProperties:{rowObject:true,serialNumberColumn:"sno",enableDeleteRow:true,enableAddRow:true,rowEmptyCheckColumn:"testdatetime",optional:false,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "testdatetime", name: "Test Date Time", field: "testdatetime",defaultValue:"","inputType":0,"type":"TDATETIME","maxValue":0,"textLength":100,"decimalLength":0,"visible":xrayv,"readOnly":false,"mandatory":true,width:groupw,align:"left"},
    
  
    {order:"2",id: "timings", name: "Type of Test", field: "timings",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:testactualw,"chkTag":true,lovOptions:{url:"/waggle/service/ajax",ajax:"sugertesttype",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[
  		{tgt:"testgrid_data",tt:false,row:"cr",id:"TestType",col:"timings"},
  	{tgt:"testgrid_data",tt:true,row:"cr",id:"TestType",col:"timings"},
  	{tgt:"testgrid_data",tt:false,row:"cr",id:"TestRefUnit",col:"testunit"},
  	{tgt:"testgrid_data",tt:false,row:"cr",id:"TestRefRange",col:"testrange"}
  	]}},
  	
    {order:"3",id: "testactual", name: "Actual", field: "testactual",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:testactualw,align:"left",onchange:"onDetailChange"},
  	{order:"4",id: "testunit", name: "Unit", field: "testunit",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":100,"decimalLength":0,"visible":xrayv,"readOnly":true,"mandatory":false,width:testunitw,align:"left"},
    {order:"5",id: "testrange", name: "Range", field: "testrange",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":100,"decimalLength":0,"visible":xrayv,"readOnly":true,"mandatory":false,width:testrangew,align:"left"}

    ]
    }}]};
	var labbill=new FlexUI.Screen("labbill",sProps);
	//ajax columns ,values:"F~PP~R",keys:"F~PP~R"
	var l=new FlexUI.Ajax();
    $(document).ready(function () {
    	
		$('#divfootmenu').css("display","block");
		$('#divsearch').css("display","block");
		
		screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
        screenObjects.getScreenObject("testgrid_data").getInputField().onTextKeyDown.subscribe(tableTextKeyDown);
        screenObjects.getScreenObject("testgrid_data").onAfterDeleteRow.subscribe(tableRowDelete);
        $('#subtitle').text("");
        
			screenObjects.getScreenObject("crno").setMandatory(false);
			screenObjects.getScreenObject("crsno").setMandatory(false);
			screenObjects.getScreenObject("grouptest").setValue("1");
			
        screenObjects.getScreenObject("smobileno").focus();
            
    
            
        });

		function onDetailChange(){

			
			alert("its in fn");
			var totalActual = $("#testactual").val();
			alert("totalActual:"+" "+totalActual);

			
		}

        function saveLabBill(){

        	if('<%=mode%>'=="View") return;
        	if(labbill.getSaveInProgress()) return;
        	
        	screenObjects.getScreenObject("grouptest").setValue("1");
        	
        	var r=null;
        	var code=toNumber(screenObjects.getScreenObject("code").getValue());
        	if(code!=0){
    			labbill.setOperation("MOD");
        	}else{
    			labbill.setOperation("ADD");
    		}
    		labbill.setScreenCode(28);    		
    		var d=labbill.processDataToSave();
    		labbill.setSaveInProgress(true);   
    		 		
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",d);
				hideLoader();
		 	}else{
		 		alert("Please correct the validation errors and continue...");
		 		labbill.setSaveInProgress(false);
		 		return;
		 	}		 
			try{		 
		 	if(r.result=="Success"){
				setErrorMessage(r.message+" [No:"+code+"]")   ;
				clearInnerScreen();
				return r.key;			
			}else{
				labbill.setSaveInProgress(false);								
				alert(r.message);	
			}
			}catch(e){    		labbill.setSaveInProgress(false);}
        }
        function clearInnerScreen(){
        	labbill.clearScreen();
			$("#lcsno").text("");
        	labbill.setSaveInProgress(false);  
        	screenObjects.getScreenObject("crstatus").setValue("1,2");
        	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
       		screenObjects.getScreenObject("smobileno").focus();
        }
		function tableTextKeyDown(e,args){
			var key=e.which || e.keyCode;
			if(key==113){
				e.preventDefault();
				saveLabBill();
			}
		}
		function tableRowDelete(e,args){
		}
		function loadClinicalRequests(id,me){
			var l={url:"/waggle/service/ajax",ajax:"sugertest",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branchcode",src:"branchcode",ft:false},{n:"status",src:"crstatus",ft:false}],results:[],standalone:true};
			var lov=new FlexUI.LOV("cr_lov",me,l);
			lov.onLovClose.subscribe(onClinicalRequestLoad);
			lov.show();
			
		}
		function onClinicalRequestLoad(e,args){
			showLoader();
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			var code=args.result[3];
			var l=new FlexUI.Ajax();
			var v=l.callAjax("GET","/waggle/service/screen/data?screencode=28&branchcode="+branch+"&crsno="+code,"");
			clearInnerScreen();
			labbill.loadObjectData(v);

		  	hideLoader();
		}
		function printLabReport(){
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			var code=screenObjects.getScreenObject("code").getValue();
			if(toNumber(code)!=0){
				var url="/waggle/service/discharge/printsugertest?branchcode="+branch+"&billno="+code;
				window.open(url,"_blank");
			}
		}
		
		function checkIPPatientExists(id,me){
			if(!labbill.getSaveInProgress()){
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
							getPatientInfo(branch,v.data[0]);					
							return true;
						}else if(v.data && v.data.length>1){
							screenObjects.getScreenObject("smobileno").setTag(stext);
							var d=null;
							d={url:"/waggle/service/ajax",ajax:"hospinpatients",scrollEnabled:true,searchFromList:false,dsi:dsi,edsi:1,params:[{n:"branchcode",src:"branchcode",ft:false},{n:"searchtxt",src:"smobileno",ft:false}],results:[],standalone:true};
							var lov=new FlexUI.LOV("s_lov",me,d,v.data);
							lov.onLovClose.subscribe(onPatientClose);
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
		function onPatientClose(e,args){
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			loadOrderData("/waggle/service/screen/data?branchcode="+branch+"&patientcode="+args.result[20],0,"")
		}		
		function getPatientInfo(branch,result){
			$('#lcsno').text(result[1]);
			loadOrderData("/waggle/service/screen/data?branchcode="+branch+"&patientcode="+result[20],0,"");
		}
		function loadOrderData(url,code,did){
		  	showLoader();
			var l=new FlexUI.Ajax();
			var v=l.callAjax("GET",url,"&screencode=12");
			labbill.loadObjectData(v);
			$('#callback').css('display','block');
		  	$('#xyz').css('display','none');
		  	$('#addGrp').css('display','none');
		  	hideLoader();
		  	var grid=screenObjects.getScreenObject("testgrid_data");
			var siz=grid.getSize();
			for(var i=0;i<siz-1;i++){
				grid.getRow(i).setEditable(false);
				grid.checkAndMove("Next",false);		
			}
			grid.deleteAndMove();			
		}		

		
	</script>
</body>
</html>