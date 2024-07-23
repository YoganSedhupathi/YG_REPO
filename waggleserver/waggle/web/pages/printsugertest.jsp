<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Print Suager Test</title>
</head>
<%
   String mode=request.getParameter("mode");
   String code=request.getParameter("code");
   String userId=(String)session.getAttribute("LOGIN_ID");
   String branch=request.getParameter("branch"); 
%>
<body>	
	<div id="branchcontainer" class="brTp" style="display:block;z-index:999">
		<select class="form-control" id='branch' onchange="changeBranchCodeAndClearSubScreenData()"></select>
    </div>
    <div class="col-sm-12 col-md-12 col-lg-12 mpZero  marTp" >
    	<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
			Test Report 
		</div>
	</div>
	<div class="clearfix"></div>
	<div class="col-md-12 col-sm-12 mpZero ">
	<div class="col-md-12 col-sm-12 panelOrange hcH" id="divsearch">
			<div  class="col-md-2 col-sm-2 mpZero">
			<div class="form-group mbotto">
				<div class="col-md-4" style="display:none"><label>Search By </label></div>
				<div class="col-md-4" style="display:none"><select class="form-control" id="searchtype">
					<option value="all">All</option>
					</select>
				</div>
				<div class="col-md-12"><select class="form-control" id="searchpatient">
					<option value="regno">Reg No/IP No</option>						
					</select>
				</div>
			</div>
			</div>
					<div  class="col-md-10 col-sm-10 mpZero">		
					<div class="form-group mbotto">
						<div class="col-md-7"><input type="text" class="form-control" id="smobileno"/></div>
						<div class="col-md-2"><label>Reg.No</label></div>
						<div class="col-md-3"><label id="lcsno"></label></div>
					</div>
					</div>
		 </div>	
		<div class="col-md-12 col-sm-12 mpZero">
		<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">		
      		 <div class="col-md-12 col-sm-12 mpZero">
			<div class="col-md-12 col-sm-12 mpZero">
				<div  class="col-md-6 col-sm-6 mpZero">
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Patient Name </label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="patientname"><input type="hidden" class="form-control" id="patientcode"><input type="hidden" class="form-control" id="hospregcode"><input type="hidden" class="form-control" id="crno"><input type="hidden" class="form-control" id="crsno"><input type="hidden" class="form-control" id="crstatus" value="1,2"></div>
					</div>
				</div>
				<div  class="col-md-6 col-sm-6 mpZero">		
				<div class="form-group mbotto">
					<div class="col-md-4"><label>Age</label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="patientage"></div>
				</div>
				</div>
			</div>
			<div class="clearfix"></div>	
			<div class="col-md-12 col-sm-12 mpZero">
				<div  class="col-md-6 col-sm-6 mpZero">		
				<div class="form-group mbotto">
					<div class="col-md-4"><label>Gender</label></div>
					<div class="col-md-8"><select class="form-control" id="gender"></select></div>
				</div>
				</div>
				<div  class="col-md-6 col-sm-6 mpZero">		
				<div class="form-group mbotto">
					<div class="col-md-4"><label>Doctor name </label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="doctorname"><input type="hidden" id="doctorcode"/></div>
				</div>
				</div>			
			</div>
			<div class="clearfix"></div>	
			<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH">
				<div class="col-sm-4 col-md-4 col-lg-4">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">From Date</label><div class="col-sm-7 mpRes"><input id="fromDate" name="fromDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control"/></div></div>
	  					</div>
		    			<div class="col-sm-4 col-md-4 col-lg-4">
		  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">To Date</label><div class="col-sm-7 mpRes"><input id="toDate" name="toDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control"/></div></div>
		  				</div>
		  				<div class="col-sm-4 col-md-4 col-lg-4 mpZero">
		  					<div class="form-group extrBT"><button type="button" class="btn btn-primary mRhAj btn-sm" onclick="reportGo()">Go</button><button type="button" id="prntBtn" class="btn btn-primary mRhAj btn-sm" onclick="printReport()">Print</button></div>	
					    </div>
				<div  class="col-md-6 col-sm-6 mpZero" style="display:none">		
					<div class="form-group mbotto">
						<div class="col-md-4"><label>Technician</label></div>
						<div class="col-md-8"><input type="text" class="form-control" id="technician"></div>
					</div>
				</div>
				<div  class="col-md-6 col-sm-6 mpZero" style="display:none">		
				<div class="form-group mbotto">
					<div class="col-md-4"><label>Date & Time</label></div>
					<div class="col-md-8"><input type="text" class="form-control" id="testtime"></div>
				</div>
				</div>
			</div>
		 </div>
		</div>
		<input type="hidden" class="form-control" id="grouptest" value="0">
		<div class="clearfix"></div>	
		<div class="col-md-12 col-sm-12 marLfBx panelOrange hcH" id="testdetails">
		
		</div>

		<div class="clearfix"></div>	
		
	</div>
	<script>
	loadBranchData();
    var sProps={js:"",screen:[
  	{name:"group1",predesigned:true,contentType:"Fields",
  	fields:[
  	{name:"code",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billno"},
  	{name:"billno",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"billtype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"2","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"patienttype",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"2","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branchcode"},
  	{name:"branchcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"ipno"},
  	{name:"ipno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"patientname"},
  	{name:"patientname",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"patientage"},
  	{name:"patientcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"patientage"},
  	{name:"patientage",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"gender"},
  	{name:"gender",inputType:1,type:"TEXT",caption:"",mandatory:true,defaultValue:"M","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"testtime",values:"M~F",keys:"Male~Female"},
  	{name:"testtime",inputType:0,type:"DATETIME",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"doctorname"},
  	{name:"doctorname",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"technician",lovOptions:{url:"/waggle/service/ajax",ajax:"doctors",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"doctorcode",tt:false,id:"dr_code"},{tgt:"doctorname",tt:true,id:"dr_name"},{tgt:"doctorname",tt:false,id:"dr_name"}]}},
  	{name:"doctorcode",inputType:0,type:"INT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"technician"},  	  	  
  	{name:"technician",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"btnSave"},
  	{name:"grouptest",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"btnSave"},
  	{name:"billdate",inputType:0,type:"TDATE",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},  	
  	{name:"hospregcode",inputType:0,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"crno",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"crsno",inputType:0,type:"TEXT",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"crstatus",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"btnSave"},
  	{name:"smobileno",inputType:0,type:"TEXT",caption:"",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"ipno",validation:"checkIPPatientExists"},
  	{name:"btnSave",inputType:3,caption:"",visible:false,readOnly:true},
    {name:"btnClear",inputType:3,caption:"",visible:false,readOnly:true}
  	]}]};
	var labbill=new FlexUI.Screen("labbill",sProps);
		
	//ajax columns
	var l=new FlexUI.Ajax();
    $(document).ready(function () {
    	

    		screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
            screenObjects.getScreenObject("smobileno").focus();
            
        });
        $('#fromDate').datetimepicker({
						timeFormat: 'hh:mm TT',
						dateFormat:'dd/mm/yy'
				});
				if($('#fromDate').val()==""){
					var cd=new Date();
					$('#fromDate').datetimepicker("setDate",cd);
				}
				$('#toDate').datetimepicker({
						timeFormat: 'hh:mm TT',
						dateFormat:'dd/mm/yy'
				});			
				if($('#toDate').val()==""){
					var cd=new Date();
					$('#toDate').datepicker("setDate",cd);
				}
        function clearInnerScreen(){
        	labbill.clearScreen();
        	labbill.setSaveInProgress(false);        	
        	screenObjects.getScreenObject("crstatus").setValue("1,2");
        	screenObjects.getScreenObject("branchcode").setValue($('#branch').val());
       		screenObjects.getScreenObject("smobileno").focus();
        }
		function tableTextKeyDown(e,args){
			var key=e.which || e.keyCode;
			if(key==113){
				e.preventDefault();
				saveLabBill();
			}
		}
		
		function printLabReport(){
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			var code=screenObjects.getScreenObject("code").getValue();
			if(toNumber(code)!=0){
				var url="/waggle/service/discharge/printlabbill?branchcode="+branch+"&billno="+code;
				window.open(url,"_blank");
			}
		}
		function checkIPPatientExists(id,me){
			if(!labbill.getSaveInProgress()){
				var branch=screenObjects.getScreenObject("branchcode").getValue();
				var stext=screenObjects.getScreenObject("smobileno").getValue();
				var params="";
				var paramName="F1";
				var dsi=0;
				var searchType=$('#searchtype').val();
				params="&F2="+stext;
				paramName="F2";
				dsi=1;					
				if(stext!=""){
					var v=null;
					var l=new FlexUI.Ajax();
					v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=hospinpatients&branchcode="+branch+"&searchtxt="+escape(stext));
					if(v!=null){
						if(v.data && v.data.length==1){
							getPatientInfo(branch,v.data[0]);					
							return true;
						}else if(v.data && v.data.length>1){
							screenObjects.getScreenObject("smobileno").setTag(stext);
							var d=null;
							d={url:"/waggle/service/ajax",ajax:"hospinpatients",scrollEnabled:true,searchFromList:false,dsi:dsi,edsi:1,params:[{n:"branchcode",src:"branchcode",ft:false},{n:"searchtxt",src:"smobileno",ft:false}],results:[],standalone:true};
							var lov=new FlexUI.LOV("s_lov",me,d,v.data);
							lov.onLovClose.subscribe(onPatientClose);
							lov.show();					
							return false;
						}		
					}
				}
				clearInnerScreen();
				return false;				
			}else{
				screenObjects.getScreenObject("smobileno").setTag("");
				return true;
			}	
		}
		function onPatientClose(e,args){
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			loadOrderData("/waggle/service/screen/data?branchcode="+branch+"&patientcode="+args.result[20],0,"")
		}		
		function getPatientInfo(branch,result){
			$('#lcsno').text(result[1]);
			loadOrderData("/waggle/service/screen/data?branchcode="+branch+"&patientcode="+result[20],0,"");
		}
		function loadOrderData(url,code,did){
		  	showLoader();
			var l=new FlexUI.Ajax();
			var v=l.callAjax("GET",url,"&screencode=12");
			labbill.loadObjectData(v);
			$('#callback').css('display','block');
		  	hideLoader();			
		}	
		function reportGo(id){
	
			var patientcode=screenObjects.getScreenObject("patientcode").getValue();
			var hospregcode=screenObjects.getScreenObject("hospregcode").getValue();
			var l=new FlexUI.Ajax();
	    	v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=sugertests&branchcode="+branch+"&patientcode="+ patientcode+"&hospregcode="+hospregcode+"&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val()+"&searchtxt=");
	    	var s=v.data.length;
	    	
	    	var dl=$('#testdetails');
	    	dl.children().remove();
	    	for(var i=0;i<s;i++){
	    		    dl.append('<div class="col-md-12 col-xs-12 mpZ borBot1 borBot2">'+
	    		    		'<div class="col-md-1 col-xs-1"><input type="checkbox" name="chselect" id="bid_'+v.data[i][0]+'">'+
	      					'</div>'+
	      					'<div class="col-md-3 col-xs-3 ">Lab Bill No : '+v.data[i][2]+
					    	'</div>'+
					    	'<div class="col-md-3 col-xs-3 ">Date Time :'+v.data[i][3]+
					    	'</div>'+
					        '</div>');
	    	}
	
		}	
		function printReport(){
			var el=$('#testdetails').find("[name='chselect']");
			var selectedID="";
			var e=0;
			for(var i=0;i<el.length;i++){
				if($(el[i]).prop("checked")){
					if(e>0){
						selectedID=selectedID+",";
					}
					selectedID=selectedID+$(el[i]).attr("id").replace("bid_","")
					e++;
				}
				//
			}
			var branch=screenObjects.getScreenObject("branchcode").getValue();
			//var code=screenObjects.getScreenObject("code").getValue();
			if(selectedID.length!=0){
				var url="/waggle/service/discharge/printsugertest?branchcode="+branch+"&billno="+selectedID;
				window.open(url,"_blank");
			}else{
				alert("Please select any one date");
			}
		}
	</script>
</body>
</html>