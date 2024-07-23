<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<%
	String code=(String)request.getParameter("code");
	String branch=(String)request.getParameter("branch");
	String userId=(String)session.getAttribute("LOGIN_ID");
	String rptId=(String)request.getParameter("id");
	String screencode=(String)request.getParameter("screencode");
%>

<div class="card border-0">
	<div class="card-body lpage">
		<div class="row w-100">
			<div class="col-md-4 d-flex "  >
				<h4 class="header-title">Doctor Patients</h4>
			</div>
			<div class="col-md-6 d-flex " style="text-align: right;">
				<div id="" style="display:block" class="col-sm-12 col-md-12 col-lg-12 mpRhZ mTBx" >
					      <div id="branch1" style="display:none"> </div>				
						  <div id="divFirstFilter" style="display:block"></div>	
						  
				</div>	
			</div>
			<div class="col-md-1" id="divSecond" style="text-align: left;">
				<div class="form-group extrBT"><button type="button" class="btn btn-primary mRhAj btn-sm" onclick="reportGo(200009)">Go</button>&nbsp;<button type="button" class="btn btn-primary mRhAj btn-sm" onclick="printCurrentSession()">Print</button></div>	
			</div>
			<div class="col-md-1" style="text-align: right;">
				<button type="button" class="btn btn-clear" onclick='toggleHeaderRow()'><span class="mdi mdi-filter-variant">Search</span></button>	
			</div>
		</div>
		  <div class="row ">
			  <div class="table-container">
				<div class="col-md-12 col-sm-12 " id="rep"></div>
			  </div>
		  </div>
	</div>
</div>







<!-- JQ grid starts
        <div id="content" >
			<div class="clearfix"></div>
			<div id="filter" style="display:block" class="col-sm-15 col-md-15 col-lg-15 mpRhZ mTBx">
				<div class="panelOrange hcH">
				<div class="subHe" id="dtfilter" name="dtfilter" style="display: none">Doctor Patients<span class="pull-right" onclick="showHideFilter()"><b class="fa fa-caret-down"></b></span></div>
				  	<div id="branch1" style="display:none">
					</div>				
  					<div id="divFirstFilter" style="display:block">
					</div>
					<div id="divSecond" style="display:block">
		  				<div class="col-sm-4 col-md-4 col-lg-4 mpZero">
		  					<div class="form-group extrBT"><button type="button" class="btn btn-primary mRhAj btn-sm" onclick="">Go</button><button type="button" class="btn btn-primary mRhAj btn-sm" onclick="printCurrentSession()">Print</button></div>	
					    </div>
					</div>   					   
  				</div>
      		</div>			
            <div id="rep" style='position:relative;border:0px;display:block;' class="mTBx">
            	<div class=""><span class="pull-right" style="margin-top:-50px" ><button class="btn btn-sm seaColB" onclick="enableSearch();"><i class="fa fa-search"></i></button></span></div>
				<div class="clearfix"></div>
        	</div>
        </div>
<!-- JQ grid ends-->
<script>
var l=new FlexUI.Ajax();
var v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=userdefbranch");
var defbranch=v.data;
  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"",screen:[
  {name:"divFirstFilter",title:"",pcolumns:3,height:30,width:98,minWidth:500,minHeight:100,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"doctorname",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[
    {tgt:"doctorname",tt:false,id:"dr_name"},
    {tgt:"doctorname",tt:true,id:"dr_name"},
  	{tgt:"doctorcode",tt:false,id:"dr_code"}
  ]}},
  {colno:0,name:"doctorcode",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:""}
  ]},
  {name:"branch1",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"",lovOptions:{url:"/waggle/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  ]}]};

var ledgereport=null;
ledgereport=new FlexUI.Screen("ledgereport",sProps);
setDefaultBranch();
var newParams="&status=1&doctorcode=0&branchcode="+screenObjects.getScreenObject("branch").getTag();
jqReport(200009,"#rep",newParams,null,null);
	
function setDefaultBranch(){
		var branch=screenObjects.getScreenObject("branch");
		branch.setTag(defbranch[0][1]);
		branch.setValue(defbranch[0][0]);
	}


function toggleHeaderRow(){
  	toggleSearchToolBar(200009);
  }
  

function enableSearch(){
	toggleSearchToolBar(200009);
}
enableSearch();	       
function reportGo(id){
	showLoader();
	var newParams="&status=1&&doctorcode="+screenObjects.getScreenObject("doctorcode").getValue()+"&branchcode="+screenObjects.getScreenObject("branch").getTag();
	changeUrlAndReloadGrid(id,"",newParams);
	hideLoader();
}
function showHideFilter(){
	if( $('#divFirstFilter').is(':visible') ) {
		$('#divFirstFilter').css("display","none");
	}else{
		$('#divFirstFilter').css("display","block");
	}
}


function printCurrentSession(){
		var printData={};
		printData["type"]="DOCPAT";
		printData["title"]="PATIENTS LIST";
		printData["branchname"]="Tiruvarur Medical Center PVT Ltd";
		printData["address1"]="27,Javulikara Street";
		printData["address2"]="Tiruvarur - 610 001";
		printData["address3"]="Phone - 242292,240292";
		printData["login_id"]='<%=userId%>';
		printData["reportid"]='200009';
		printData["doctorcode"]=screenObjects.getScreenObject("doctorcode").getValue();
		printData["branch"]=screenObjects.getScreenObject("branch").getTag();
		printData["doctorname"]=screenObjects.getScreenObject("doctorname").getValue();
		printData["gendate"]=formatDateddMMyyyy(new Date());
		printData["host"]='192.168.1.6:8282/waggle';
		//printData["host"]='localhost:9090/HMS';
		printData["rows"]="48";		
		$.ajax({
            url: "http://localhost:9696",
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
