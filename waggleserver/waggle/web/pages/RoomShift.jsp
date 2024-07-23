<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
%>
<body>
	<div class="card border-0 shadow">
		<div class="card-body lpage">
		  <!--Header-->
		  <div class="row w-100">
					  <div class="col-md-6 d-flex align-items-center">
						  <h4 class="header-title">Room Shifting </h4>
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
				<div class="bline"><h6>Patient Details</h6></div>
			 
				<div class="row w-100 cBor">
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
							<div class="col-md-4"><label class="form-lable" id="patientage"></label></div>
							<div class="col-md-2"><label for="gender" class="form-lable">Gender</label></div>
							<div class="col-md-4"><label class="form-lable" id="gender"></label></div>
						</div>
					</div>
					<div class="col-sm-12 col-md-12 col-lg-12">  
						<div class="input-group mb-1">
							<div class="col-md-2"><label for="doctorname" class="form-lable">Doctor name</label></div>
									   <div class="col-md-4"><label class="form-lable" id="doctorname"></label><input type="hidden" id="doctorcode"/></div>
									   
									   <div class="col-md-2"><label for="referredby" class="form-lable">Refer By</label></div>
									   <div class="col-md-4"><label class="form-lable" id="referredby"></label><input type="hidden" id="referralcode"/></div>
							</div>
					</div>
				</div>


	  
			   <div class="row">
				  <div class="table-container">
					<div class="col-md-12 col-sm-12 garea" id="roomgrid"></div>
				  </div>
				</div>
	  
				<div class="row w-100 mt-3">
				  <div class="col-md-4">
					<div class="hstack justify-content-start">
					  <div id="saveGrp">
						<div class="mb-3">
							<button type="button" class="btn btn-edit" onclick='saveRoomShift()'><span class="mdi mdi-check-circle-outline me-2">Save</span></button>
						     <button type="button" class="btn btn-clear" onclick='hideMasterData()'><span class="mdi mdi-refresh me-2">Cancel</span></button>
						</div>
					  </div>
					</div>
				  </div>
				</div>

		  </div>
		 <!--Content End-->
		</div>
	  </div>


	<script>
	loadBranchData();
	jqReport(12,"#xyz","&branchcode="+$('#branch').val());
    var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"ipno",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"roomno",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientname"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"doctorname"},
  	{name:"gender",inputType:4,type:"SPAN",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"doctorname"},
  	{name:"doctorname",inputType:4,type:"SPAN",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"sponsorname",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"sponsorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referralcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"referredby"},
  	{name:"referredby",inputType:4,type:"SPAN",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"roomgrid_data"},
  	{name:"smobileno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"ipno",validation:"checkIPPatientExists"},
  	{name:"btnSave",inputType:3,caption:"",visible:false},
    {name:"btnClear",inputType:3,caption:"",visible:false}
  	]},
  	{name:"roomgrid",title:"",contentType:"Table",tableProperties:{rowObject:true,serialNumberColumn:"sno",rowEmptyCheckColumn:"roomcode",optional:false,enableAddRow:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "rsdid", name: "ID", field: "rsdid",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,"chkTag":false,width:0},
    {order:"2",id: "roomcode", name: "RoomCode", field: "roomcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:0,"chkTag":false},    
  	{order:"3",id: "roomname", name: "Room", field: "roomname",defaultValue:"","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,"chkTag":true,lovOptions:{url:"/waggle/service/ajax",ajax:"rooms",scrollEnabled:true,searchFromList:false,dsi:0,
	params:[
	{n:"branchcode",src:"branchcode",tt:false}
	],results:[
	{tgt:"roomgrid_data",col:"roomname",row:"cr",tt:false,id:"rm_roomname"},
	{tgt:"roomgrid_data",col:"roomname",row:"cr",tt:true,id:"rm_roomname"},
	{tgt:"roomgrid_data",col:"roomcode",row:"cr",tt:false,id:"rm_code"},
	{tgt:"roomgrid_data",col:"wardname",row:"cr",tt:false,id:"wm_wardname"},
	{tgt:"roomgrid_data",col:"wardcode",row:"cr",tt:false,id:"rm_wardcode"}
	]},validation:"populateAdmissionTime"
	},
	{order:"4",id: "admissiondate", name: "Admission Time", field: "admissiondate",defaultValue:"","inputType":0,"type":"TDATETIME","maxValue":0,"textLength":13,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,align:"left"},	
	{order:"5",id: "wardcode", name: "WardCode", field: "wardcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,"chkTag":false},
    {order:"6",id: "wardname", name: "Ward", field: "wardname",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"left"},    	  
    {order:"7",id: "dischargedtime", name: "Discharged Time", field: "dischargedtime",defaultValue:"","inputType":0,"type":"TDATETIME","maxValue":0,"textLength":13,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:200,align:"left"}
    ]
    }}]};
	var roomshift=new FlexUI.Screen("roomshift",sProps);	
	//ajax columns
	$('#screentitle').text("Room Shift");
	var l=new FlexUI.Ajax();
    $(document).ready(function () {
    		addMasterData();
            screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
            var grid=screenObjects.getScreenObject("roomgrid_data").onBeforeDeleteRow.subscribe(onRowDelete);
            $('#subtitle').text("");
     });

	 function checkdate(){
		var Adatetimeval = $("#admissiondate").val();
		var Ddatetimeval = $("#dischargedtime").val();

		if (Adatetimeval > Ddatetimeval ) {
       alert("you can not choose date greater then current");   
    }
   else {
      alert("valid date");
	  return false;
	 }
	}
     function saveRoomShift(){
     		if(!checkPatientStatus()) return;
     		if(roomshift.getSaveInProgress()) return;
        	var r=null;
    		roomshift.setOperation("ADD");
    		roomshift.setScreenCode(12);
    		var d=roomshift.processDataToSave(null,0,2);
			// alert("the value d"+" "+ d);
    		roomshift.setSaveInProgress(true);
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",d);
				hideLoader();
		 	}else{
		 		roomshift.setSaveInProgress(false);
		 		alert("Please correct the validation errors and continue...");
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				alert(r.message);
				hideMasterData();
				roomshift.setSaveInProgress(false);
				return r.key;		
			}else{
				roomshift.setSaveInProgress(false);
				alert(r.message);		
			}


      }
      function deleteRoomShift(){
      		if(!checkPatientStatus()) return;
      		if(roomshift.getSaveInProgress()) return;
        	var r=null;
    		roomshift.setOperation("DEL");
    		roomshift.setScreenCode(12);
    		var d=roomshift.processDataToSave(null,0,1);
    		roomshift.setSaveInProgress(true);    		
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",d);
				hideLoader();
		 	}else{
		 		alert("Please correct the validation errors and continue...");
		 		return;
		 	}		 
		 	if(r.result=="Success"){
		 		roomshift.setSaveInProgress(false);		 		
				alert("Room Details Deleted Successfully");
				return "OK";			
			}else{
				roomshift.setSaveInProgress(false);				
				alert(r.message);
				return "";		
			}
      }
      
        function clearInnerScreen(){
        	$('#overlapdiv').css('display','none');
        	roomshift.clearScreen();
        	roomshift.setSaveInProgress(false);        	
        	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
        }
  function addMasterData(){ 
  	clearInnerScreen();
  	$('#callback').css('display','block');
	$('#jqcontainer').css('display','none');
  	$('#xyz').css('display','none');
  	$('#addGrp').css('display','none');
	$('#saveGrp').css('display','block');
  }
  
  function hideMasterData(){
  	//$('#callback').css('display','none');
  	//$('#xyz').css('display','block');
  	//$('#addGrp').css('display','block');
	//$('#saveGrp').css('display','none');
  	clearInnerScreen();
  	$('#smobileno').focus();
  	//reloadGrid(12);
  }
    
  function toggleHeaderRow(){
  	toggleSearchToolBar(12);
  }
  
  toggleHeaderRow();
  
  function loadOrderData(url,code,did){
  	showLoader();
	var l=new FlexUI.Ajax();
	var v=l.callAjax("GET",url,"&screencode=12");
	roomshift.loadObjectData(v);
	$('#callback').css('display','block');
  	$('#xyz').css('display','none');
	$('#jqcontainer').css('display','none');
  	$('#addGrp').css('display','none');
  	hideLoader();
  	var grid=screenObjects.getScreenObject("roomgrid_data");
	var siz=grid.getSize();
	for(var i=0;i<siz-1;i++){
		grid.getRow(i).setEditable(false);
		grid.checkAndMove("Next",false);		
	}
	grid.deleteAndMove();			
  }
  function populateAdmissionTime(id,me,row,col){
  		var grid=screenObjects.getScreenObject("roomgrid_data");
  		var cols=grid.getCols();
  		if(grid.getSize()>1 && grid.getText(row,cols.admissiondate)==""){
  			if(grid.getText(row-1,cols.dischargedtime)==""){
  				alert("Please fill the discharge date for the previous room number and continue...");
  				grid.setText(row,cols.roomcode,"");
  				grid.setText(row,cols.roomname,"");
  				grid.setText(row,cols.wardcode,"");
  				grid.setText(row,cols.wardname,"");  				
  				return false;
  			}
  			grid.setText(row,cols.admissiondate,grid.getText(row-1,cols.dischargedtime));
  		}
  		return true;
  } 
  function onRowDelete(e,args){
  	var grid=screenObjects.getScreenObject("roomgrid_data");
  	if(grid.getSize()-1==args.row){
  		var rsdid=grid.getText(args.row,grid.getCols().rsdid);
  		if(rsdid!="" && rsdid!=0){
  			if(confirm("Do you want to delete the room details?")){
	  			//call delete row
	  			var res=deleteRoomShift();
	  			if(res=="OK"){
	  				return true;
	  			}else{
	  				return false;
	  			}
	  		}else{
	  			return false;
	  		}
  		}
  		if(args.row-1>=0){
  			grid.getRow(args.row-1).setEditable(true);
  		}
	  	return true;
  	}
  	return false;
  }
  function checkPatientStatus(){
		var result=true;
		var code=screenObjects.getScreenObject("patientcode").getValue();
		var l=new FlexUI.Ajax();
		v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=patientstatus&code="+code);
		if(v!=null && v.data.length>0){
			if(v.data[0][0]==2){
				alert("Patient already discharged. Please exit the screen to continue");
				result=false;
			}
		}				
		return result;	
  }
		function checkIPPatientExists(id,me){
			if(!roomshift.getSaveInProgress()){
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
  </script>
</body>
</html>