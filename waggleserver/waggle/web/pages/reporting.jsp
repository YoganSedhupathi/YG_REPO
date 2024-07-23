<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title></title>
</head>
<body>
<%
	  String rptId=request.getParameter("id");
%>
<!--add and search-->
<!-- JQ grid starts-->
<div id="callback" style="display:block;">
</div>
<div class="col-sm-12 col-md-12 col-lg-12 mpZero pull-right">
	<div class="form-group extrBT"><button type="button" class="btn btn-primary mRhAj btn-sm" onclick="reportGo('<%=rptId%>')">Go</button></div>	
</div>
<div class="clearfix"></div>
<div id="xyz" style='position:relative;border:0px;display:block;'>
<div class=""><span class="pull-right" style="margin-top:-50px" ><button class="btn btn-sm seaColB" onclick="toggleHeaderRow();"><i class="fa fa-search"></i></button></span></div>
<div class="clearfix"></div>
</div>			    	 
<!-- JQ grid ends-->

<script>
  var newParams="";
  var reports=new FlexUI.ConstructReport(<%=rptId%>,"callback");
  reports.buildFilters();
  processParameters();  		
  jqReport(<%=rptId%>,"#xyz",newParams);
  function addMasterData(){ 
  	reports.clearScreen();
  }
  function toggleHeaderRow(){
  	toggleSearchToolBar(<%=rptId%>);
  }
  toggleHeaderRow();
  function reportGo(id){
	showLoader();
	processParameters();
	changeUrlAndReloadGrid(id,"",newParams);	
	hideLoader();
}
  function processParameters(){
   		newParams="";  	
  		var screenProperties=reports.getCurrentScreen().getScreenProperties();
  		var s=screenProperties.length;
  		var comma=""; 
  		for(var i=0;i<s;i++){
			var g=screenProperties[i];
			var fields=g.fields;
			var fs=fields.length;
			var v="";
			for(var p=0;p<fs;p++){				
				var f=fields[p];
				var fieldId=f.name;
				var w=screenObjects.getScreenObject(fieldId);
				v=w.getValue();
				if(v==null || v==""){
					v=f.defaultValue;
				}
				newParams=newParams+"&"+fieldId+"="+escape(v);
			}				
		}
  	}
</script> 
</body>
</html>