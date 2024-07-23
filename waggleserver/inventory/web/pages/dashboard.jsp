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
		var v=a.callAjax("GET","/inventory/service/account/dash","&id=lastsevensales&term=&type=line");
		
		var v1=a.callAjax("GET","/inventory/service/account/dash","&id=toptenproduct&term=");

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
		series.push({data:sdata});
		
		$.plot("#flot-chart-bar", series, {
		series: {
			lines: {
				show: true
			}
		},
		grid: {
				hoverable: true //IMPORTANT! this is needed for tooltip to work
			},
		yaxis: { min: 0,max:3 },
		// xaxis: { min :0 },
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
					align: "center",
					color:'#ffffff'
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
    
	<!-- START DASHBOARD -->
	<div id="divDash" style="display:block">
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-xl-3">
					<div class="card bg-c-blue order-card">
						<div class="card-block">
							<h6 class="m-b-20">Today Sale Value</h6>
							<h2 class="text-right"><i class="fa fa-usd f-left"></i><p id="todaysalevalue" class="announcement-heading"></p></h2>
							
						</div>
						<div  class="card-block-bottom" style="border-radius: 10px;background: linear-gradient(45deg,#f3f3f3,#f3efef);">
							<p class="m-b-0" ></p>
							<a href="#" onclick="dashClick('/report.do?id=710007&title=Sales&fromdash=true')">Today Sales<span style="padding: 5px;" class="mdi mdi-arrow-right"></span></a>
						
						</div>
					</div>
				</div>
				
				<div class="col-md-4 col-xl-3">
					<div class="card bg-c-green order-card">
						<div class="card-block">
							<h6 class="m-b-20">New Orders</h6>
							<h2 class="text-right"><i class="fa fa-cart-plus f-left"></i><p id="neworder" class="announcement-heading"></p></h2>
							
						</div>
						<div  class="card-block-bottom" style="border-radius: 10px;background: linear-gradient(45deg,#f3f3f3,#f3efef);">
							<p class="m-b-0" ></p>
							<a href="#" onclick="dashClick('/report.do?id=710006&title=NewOrders&fromdash=true')">Today Orders<span style="padding: 5px;" class="mdi mdi-arrow-right"></span></a>
						
						</div>
					</div>
				</div>
				
				<div class="col-md-4 col-xl-3">
					<div class="card bg-c-yellow order-card">
						<div class="card-block">
							<h6 class="m-b-20">Orders Processed</h6>
							<h2 class="text-right"><i class="fa fa-spinner f-left"></i><p id="orderprocessed" class="announcement-heading"></p></h2>
							
						</div>
						<div  class="card-block-bottom" style="border-radius: 10px;background: linear-gradient(45deg,#f3f3f3,#f3efef);">
							<p class="m-b-0" ></p>
							<a href="#" onclick="dashClick('/report.do?id=710006&title=NewOrders&fromdash=true')"> Orders Completed<span style="padding: 5px;" class="mdi mdi-arrow-right"></span></a>
						
						</div>
					</div>
				</div>
				
				<div class="col-md-4 col-xl-3">
					<div class="card bg-c-pink order-card">
						<div class="card-block">
							<h6 class="m-b-20">Pending Orders </h6>
							<h2 class="text-right"><i class="fa fa-list f-left"></i><p id="pendingorder" class="announcement-heading"></p></h2>
							
						</div>
						<div  class="card-block-bottom" style="border-radius: 10px;background: linear-gradient(45deg,#f3f3f3,#f3efef);">
							<p class="m-b-0" ></p>
							<a href="#" onclick="dashClick('/report.do?id=710013&title=PendingOrders&fromdash=true')"> Pending Orders <span style="padding: 5px;" class="mdi mdi-arrow-right"></span></a>
						
						</div>
					</div>
				</div>
			</div>
		</div>
	
		
    <!-- END DASHBOARD -->
    
	    

    <div class="row">
          <div class="col-lg-6 ">
            <div class="panel panel-info chart">
              <div class="panel-heading header">
                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i> Last 7 Day Sales</h3>
              </div>
              <div class="panel-body">
                <div class="flot-chart">
                  <div class="flot-chart-content" id="flot-chart-bar" style="height:250px"></div>
                </div>
                <!-- <div class="text-right">
                  <a href="#">View Details <i class="fa fa-arrow-circle-right"></i></a>
                </div> -->
              </div>
            </div>
          </div>

          <div class="col-lg-6 ">
            <div class="panel panel-info chart">
              <div class="panel-heading header">
                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i> Top 10 Products (This Month)</h3>
              </div>
              <div class="panel-body">
                <div class="flot-chart">
                  <div class="flot-chart-content" id="toptenproduct" style="height:250px;"></div>
                </div>
                <!-- <div class="text-right">
                  <a href="#">View Details <i class="fa fa-arrow-circle-right"></i></a>
                </div> -->
              </div>
            </div>
          </div>

		  	
        </div>
    
    <div style="clear:both;"></div>
    
    
    </div>

    <div id="reportcontent" style="display:none">
        	
    </div>
<script>
/*
initializeGrid("todaytender",['Tender#','Ref No', 'Date','Description','Title'],[
    {name:'tenderno',index:'tenderno', width:70, sortable:false,editable: false,edittype:"text"} ,    
	{name:'tenderrefno',index:'tenderrefno', width:140,editable: false,edittype:"text"},
    {name:'tenderdate',index:'tenderdate', width:95, hidden:false,editable: false}, 
    {name:'tendername',index:'tendername', width:190, editable: false}, 
    {name:'tendertitle',index:'tendertitle', width:80, hidden:true,editable: false}
     ],{tenderno:"",tenderrefno:"",tenderdate:"",tendername:"",tendertitle:""},false,false);
   
initializeGrid("thisweektender",['Tender#','Ref No', 'Date','Description','Title'],[
    {name:'tenderno',index:'tenderno', width:70, sortable:false,editable: false,edittype:"text"} ,    
	{name:'tenderrefno',index:'tenderrefno', width:140,editable: false,edittype:"text"},
    {name:'tenderdate',index:'tenderdate', width:95, hidden:false,editable: false}, 
    {name:'tendername',index:'tendername', width:190, editable: false}, 
    {name:'tendertitle',index:'tendertitle', width:80, hidden:true,editable: false}
     ],{tenderno:"",tenderrefno:"",tenderdate:"",tendername:"",tendertitle:""},false,false);

*/     
function loadOrderData(url,code){
		var a=new FlexUI.Ajax();
		var v=a.callAjax("GET",url,code);
				
/*		for (var property in v) {
			if(property=='todaytender'){
	    		addGridRowWithData('todaytender',v[property]);
	    	}else if(property=='thisweektender'){
	    		addGridRowWithData('thisweektender',v[property]);
	    	}
		}*/
		$('#todaysalevalue').html(v['todaysales']);
		$('#neworder').html(v['neworders']);
		$('#orderprocessed').html(v['orderprocessed']);
		$('#pendingorder').html(v['pendingorder']);
		
}
loadOrderData("/inventory/service/account/dashboard","");
showDash();
function dashClick(m){
	if(m!=null && m!="" && m!="#"){
		$("#divDash").css("display","none");
		$("#reportcontent").css("display","block");
		$("#reportcontent").html("");
		$("#reportcontent").load("/inventory"+m);
	}
}
</script>        
    </body>
</html>