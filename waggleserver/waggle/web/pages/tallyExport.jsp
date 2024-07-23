<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Category</title>
</head>
<body>

<div class="col-sm-10 col-md-10 col-lg-10 mpZero"><h1>Tally Export</h1><ol class="breadcrumb mpZero"><li><a href="#">Home</a></li><li><a>MIS</a></li><li class="active breaCSel"><strong>Tally Export</strong></li></ol></div>
	
<!--add and search-->
<div class="col-sm-2 col-md-2 col-lg-2 mpZero marTp" id='addGrp'>
</div>

<div class="clearfix"></div>                    
<!-- JQ grid starts-->
<div style="width:100%;float:left">
	    	 
<div id="callback" style="display:block" >
<div class="col-sm-10 col-md-10 col-lg-10 mTBx">                    
    <div id="group1" class="panelOrange hcH">
   </div></div>
</div>
<!-- JQ grid ends-->
</div>
<div class="clearfix"></div>   
<div id="saveGrp" style='display:block' class="mTBx">
<span>
<button type="button" class="btn btn-primary mRhAj" onclick='onSaveClicked("1")'>Generate Master</button>
<button type="button" class="btn btn-default" onclick='onSaveClicked("2")'>Generate Voucher</button>
</span>
</div>

<script>
  	var l=new FlexUI.Ajax();
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",pcolumns:1,title:"Export Details",height:40,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{colno:0,name:"type",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"fromdate"},
  	{colno:0,name:"guid",inputType:0,type:"TEXT",caption:"Guid",mandatory:true,defaultValue:"0","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"fromdate"},
  	{colno:0,name:"fromdate",inputType:0,type:"DATE",caption:"From Date",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"todate"},
  	{colno:0,name:"todate",inputType:0,type:"DATE",caption:"To Date",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""}
  	]
  	}]};
  var categorym=new FlexUI.Screen("custtype",sProps);

  
  function onSaveClicked(id){
    screenObjects.getScreenObject("type").setValue(id);
    
	var d=categorym.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/waggle/service/tallyexport",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			categorym.clearScreen();
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  var s=new FlexUI.Ajax();
  var v=s.callAjax("GET","/waggle/service/tallyexport/getguid","1");
  categorym.loadData(v);
  
</script> 
</body>
</html>