<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Tables</title>
</head>
<body>
<div class="col-sm-10 col-md-10 col-lg-10 mpZero"><h1>Tables</h1><ol class="breadcrumb mpZero"><li><a href="#">Home</a></li><li><a>Master</a></li><li class="active breaCSel"><strong>Tables</strong></li></ol></div>
	
<!--add and search-->
<div class="col-sm-2 col-md-2 col-lg-2 mpZero marTp" id='addGrp'>
</div>
<div class="clearfix"></div>
<!-- JQ grid starts-->
<div id="xyz" style='position:relative;border:0px;display:block;' class="mTBx"></div>			    	 
<div id="callback" style="display:none" >
<div class="col-sm-12 col-md-12 col-lg-12 mpZero mTBx">   
    <div id="group1" class="panelOrange hcH">
   </div></div>
   <div class="clearfix"></div>
</div>
<!-- JQ grid ends-->
<div class="clearfix"></div>
<div id="saveGrp" style='display:none' class="mTBx">
<span>
<button type="button" class="btn btn-primary mRhAj" onclick='onSaveClicked()'>Save</button>
<button type="button" class="btn btn-default" onclick='hideMasterData()'>Cancel</button>

</span>
</div>
<script>
  	var l=new FlexUI.Ajax();
  	var rackKey="";
  	var rackKeyValue="";
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Location",pcolumns:2,height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"productname"},
  	{colno:0,name:"branch",inputType:0,type:"LOV",caption:"Branch",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
  	{colno:0,name:"location",inputType:0,type:"LOV",caption:"Location",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"tablenumber",lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}},
  	{colno:0,name:"tablenumber",inputType:0,type:"TEXT",caption:"Number",mandatory:true,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"noofpersons"},
  	{colno:0,name:"noofpersons",inputType:0,type:"INT",caption:"No. of Persons",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"status"},
  	{colno:0,name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"",keys:"Active~InActive",values:"Active~InActive"}
  	]
  	}]};
  var screenProps=changeScreenAttributes(110021,sProps);
  var locationm=new FlexUI.Screen("location",screenProps);
  jqReport(110021,"#xyz");
  function addMasterData(){ 
  	locationm.clearScreen(); 
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	screenObjects.getScreenObject("branch").focus();
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("110021");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var code=screenObjects.getScreenObject("code").getValue();
    if(code!="0" && code!=""){
    	locationm.setOperation("EDIT");
    }
	var d=locationm.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/branch/table",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			locationm.clearScreen();
			hideMasterData();
			reloadGrid("110021");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/branch/table";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
	var v=l.callAjax("GET",url,code);
	locationm.loadData(v);
	screenObjects.getScreenObject("branch").setEnabled(false);
		
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	hideLoader();
  	screenObjects.getScreenObject("tablenumber").focus();
  }
</script> 
</body>
</html>