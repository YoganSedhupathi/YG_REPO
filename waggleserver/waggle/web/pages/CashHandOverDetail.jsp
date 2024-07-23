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
	<div class="clearfix"></div>
	<div id="branchcontainer" class="brTp" style="display:block;z-index:999">
		<select class="form-control" id='branch' onchange="changeBranchCodeAndClearSubScreenData()"></select>
    </div>
    <div class="col-sm-12 col-md-12 col-lg-12 mpZero marTp" id="addGrp">
		<div class="btn-group pull-right" id="actionicons">
			<button onclick="toggleHeaderRow()" class="btn btn-sm seaColB"><i class="fa fa-search"></i></button>
		</div>
	</div>    
	<div class="col-md-12 col-sm-12 mpZero marTp">
		<div class="col-md-12 col-sm-12 mpZero" id="xyz">
		
		</div>
	</div>
	<script>
 	loadBranchData();	
	jqReport(11,"#xyz","&branchcode="+$('#branch').val());
    $(document).ready(function () {
            $('#subtitle').text("");
            $('#screentitle').text("Bills");
     });
  	function toggleHeaderRow(){
  		toggleSearchToolBar(11);
  	}
  
  	toggleHeaderRow();
    function loadOrderData(url,code,did){
	  	var rowData=$("#report_11").getRowData(did);
	  	var data;
		$.ajax({
            url: "/waggle/service/screen/data?screencode=11&branchcode="+rowData.branchcode+"&code="+rowData.code,
            type: "GET",
            async: false,
            contentType:"application/json",
            dataType: "json",
            success: function (r) {
				data=r;		
            }
        });			
		var printData={};
		if(data.billtype==1){
			printData["type"]="IPBILL";
		}else{
			printData["type"]="OPBILL";
		}
		printData["branchname"]=$('#branch option:selected').text();
		printData["address1"]="27,Javulikara Street";
		printData["address2"]="Tiruvarur - 610 001";
		printData["address3"]="Phone - 242292,240292";
		printData["tin"]="";
		printData["buname"]=data["buname"];
		printData["billno"]=data["billno"];
		printData["billdate"]=data["billtime"]+"";
		printData["totalamt"]=roundOff(data["totalamt"],2)+"";
		printData["tenderamount"]=roundOff(data["tenderamount"],2)+"";
		printData["balanceamount"]=roundOff(data["balanceamount"],2)+"";
		printData["roundoff"]="0.00";
		printData["sponsorname"]=data["sponsorname"]+"";
		printData["doctorname"]=data["doctorname"]+"";
		printData["referredby"]=data["referredby"]+"";
		printData["roundoff"]="0.00";
		printData["patientname"]=data["patientname"];		
		printData["patientage"]=data["patientage"];
		printData["gender"]=data["gender"];
		printData["invtype"]="CASH";
		printData["items"]=[];
		for(var x=0;x<data["billgrid_data"].length;x++){
			var item={};
			item.name=data["billgrid_data"][x].product+"";
			item.rate=roundOff(data["billgrid_data"][x].rate,2)+"";
			item.qty=data["billgrid_data"][x].quantity+"";
			item.amount=data["billgrid_data"][x].amount+"";;				
			printData.items.push(item);
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
  </script>
</body>
</html>