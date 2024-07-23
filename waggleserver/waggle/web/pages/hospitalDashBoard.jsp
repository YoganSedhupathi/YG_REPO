<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
		<style>
					body{
			margin-top:20px;
			background:#FAFAFA;
			}
			.order-card {
				color: #fff;
			}

			.bg-c-blue {
				background: linear-gradient(45deg,#4099ff,#73b4ff);
			}

			.bg-c-green {
				background: linear-gradient(45deg,#2ed8b6,#59e0c5);
			}

			.bg-c-yellow {
				background: linear-gradient(45deg,#FFB64D,#ffcb80);
			}

			.bg-c-pink {
				background: linear-gradient(45deg,#FF5370,#ff869a);
			}
			.bg-c-dark {
				background: linear-gradient(45deg,#3d3446,#ff869a);
			}
		


			.card {
				border-radius: 5px;
				-webkit-box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
				box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
				border: none;
				margin-bottom: 30px;
				-webkit-transition: all 0.3s ease-in-out;
				transition: all 0.3s ease-in-out;
			}
			.chart {
				border-radius: 0px;
				-webkit-box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
				box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
				border: black;
				margin-bottom: 30px;
				-webkit-transition: all 0.3s ease-in-out;
				transition: all 0.3s ease-in-out;
			}

			.card .card-block {
				padding: 25px;
			}
			.card .card-block-bottom {
				padding: 15px;
			}
			
			.order-card i {
				font-size: 26px;
			}

			.f-left {
				float: left;
			}

			.f-right {
				float: right;
			}
			.header {
				overflow: hidden;
				background-color: #f1f1f1;
				padding: 10px 10px;
				}
		</style>
    </head>
    <body>
    <script language="javascript" type="text/javascript" src="js/flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="js/flot/jquery.flot.categories.js"></script>
	<script language="javascript" type="text/javascript" src="js/flot/jquery.flot.tooltip.js"></script>    
    <script>
    <%
    	String userId=(String)session.getAttribute("LOGIN_ID");
    	%>
    	function showDash(categoryid) {
    	var a=new FlexUI.Ajax();
		var v=a.callAjax("GET","/waggle/service/account/dash","&id=lastsevensales&term=&type=line");
		
		var v1=a.callAjax("GET","/waggle/service/account/dash","&id=toptenproduct&term=");

		var data = v;

		var series=[];
		var s=data.length;
		var maxAmount=0;
		var sdata=[];		
		for(var i=0;i<s;i++){
			var d;
			d=data[i];
			sdata.push([i,d[1]]);
			if(d[1]>maxAmount){
				maxAmount=d[1];
			}
		}
		series.push({label:'Sales',data:sdata});
		
		$.plot("#flot-chart-bar", series, {
		series: {
			lines: {
				show: true
			}
		},
		grid: {
				hoverable: true //IMPORTANT! this is needed for tooltip to work
			},
		yaxis: { min: 0 },
		xaxis: { tickFormatter: function (v, axis) {					
        			return data[v][0];
      			}
    	},
		tooltip: true,
		tooltipOpts: {
			content: "'%s' is %y",
			shifts: {
				x: -60,
				y: 25
			}
		}
		});
		var tp=v1;
		$.plot("#toptenproduct", [ tp ], {
			series: {
				bars: {
					show: true,
					barWidth: 0.6,
					align: "center"
				}
			},
			xaxis: {
				mode: "categories",
				tickLength: 0
			},
			tooltip:true,
			grid: {
			hoverable: true 
			},
			tooltipOpts: {
				content: " %x = %y",
				shifts: {
					x: -60,
					y: 25
				}
			}			
		});
	}
    	
    </script>
    
    
    <div id="divDash" class="col-sm-12 col-md-12 col-lg-12 mTBx" style="display:block"> 
	    <div class="container">
			<div class="row">
				<div class="col-md-4 col-xl-2">
					<div class="card bg-c-blue order-card">
						<div class="card-block">
							<h6 class="m-b-20">Today Admission</h6>
							<h2 class="text-right"><i class="fa fa-calendar f-left"></i><p id="todayadmission" class="announcement-heading"></p></h2>
							
						</div>
						<div  class="card-block-bottom" style="border-radius: 10px;background: linear-gradient(45deg,#f3f3f3,#f3efef);">
							<p class="m-b-0" ></p>
							<a href="#" onclick="dashClick('/report.do?id=710007&title=Sales&fromdash=true')">Today Admission<span style="padding: 5px;" class="mdi mdi-arrow-right"></span></a>
						
						</div>
					</div>
				</div>
				
				<div class="col-md-4 col-xl-2">
					<div class="card bg-c-green order-card">
						<div class="card-block">
							<h6 class="m-b-20">Total Patients</h6>
							<h2 class="text-right"><i class="fa fa-user-plus f-left"></i><p id="totalpatients" class="announcement-heading"></p></h2>
							
						</div>
						<div  class="card-block-bottom" style="border-radius: 10px;background: linear-gradient(45deg,#f3f3f3,#f3efef);">
							<p class="m-b-0" ></p>
							<a href="#" onclick="dashClick('/report.do?id=710007&title=Sales&fromdash=true')">Total Patients<span style="padding: 5px;" class="mdi mdi-arrow-right"></span></a>
						
						</div>
					</div>
				</div>
				
				<div class="col-md-4 col-xl-2">
					<div class="card bg-c-yellow order-card">
						<div class="card-block">
							<h6 class="m-b-20">SelfCare</h6>
							<h2 class="text-right"><i class="fa fa-heartbeat f-left"></i><p id="selcare" class="announcement-heading"></p></h2>
							
						</div>
						<div  class="card-block-bottom" style="border-radius: 10px;background: linear-gradient(45deg,#f3f3f3,#f3efef);">
							<p class="m-b-0" ></p>
							<a href="#" onclick="dashClick('/report.do?id=710006&title=NewOrders&fromdash=true')"> SelfCare <span style="padding: 5px;" class="mdi mdi-arrow-right"></span></a>
						
						</div>
					</div>
				</div>
				
				<div class="col-md-4 col-xl-2">
					<div class="card bg-c-pink order-card">
						<div class="card-block">
							<h6 class="m-b-20">Corporates </h6>
							<h2 class="text-right"><i class="fa fa-hospital-o f-left"></i><p id="Sponsors" class="announcement-heading"></p></h2>
							
						</div>
						<div  class="card-block-bottom" style="border-radius: 10px;background: linear-gradient(45deg,#f3f3f3,#f3efef);">
							<p class="m-b-0" ></p>
							<a href="#" onclick="dashClick('/report.do?id=710013&title=PendingOrders&fromdash=true')"> Corporates <span style="padding: 5px;" class="mdi mdi-arrow-right"></span></a>
						
						</div>
					</div>
				</div>

				<div class="col-md-4 col-xl-2">
					<div class="card bg-c-dark order-card">
						<div class="card-block">
							<h6 class="m-b-20">MLC </h6>
							<h2 class="text-right"><i class="fa fa-list f-left"></i><p id="mlc" class="announcement-heading"></p></h2>
							
						</div>
						<div  class="card-block-bottom" style="border-radius: 10px;background: linear-gradient(45deg,#f3f3f3,#f3efef);">
							<p class="m-b-0" ></p>
							<a href="#" onclick="dashClick('/report.do?id=710013&title=PendingOrders&fromdash=true')"> MLC <span style="padding: 5px;" class="mdi mdi-arrow-right"></span></a>
						
						</div>
					</div>
				</div>

			</div>
		</div>
	
		
    <!-- END DASHBOARD -->
    <div class="row">
          <div class="col-lg-6">
            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i>Doctor wise Patients</h3>
              </div>
              <div class="panel-body">
                <div class="flot-chart">
                  <div class="flot-chart-content"  style="height:250px"><table id="drwisepatients" width="100%" ></table></div>
                </div>
                <!-- <div class="text-right">
                  <a href="#">View Details <i class="fa fa-arrow-circle-right"></i></a>
                </div> -->
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i> Room Status</h3>
              </div>
              <div class="panel-body">
                <div class="flot-chart">
                  <div class="flot-chart-content"  style="height:250px;"><table id="roomstatus" width="100%" ></table></div>
                </div>
                <!-- <div class="text-right">
                  <a href="#">View Details <i class="fa fa-arrow-circle-right"></i></a>
                </div> -->
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i> Corporates</h3>
              </div>
              <div class="panel-body">
                <div class="flot-chart">
                  <div class="flot-chart-content"  style="height:250px;"><table id="sponsorstatus" width="100%" ></table></div>
                </div>
                <!-- <div class="text-right">
                  <a href="#">View Details <i class="fa fa-arrow-circle-right"></i></a>
                </div> -->
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i> Labs</h3>
              </div>
              <div class="panel-body">
                <div class="flot-chart">
                  <div class="flot-chart-content"  style="height:250px;"><table id="labs" width="100%" ></table></div>
                </div>
                <!-- <div class="text-right">
                  <a href="#">View Details <i class="fa fa-arrow-circle-right"></i></a>
                </div> -->
              </div>
            </div>
          </div>
          <div class="col-lg-12">
            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i> Lab Summary</h3>
              </div>
              <div class="panel-body">
                <div class="flot-chart">
                  <div class="flot-chart-content"  style="height:250px;"><table id="labbills" width="100%" ></table></div>
                </div>
                <!-- <div class="text-right">
                  <a href="#">View Details <i class="fa fa-arrow-circle-right"></i></a>
                </div> -->
              </div>
            </div>
          </div>
          <div class="col-lg-12">
            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i> Discharge Summary</h3>
              </div>
              <div class="panel-body">
                <div class="flot-chart">
                  <div class="flot-chart-content"  style="height:250px;"><table id="dischargesummary" width="100%" ></table></div>
                </div>
                <!-- <div class="text-right">
                  <a href="#">View Details <i class="fa fa-arrow-circle-right"></i></a>
                </div> -->
              </div>
            </div>
          </div>
        </div>
        <div style="clear:both;"></div>
    <div id="reportcontent" style="display:none">
        	
    </div>
	
<script>

initializeGrid("drwisepatients",['Doctor Name','Patients #'],[
    {name:'doctorname',index:'doctorname', width:400, sortable:false,editable: false,edittype:"text"} ,    
	{name:'patients',index:'patients', width:100,editable: false,edittype:"text"}
     ],{doctorname:"",patients:""},false,false);
     
   initializeGrid("roomstatus",['Branch','Ward','Occupied #','Free #'],[
    {name:'branchname',index:'branchname', width:180, sortable:false,editable: false,edittype:"text"} ,
    {name:'ward',index:'ward', width:180, sortable:false,editable: false,edittype:"text"} ,    
	{name:'occupied',index:'occupied', width:100,editable: false,edittype:"text"},
	{name:'free',index:'free', width:70,editable: false,edittype:"text"}
     ],{ward:"",occupied:"",free:""},false,false);
   
   initializeGrid("sponsorstatus",['Corporate','Patients #'],[
    {name:'sponsors',index:'sponsors', width:400, sortable:false,editable: false,edittype:"text"} ,    
	{name:'patients',index:'patients', width:90,editable: false,edittype:"text"}
     ],{sponsors:"",patients:""},false,false);
     
     initializeGrid("labs",['Branch','In-Patients','Out-Patients'],[
    {name:'branch',index:'branch', width:200, sortable:false,editable: false,edittype:"text"} ,    
	{name:'ip',index:'ip', width:120,editable: false,edittype:"text"},
	{name:'op',index:'op', width:120,editable: false,edittype:"text"}
     ],{branch:"",category:"",ip:"",op:""},false,false);
     
     initializeGrid("labbills",['Branch','Cash','Credit','Card','Corporate','Total'],[
    {name:'branch',index:'branch', width:200, sortable:false,editable: false,edittype:"text"} ,    
	{name:'cash',index:'cash', width:120,editable: false,edittype:"text"},
	{name:'credit',index:'credit', width:120,editable: false,edittype:"text"},
	{name:'card',index:'card', width:120,editable: false,edittype:"text"},
	{name:'sponsor',index:'sponsor', width:120,editable: false,edittype:"text"},
	{name:'total',index:'total', width:120,editable: false,edittype:"text"}
     ],{branch:"",cash:"",credit:"",card:"",sponsor:"",total:""},false,false);
     
     initializeGrid("dischargesummary",['Branch','#Patients','Cash','Card','Corporate','Total'],[
    {name:'branch',index:'branch', width:200, sortable:false,editable: false,edittype:"text"} ,
    {name:'patients',index:'patients', width:120,editable: false,edittype:"text"},    
	{name:'cash',index:'cash', width:120,editable: false,edittype:"text"},
	{name:'card',index:'card', width:120,editable: false,edittype:"text"},
	{name:'sponsor',index:'sponsor', width:120,editable: false,edittype:"text"},
	{name:'total',index:'total', width:120,editable: false,edittype:"text"}
     ],{branch:"",patients:"",cash:"",card:"",sponsor:"",total:""},false,false);
     
function loadOrderData(url,code){
		var a=new FlexUI.Ajax();
		var v=a.callAjax("GET",url,code);
				
		
		$('#todayadmission').html(v['todayadmission']);
		$('#mlc').html(v['mlc']);
		$('#totalpatients').html(v['totalpatients']);
		$('#Sponsors').html(v['2']);
		$('#selcare').html(v['1']);
		
		for (var property in v) {
			if(property=='drwisepatients'){
	    		addGridRowWithData('drwisepatients',v[property]);
	    	}else if(property=='roomstatus'){
	    		addGridRowWithData('roomstatus',v[property]);
	    	}else if(property=='sponsorstatus'){
	    		addGridRowWithData('sponsorstatus',v[property]);
	    	}else if(property=='labs'){
	    		addGridRowWithData('labs',v[property]);
	    	}else if(property=='labstender'){
	    		addGridRowWithData('labbills',v[property]);
	    	}else if(property=='dischargedetails'){
	    		addGridRowWithData('dischargesummary',v[property]);
	    	}
		}
		
}
loadOrderData("/waggle/service/account/dashboard","");

function dashClick(m){
	if(m!=null && m!="" && m!="#"){
		$("#divDash").css("display","none");
		$("#reportcontent").css("display","block");
		$("#reportcontent").html("");
		$("#reportcontent").load("/HMS"+m);
	}
}
</script>        
    </body>
</html>