<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Day End</title>
</head>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
%>
<body>

	<div class="card border-0 shadow">
		<div class="card-body lpage">
			<div class="row w-100">
				<div class="col-md-6 d-flex align-items-center">
					<h4 class="header-title">Day End Details</h4>
				</div>
			</div>
			
			<div class="row " id="jqcontainer" style="display:none"> <div class="table-container" > <div id="xyz" class="w-100"></div></div></div>	
			<div id="callback"  >
				
			<div class="table-container">
				<div class="row w-100 ml-12">
					<div class="col-sm-12 col-md-12 col-lg-12">                    
						<div id="group1" class="row"></div>
					</div>                    
					
				</div>
			   
			</div>

			<div class="row w-100 mt-3">
				<div class="col-md-3">
				  <div class="hstack justify-content-start">
					<div id="actButton">
						<button id="btnGenerate" class="btn btn-primary priBut" type="button" onclick="doDayEnd()">Generate</button>
	                	<button id="btnCensus"   class="btn btn-primary priBut" type="button" onclick="doCensus()">Run Census</button>
		                <button id="btnClear"    class="btn btn-light" type="button" onclick="clearInnerScreen()">Clear</button>
					</div>
				  </div>
				</div>
			</div>	
			   
			</div>
		</div>
	</div>


	<!--  -->


	<script>
 	var l=new FlexUI.Ajax();
	var v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=userdefbranch");
	var defbranch=v.data;
	
 	var sProps={js:"",screen:[
 	{name:"branch1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
	  fields:[ {colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/waggle/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
	  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"custname",lovOptions:{url:"/waggle/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}}
	]},
  	{name:"group1",contentType:"Fields",pcolumns:1,
  	fields:[
  	{colno:0,name:"fromtime",inputType:0,type:"DATE",caption:"Start Time",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"btnGenerate"},
  	{colno:0,name:"totime",inputType:0,type:"DATE",caption:"End Time",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnGenerate"},
  	{colno:0,name:"trandate",inputType:0,type:"TDATE",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""},
  	]}]};
	var dayend=null;	
    $(document).ready(function () {
    		dayend=new FlexUI.Screen("dayend",sProps);
    		setDefaultBranch();    		
            $('#subtitle').text("");
            //screenObjects.getScreenObject("fromtime").setValue(formatDateddMMyyyy(new Date())+" 12:00 AM");
            screenObjects.getScreenObject("fromtime").setValue(formatDateddMMyyyy(new Date()));
            screenObjects.getScreenObject("trandate").setValue(formatDateddMMyyyy(new Date()));
            $('#screentitle').text("Day End");
     });
    function clearInnerScreen(){
    	dayend.clearScreen();
    	setDefaultBranch();
    	$("starttime").focus();
    }
	function doDayEnd(){
	    var data;
	    var startTime=screenObjects.getScreenObject("fromtime").getValue()+" 12:00 AM";
	    //var endTime=screenObjects.getScreenObject("totime").getValue();
	    var endTime=screenObjects.getScreenObject("fromtime").getValue()+" 11:59 PM";
	    var branch=screenObjects.getScreenObject("branch").getTag();
	    var tranDate=screenObjects.getScreenObject("trandate").getValue();
		$.ajax({
            url: "/waggle/service/account/dayend",
            type: "POST",
            async: false,
            contentType:"application/x-www-form-urlencoded",
            data: "&branchcode="+branch+"&fromtime="+startTime+"&totime="+endTime+"&trandate="+tranDate,
            success: function (r) {
				data=r;		
            }
        });			
		if(data.status=="Success"){
			alert("Day End Processed Successfully");
	    }else{
	    	alert(data.message);
	    }						
	}
	function doCensus(){
	    var data;
		$.ajax({
            url: "/waggle/service/discharge/updatebalances?branchcode=1",
            type: "GET",
            async: false,
            success: function (r) {
				data=r;		
            }
        });
		if(data=="Success"){
			alert("Census Generated Successfully");
	    }else{
	    	alert("Census not completed");
	    }						
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