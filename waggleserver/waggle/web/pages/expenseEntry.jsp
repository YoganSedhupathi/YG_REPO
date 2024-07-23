<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Receipts/Payments</title>
</head>
<body>
<%
	String code=(String)request.getParameter("code");
	String branch=(String)request.getParameter("branch");
%>
<!-- JQ grid starts-->
<div id="xyz" style='position:relative;border:0px;display:none;'></div>			    	 
<div id="callback">
<div class="col-sm-12 col-md-12 col-lg-12 mpZero  mTBx1" >
<div  class="panelOrange hcH">
<div  class="subHe1">
	Account Entry
   <div id="branch1" class="brTp" style="display:block">
   </div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpZero mTBx1" id="divHide">
	<div  id="divFirst" class="mTBx1">

   <div class="col-sm-6 col-md-6 col-lg-6">
    <div id="group1" class="">
   </div></div>
   <div class="col-sm-6 col-md-6 col-lg-6">                    
    <div id="trandetail" class="">
   </div></div>
   <div class="clearfix"></div>
	<div class="col-sm-6 col-md-6 col-lg-6">                    
    <div id="paymentdetail" class="">
   </div></div>
   <div class="col-sm-6 col-md-6 col-lg-6">                    
    <div id="amountdetail" class="">
   </div></div>   
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12">
    <div id="chequedetails" class="">
   </div></div>
   <div class="col-sm-12 col-md-12 col-lg-12">
    <div id="carddetails" class="">
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
<div style="position:fixed; bottom:0; width:94.5%; background:#fff; z-index:1000;">
<div id="saveGrp" class="" >
	<button id="btnSave" class="btn btn-primary priBut" type="button" onclick="save()">Save</button>
    <button id="btnClear" class="btn btn-default" type="button" onclick="add('')">Cancel</button>
    <button id="btnEdit" class="btn btn-default" type="button" onclick="edit('')">Edit</button>	
</div>

<script>
var l=new FlexUI.Ajax();
var v=l.callAjax("GET","/waggle/service/ajax","ic=0&id=userdefbranch");
var defbranch=v.data;

  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/expenseentry.js",screen:[
  {name:"branch1",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"refno",lovOptions:{url:"/waggle/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  ]},
  {name:"group1",title:"",pcolumns:1,colcss:"col-sm-12 col-md-12 col-lg-12",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {colno:0,name:"trantype",inputType:1,type:"TEXT",caption:"TranType",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"account",values:"1~2~3",keys:"Receipt~Payment~Contra",onchange:"onVoucherTypeChange"},
  {colno:0,name:"account",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"trandate",lovOptions:{url:"/waggle/service/ajax",ajax:"ledgers",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"account",tt:true,id:"lm_code"},{tgt:"account",tt:false,id:"lm_name"},{tgt:"address",tt:false,id:"lm_address1,lm_address2,lm_city,lm_pincode",m:true},{tgt:"address1",tt:false,id:"lm_address1"},{tgt:"address2",tt:false,id:"lm_address2"},{tgt:"city",tt:false,id:"lm_city"},{tgt:"pincode",tt:false,id:"lm_pincode"}]}},
  {colno:0,name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address3"},
  {colno:0,name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"city"},
  {colno:0,name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"pincode"},
  {colno:0,name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"trandate"},
  {colno:0,name:"address",inputType:4,type:"SPAN",caption:"Address",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address2"}    
  ]},  
  {name:"trandetail",title:"",pcolumns:1,colcss:"col-sm-12 col-md-12 col-lg-12",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"trandate",inputType:0,type:"DATE",caption:"Payment Date",format:"dd/mm/yy",defaultValue:"","chkTag":false,visible:true,readOnly:false,nf:"refno"},
  {colno:0,name:"refno",inputType:0,type:"TEXT",caption:"Reference No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"total"},
  {colno:0,name:"acrefno",inputType:0,type:"INT",caption:"VNo",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mode"},
  {colno:0,name:"acno",inputType:0,type:"INT",caption:"VNo",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mode"}  
  ]
  },
  {name:"paymentdetail",title:"",pcolumns:1,pcolumns:1,colcss:"col-sm-12 col-md-12 col-lg-12",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"total",inputType:0,type:"DECIMAL",caption:"Amount:",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"discount",onchange:"onPaidChange"},
  {colno:0,name:"discount",inputType:0,type:"DECIMAL",caption:"Discount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"charges",onchange:"onPaidChange"},
  {colno:0,name:"charges",inputType:0,type:"NEGDEC",caption:"Charges",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"totalamt",onchange:"onPaidChange"}
  ]
  },
  {name:"amountdetail",title:"",pcolumns:1,colcss:"col-sm-12 col-md-12 col-lg-12",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"totalamt",inputType:0,type:"DECIMAL",caption:"Net Amount",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"mode"},
  {colno:0,name:"mode",inputType:1,type:"TEXT",caption:"Payment Mode",keys:"Cash~Cheque~Credit Card",values:"CA~CQ~CC",defaultValue:"CA","readOnly":false,"chkTag":false,nf:"remarks",visible:true,onchange:"onModeChange"}
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
  {name:"bankdetails",title:"",pcolumns:2,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"bankledger",inputType:0,type:"LOV",caption:"Bank Ledger",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"remarks",lovOptions:{url:"/Fruits/service/ajax",ajax:"banks",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"bankledger",tt:true,id:"lm_code"},{tgt:"bankledger",tt:false,id:"lm_name"}]}},
  ]
  },
  {name:"group2",title:"",height:15,width:45,minWidth:250,minHeight:50,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"remarks",inputType:0,type:"TEXTAREA",caption:"Note ",mandatory:false,defaultValue:"","maxValue":0,"textLength":500,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""}
  ]
  }]};
  /*
  
  ,
    {name:"group4",height:15,width:80,minWidth:500,minHeight:50,colWidth:15,float:"left",backColor:"beige",contentType:"Fields",fields:[
    {name:"add",inputType:3,caption:"Add",onclick:"add",visible:true},
    {name:"save",inputType:3,caption:"Save",onclick:"save",visible:true},
    {name:"edit",inputType:3,caption:"Edit",onclick:"edit",visible:true},
    {name:"Delete",inputType:3,caption:"Delete",onclick:"delete1",visible:true}
    ]}
    */
  var payments=new FlexUI.Screen("payments",sProps);
  setDefaultBranch();
 </script>
</body>
</html>
