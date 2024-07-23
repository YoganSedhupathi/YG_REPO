<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Vendor Payable Detail</title>
</head>
<body>
<%
	String code=(String)request.getParameter("code");
	String branch=(String)request.getParameter("branch");
%>


<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Vendor Payables</title>
</head>
<body>



<div class="card border-0 shadow">
  <div class="card-body lpage" >
    <div class="row w-100 mb-3" >
      <div class="col-md-6 d-flex align-items-center">
        <h4 class="header-title">Vendor Payable Detail</h4>
      </div>
      <div  class="col-md-6 text-right" id="addGrp">
        <button type="button" class="btn btn-edit" onclick='backToCustomerOutstanding();'><span class="mdi mdi-arrow-left">Back</span></button>	
        <button type="button" class="btn btn-clear" onclick='toggleHeaderRow();'><span class="mdi mdi-filter-variant">Filter</span></button>	
      </div>
      <div  class="col-md-6 text-right" id="saveGrp" style='display:none'>
        <div class="mb-3">

        </div>
      </div>
    </div>
    <div class="row " id="jqcontainer" ><div class="table-container"><div id="xyz" class="w-100"></div></div>
  </div>	
  </div>
<script>
  jqReport(6100041,"#xyz","&branch=<%=branch%>&code=<%=code%>");
  function toggleHeaderRow(){
  	toggleSearchToolBar("6100041");
  }

  function backToCustomerOutstanding(){
            $("#bodyContainer").html("");
						$("#bodyContainer").load("/inventory/supplierOutstanding.do",onSuccess);
						$("#currentMenuId").val(6100041);
  }
  toggleHeaderRow();
</script> 
</body>
</html>