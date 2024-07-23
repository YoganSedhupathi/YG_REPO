<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Category</title>
</head>
<body>

<div class="col-sm-10 col-md-10 col-lg-10 mpZero"><h1>Category</h1><ol class="breadcrumb mpZero"><li><a href="#">Home</a></li><li><a>Master</a></li><li class="active breaCSel"><strong>Category</strong></li></ol></div>
	
<!--add and search-->
<div class="col-sm-2 col-md-2 col-lg-2 mpZero marTp" id='addGrp'>
</div>

<div class="clearfix"></div>                    
<!-- JQ grid starts-->
<div style="width:100%;float:left">
<div id="xyz" style='position:relative;border:0px;display:block;' class="mTBx"></div>			    	 
<div id="callback" style="display:none" >
<div class="col-sm-6 col-md-6 col-lg-6 mTBx">                    
    <div id="group1" class="panelOrange hcH">
   </div></div>
</div>
<!-- JQ grid ends-->
</div>
<div class="clearfix"></div>   
<div id="saveGrp" style='display:none' class="mTBx">
<span>
<button type="button" class="btn btn-primary mRhAj" onclick='onSaveClicked()'>Save</button>
<button type="button" class="btn btn-default" onclick='hideMasterData()'>Cancel</button>
</span>
</div>

<script>
  	var l=new FlexUI.Ajax();
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Category Details",height:40,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"manufacturername"},
  	{name:"categoryname",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"parentcategory"},
  	{name:"parentcategory",inputType:0,type:"LOV",caption:"Group",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"status",lovOptions:{url:"/inventory/service/ajax",ajax:"category",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"parentcategory",tt:true,id:"1"},{tgt:"parentcategory",tt:false,id:"0"}]}},
  	{name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"",keys:"Active~InActive",values:"Active~InActive"}
  	]
  	}]};
  var screenProps=changeScreenAttributes(110016,sProps);
  var categorym=new FlexUI.Screen("category",screenProps);
  jqReport(110016,"#xyz");
  function addMasterData(){ 
  	categorym.clearScreen(); 
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	screenObjects.getScreenObject("categoryname").focus();
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#history').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("110016");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var code=screenObjects.getScreenObject("code").getValue();
    if(code!="0" && code!=""){
    	categorym.setOperation("EDIT");
    }
	var d=categorym.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/category",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			categorym.clearScreen();
			hideMasterData();
			reloadGrid("110016");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/category";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
	var v=l.callAjax("GET",url,code);
	categorym.loadData(v);
	screenObjects.getScreenObject('parentcategory').setEnabled(false);
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
  	hideLoader();
  	screenObjects.getScreenObject("categoryname").focus();
  }
</script> 
</body>
</html>