<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="java.util.Random"%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <title>CISSOL Technologies</title>
	<link rel="shortcut icon" href="images/titleicon.gif">
  	<link rel="icon" href="images/titleicon.gif">
	 <!-- <link rel="stylesheet" href="css/jquery-ui.css" type="text/css"/>
	 <link rel="stylesheet" href="css/jqgrid/ui.jqgrid.css" type="text/css"/>
	 <link href="css/styles.css" rel="stylesheet" type="text/css" />
	 <link href="css/style1.css" rel="stylesheet" type="text/css" />	 
	 
	  -->
	 
	 
	
    <link href="css/xgrid.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/jqgrid/ui.jqgrid.css" type="text/css"/>
     <link rel="stylesheet" href="css/jquery-ui.css" type="text/css"/>
     
     <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/icomoon.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link href="assets/css/custom.css" rel="stylesheet">
	 
	 
	 
	 <script type="text/javascript" src="js/jquery/jquery-1.8.3.min.js"></script>
	 <script src="js/jquery/jquery-ui.min.js"></script>
	<script src="js/jquery/jquery-ui-timepicker-addon.js"></script>
	<script src="js/jquery/jquery-ui-sliderAccess.js"></script>
	<script src="js/jqgrid/i18n/grid.locale-en.js"></script>
	<script src="js/jqgrid/jquery.jqGrid.min.js"></script>
	<script type="text/javascript" src="js/core.js"></script>	 
	<script type="text/javascript" src="js/newtext.js"></script>
	
	<script type="text/javascript" src="js/table.js"></script>
	<script type="text/javascript" src="js/lov.js"></script>
	<script type="text/javascript" src="js/xgrid.js"></script>
	<script type="text/javascript" src="js/newscreen.js"></script>
	<script type="text/javascript" src="js/jqimpl.js"></script>
	<script type="text/javascript" src="js/actions.js"></script>
	<script type="text/javascript" src="js/dateextn.js"></script>
    </head>
    
    <body>
    
    <div class="col-sm-6 col-md-6 col-lg-6 mTBx">                    
    	<div id="group1" class="panelOrange hcH">
    		<div  class="form-group extrBT hcHeHo">
				<label class="col-sm-4 control-label mpRes">Enable Hamali</label>
				<div class="col-sm-8 mpRes">
					<input id="enablehamali" name="enablehamali"  type="checkbox" value="0" class="form-control" onchange="changeValue(this);" />
				</div>
		   </div>
   		</div>
   </div>
   <div class="clearfix"></div>  
   <div id="saveGrp" class="mTBx">
   		<span>
			<button type="button" class="btn btn-primary mRhAj" onclick='onSaveClicked()'>Save</button>
			<button type="button" class="btn btn-default" onclick='clearData()'>Cancel</button>
		</span>
   </div>
  
<script>
function saveConfig(){
		 	var data='{"savedata":"",';
		 		data+='"detail":[';
				data+='{"name":"enablehamali","value":"'+$('#enablehamali').val()+'"}';
				data+=']}';
				var s=new FlexUI.Ajax();
			var res=s.callAjax('POST','/inventory/service/config',"data="+escape(data));
			return res;
		}
		function onSaveClicked() {
	        var valid = saveConfig();
	        alert(valid.message);
	        if(valid.result != 'Success'){
	            return false;
        	}
        }
        function clearData() {
        	$("#bodyContainer").empty();
        }
        function loadOrderData(url,code){
			if(url==""){
		  		url="/inventory/service/config";
		  	}
		  	var s=new FlexUI.Ajax();
			var v=s.callAjax("GET",url,"");
			v=v.config;
			for (var property in v) {
	   			$('#'+v[property].v).val(v[property].t);
	   			changeValueonLoad(v[property].v,v[property].t);
			}
		}
		function changeValue(id){
			if(id.checked){
				id.value="1";
			}else{
				id.value="0";
			}
		}
		function changeValueonLoad(id,value){
			if($('#'+id+'').attr('type')=="checkbox"){
				if(value==1){
					$('#'+id+'').attr('checked',"checked")
				}else{
					$('#'+id+'').removeAttr('checked')
				}
			}
		}
//defineTabUI();
loadOrderData("","");
</script>		      
    </body>
</html>