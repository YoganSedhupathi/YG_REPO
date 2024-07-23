<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Session Closing</title>
</head>
	<%
	String mode=request.getParameter("mode");
	String code=request.getParameter("code");
	%>
<body>
	<div class="card border-0 shadow">
		<div class="card-body">
		  <!--Header-->
			<div class="row w-100">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Session Details</h4>
				</div>
				<div  class="col-md-6 text-right" id="addGrp">
					<div id="actButton" class="mb-3">
						<button id="btnGenerate" class="btn btn-primary priBut" type="button" onclick="showSession()">Go</button>
						<button id="btnPrint" class="btn btn-primary priBut" type="button" onclick="printSession()">Print</button>
						<button id="btnClear" class="btn btn-clear mx-3" type="button" onclick="clearInnerScreen()"><span class="mdi mdi-close-box"></span>Clear</button>			
					</div>
				</div>
			</div>
			<div class="row w-100">
				<div class="col-sm-12 col-md-12 col-lg-12 sBor" style="display:block" >                    
				<div id="branch1" class="">
				</div>
				</div>
			</div> 

			<div id="callback">
				<div class="row">
						<div class="table-container">
						<div id="rep" class="col-md-12 col-sm-12 garea">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="cashdetails">
								
							</table>
						</div>
						</div>
					</div>
					<div class="row w-100 mt-3">
						<div class="col-md-9"></div>
							<div class="col-md-3">
								<div class="p-2 gap-2 bg-white shadow-sm rounded-3">
									<table>
									<thead>
										<th style="width:25%;">
										<div class="card-total rounded-3 " >
											Net Amount &nbsp;:&nbsp; <span class="amount-text ml-2" id="netAmt"></span>
											<label style="display:none;" id="totalamt"></label>
										</div>
										</th>
									</thead>
									<tbody>
									</tbody>
									</table>
							</div>
								</div>
					</div>
			</div>  
		</div>
	</div>

		  
	
	<script>
 	var l=new FlexUI.Ajax();
	var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=userdefbranch");
	var defbranch=v.data;
	
 	var sProps={js:"",screen:[
 	{name:"branch1",title:"",pcolumns:2,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
	  fields:[ {colno:0,name:"branch",inputType:0,type:"LOV",caption:"Branch",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
	  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"custname",lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}},
	  {colno:1,name:"username",inputType:0,type:"LOV",caption:"User",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"starttime",lovOptions:{url:"/inventory/service/ajax",ajax:"branchemployee",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[{tgt:"username",tt:false,id:"0"},{tgt:"username",tt:true,id:"2"}]}},
  	  {colno:0,name:"fromdate",inputType:0,type:"DATE",format:"dd/mm/yyyy",caption:"Date",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  	  {colno:1,name:"processdate",inputType:0,type:"TEXT",format:"dd/mm/yyyy",caption:"Taken Time",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:""}
	]}]};
	var sessionClose=null;	
	
    $(document).ready(function () {
    		qsessionClose=new FlexUI.Screen("qsessionclose",sProps);
    		setDefaultBranch();    		
            $('#subtitle').text("");
			$('#fromdate').datepicker(
	{
		language: "en",
        autoclose: true,
       	todayHighlight: true,
		format:'dd/mm/yyyy'
	}
	);	
            screenObjects.getScreenObject("fromdate").setValue(new Date());
            screenObjects.getScreenObject("processdate").setEnabled(false);
            $('#screentitle').text("Session Closing");
            ConstructPharmacyGrid();

     });
    function clearInnerScreen(){
    	qsessionClose.clearScreen();
    	setDefaultBranch();
    	$("fromdate").focus();
    	$grid = $("#cashdetails");
    	$grid.clearGridData();
    	$grid.jqGrid('setGridParam', { data: [] });
    	// $grid[0].refreshIndex();
    	$grid.trigger("reloadGrid");    	
    	$('#netCash').text("Net Cash : 0.00");
		$('#fromdate').datepicker(
	{
		language: "en",
        autoclose: true,
       	todayHighlight: true,
		format:'dd/mm/yyyy'
	}
	);	
    }
    function ConstructPharmacyGrid() {
        var areaWidth = 800;
        $("#cashdetails").jqGrid({
            datatype: "local",
            //width: areaWidth,
            height:250,
            autowidth: true,
            shrinktofit:true,
            colNames: ['BU', 'Cash', 'Card','Sponsor','Credit'],
            colModel: [
                        { name: 'buname', index: 'buname', sorttype: "integer", sortable: false, width: 100, align: 'left'},
                        { name: 'cash', index: 'cash', sorttype: "text", sortable: false, width: 100, align: 'left' },
						{ name: 'card', index: 'card', sorttype: "text", sortable: false, width: 200, align: 'left' },
						{ name: 'sponsor', index: 'sponsor', sorttype: "text", sortable: false, width: 200, align: 'left' },
						{ name: 'credit', index: 'credit', sorttype: "text", sortable: false, width: 200, align: 'left' }
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
	function showSession(){
	    var data;
	    var fromDate=screenObjects.getScreenObject("fromdate").getValue();
	    var branch=screenObjects.getScreenObject("branch").getTag();
	    var userId=screenObjects.getScreenObject("username").getTag();
		$.ajax({
            url: "/inventory/service/account/quickcashhandover?userid=0&branchcode="+branch+"&fromdate="+fromDate,
            type: "GET",
            async: false,
            contentType:"application/json",
            dataType: "json",
            success: function (r) {
				data=r;		
            }
        });
        $grid = $("#cashdetails");
        $grid.clearGridData();
        $grid.jqGrid('setGridParam', { data: data["cashdetails"] });
       // $grid[0].refreshIndex();
        $grid.trigger("reloadGrid");
        $grid.footerData('set',{"cash":data["totalcash"],"card":data["totalcard"],"sponsor":data["totalsponsor"],"credit":data["totalcredit"]},false);
        $('#netCash').text("Net Cash : "+data["totalcash"]);        	
        screenObjects.getScreenObject("processdate").setValue(data["gendate"]);		
	}
	function printSession(){
		var fromDate=screenObjects.getScreenObject("fromdate").getValue();
		var branch=screenObjects.getScreenObject("branch").getTag();
	    var userId=screenObjects.getScreenObject("username").getTag();		
		$.ajax({
            url: "/inventory/service/account/quickcashhandover?userid=0&branchcode="+branch+"&fromdate="+fromDate,
            type: "GET",
            async: false,
            contentType:"application/json",
            dataType: "json",
            success: function (r) {
				data=r;		
            }
        });	
		$.ajax({
            url: "http://localhost:8282",
            type: "POST",
            async: true,
            contentType:"application/x-www-form-urlencoded",
            data:"printdata="+JSON.stringify(data),
            dataType: "json",
            success: function (r) {
				//alert(r.result);		
            }
        });
	}
	function setDefaultBranch(){
		var branch=screenObjects.getScreenObject("branch");
		var location=screenObjects.getScreenObject("location");
		branch.setTag(defbranch[0][1]);
		branch.setValue(defbranch[0][0]);
		location.setTag(defbranch[0][3]);
		location.setValue(defbranch[0][2]);	
	}
  </script>
</body>
</html>