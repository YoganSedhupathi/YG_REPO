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
	<div class="col-md-12 col-sm-12 mpZero marTp">
			<div class="col-md-12 panelOrange hcH" >
					<div class="subHe">Session Details</div>
					<div class="col-md-12 col-sm-12 mpZero" style="display:none">
						<div class="form-group mbotto">
						<div class="col-md-2"><label>Type</label></div>
						<div class="col-md-10"><select id="stype"></select></div>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="col-md-6 col-sm-6 mpZero">
						<div class="form-group mbotto">
						<div class="col-md-2"><label>Branch</label></div>
						<div class="col-md-10"><select class="form-control" id='branch' onchange="changeBranchCodeAndClearSubScreenData()"></select></div>
						</div>
					</div>
					<div class="col-md-6 col-sm-6 mpZero">
						<div class="form-group mbotto">
						<div class="col-md-2"><label>Taken Time</label></div>
						<div class="col-md-10"><input type="text" class="form-control" id="processdate" disabled/></div>
						</div>
					</div>
					<div class="clearfix"></div>					
					<div class="col-md-12 col-sm-12 mpZero" style="display:none">
						<div class="form-group mbotto">
						<div class="col-md-2"><label>User</label></div>
						<div class="col-md-10"><input type="text" id="username"/><input type="hidden" id="userid"/></div>
						</div>
					</div>
					<div class="clearfix"></div>					
					<div class="col-md-12 col-sm-12 mpZero">
						<div  class="col-md-6 col-sm-6 mpZero">		
						<div class="form-group mbotto">
							<div class="col-md-2"><label>Date</label></div>
							<div class="col-md-10"><input type="text" class="form-control" id="starttime"></div>
						</div>
						</div>	
						<div  class="col-md-6 col-sm-6 mpZero" style="display:none">		
						<div class="form-group mbotto">
							<div class="col-md-4"><label>End Time</label></div>
							<div class="col-md-8"><input type="text" class="form-control" id="endtime"></div>
						</div>
						</div>
					</div>					
					<div class="clearfix"></div>	
	            	<div id="actButton" class="col-md-12 text-right">
	                	<button id="btnGenerate" class="btn btn-primary priBut" type="button" onclick="printSession(false)">Generate</button>
	                	<button id="btnPrint" class="btn btn-primary priBut" type="button" onclick="printSession(true)">Print</button>
		                <button id="btnClear" class="btn btn-default" type="button" onclick="clearInnerScreen()">Clear</button>
	            	</div>
	            	<div class="clearfix"></div>
					<div id="clbal" style='position:relative;border:0px;display:block;' class="mTBx">
        				<div style="background:#fedc34; display:inline-block; width:100%; padding:5px 10px;text-align:right" >
				    	<div class="netAm" id="netCash">Net Cash 0.00</div>
    				</div>
        			</div>
	            	<div class="clearfix"></div>
	            	<div class="col-md-12 col-sm-12 mpZero">
	            		<div class="col-md-12 col-sm-12 mpZero" id="bills" style="height:360px;display:block">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="cashdetails"></table>
		  				</div>
	            	</div>
			</div>		
	</div>
	<script>
 	loadBranchData();
 	var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"stype"},
  	{name:"stype",inputType:1,type:"TEXT",caption:"",mandatory:false,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"username",values:"1~2",keys:"IP~OP"},
  	{name:"username",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"starttime",lovOptions:{url:"/waggle/service/ajax",ajax:"branchemployee",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branchcode",ft:false}],results:[{tgt:"username",tt:false,id:"em_name"},{tgt:"userid",tt:false,id:"em_code"}]}},
  	{name:"userid",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"starttime"},
  	{name:"starttime",inputType:0,type:"DATE",caption:"Date",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"btnGenerate"},
  	{name:"endtime",inputType:0,type:"DATETIME",caption:"End Time",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	{name:"processdate",inputType:0,type:"TEXT",caption:"Taken Time",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:""},
	{name:"btnGenerate",inputType:3,caption:"",visible:false},
    {name:"btnClear",inputType:3,caption:"",visible:false}	  		
  	]}]};
	var sessionClose=null;	
    $(document).ready(function () {
    		sessionClose=new FlexUI.Screen("sessionclose",sProps);
            $('#subtitle').text("");
            $('#screentitle').text("Session Closing");
            screenObjects.getScreenObject("starttime").setValue(formatDateddMMyyyy(new Date()));
            screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
            ConstructCashGrid();            
     });
    function clearInnerScreen(){
    	sessionClose.clearScreen();
    	$("stype").focus();
    	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
    	clearGrid();
    }
	function printSession(print){
	    var data;
	    var startTime=screenObjects.getScreenObject("starttime").getValue();
	    var endTime=screenObjects.getScreenObject("endtime").getValue();
	    var type=screenObjects.getScreenObject("stype").getValue();
	    var branch=screenObjects.getScreenObject("branchcode").getValue();
	    //var userId=screenObjects.getScreenObject("userid").getValue();
		$.ajax({
            url: "/waggle/service/session?userid=0&type=1&branchcode="+branch+"&starttime="+startTime+"&displaydp=0",
            type: "GET",
            async: false,
            contentType:"application/json",
            dataType: "json",
            success: function (r) {
				data=r;		
            }
        });			
        if(print){
        	data["displaydp"]="0";
			if(data.status=="Success"){
				$.ajax({
		            url: "http://localhost:9191",
		            type: "POST",
		            async: true,
		            contentType:"application/x-www-form-urlencoded",
		            data:"printdata="+JSON.stringify(data),
		            dataType: "json",
		            success: function (r) {
						//alert(r.result);		
		            }
		        });
		     }else{
		     	alert(data.message);
		     }			
	    }else{
	    	clearGrid();
	        $grid = $("#cashdetails");
	        $grid.clearGridData();
	        $grid.jqGrid('setGridParam', { data: data["cashdetails"] });
	        $grid[0].refreshIndex();
	        $grid.trigger("reloadGrid");
	        $grid.footerData('set',{"cash":data["totalcash"],"card":data["totalcard"],"sponsor":data["totalsponsor"],"credit":data["totalcredit"]},false);
	        $('#netCash').text("Net Cash : "+data["totalcash"]);        	
	        screenObjects.getScreenObject("processdate").setValue(data["gendate"]);		
	    }			
	}
	function ConstructCashGrid() {
        var areaWidth = 800;
        $("#cashdetails").jqGrid({
            datatype: "local",
            //width: areaWidth,
            height:350,
            autowidth: true,
            shrinktofit:true,
            colNames: ['BU', 'Cash', 'Card','Sponsor','Credit'],
            colModel: [
                        { name: 'buname', index: 'billno', sorttype: "integer", sortable: false, width: 250, align: 'left'},
                        { name: 'cash', index: 'cash', sorttype: "text", sortable: false, width: 100, align: 'right' },
						{ name: 'card', index: 'card', sorttype: "text", sortable: false, width: 200, align: 'right' },
						{ name: 'sponsor', index: 'sponsor', sorttype: "text", sortable: false, width: 200, align: 'right' },
						{ name: 'credit', index: 'credit', sorttype: "text", sortable: false, width: 0, align: 'left' }
            ],
            rowNum: 500,
            footerrow:true,
            userDataOnFooter:true,            
            datatype: "jsonstring",
            jsonReader: { repeatitems: false },
            viewrecords: true,
            gridview: true,
            loadtext: "Loading....",
            multiselect: false,
        });
    }
    function clearGrid(){    	
    	$grid = $("#cashdetails");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	$grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");
    	$('#netCash').text("Net Cash : 0.00");
    }
  </script>
</body>
</html>