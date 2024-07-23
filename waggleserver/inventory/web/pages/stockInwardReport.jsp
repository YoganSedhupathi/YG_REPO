<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8" name="viewport" content= "width=device-width, initial-scale=1.0">
		<title>Stock Report</title>
    </head>
    <body>
    <script>
    <%
    	String userId=(String)session.getAttribute("LOGIN_ID");
    	String rptId=request.getParameter("id");
    	String rptTitle=request.getParameter("title");
    	String fromdt=request.getParameter("fromdt");
    	String todt=request.getParameter("todt");
    	String fromdash=request.getParameter("fromdash");
    	if(fromdt!=null && !fromdt.equals("")){%>
    		$('#fromDate').val(fromdt);
    	<%}
    	if(todt!=null && !todt.equals("")){%>
			$('#toDate').val(todt);
		<%}
	%>

    </script>

<div class="card border-0">
	<div class="card-body">
		<div class="row w-100">
			<div class="col-md-3 d-flex align-items-center">
				<h4 class="header-title"><%=rptTitle%></h4>
			</div>
		
			<div class="col-md-9">
				<div class="row">
					<div class="col-md-10 h-30 text-right">
						<div class="d-flex">
							<div id="productc" class="col-md-6">
								<div class="input-group">
									<span class="input-group-text">Product</span>
									<input type="text" id="productname" autocomplete="off" class="form-control" data-server="/inventory/service/autocomplete?id=manufacturer&term=" data-live-server="true" data-value-field="id"  data-label-field="name"/>
									<button id="prodSearch" type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button>
								</div>
							</div>
							<div class="input-group" id="datefilc" >
								<span class="input-group-text">From</span>
								<input id="fromDate" name="fromDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
								<span class="input-group-text">To </span>
								<input id="toDate" name="toDate" inputType="date"  type="text" mandatory="1"  class="form-control"/>
								<button type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button>
							</div>
							<div id="daysc" class="col-md-6">
								<div class="input-group">
									<span class="input-group-text">Last N' Days</span>
									<input type="text" id="lastndays" class="form-control" value="7"/>
									<span class="input-group-text">Quantity</span>
									<input type="text" id="saleqty" class="form-control" value="0"/>
									<button type="button" class="btn btn-edit" onclick="reportGo('<%=rptId%>')">Go</button>
								</div>
							</div>

							<div id="orderdayc" class="col-md-2" style="display:none">
								<span class="input-group-text">Order Days</span>
								<input type="text" id="orderdays" class="form-control" value="30"/>
							</div>
							<div id="begindatec" class="col-md-2" style="display:none">
								<span class="input-group-text">Total Avg. Date</span>
								<input id="beginDate" name="beginDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control" value="01/07/2015"/>
							</div>
							<div id="qtybasedon" class="col-md-2" style="display:none">
								<span class="input-group-text">Based On</span>
								<select id="basedon" name="basedon" class="form-control"><option value='1'>Order Stock</option><option value='0'>Min Qty</option></select>
							</div>
							<div id="orderqtyc" class="col-md-2" style="display:none">
								<span class="input-group-text">Order Quantity Above</span>
								<input id="orderQtyFilter" name="orderQtyFilter" type="text" class="form-control" value="0"/>
							</div>
						</div>
					</div>
					<div  class="col-md-2 text-right mb-2" id="addGrp">
						<button type="button" class="btn btn-clear" onclick='enableSearch();'><span class="mdi mdi-filter-variant">Search</span></button>	
					</div>
				</div>
			</div>
		</div>
		
		<div class="row" id="jqcontainer" ><div class="table-container" ><div id="rep" class="w-100"></div></div></div>
	</div>
	</div>
</div>

       

<script>
		$('#fromDate').datepicker({format:'dd/mm/yyyy'});			
		if($('#fromDate').val()==""){
			var cd=new Date();
			$('#fromDate').datepicker("setDate",cd);
		}
		$('#toDate').datepicker({format:'dd/mm/yyyy'});			
		if($('#toDate').val()==""){
			var cd=new Date();
			$('#toDate').datepicker("setDate",cd);
		}
		$('#beginDate').datepicker({format:'dd/mm/yyyy'});			
		if($('#beginDate').val()==""){
			var cd=new Date();
			$('#beginDate').datepicker("setDate",cd);
		}


</script>

<script>
$(document).ready(function(){
	ConstructPrevPurchaseGrid();
});
var l=new FlexUI.Ajax();
var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=userbranch");
var branches=v.data;
if(branches!=null){
	var s=branches.length;
	$('#branch').children().remove();
	for(var j=0;j<s;j++){
		$('#branch').append("<option value='"+branches[j][1]+"'>"+branches[j][0]+"</option>");	
	}
}
var orderqtyabv="0";
if($('#orderQtyFilter').val()!=""){
	orderqtyabv=$('#orderQtyFilter').val();
}
var params="";
newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&branch="+$('#branch').val()+"&productname="+escape($("#productname").val())+"&lastndays="+$('#lastndays').val()+"&saleqty="+$('#saleqty').val()+"&begindate="+$('#beginDate').val()+"&orderdays="+$('#orderdays').val()+"&orderqtyabv="+orderqtyabv+"&basedon="+$('#basedon').val();

jqReport(<%=rptId%>,"#rep",newParams);
showCSVExportButton(<%=rptId%>,newParams);
function enableSearch(){
	toggleSearchToolBar(<%=rptId%>);
}
enableSearch();
function reportGo(id){
	showLoader();
	if($('#orderQtyFilter').val()!=""){
		orderqtyabv=$('#orderQtyFilter').val();
	}else{
		orderqtyabv="0";
	}
	newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&branch="+$('#branch').val()+"&productname="+escape($("#productname").val().trim())+"&lastndays="+$('#lastndays').val()+"&saleqty="+$('#saleqty').val()+"&begindate="+$('#beginDate').val()+"&orderdays="+$('#orderdays').val()+"&orderqtyabv="+orderqtyabv+"&basedon="+$('#basedon').val();
	changeUrlAndReloadGrid(id,params,newParams);
	showPDFExportButton(id,newParams);
	showCSVExportButton(id,newParams);	
	hideLoader();
}
function showHideFilter(){
	if( $('#divFirstFilter').is(':visible') ) {
		$('#divFirstFilter').css("display","none");
	}else{
		$('#divFirstFilter').css("display","block");
	}
}

new Autocomplete(document.getElementById("productname"), {
    	// options
			});
// $("#productname").autocomplete({
// 		source: "/inventory/service/autocomplete?id=product",
// 		minLength: 0,
// 		select: function( event, ui ) {
// 			this.value=ui.item.label;
// 			reportGo(<%=rptId%>);
// 		},messages : {
// 	      	noResults : 'No results found.',
// 	      	results : function(count) {
// 	        	return count + (count > 1 ? ' results' : ' result ') + ' found';
// 	      	}
//     	}
// });

// $('#productname').autoComplete({
//     resolver: 'custom',
//     events: {
//         search: function (qry, callback) {
// 	            $.ajax('/inventory/service/autocomplete?id=product',
//             ).done(function (res) {
//                 //callback(res.results)
//             });
//         }
//     }
// });



if("<%=rptId%>"=="1200004"){
	$('#datefilc').css("display","none");
	$('#daysc').css("display","none");
}else if("<%=rptId%>"=="1200005"){
	$('#productc').css("display","none");
	$('#daysc').css("display","inline-flex");
	$('#datefilc').css("display","none");	
	if("<%=rptId%>"=="1200005"){
		$('#qtyc').css("display","inline-flex");
		
	}
}else if("<%=rptId%>"=="1200006"){
	$('#datefilc').css("display","none");
	$('#productc').css("display","none !important");
	$('#daysc').css("display","block");
	$('#orderdayc').css("display","block");
	$('#begindatec').css("display","block");
	$('#orderqtyc').css("display","block");
	$('#qtybasedon').css("display","block");
}else if("<%=rptId%>"=="1200009"){
	$('#datefilc').css("display","none");
	$('#productc').css("display","none");
	$('#daysc').css("display","none");
	$('#orderdayc').css("display","none");
	$('#begindatec').css("display","none");
	$('#orderqtyc').css("display","none");
	$('#qtybasedon').css("display","none");
	$('#productc').css("display","block");
}else if("<%=rptId%>"=="710023"){
	$('#daysc').css("display","none");
	$('#prodSearch').css("display","none");
}else if("<%=rptId%>"=="710022"){
	$('#daysc').css("display","none");
	$('#prodSearch').css("display","none");
	
}
  



function showIndentDlg(){
		$('#indentdlg').dialog({
			autoOpen:false,
			modal:true,
			minHeight:600,
			minWidth:900,
			position:'center'
		});
		$('#indentdlg').dialog('open');		
}
function closeIndentDlg(){
	clearIndent();
	$('#indentdlg').dialog('close');
	$('#indentdlg').dialog('destroy');	
}
function loadOrderData(link,name,did){
		var rowData=$("#report_<%=rptId%>").getRowData(did);
		if(name=="Indent"){
			showIndentDlg();
			var data=null;
			if(toNumber(rowData.ind_id)>0){
				$.ajax({
		            url: "/inventory/service/purchaseorder/indent?branch="+$('#branch').val()+"&indentid="+rowData.ind_id,
		            type: "GET",
		            async: false,
		            contentType:"application/json",
		            dataType: "json",
		            success: function (r) {
						data=r;		
		            }
		        });
			}
			if(data!=null){
				$('#suppcode').val(data.suppcode);
    			$('#suppname').val(data.suppname);
    			$('#orderqty').val(data.orderqty);
    			$('#indentid').val(data.indentid);
    			$('#orderfreeqty').val(data.orderfreeqty);
    			$('#orderbasefreeqty').val(data.orderbasefreeqty);
    		}else{
    			$('#orderqty').val(toNumber(rowData.orderqty));
    		}
    		$('#productcode').val(rowData.pm_code);
    		$('#productn').text(rowData.pm_name);
    		$('#manun').text(rowData.mm_name);
    		$('#genericn').text(rowData.pgm_name);
    		$('#unitn').text(rowData.um_name);
    		$('#indentqty').val(rowData.orderqty);
    		$('#rowid').val(did);
    		var purdata=[];
    		$.ajax({
		            url: "/inventory/service/ajax?ro=true&ic=0&id=prevpurchases&pmcode="+rowData.pm_code,
		            type: "GET",
		            async: false,
		            contentType:"application/json",
		            dataType: "json",
		            success: function (r) {
						purdata=r;		
		            }
		    });
		    $grid = $("#prevpurchase");
    		$grid.clearGridData();
    		$grid.jqGrid('setGridParam', { data:purdata.data  });
    		$grid[0].refreshIndex();
    		$grid.trigger("reloadGrid");
		}
}
function ConstructPrevPurchaseGrid() {
        var areaWidth = 700;
        $("#prevpurchase").jqGrid({
            datatype: "local",
            width: areaWidth,
            height:290,
            autowidth: true,
            shrinktofit:true,
            colNames: ['SupplierName', 'Date', 'InvNo', 'Qty','Free','Rate','Discount','NetCost','SuppCode','Select'],
            colModel: [
                        { name: 'supp_name', index: 'supp_name', sorttype: "text", sortable: false, width: 250, align: 'left'},
                        { name: 'ph_inv_date', index: 'ph_inv_date', sorttype: "text", sortable: false, width: 80, align: 'left' },
                        { name: 'ph_inv_no', index: 'ph_inv_no', sorttype: "text", sortable: false, width: 80, align: 'left' },
						{ name: 'pd_qty', index: 'pd_qty', sorttype: "integer", sortable: false, width: 80, align: 'left'},
						{ name: 'pd_freeqty', index: 'pd_freeqty', sorttype: "text", sortable: false, width: 80, align: 'left' },
						{ name: 'pd_rate', index: 'pd_rate', sorttype: "text", sortable: false, width: 80, align: 'left' },
						{ name: 'pd_disc_perc', index: 'pd_freeqty', sorttype: "text", sortable: false, width: 80, align: 'left' },
						{ name: 'pd_netcost', index: 'pd_netcost', sorttype: "text", sortable: false, width: 80, align: 'left' },
						{ name: 'ph_supp_code', index: 'ph_supp_code', sorttype: "text", sortable: false, hidden:true,width: 0, align: 'left' },
						{ name: 'select', index: 'select', sorttype: "text", sortable: false, formatter: SelectFormatter, width: 70 }
            ],
            rowNum: 50,
            datatype: "jsonstring",
            jsonReader: { repeatitems: false },
            viewrecords: true,
            gridview: true,
            loadtext: "Loading....",
            multiselect: false,
        });
    }
function SelectFormatter(cellVlue, option) {
    var selectForm = "<div align=center style=cursor:pointer><span class='fa fa-check' title='Select' onclick=selectSupplier(event," + option.rowId + ")></span></div>";
    return selectForm;
}    
function selectSupplier(event, rowid){
    var rowData = $('#prevpurchase').jqGrid('getRowData', rowid);
    $('#suppname').val(rowData.supp_name);
    $('#suppcode').val(rowData.ph_supp_code);
    if(toNumber(rowData.pd_freeqty)>0){
    	var baseFreeQty=Math.floor(toNumber(rowData.pd_qty)/toNumber(rowData.pd_freeqty));
    	$('#orderbasefreeqty').val(baseFreeQty);
    }
    calculateFreeQty();
}
function calculateFreeQty(){
	var freeqty=0;
	if(toNumber($('#orderbasefreeqty').val())>0){		
    	 freeqty=toNumber($('#orderqty').val())/toNumber($('#orderbasefreeqty').val());
    }
    $('#orderfreeqty').val(freeqty);
}
function onOrderQtyKeyUp(){
	calculateFreeQty();
}
$('#orderqty').bind("keyup",onOrderQtyKeyUp);
function saveIndent() {
	var operation="ADD";
	if(toNumber($('#indentid').val())>0){
    		operation="EDIT";
    }	
    if($('#suppcode').val()=="" || $('#suppcode').val()=="0"){
    	alert("Please select the supplier");
    	return;
    }
    if($('#orderqty').val()=="" || $('#orderqty').val()=="0" || toNumber($('#orderqty').val())<=0){
    	alert("Please enter the valid order quantity");
    	return;
    }
	var data='data={"operation":"'+operation+'","savedata":';
    var saveData = {};
    saveData["orderdays"]=$('#orderdays').val();
    saveData["suppcode"]=$('#suppcode').val();
    saveData["productcode"]=$('#productcode').val();
    saveData["begindate"]=$('#beginDate').val();
    saveData["indentid"]=$('#indentid').val();
    saveData["branchcode"]=$('#branch').val();
    saveData["indentqty"]=$('#indentqty').val();
    saveData["orderqty"]=$('#orderqty').val();
    saveData["orderbasefreeqty"]=$('#orderbasefreeqty').val();
    saveData["orderfreeqty"]=$('#orderfreeqty').val();
    saveData["status"]=$('#status').val();
    data=data+JSON.stringify(saveData)+"}";
    $.ajax({
        url: "/inventory/service/purchaseorder/indent",
        type: "POST",
        data: data,
        contentType: "application/x-www-form-urlencoded",
        async: false,
        dataType: "json",
        success: function (data) {
			if(data.result=="Success"){
				var rid=$('#rowid').val();
				if(saveData["status"]=="0"){
					$("#report_<%=rptId%>").jqGrid('setCell', rid,'ind_id',"0");		
					$("#report_<%=rptId%>").jqGrid('setCell', rid,'supp_name',"");
					$("#report_<%=rptId%>").jqGrid('setCell', rid,'ind_order_qty',"0");
					$("#report_<%=rptId%>").jqGrid('setCell', rid,'ind_orderdays',"0");
				}else{
					$("#report_<%=rptId%>").jqGrid('setCell', rid,'ind_id',data.key);		
					$("#report_<%=rptId%>").jqGrid('setCell', rid,'supp_name',$('#suppname').val());
					$("#report_<%=rptId%>").jqGrid('setCell', rid,'ind_order_qty',$('#orderqty').val());
					$("#report_<%=rptId%>").jqGrid('setCell', rid,'ind_orderdays',$('#orderdays').val());
				}
				clearIndent();
				closeIndentDlg();
			}else{
				alert(data.result);
			}
        }
    });
}
function clearIndent(){
    $('#suppcode').val("0");
    $('#suppname').val("");
    $('#productcode').val("0");
    $('#indentid').val("0");
    $('#indentqty').val("0");
    $('#orderqty').val("0");
    $('#orderbasefreeqty').val("0");
    $('#orderfreeqty').val("0");
    $('#status').val("1");
    $('#rowid').val("");
	$grid = $("#prevpurchase");
    $grid.clearGridData();
    $grid.jqGrid('setGridParam', { data: [] });
    $grid[0].refreshIndex();
    $grid.trigger("reloadGrid");
}
// $("#suppname").autocomplete({
// 		source: "/inventory/service/autocomplete?id=supplier",
// 		minLength: 0,
// 		select: function( event, ui ) {
// 			this.value=ui.item.label;
// 			$('#suppcode').val(ui.item.id);
// 		},messages : {
// 	      	noResults : 'No results found.',
// 	      	results : function(count) {
// 	        	return count + (count > 1 ? ' results' : ' result ') + ' found';
// 	      	}
//     	}
// });
</script>        
</body>
</html>