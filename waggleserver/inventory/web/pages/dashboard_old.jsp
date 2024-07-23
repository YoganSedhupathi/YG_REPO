<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    </head>
    <body>
    <script language="javascript" type="text/javascript" src="js/flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="js/flot/jquery.flot.categories.js"></script>
	<script language="javascript" type="text/javascript" src="js/flot/jquery.flot.pie.js"></script>
	<script language="javascript" type="text/javascript" src="js/flot/jquery.flot.tooltip.js"></script>    
    <script>
    <%
    	String userId=(String)session.getAttribute("LOGIN_ID");
    	%>
    	function showDash() {
    	var setNo=$('#setno').val();
    	/*var a=new FlexUI.Ajax();
		var v=a.callAjax("GET","/wovenerp/service/ajax","&id=setno&ic=0&ro=false&setno="+setno);		
		var setdata = v.data;*/

 		var data = [
        {label: "thin", data:(17/52*100)},
        {label: "large", data: (10/52*100)},
        {label: "entangle", data: (5/52*100)},
        {label: "other1", data: (5/52*100)},
        {label: "other2", data: (8/52*100)},
        {label: "other3", data: (7/52*100)},
        {label: "other4", data: (3/52*100)}
    	];
var options = {
            series: {
                pie: {show: true
                    }
		},
            legend: {
                show: false
            }
	  
         };
 
    $.plot($("#chartcontainer"), data, options);  
	}
function labelFormatter(label, series) {
    return "<div style='font-size:15pt; text-align:center; padding:2px;'>"    + label + "<br/>" + series.data[0][1] + "%</div>";
}
    	
    </script>
    
    
    <div id="divDash" class="col-sm-12 col-md-12 col-lg-12 mTBx" style="display:block"> 
	    <div class="row">
	          <div class="col-lg-12">
	            <div class="panel panel-info">
	              <div class="panel-body">
	                <div class="row">
	                	<div class="form-group extrBT col-lg-5"><label class="col-sm-5 control-label mpRes" for="inputEmail3">Set No</label><div class="col-sm-7 mpRes"><input type="text" id="setno"/><button id="btnGo" onclick="showDash()">Go</button></div></div>
	                </div>
	              </div>
	            </div>
	          </div>
	          <div class="clearfix"></div>
	          <div class="col-lg-12">
	            <div class="panel panel-info">
	              <div class="panel-body">
	                <div style="text-align:center">
	                	<div id="chartcontainer" style="width:500px;height:400px;"></div>
	                </div>
	              </div>
	            </div>
	          </div>
	    </div>
    </div>
</body>
</html>