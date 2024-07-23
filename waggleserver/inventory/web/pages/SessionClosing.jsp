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
					<div id="branch" class="col-md-12 col-sm-12 mpZero" style="display:block">
   					</div>					
					<div class="clearfix"></div>
					<div id="group1" class="col-md-12 col-sm-12 mpZero">
					</div>
					<div class="clearfix"></div>	
	            	<div id="actButton" class="col-md-12 text-right">
	                	<button id="btnGenerate" class="btn btn-primary priBut" type="button" onclick="printSession()">Generate</button>
		                <button id="btnClear" class="btn btn-default" type="button" onclick="clearInnerScreen()">Clear</button>
	            	</div>
			</div>		
	</div>
	<script>
 	var l=new FlexUI.Ajax();
	var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=userdefbranch");
	var defbranch=v.data;
	
 	var sProps={js:"",screen:[
 	{name:"branch",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
	  fields:[ {colno:0,name:"branch",inputType:0,type:"LOV",caption:"Branch",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
	  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"custname",lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}}
	]},
  	{name:"group1",contentType:"Fields",
  	fields:[
  	{name:"username",inputType:0,type:"LOV",caption:"User",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"starttime",lovOptions:{url:"/inventory/service/ajax",ajax:"branchemployee",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[{tgt:"username",tt:false,id:"0"},{tgt:"username",tt:true,id:"2"}]}},
  	{name:"starttime",inputType:0,type:"DATETIME",caption:"Start Time",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"endtime"},
  	{name:"endtime",inputType:0,type:"DATETIME",caption:"End Time",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"btnGenerate"}
  	]}]};
	var sessionClose=null;	
    $(document).ready(function () {
    		sessionClose=new FlexUI.Screen("sessionclose",sProps);
    		setDefaultBranch();    		
            $('#subtitle').text("");
            screenObjects.getScreenObject("starttime").setValue(formatDateddMMyyyy(new Date())+" 12:00 AM");
            $('#screentitle').text("Session Closing");
     });
    function clearInnerScreen(){
    	sessionClose.clearScreen();
    	setDefaultBranch();
    	$("starttime").focus();
    }
	function printSession(){
	    var data;
	    var startTime=screenObjects.getScreenObject("starttime").getValue();
	    var endTime=screenObjects.getScreenObject("endtime").getValue();
	    var branch=screenObjects.getScreenObject("branch").getTag();
	    var userId=screenObjects.getScreenObject("username").getTag();
		$.ajax({
            url: "/inventory/service/account/cashhandover?userid="+userId+"&branchcode="+branch+"&starttime="+startTime+"&endtime="+endTime,
            type: "GET",
            async: false,
            contentType:"application/json",
            dataType: "json",
            success: function (r) {
				data=r;		
            }
        });			
		if(data.status=="Success"){
			alert("Session Closed Successfully");
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