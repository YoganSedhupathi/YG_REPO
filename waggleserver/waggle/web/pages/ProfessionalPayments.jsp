<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Admission</title>
</head>
<%
   String mode=request.getParameter("mode");
   String doctorcode=request.getParameter("doctorcode");
   String userId=(String)session.getAttribute("LOGIN_ID");
   String branch=request.getParameter("branch");
   String screenCode=request.getParameter("screencode");
   String fromDate=request.getParameter("fromdate");
   String toDate=request.getParameter("todate");
   String doctorName=request.getParameter("doctorname");
   if(fromDate==null){
	fromDate="";
   }
   if(toDate==null){
	 toDate="";
   }
   if(mode==null){
   	 mode="";
   }
%>
<body>
	<div id="branchcontainer" class="brTp" style="display:block;z-index:999">
		<select class="form-control" id='branch' onchange="changeBranchCodeAndClearSubScreenData()"></select>
    </div>
    <div class="col-sm-12 col-md-12 col-lg-12 mpZero  marTp" id="heading">
    	<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
			Professional Payments
			<div id="addGrp" class="btn-group pull-right">
				<div class="btn-group pull-right" id="actionicons">
					<button onclick="addMasterData()" class="btn btn-sm addColB"><i class="fa fa-plus"></i></button>
					<button onclick="toggleHeaderRow()" class="btn btn-sm seaColB"><i class="fa fa-search"></i></button>
				</div>
			</div>		
		</div>
	</div>    
	<div class="col-md-12 col-sm-12 mpZero ">
		<div class="col-md-12 col-sm-12 mpZero marTp" id="xyz">
		</div>		
		<div class="col-md-12 col-sm-12 mpZero" id="callback" style="display:none">
		<div class="col-md-12 col-sm-12 mpZero">
		<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
			<div class="col-md-6 col-sm-6 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-2"><label>From Date</label></div>
					<div class="col-md-10"><input type="text" class="form-control" id="fromdate"></div>
				</div>
			</div>
			<div class="col-md-6 col-sm-6 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-2"><label>To Date</label></div>
					<div class="col-md-10"><input type="text" class="form-control" id="todate"/></div>
				</div>
			</div>
			<div class="col-md-6 col-sm-6 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-2"><label>Doctor name </label></div>
					<div class="col-md-10"><input type="text" class="form-control" id="doctorname"><input type="hidden" id="doctorcode"/><input type="hidden" id="code"/><input type="hidden" id="paymentno"/></div>
				</div>
			</div>
			<div class="col-md-6 col-sm-6 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-2"><label>Payment Date</label></div>
					<div class="col-md-10"><input type="text" id="paydate"/></div>
				</div>
			</div>			
		 </div>
		</div>
		<div class="clearfix"></div>	
		 <div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
      		 <div class="col-md-12 col-sm-12 mpZero" id="patientgrid" style="height:280px">
			<span>Patient Grid<span/>
			</br>
			</br>
			</br>
			</br>
			</br>
			</br>
			</br>
			</br>
			</br>
			</br>
			</br>
			</br>
			</br>
			</br>
			</br>
		  </div>
		</div>
		<div class="clearfix"></div>
		<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
			<div class="col-md-3 col-sm-3 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-3"><label>Total </label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="totalamt" disabled></div>
				</div>
			</div>
			<div class="col-md-3 col-sm-3 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-3"><label>Discount </label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="totaldiscount" disabled></div>
				</div>
			</div>
			<div class="col-md-3 col-sm-3 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-3"><label>Amount </label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="payableamount" disabled></div>
				</div>
			</div>								
			<div class="col-md-3 col-sm-3 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-4"><label>TDS %</label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="tdspercentage"></div>
				</div>
			</div>
			<div class="col-md-3 col-sm-3 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-3"><label>TDS </label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="tdsamount" disabled><input type="hidden" class="form-control" id="netamount"></div>
				</div>
			</div>
			<div class="col-md-3 col-sm-3 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-3"><label>Ledger</label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="ledgername"><input type="hidden" class="form-control" id="ledgercode"></div>
				</div>
			</div>
			<div class="col-md-3 col-sm-3 mpZero">
				<div class="form-group mbotto">
				<div class="col-md-3"><label>Cheque No</label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="chequeno"></div>
				</div>
			</div>			
						
		 </div>
		<div class="clearfix"></div>	
		 <div class="col-md-12 col-sm-12 mpZero">
      		 <div class="col-md-12 col-sm-12 mpZero">
      		   <div class="col-md-5 text-left">
      		 		<button id="btnSave" class="btn btn-primary" type="button" onclick="saveProfessionalPayments()">Save</button>
      		 		<button id="btnClearScr" class="btn btn-default" type="button" onclick="hideMasterData()">Close</button>
      		 	</div>      		 
      		 	<div class="col-md-7 text-right mpZero">
      		 		<div style="background:#fedc34; display:inline-block; width:100%; padding-top:5px;" >
	    				<div class="netAm" id="netAmt">Net Amount 0.00</div>
    				</div>
      		 	</div>
			</div>
		</div>
		</div>
	</div>
	 <div id='changedrdlg' class='pop_lov_box' style="display:none">
			<div id='changedrtitle' class='pop_lov_hed_box'>
			<div class='pop_lov_clos'>
				<a href='#'>
					<span class='fa fa-times-circle'>
					</span>
				</a>
			</div>
			<div class='pop_lov_hed_txt'><span id="changedripno"></span></div>
			</div>
			<div id='changedrd' class='pop_lov_inp_box'>
				<div class="col-md-12 col-sm-12 mpZero">
					<div class="col-md-12 col-sm-12 mpZero">
						<div class="form-group mbotto">
							<div class="col-md-4"><label>Doctor Name</label></div>
							<div class="col-md-8">
							<input class="form-control" type="text" id="codoctorname" disabled/>
							</div>
						</div>
					</div>												
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>IP No</label></div>
						<div class="col-md-8">
							<input class="form-control" id="cipno" disabled/>
							<input type="hidden" id="billsno" value="0"/>
							<input type="hidden" id="billno" value="0"/>
							<input type="hidden" id="branchcode" value="0"/>
						</div>
					</div>
					</div>
					<div  class="col-md-12 col-sm-12 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Patient Name</label></div>
						<div class="col-md-8">
							<input class="form-control" id="cpatientname" disabled/>
						</div>
					</div>
					</div>
					<div class="col-md-12 col-sm-12 mpZero">
						<div class="form-group mbotto">
						<div class="col-md-4"><label>New Doctor name </label></div>
						<div class="col-md-8">
							<input type="text" class="form-control" id="cdoctorname"><input type="hidden" id="cdoctorcode"/>
						</div>
						</div>
					</div>
				</div>
				<div id="actButton" class="col-md-12 text-right">
                	<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="saveDoctorName()">Save</button>
	                <button id="btnCancel" class="btn btn-default" type="button" onclick="cancelCancelDoctorDlg()">Cancel</button>
            	</div>
			</div>
		</div>	
	<script>
	loadBranchData();
	$('#fromdate').datepicker({
			dateFormat:'dd/mm/yy'
	});
	if($('#fromdate').val()==""){
		if("<%=fromDate%>"==""){	
			var cd=new Date();
			$('#fromdate').datepicker("setDate",cd);
		}else{
			$('#fromdate').val("<%=fromDate%>");
		}
	}
	$('#todate').datepicker({
			dateFormat:'dd/mm/yy'
	});			
	if($('#todate').val()==""){
		if("<%=toDate%>"==""){
			var cd=new Date();
			$('#todate').datepicker("setDate",cd);
		}else{
			$('#todate').val("<%=toDate%>");
			$('#paydate').val("<%=toDate%>");
		}
	}	
	if("<%=mode%>"!="Pay"){
		jqReport(500015,"#xyz","&branchcode="+$('#branch').val());
	}
    var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[
  	{name:"code",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"paymentno"},
  	{name:"paymentno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"doctorname",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"paydate",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"doctorcode",tt:false,id:"dr_code"},{tgt:"doctorname",tt:true,id:"dr_name"},{tgt:"doctorname",tt:false,id:"dr_name"},{tgt:"cdoctorname",tt:true,id:"dr_name"},{tgt:"cdoctorname",tt:false,id:"dr_name"}]},validation:"loadProfessionalCharges"},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"paydate"},
  	{name:"paydate",inputType:0,type:"DATE",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"tdspercentage"},
  	{name:"totalamt",inputType:0,type:"DECIMAL",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"tdspercentage"},
  	{name:"totaldiscount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"tdspercentage"},
  	{name:"payableamount",inputType:0,type:"DECIMAL",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"tdspercentage"},
  	{name:"tdspercentage",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":30,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"tdsamount",onchange:"onRateQuantityChange"},
  	{name:"tdsamount",inputType:0,type:"DECIMAL",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"ledgername"},
  	{name:"netamount",inputType:0,type:"DECIMAL",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"ledgername"},
  	{name:"ledgername",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"chequeno",lovOptions:{url:"/waggle/service/ajax",ajax:"cashbanks",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"ledgercode",tt:false,id:"lm_code"},{tgt:"ledgername",tt:true,id:"lm_name"},{tgt:"ledgername",tt:false,id:"lm_name"}]}},
  	{name:"ledgercode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"chequeno"},
  	{name:"chequeno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"patientgrid_data"},
  	{name:"cdoctorname",inputType:0,type:"LOV",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"patientgrid_data",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"cdoctorcode",tt:false,id:"dr_code"},{tgt:"cdoctorname",tt:true,id:"dr_name"},{tgt:"cdoctorname",tt:false,id:"dr_name"}]}},
  	{name:"cdoctorcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientgrid_data"},
  	{name:"billno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientgrid_data"},
  	{name:"billsno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientgrid_data"},
  	{name:"btnSave",inputType:3,caption:"",visible:false},
    {name:"btnClear",inputType:3,caption:"",visible:false}
  	]},
  	{name:"patientgrid",title:"",contentType:"Table",tableProperties:{rowObject:true,serialNumberColumn:"sno",enableAddRow:false,rowEmptyCheckColumn:"patientcode",optional:false,columns:[
  	{order:"0",id: "selected", name: "Select", field: "selected",defaultValue:"0","inputType":2,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:100,align:"center"},  	
    {order:"1",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true,align:"center"},
    {order:"2",id: "patientno", name: "IP No", field: "patientno",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:150,"chkTag":false,align:"center"},    
    {order:"3",id: "patientcode", name: "Code", field: "patientcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,"chkTag":false},
    {order:"4",id: "patientname", name: "Name", field: "patientname",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:200},
    {order:"5",id: "admissiondate", name: "Admission Date", field: "admissiondate",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"center"},
    {order:"6",id: "dischargedate", name: "Discharge Date", field: "dischargedate",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"center"},
    {order:"7",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:150,align:"right"},
    {order:"8",id: "drcode", name: "Dr.Code", field: "drcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "bdsno", name: "BillSno", field: "bdsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"10",id: "bdno", name: "BillNo", field: "bdno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"11",id: "discount", name: "Discount", field: "discount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:150,align:"right","onchange":"onRateQuantityChange"},
    {order:"12",id: "changedoctor", name: "Change Doctor", field: "changedoctor",defaultValue:"0","inputType":3,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:100,chkTag:false,caption:"Change",align:"center",onclick:"showChangeDrDialog"}
    ]
    }}]};
	var ppayment=new FlexUI.Screen("ppayment",sProps);
	var l=new FlexUI.Ajax();
    $(document).ready(function () {
            screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
            $('#subtitle').text("");
        	$('#btnCancelScr').css("display","none");
        	$('#screentitle').text("Professional Payment");
        	$('#heading').css("display","block");
            screenObjects.getScreenObject("doctorname").focus();
            $('#btnSave').css("display","inline-block");
        });
        function saveProfessionalPayments(){
        	if('<%=mode%>'=="View") return;
        	if(ppayment.getSaveInProgress()) return;
        	var r=null;
        	sProps.screen[0].fields[15].mandatory=false;
    		ppayment.setOperation("ADD");
    		ppayment.setScreenCode(<%=screenCode%>);
    		var d=ppayment.processDataToSave();
    		ppayment.setSaveInProgress(true);    		
			if("FAILED"!=d){
				var s=new FlexUI.Ajax();
				showLoader();
				r=s.callAjax("POST","/waggle/service/screen/save",d);
				hideLoader();
		 	}else{
		 		alert("Please correct the validation errors and continue...");
		 		ppayment.setSaveInProgress(false);		 		
		 		return;
		 	}		 
		 	if(r.result=="Success"){
				alert(r.message+" [No:"+r.paymentno+"]");
				var ps=JSON.parse(d.replace("data=","")).savedata;
				ps["paymentno"]=r.paymentno;
				printPdfBill(screenObjects.getScreenObject("branchcode").getValue(),r.code);
				hideMasterData();
				return r.key;			
			}else{
				ppayment.setSaveInProgress(false);
				alert(r.message);		
			}
        }
        function clearInnerScreen(){
        	$('#overlapdiv').css('display','none');
        	ppayment.clearScreen();
        	ppayment.setSaveInProgress(false);
        	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
        	screenObjects.getScreenObject("doctorname").setEnabled(true);
        	sProps.screen[0].fields[15].mandatory=false;
        }
        function onRateQuantityChange(id,me){
			calculateTotal();
			return true;
		}
		function calculateTotal(){
			var total=0;
			var discount=0;
			var t=screenObjects.getScreenObject("patientgrid_data");
			var tdspercentage=screenObjects.getScreenObject("tdspercentage").getValue();
			var cols=t.getCols();
			var s=t.getSize();
			for(var i=0;i<s;i++){
				if(t.getText(i,cols.selected)=="true"){
					total+=toNumber(t.getText(i,cols.amount));
					discount+=toNumber(t.getText(i,cols.discount));
				}
			}
			var payable=total-discount;
			screenObjects.getScreenObject("totalamt").setValue(roundOff(total,2));
			screenObjects.getScreenObject("payableamount").setValue(roundOff(payable,2));
			screenObjects.getScreenObject("totaldiscount").setValue(roundOff(discount,2));
			var tdsamount=roundOff(payable*toNumber(tdspercentage)/100,2);
			screenObjects.getScreenObject("tdsamount").setValue(tdsamount);
			screenObjects.getScreenObject("netamount").setValue(roundOff(payable-tdsamount,2));
			$("#netAmt").html("Net Amount   "+roundOff(payable-tdsamount,2));
		}
		function loadProfessionalCharges(){
			if(!ppayment.getSaveInProgress()){
				var s=new FlexUI.Ajax();
				showLoader();
				var r=s.callAjax("GET","/waggle/service/ajax","&ic=0&ro=true&id=professionalcharges&branch="+screenObjects.getScreenObject("branchcode").getValue()+"&doctorcode="+screenObjects.getScreenObject("doctorcode").getValue()+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val());
				var t=screenObjects.getScreenObject("patientgrid_data");
				t.clear();
				t.setObjectData(r.data);
				$('#patientgrid').find('input[type="checkbox"]').bind("click",calculateTotal);
				calculateTotal();			
			  	hideLoader();			
		  	}
		  	return true;
		}
		function printPdfBill(branchcode,code){
			var url="/waggle/service/account/printdoctorfee?branchcode="+branchcode+"&code="+code;
			window.open(url,"_blank");
		}
		function printBill(data,branchcode,code){
			var printData={};
			if(!data){
				$.ajax({
		            url: "/waggle/service/screen/data?screencode=500015&branchcode="+branchcode+"&code="+code,
		            type: "GET",
		            async: false,
		            contentType:"application/json",
		            dataType: "json",
		            success: function (r) {
						data=r;		
		            }
		        });	      
	        }  			
			printData["type"]="PROFPAY";
			printData["branchname"]=$('#branch option:selected').text();
			printData["address1"]="27,Javulikara Street";
			printData["address2"]="Tiruvarur - 610 001";
			printData["address3"]="Phone - 242292,240292";
			printData["tin"]="";
			printData["paymentno"]=data["paymentno"];
			printData["paydate"]=data["paydate"];
			printData["totalamt"]=data["totalamt"]+"";
			printData["netamount"]=data["netamount"]+"";
			printData["totaldiscount"]=data["totaldiscount"]+"";
			printData["payableamount"]=data["payableamount"]+"";
			printData["tdspercentage"]=data["tdspercentage"]+"";
			printData["tdsamount"]=data["tdsamount"]+"";
			printData["netamount"]=data["netamount"]+"";
			printData["doctorname"]=data["doctorname"]+"";
			printData["userid"]="<%=userId%>";
			printData["patients"]=[];
			for(var x=0;x<data["patientgrid_data"].length;x++){
				if(data["patientgrid_data"][x].selected=="true"){
					var item={};				
					item.ipno=data["patientgrid_data"][x].patientno+"";
					item.name=data["patientgrid_data"][x].patientname+"";
					item.admissiondate=data["patientgrid_data"][x].admissiondate+"";
					item.dischargedate=data["patientgrid_data"][x].dischargedate+"";
					item.amount=roundOff(data["patientgrid_data"][x].amount,2)+"";
					printData.patients.push(item);
				}
			}
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
	function loadOrderData(url,name,did){
		var rowData=$("#report_500015").getRowData(did);	
		if(name=="Print"){
			//printBill(undefined,$('#branch').val(),rowData.code);
			printPdfBill(rowData.branchcode,rowData.code);				
		}else{
			addMasterData();
	  		showLoader();
			var l=new FlexUI.Ajax();
			var v=l.callAjax("GET","/waggle/service/screen/data?screencode=500015","&branchcode="+$('#branch').val()+"&code="+rowData.code);
			ppayment.loadObjectData(v);
	  		screenObjects.getScreenObject("doctorname").setEnabled(false);
	  		hideLoader();
	  		if(name=="View"){
	  			$('#btnSave').css('display','none');
	  			$('#patientgrid').find('input[type="checkbox"]').prop("disabled",true);
	  			$('#patientgrid').find('button').prop("disabled",true);
	  		}else{
	  			$('#btnSave').css('display','block');
	  		}
	  		calculateTotal();
  		}
    }	
  function addMasterData(){ 
  	clearInnerScreen();
	$('#callback').css('display','block');
  	$('#xyz').css('display','none');
  	$('#addGrp').css('display','none');
  }
  function hideMasterData(){
  	if("<%=mode%>"=="Pay"){
		$('.ui-dialog').children().remove();
		$('.ui-dialog').remove();
		$("#bodyContainer").children().remove();
		$("#bodyContainer").html("");
		$("#bodyContainer").load("/waggle/dischargeHistory.do?id=500016&fromdate=<%=fromDate%>&todate=<%=toDate%>");	  				
	}else{
	  	clearInnerScreen();
	  	$('#callback').css('display','none');
	  	$('#xyz').css('display','block');
	  	$('#addGrp').css('display','block');
	  	reloadGrid(500015);
	 }
  }
  function toggleHeaderRow(){
  	toggleSearchToolBar(500015);
  }
  if("<%=mode%>"!="Pay"){
  		toggleHeaderRow();
  }else{
  		addMasterData();
  		screenObjects.getScreenObject("paydate").setValue("<%=toDate%>");
		screenObjects.getScreenObject("branchcode").setValue(<%=branch%>);
		screenObjects.getScreenObject("doctorcode").setValue(<%=doctorcode%>);  		
		screenObjects.getScreenObject("doctorname").setValue("<%=doctorName%>");
		screenObjects.getScreenObject("doctorname").setTag("<%=doctorName%>");
		loadProfessionalCharges();
  }
  	function cancelCancelDoctorDlg(){
	 	$('#changedrdlg').dialog('close');
		$('#changedrdlg').dialog('destroy');	
		sProps.screen[0].fields[15].mandatory=false; 	
	 }
	 function showChangeDrDialog(id,me){
	 	var col1=me.getButton().parent();
    	var col = $(col1).parent().children().index($(col1));
  		var row = $(col1).parent().parent().children().index($(col1).parent());
  		$('#changedrdlg').dialog({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:600,position:'center'});
		$('#changedrdlg').dialog('open');
		var grid=screenObjects.getScreenObject("patientgrid_data");	  		 			
		var ipno=grid.getText(row,grid.getCols().patientno);
		$('#cipno').val(ipno);
		$('#codoctorname').val(screenObjects.getScreenObject("doctorname").getValue());
		$('#cpatientname').val(grid.getText(row,grid.getCols().patientname));
		screenObjects.getScreenObject("billno").setValue(grid.getText(row,grid.getCols().bdno));
		screenObjects.getScreenObject("billsno").setValue(grid.getText(row,grid.getCols().bdsno));		
		screenObjects.getScreenObject("cdoctorname").setValue("");
		screenObjects.getScreenObject("cdoctorname").setTag("");
		screenObjects.getScreenObject("cdoctorcode").setValue("");
		sProps.screen[0].fields[15].mandatory=true;
	 }
	 function saveDoctorName(){
        	if('<%=mode%>'=="View") return;
        	if(ppayment.getSaveInProgress()) return;
        	if(screenObjects.getScreenObject("billno").getValue()=="" || screenObjects.getScreenObject("billno").getValue()=="0"){
				alert("Bill number is not available for this entry");
				return;
			}        	
        	if(screenObjects.getScreenObject("billsno").getValue()=="" || screenObjects.getScreenObject("billsno").getValue()=="0"){
				alert("Bill serial number is not available for this entry");
				return;
			}        	        	
			if(screenObjects.getScreenObject("cdoctorcode").getValue()=="" || screenObjects.getScreenObject("cdoctorcode").getValue()=="0"){
				alert("Please select a new doctor to continue");
				return;
			}        	
        	var r=null;
    		ppayment.setOperation("UPD");
    		ppayment.setScreenCode(<%=screenCode%>);
    		var d='data={"screencode":"500015","operation":"UPD","savedata":{"doctorcode":"'+screenObjects.getScreenObject("doctorcode").getValue()+'","cdoctorcode":"'+screenObjects.getScreenObject("cdoctorcode").getValue()+'","billno":"'+screenObjects.getScreenObject("billno").getValue()+'","billsno":"'+screenObjects.getScreenObject("billsno").getValue()+'"}}';
    		ppayment.setSaveInProgress(true);    		    	
			var s=new FlexUI.Ajax();
			showLoader();
			r=s.callAjax("POST","/waggle/service/screen/save",d);
			hideLoader();
		 	if(r.result=="Success"){
		 		alert("Doctor Changed Successfully");
		 		ppayment.setSaveInProgress(false);
		 		loadProfessionalCharges();
		 		cancelCancelDoctorDlg();
				return r.key;			
			}else{
				ppayment.setSaveInProgress(false);
				alert(r.message);		
			}
        }
	</script>
</body>
</html>