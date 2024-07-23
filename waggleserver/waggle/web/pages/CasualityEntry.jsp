<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>
</head>
<%
   String mode=request.getParameter("mode");
   String code=request.getParameter("code");
%>
<body>

	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100 mb-3">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Casualty Slip</h4>
				</div>
				<div  class="col-md-6 text-right" id="addGrp" style="display:none"></div>
				<div  class="col-md-6 text-right" id="actButton" >
					<div class="mb-3">
						<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="saveCasuality()">Save</button>
	                    <button id="btnClear" class="btn btn-default" type="button" onclick="clearInnerScreen()">Cancel</button>
                    </div>
				</div>
			</div>
			
			<div class="row" id="jqcontainer" style='display:none'> <div class="table-container" > <div id="xyz" class="w-100" > </div></div></div>	
			<div id="callback"  >	
				<div class="table-container">
					<div class="row w-100 ml-8">                    
						<div class="col-md-12 col-sm-12 mpZero">
							<div class="col-md-8 col-sm-8 mpZero">
								<div class="form-group mbotto">
								<div class="col-md-4"><label>Patinet Name </label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="patientname"></div>
								</div>
							</div>
							<div class="clearfix"></div>	
							<div class="col-md-8 col-sm-8 mpZero">	
								<div class="form-group mbotto">
									<div class="col-md-4"><label>Age</label></div>
									<div class="col-md-8"><input type="text" class="form-control" id="patientage"></div>
								</div>
								</div>	
								<div class="col-md-8 col-sm-8 mpZero">
									<div class="form-group mbotto">
										<div class="col-md-4"><label>Gender</label></div>
										<div class="col-md-8"><select class="form-control" id="gender"></select></div>
									</div>
								</div>
							<div class="clearfix"></div>
							<div class="col-md-8 col-sm-8 mpZero">	
									<div class="form-group mbotto">
										<div class="col-md-4"><label>Is MLC</label></div>
										<div class="col-md-8"><select class="form-control" id="ismlc"></select></div>
									</div>
								</div>	
							
								<div class="col-md-8 col-sm-8 mpZero">
								<div class="form-group mbotto">
								<div class="col-md-4"><label>Doctor name </label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="doctorname"><input type="hidden" id="doctorcode"/></div>
								</div>
							</div>
							<div class="clearfix"></div>	
							<div class="col-md-8 col-sm-8 mpZero">
								<div class="form-group mbotto">
								<div class="col-md-4"><label>Refer By  </label></div>
								<div class="col-md-8"><input type="text" class="form-control" id="referredby"><input type="hidden" id="referralcode"/></div>
								</div>
							</div>
																	
						 </div>
					</div>
				</div> 
			</div>
		</div>
	</div>

	
	<script>
	loadBranchData();
    var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[
  	{name:"code",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billno"},
  	{name:"billno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":3,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"gender"},
  	{name:"gender",inputType:1,type:"TEXT",caption:"",mandatory:true,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"ismlc",values:"M~F",keys:"Male~Female"},
  	{name:"ismlc",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"doctorname",values:"0~1",keys:"No~Yes"},
  	{name:"doctorname",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"referredby",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"doctorcode",tt:false,id:"dr_code"},{tgt:"doctorname",tt:true,id:"dr_name"},{tgt:"doctorname",tt:false,id:"dr_name"},{tgt:"referralcode",tt:false,id:"dr_code"},{tgt:"referredby",tt:false,id:"dr_name"},{tgt:"referredby",tt:true,id:"dr_name"}]}},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referredby",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"billgrid_data",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"referralcode",tt:false,id:"dr_code"},{tgt:"referredby",tt:false,id:"dr_name"},{tgt:"referredby",tt:true,id:"dr_name"}]}},
  	{name:"entrydate",inputType:0,type:"TDATE",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},  	
  	{name:"btnSave",inputType:3,caption:"",visible:false,readOnly:true},
    {name:"btnClear",inputType:3,caption:"",visible:false,readOnly:true}
  	]
  	}]};
	var casuality=new FlexUI.Screen("casuality",sProps);	
	var l=new FlexUI.Ajax();
    $(document).ready(function () {
            screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
            $('#subtitle').text("");
            $('#screentitle').text("Casuality");
            screenObjects.getScreenObject("patientname").focus();
        });
        function saveCasuality(){
        	if(casuality.getSaveInProgress()) return;
        	var r=null;
    		casuality.setOperation("ADD");
    		casuality.setScreenCode(16);
    		var d=casuality.processDataToSave();
    		casuality.setSaveInProgress(true);
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",d);
				hideLoader();
		 	}else{
		 		casuality.setSaveInProgress(false);
		 		alert("Please correct the validation errors and continue...");
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				alert(r.message+" [No:"+r.code+"]");
				clearInnerScreen();
				var ps=JSON.parse(d.replace("data=","")).savedata;
				ps["billno"]=r.billno;
				ps["mlccode"]=r.mlccode;
				printCasuality(ps);
				return r.key;			
			}else{
				casuality.setSaveInProgress(false);
				alert(r.message);		
			}
        }
        function clearInnerScreen(){
        	casuality.clearScreen();
        	casuality.setSaveInProgress(false);
        	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
        	screenObjects.getScreenObject("patientname").focus();
        }
		function printCasuality(data){
			var printData={};
			printData["type"]="CS";
			printData["branchname"]=$('#branch option:selected').text();
			printData["address1"]="27,Javulikara Street";
			printData["address2"]="Tiruvarur - 610 001";
			printData["address3"]="Phone - 242292,240292";
			printData["billno"]=data["billno"];
			printData["billdate"]=data["entrydate"]+" "+formatTimeHHMM(new Date());
			printData["doctorname"]=data["doctorname"]+"";
			printData["referredby"]=data["referredby"]+"";
			printData["patientname"]=data["patientname"];		
			printData["patientage"]=data["patientage"];
			printData["gender"]=data["gender"];
			printData["mlccode"]=data["mlccode"];
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
	</script>
</body>
</html>