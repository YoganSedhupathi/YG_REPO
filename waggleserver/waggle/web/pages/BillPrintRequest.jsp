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



	
	<div id="listContainer" class="card border-0">
		<div class="card-body lpage">
			<div class="row w-100 mb-3">
				<div class="col-md-6 d-flex align-items-center">
					
					<h4 class="header-title"><%=title%></h4>
				</div>
				<div  class="col-md-6 d-flex text-right" id="addGrp">
						<div class="col-md-7">
							<div class="input-group">
								<span class="input-group-text">From</span>
								<input id="fromDate" name="fromDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
								<span class="input-group-text">To</span>
								<input id="toDate" name="toDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>&nbsp;
								<button type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button>
							</div>
						</div>
						<div class="col-md-5">
							<button type="button" class="btn btn-clear" onclick='toggleHeaderRow()'><span class="mdi mdi-filter-variant">Search</span></button>	
						</div>
					
				</div>

			</div>
			<div class="row " id="jqcontainer"  ><div class="table-container" ><div id="xyz" class="w-100"></div></div></div>

		</div>
	</div>



<!--
    <div class="col-sm-12 col-md-12 col-lg-12 mpZero marTp">
    	<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
    	<div class="subHe" id="dtfilter" name="dtfilter" style="display: block"><%=title%></div>
    	
    	<div class="col-sm-4 col-md-4 col-lg-4">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">From Date</label><div class="col-sm-7 mpRes"></div></div>
	  					</div>
		    			<div class="col-sm-4 col-md-4 col-lg-4">
		  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">To Date</label><div class="col-sm-7 mpRes"></div></div>
		  				</div>
		  				<div class="col-sm-4 col-md-4 col-lg-4 mpZero">
		  					<div class="form-group extrBT"></div>	
					    </div>
			
		<div id="addGrp" class="btn-group pull-right">    	
		<div class="btn-group pull-right" id="actionicons">
			<button onclick="toggleHeaderRow()" class="btn btn-sm seaColB"><i class="fa fa-search"></i></button>
			<%if("400013".equals(rptId)){%>
				<button onclick="printCensus()" class="btn btn-sm seaColB"><i class="fa fa-print"></i></button>
			<%}%>
		</div>
		</div>
	</div>    
	<div class="col-md-12 col-sm-12 mpZero marTp">
		<div class="col-md-12 col-sm-12 mpZero" id="xyz">
		
		</div>
	</div>
	-->
		
		<div id='cancelcrdlg' class='modal'>
			<div class="modal-dialog modal-lg  modal-dialog-scrollable">
			  <div class="modal-content">
					<div id='canceltitle' class='modal-header'>
						<div class='pop_lov_hed_txt'><h3><label> Bill No :&nbsp;</label><span id="crbno"></span></h3></div>

						<div class='pop_lov_clos'>
							<a href='#'>
								<span class='fa fa-times-circle'>
								</span>
							</a>
						</div>	

						<button type="button" class="btn-close" onclick="cancelCancelCrDlg()" data-bs-dismiss="modal"></button>
						
					</div>
					<div class='modal-body' id='cancelcrd'>
						<div class="col-md-12 col-sm-12 mpZero">
							<div  class="col-md-12 col-sm-12 mpZero">		
							<div class="form-group mbotto">
								<div class="col-md-4"><label>IP No</label></div>
								<div class="col-md-8">
									<input class="form-control" id="ipno" disabled/>
								</div>
							</div>
							</div>
							<div  class="col-md-12 col-sm-12 mpZero">		
							<div class="form-group mbotto">
								<div class="col-md-4"><label>Patient Name</label></div>
								<div class="col-md-8">
									<input class="form-control" id="ipatientname" disabled/>
								</div>
							</div>
							</div>
							<div  class="col-md-12 col-sm-12 mpZero">		
								<div class="form-group mbotto">
									<div class="col-md-4"><label> UHID</label></div>
									<div class="col-md-8">
										<input class="form-control" id="crh_hospreg_code" disabled/>
									</div>
								</div>
							</div>
						
							<div  class="col-md-12 col-sm-12 mpZero">		
										<div class="form-group mbotto">
											<div class="col-md-4"><label> Bill Date</label></div>
											<div class="col-md-8">
												<input class="form-control" id="billdate" disabled/>
											</div>
										</div>
							</div>	
							<div  class="col-md-12 col-sm-12 mpZero">		
								<div class="form-group mbotto">
									<div class="col-md-4"><label> BU Name</label></div>
									<div class="col-md-8">
										<input class="form-control" id="buname" disabled/>
									</div>
								</div>
							</div>		
							<div  class="col-md-12 col-sm-12 mpZero">		
								<div class="form-group mbotto">
									<div class="col-md-4"><label> Amount</label></div>
									<div class="col-md-8">
										<input class="form-control" id="totalamt" disabled/>
									</div>
								</div>
							</div>		
							<div  class="col-md-12 col-sm-12 mpZero">		
							<div class="form-group mbotto">
								<div class="col-md-4"><label>Cancel Remarks*</label></div>
								<div class="col-md-8">
									<textarea  class="form-control" id="cancelremarks" row=10 col=50  ></textarea>
									<input type="hidden" id="crhno" value="0"/>
									<input type="hidden" id="branchcode" value="0"/>
								</div>
							</div>
							</div>
						</div>
					</div>
					<div id="actButton" class="modal-footer">
						<button id="btnPrint" class="btn btn-primary priBut" type="button" onclick="cancelClinicalRequest()">Save</button>
	                <button id="btnCancel" class="btn btn-default" type="button" onclick="cancelCancelCrDlg()">Cancel</button>
            	</div>
			  </div>
			</div>
		</div>

		
	<script>

	$('#fromDate').val(localStorage.getItem("fromdate")==undefined?"":localStorage.getItem("fromdate"));
	$('#toDate').val(localStorage.getItem("todate")==undefined?"":localStorage.getItem("todate"));


		$('#fromDate').datepicker({
				 language: "en",
       			 autoclose: true,
       			 todayHighlight: true,
	 	 	     format:'dd/mm/yyyy'
		});
		$('#toDate').datepicker({
				language: "en",
				autoclose: true,
				todayHighlight: true,
				format:'dd/mm/yyyy'
		});
		if($('#fromDate').val()==""){
			var cd=new Date();
			$('#fromDate').datepicker("setDate",cd);
		}
					
		if($('#toDate').val()==""){
			var cd=new Date();
			$('#toDate').datepicker("setDate",cd);
		}
		

		

 	loadBranchData();	
 	var params="";
 	var newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&branchcode="+$('#branch').val();
	jqReport(<%=rptId%>,"#xyz",newParams);
    $(document).ready(function () {
            $('#subtitle').text("");
            $('#screentitle').text("Bills");
     });
  	function toggleHeaderRow(){
  		toggleSearchToolBar(<%=rptId%>);
  	}
  function reportGo(id){
	showLoader();
	localStorage.setItem("fromdate",$('#fromDate').val());
	localStorage.setItem("todate",$('#toDate').val());
	var newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&branchcode="+$('#branch').val();
	changeUrlAndReloadGrid(id,params,newParams);
	hideLoader();
}
  
  	toggleHeaderRow();
    function loadOrderData(url,name,did){
	  	var rowData=$("#report_<%=rptId%>").getRowData(did);
	  	if(name=="Print"){
		  	var printData={};	  		  	
		  	if(<%=rptId%>==11 || <%=rptId%>==20){
			  	var data;
				$.ajax({
		            url: "/waggle/service/screen/data?screencode=<%=rptId%>&branchcode="+rowData.branchcode+"&code="+rowData.code,
		            type: "GET",
		            async: false,
		            contentType:"application/json",
		            dataType: "json",
		            success: function (r) {
						data=r;		
		            }
		        });			
				if(data.billtype==1){
					printData["type"]="IPBILL";
				}else{
					printData["type"]="OPBILL";
				}
				printData["branchname"]=$('#branch option:selected').text();
				printData["address1"]="52, SOUTH STREET";
				printData["address2"]="ARUPPUKOTTAI - 626 101";
				printData["address3"]="Phone - 222273,220936";
				printData["tin"]="";
				printData["buname"]=data["buname"];
				printData["billno"]=data["billno"];
				printData["billdate"]=data["billtime"]+"";
				printData["totalamt"]=roundOff(data["totalamt"])+"";
				printData["netamount"]=roundOff(data["netamount"],2)+"";
				printData["srvchgamount"]=roundOff(data["srvchgamount"],2)+"";
				printData["tenderamount"]=roundOff(data["tenderamount"],2)+"";
				printData["balanceamount"]=roundOff(data["balanceamount"],2)+"";
				printData["roundoff"]="0.00";
				printData["sponsorname"]=data["sponsorname"]+"";
				printData["doctorname"]=data["doctorname"]+"";
				printData["referredby"]=data["referredby"]+"";
				printData["fromplace"]=data["fromplace"]+"";
				printData["toplace"]=data["toplace"]+"";
				printData["fromkm"]=data["fromkm"]+"";
				printData["tokm"]=data["tokm"]+"";							
				printData["roundoff"]="0.00";
				printData["patientname"]=data["patientname"];		
				printData["patientage"]=data["patientage"];
				printData["ipno"]=data["ipno"];
				printData["csno"]=data["csno"];
				printData["hospregcode"]=data["hospregcode"];
				printData["userid"]="<%=userId%>";
				printData["gender"]=data["gender"];
				printData["invtype"]="CASH";
				printData["billprefix"]="GSH";
				printData["items"]=[];
				for(var x=0;x<data["billgrid_data"].length;x++){
					var item={};
					item.name=data["billgrid_data"][x].product+"";
					item.rate=roundOff(data["billgrid_data"][x].rate,2)+"";
					item.qty=data["billgrid_data"][x].quantity+"";
					item.amount=data["billgrid_data"][x].amount+"";;				
					printData.items.push(item);
				}
			}else{
			  	var data;
				$.ajax({
		            url: url,
		            type: "GET",
		            async: false,
		            contentType:"application/json",
		            dataType: "json",
		            success: function (r) {
						data=r;		
		            }
		        });
		        printData=data;	
		        if(<%=rptId%>==500012){
		        	printData["type"]="VCHER";
		        	printData["branchname"]="GOMATHI SPECIALITY HOSPITAL";
		        	printData["address1"]="52,South Street";
		printData["address2"]="ARUPPUKOTTAI - 626 101";
		printData["address3"]="Phone - 222273,220936";			        	
		        }								
			}
			$.ajax({
	            url: "http://localhost:9696",
	            type: "POST",
	            async: true,
	            contentType:"application/x-www-form-urlencoded",
	            data:"printdata="+JSON.stringify(printData),
	            dataType: "json",
	            success: function (r) {
					//alert(r.result);		
	            }
	        });
	      }else if(<%=rptId%>==11 && name=="View"){
	      		$('.ui-dialog').children().remove();
				$('.ui-dialog').remove();
				$("#bodyContainer").children().remove();
				$("#bodyContainer").html("");
				$("#bodyContainer").css("display","block");
				if(rowData.billtype==2){
					if(rowData.buname!="Ambulance"){				
						$("#bodyContainer").load("/waggle/opbill.do?mode=View&screencode=11&branch="+rowData.branchcode+"&code="+rowData.code);
					}else{
						$("#bodyContainer").load("/waggle/ambulanceBill.do?mode=View&screencode=11&branch="+rowData.branchcode+"&code="+rowData.code);
					}
				}else{
					$("#bodyContainer").load("/waggle/bill.do?mode=View&screencode=11&branch="+rowData.branchcode+"&code="+rowData.code);
				}	  				
	      }else if(<%=rptId%>==11 && name=="Edit"){
	      		$('.ui-dialog').children().remove();
				$('.ui-dialog').remove();
				$("#bodyContainer").children().remove();
				$("#bodyContainer").html("");
				if(rowData.billtype==2){			
					if(rowData.buname!="Ambulance"){	
						$("#bodyContainer").load("/waggle/opbill.do?mode=Edit&screencode=11&branch="+rowData.branchcode+"&code="+rowData.code);
					}else{
						$("#bodyContainer").load("/waggle/ambulanceBill.do?mode=Edit&screencode=11&branch="+rowData.branchcode+"&code="+rowData.code);
					}
				}else{
					$("#bodyContainer").load("/waggle/bill.do?mode=View&screencode=11&branch="+rowData.branchcode+"&code="+rowData.code);
				}	  				
	      }else if(<%=rptId%>==20 && name=="View"){
	      		$('.ui-dialog').children().remove();
				$('.ui-dialog').remove();
				$("#bodyContainer").children().remove();
				$("#bodyContainer").html("");
				// if(rowData.billtype==2){	
					$("#bodyContainer").load("/waggle/opbill.do?mode=Edit&screencode=20&branch="+rowData.branchcode+"&code="+rowData.code);
				// }					
	      }else if(<%=rptId%>==20 && name=="Edit"){
	      		$('.ui-dialog').children().remove();
				$('.ui-dialog').remove();
				$("#bodyContainer").children().remove();
				$("#bodyContainer").html("");
				// if(rowData.billtype==2){				
					$("#bodyContainer").load("/waggle/opbill.do?mode=Edit&screencode=20&branch="+rowData.branchcode+"&code="+rowData.code);
				// }	  				
	      }else if(<%=rptId%>==20 && name=="Cancel"){
				if(rowData.crh_status!=1){				
					alert("This clinical request is already billed or cancelled");
				}else{
					showCRCancelDialog(rowData.code,rowData.billno,rowData.ipno,rowData.patientname,rowData.branchcode,rowData.billdate,rowData.buname,rowData.totalamt,rowData.crh_hospreg_code);
				}	  				
	      }
	      					
	 }
	 function printCensus(){
	 	var printData={};
	 	printData["title"]="CENSUS";
		printData["gendate"]=formatDateddMMyyyy(new Date());
		printData["type"]="CENS";
		printData["branchname"]=$('#branch option:selected').text();
		printData["branch"]=$('#branch').val();
		printData["address1"]="52,Javulikara Street";
		printData["address2"]="ARUPPUKOTTAI - 626 101";
		printData["address3"]="Phone - 222273,220936";
		printData["login_id"]='<%=userId%>';
		printData["reportid"]='<%=rptId%>';
		//printData["host"]='192.168.1.101:8080/HMS';
		printData["host"]='localhost:9090/HMS';
		printData["rows"]="200";		
		$.ajax({
            url: "http://localhost:9696",
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

	 function cancelCancelCrDlg(){
	 	$('#cancelcrdlg').modal('hide');
		$('#cancelcrdlg').modal('dispose');	 	
		$('#cancelcrdlg').removeData('row');
	 } 

	
	 function showCRCancelDialog(crNo,crBno,ipno,patientName,branchCode,billdate,buname,totalamt,crh_hospreg_code){
	  		$('#cancelcrdlg').modal({autoOpen:false,modal:true,height:'auto',minHeight:400,minWidth:600,position:'center'});
			$('#cancelcrdlg').modal('show');
			$('#crbno').text(crBno);
			$('#ipno').val(ipno);					
			$('#crhno').val(crNo);
			$('#branchcode').val(branchCode);
			$('#ipatientname').val(patientName);
			$('#billdate').val(billdate);
			$('#buname').val(buname);
			$('#totalamt').val(totalamt);
			$('#crh_hospreg_code').val(crh_hospreg_code);
	 }

	 function cancelClinicalRequest(){
		    var val = $("#cancelremarks").val();
			
			if (val == "") {
					  alert("Cancel Remarks  is required");
					  return false;
  			  } 
	 	   var saveData={};
	 	   saveData["operation"]="CAN";
	 	   saveData["screencode"]="20";
	 	   var dData={};
	 	   dData["branchcode"]=$('#branchcode').val();
	 	   dData["code"]=$('#crhno').val();
	 	   saveData["savedata"]=dData;	 	   
	 	   var s=new FlexUI.Ajax();
		   showLoader();
		   var r=s.callAjax("POST","/waggle/service/screen/save","data="+JSON.stringify(saveData));
		   if(r.result=="Success"){
		   		alert("Request Cancelled Successfully");
		   		cancelCancelCrDlg();
		   		reloadGrid(<%=rptId%>);
		   }else{
		   		alert(r.message);
		   }
		   hideLoader();
	 }

function cancelrem(){
	
}
  </script>
</body>
</html>