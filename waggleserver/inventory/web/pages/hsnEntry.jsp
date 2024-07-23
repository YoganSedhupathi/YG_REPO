<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>HSN Update</title>
</head>
<body>
<%
	String code=(String)request.getParameter("code");
	String branch=(String)request.getParameter("branch");
%>
<!-- JQ grid starts-->
<div id="xyz" style='position:relative;border:0px;display:none;'></div>			    	 
<div id="callback"  >
<div class="col-sm-12 col-md-12 col-lg-12 mpZero  mTBx1" >
<div  class="panelOrange hcH">
<div  class="subHe1">
HSN Update
<div id="branch" class="brTp" style="display:block">
   </div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpZero" id="divHide">
	<div  id="divFirst">

   <div class="col-sm-6 col-md-6 col-lg-6">
    <div id="group1" class="">
   </div></div>
   </div>
   </div>
   </div></div></div></div>
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpZero">                    
    <div id="group2" class="panelOrange hcH">
   </div></div>
</div>
<!-- JQ grid ends-->
<div id="saveGrp" class="" >
	<button id="btnGenerate" class="btn btn-primary priBut" type="button" onclick="saveHSNCode()">Save</button>
</div>

<script>
$('.butt_sav').click(function(e){
	e.preventDefault();
});
$('.butt_can').click(function(e){
	e.preventDefault();
});			 
var l=new FlexUI.Ajax();
var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=userdefbranch");
var defbranch=v.data;

  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"",screen:[
  {name:"group1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"product",inputType:0,type:"LOV",caption:"TMC Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"hsnproduct",lovOptions:{url:"/inventory/service/ajax",ajax:"product",scrollEnabled:true,searchFromList:false,dsi:0,params:[{src:"branch",tt:false,n:"branch"}],results:[{tgt:"product",tt:true,id:"1"},{tgt:"product",tt:false,id:"0"}]}},
  {colno:1,name:"hsnproduct",inputType:0,type:"LOV",caption:"Source Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"hsnproduct",lovOptions:{url:"/inventory/service/ajax",ajax:"hsnproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"hsnproduct",tt:true,id:"0"},{tgt:"hsnproduct",tt:false,id:"0"},{tgt:"hsncode",tt:false,id:"1"},{tgt:"tax",tt:false,id:"2"}]}},  
  {colno:1,name:"hsncode",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:""},
  {colno:0,name:"tax",inputType:0,type:"DECIMAL",caption:"Tax",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:""},
  {colno:0,name:"branch",inputType:0,type:"INT",caption:"Branch",mandatory:false,defaultValue:"1","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:""}
  ]}]};
  var payments=new FlexUI.Screen("xyz",sProps);
  screenObjects.getScreenObject("branch").setValue("1");
  function saveHSNCode(){
  		var data;
	    var pcode=screenObjects.getScreenObject("product").getTag();
	    var hsncode=screenObjects.getScreenObject("hsncode").getValue();
	    var tax=screenObjects.getScreenObject("tax").getValue();
		$.ajax({
            url: "/inventory/service/config/hsn",
            type: "POST",
            async: false,
            contentType:"application/x-www-form-urlencoded",
            data: "&productcode="+pcode+"&hsn="+hsncode+"&tax="+tax,
            success: function (r) {
				data=r;		
            }
        });			
		if(data.result=="Success"){
		    screenObjects.getScreenObject("product").setValue("");
		    screenObjects.getScreenObject("product").setTag("");
		    screenObjects.getScreenObject("hsnproduct").setValue("");
		    screenObjects.getScreenObject("hsnproduct").setTag("");		   
		    screenObjects.getScreenObject("hsncode").setValue("");
		    screenObjects.getScreenObject("tax").setValue("");		
			alert(data.message);
	    }else{
	    	alert(data.message);
	    }						
  	
  
  } 
 </script>
</body>
</html>
