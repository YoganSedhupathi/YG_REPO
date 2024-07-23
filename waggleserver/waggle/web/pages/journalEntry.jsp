<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Vouchers</title>
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
Vouchers
<span class="pull-right right-btn" onclick="showHideField('ledgers')"><b id="plusbutton1" class="fa fa-angle-double-up"></b></span></div>
   <div id="branch1" class="brTp" style="display:block">
   </div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpZero" id="divHide">
	<div  id="divFirst">
	
   <div class="col-sm-7 col-md-7 col-lg-7">
    <div id="group1" class="">
   </div></div>
   <div class="col-sm-4 col-md-4 col-lg-4">                    
    <div id="trandetail" class="">
   </div></div>   
   <div class="col-sm-1 col-md-1 col-lg-1">
    <div id="dummyDiv" class="">
   </div></div>
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpRes mTBx1">
    <div id="ledgers" class="panelOrange hcH" style="height:300px;">
   </div></div>   
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12" >
    <div id="chequedetails" class="" style="display:none">
   </div></div>
   <div class="col-sm-12 col-md-12 col-lg-12">
    <div id="carddetails" class="" style="display:none">
   </div></div>
   </div>
   </div>
   </div></div></div></div>
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpZero mTBx1">                    
    <div id="group2" class="panelOrange hcH">
   </div></div>
   <div class="clearfix"></div>
</div>
<!-- JQ grid ends-->
<div style="position:fixed; bottom:0; width:94.5%; background:#fff; z-index:1000;">
<div id="saveGrp" class="" >
	<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="save()">Save</button>
    <button id="btnClear" class="btn btn-default" type="button" onclick="add('')">Cancel</button>
    <button id="btnEdit" class="btn btn-primary priBut" type="button" onclick="edit('')">Edit</button>
</div>
<script>
$('.butt_sav').click(function(e){
	e.preventDefault();
});
$('.butt_can').click(function(e){
	e.preventDefault();
});			 
var l=new FlexUI.Ajax();
var v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=userdefbranch");
var defbranch=v.data;

  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/journalentry.js",screen:[
  {name:"branch1",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"refno",lovOptions:{url:"/waggle/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  ]},
  {name:"group1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {name:"trantype",inputType:1,type:"TEXT",caption:"TranType",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"trandate",values:"2~1~3~4",keys:"Payment~Receipt~Contra~Journal"}
  ]},
  {name:"trandetail",title:"",pcolumns:1,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"trandate",inputType:0,type:"DATE",caption:"Date",format:"dd/mm/yy",defaultValue:"","chkTag":false,visible:true,nf:"mode"},
  {colno:0,name:"refno",inputType:0,type:"TEXT",caption:"No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mode"},
  {colno:0,name:"mode",inputType:1,type:"TEXT",caption:"Mode",keys:"None~Cash~Cheque~Credit Card",values:"NA~CA~CQ~CC",defaultValue:"NA","readOnly":false,"chkTag":false,nf:"ledgers_data",visible:true,onchange:"onModeChange"}
  ]
  },
  {name:"chequedetails",title:"",pcolumns:2,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"chequeno",inputType:0,type:"TEXT",caption:"Cheque No",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"chequedate"},
  {colno:0,name:"chequedate",inputType:0,type:"DATE",caption:"Cheque Date",format:"dd/mm/yy",defaultValue:"","chkTag":false,visible:true,nf:"bankname"},  
  {colno:1,name:"bankname",inputType:0,type:"TEXT",caption:"Bank Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"bankbranch"},
  {colno:1,name:"bankbranch",inputType:0,type:"TEXT",caption:"Branch Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"outstanding_data"}
  ]
  },
  {name:"carddetails",title:"",pcolumns:3,colcss:"col-sm-4 col-md-4 col-lg-4",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"cardbank",inputType:0,type:"TEXT",caption:"Bank Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"cardtype"},
  {colno:1,name:"cardtype",inputType:0,type:"TEXT",caption:"Card Type",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"cardtranno"},
  {colno:2,name:"cardtranno",inputType:0,type:"TEXT",caption:"Transaction No",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"outstanding_data"}
  ]
  },
  {name:"ledgers",title:"",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:"account",serialNumberColumn:"sno",rowObject:false,enableAddRow:true,enableDeleteRow:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "crdr", name: "CrDr", field: "crdr",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:100,chkTag:false,onchange:"crDrChange",validation:"validateCrdr"},
    {order:"2",id: "account", name: "Account", field: "account",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,chkTag:true,lovOptions:{url:"/waggle/service/ajax",ajax:"ledgers",scrollEnabled:true,searchFromList:false,dsi:0,eremove:false,params:[],results:[{tgt:"ledgers_data",row:"cr",col:"account",tt:true,id:"lm_code"},{tgt:"ledgers_data",row:"cr",col:"account",tt:false,id:"lm_name"},{tgt:"ledgers_data",row:"cr",col:"billwise",tt:false,id:"lm_billwise"},{tgt:"ledgers_data",row:"cr",col:"groupcode",tt:false,id:"lm_groupcode"}]}},
    {order:"3",id: "dramount", name: "Debit", field: "dramount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,chkTag:false,onchange:"amountChange",validation:"validateCrdr"},
    {order:"4",id: "cramount", name: "Credit", field: "cramount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,chkTag:false,onchange:"amountChange",validation:"validateCrdr"},
    {order:"5",id: "billwise", name: "Billwise", field: "billwise",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"6",id: "groupcode", name: "Group", field: "groupcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false}
    ]}},
      {name:"group2",title:"",pcolumns:3,colcss:"col-sm-4 col-md-4 col-lg-4",height:15,width:45,minWidth:250,minHeight:50,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"creditamount",inputType:0,type:"DECIMAL",caption:"Total Debit",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false},
  {colno:1,name:"debitamount",inputType:0,type:"DECIMAL",caption:"Total Credit",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false},
  {colno:2,name:"remarks",inputType:0,type:"TEXTAREA",caption:"Note ",mandatory:false,defaultValue:"","maxValue":0,"textLength":500,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""}
  ]
  }]};  
  var voucher=new FlexUI.Screen("vouchers",sProps);
  setDefaultBranch();
 </script>
</body>
</html>
