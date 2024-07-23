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




<div class="card border-0 shadow">
  <div class="card-body lpage">
    <!--Header-->
    <div class="row w-100">
      <div class="col-md-6 d-flex align-items-center">
        <h4 class="header-title">Account Entry</h4>
      </div>
    </div>
     <!--Header End-->
    <!--Listing -->
    <div class="row lpage" id="jqcontainer" style="display:none;">
       <div class="table-container"  >
         <div id="xyz" class="w-100">
       </div>
      </div>
    </div>	
    <!--Listing End-->
		<!--Content Start--> 
    <div id="callback"   class="mt-3">
      <div class="table-container">
        <div class="row w-100 ">                    
                  <div class="col-sm-4 col-md-4 col-lg-4">                       
                      <div id="group1" class="">
                      </div>
                  </div>
                  <div class="col-sm-4 col-md-4 col-lg-4">                       
                    <div id="trandetail" class="">
                    </div>
                  </div>
                  <div class="col-sm-3 col-md-3 col-lg-3">                       
                    <div id="paymentdetail" class="">
                    </div>
                </div>
        </div>
     
        <div class="row w-100 "> 
          <div class="col-sm-4 col-md-4 col-lg-4"> 
                  <div id="bankdetails"class="">
                  </div>                      
                  <div id="chequedetails" class="">
                  </div>
                  <div id="carddetails" class="">
                  </div>
          </div>
        </div>    
        <div class="row w-100">                    
          <div id="group2" class="col-sm-4 col-md-4 col-lg-4"></div>
          <div class="col-sm-3 col-md-3 col-lg-3">                       
            <div  class="">
            </div>
        </div>
        </div>
        
      </div>

      <div class="row w-100 mt-3">
        <div class="col-md-6">
          <div class="hstack justify-content-start">
            <div id="saveGrp">
                 
            </div>
          </div>
        </div>
      </div>


    </div>
  </div>
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

  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/expenseentry.js",screen:[
  {name:"group1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {colno:0,name:"trantype",inputType:1,type:"TEXT",caption:"TranType",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"account",values:"1~2~3",keys:"Receipt~Payment~Contra",onchange:"onVoucherTypeChange"},
  {colno:0,name:"account",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"trandate",lovOptions:{url:"/inventory/service/ajax",ajax:"ledgers",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"account",tt:true,id:"1"},{tgt:"account",tt:false,id:"0"},{tgt:"address",tt:false,id:"2,3,4,5",m:true},{tgt:"address1",tt:false,id:"2"},{tgt:"address2",tt:false,id:"3"},{tgt:"city",tt:false,id:"4"},{tgt:"pincode",tt:false,id:"5"}]}},
  {colno:0,name:"address",inputType:4,type:"SPAN",caption:"Address",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address2"},  
  {colno:1,name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address2"},
  {colno:0,name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"city"},
  {colno:1,name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"pincode"},
  {colno:0,name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"trandate"}
  ]},
  {name:"branch",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"refno",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  ]},
  {name:"trandetail",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
    {name:"trandate",inputType:0,type:"TDATE",caption:"Payment Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,readOnly:true,nf:"total"},
    {name:"refno",inputType:0,type:"TEXT",caption:"Reference No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"total"},
    {name:"acrefno",inputType:0,type:"INT",caption:"VNo",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mode"},
    {name:"acno",inputType:0,type:"INT",caption:"VNo",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mode"} ,
    
    {name:"mode",inputType:1,type:"TEXT",caption:"Payment Mode",keys:"Cash~Cheque~Credit Card",values:"CA~CQ~CC",defaultValue:"CA","readOnly":false,"chkTag":false,nf:"remarks",visible:true,onchange:"onModeChange"}
  ]
  },
  {name:"paymentdetail",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"total",inputType:0,type:"DECIMAL",caption:"Amount:",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"discount",onchange:"onPaidChange"},
  {name:"discount",inputType:0,type:"DECIMAL",caption:"Discount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"charges",onchange:"onPaidChange"},
  {name:"charges",inputType:0,type:"NEGDEC",caption:"Charges",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"totalamt",onchange:"onPaidChange"},
  {name:"totalamt",inputType:0,type:"DECIMAL",caption:"Net Amount",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"mode"},
  
    ]
  },
  {name:"bankdetails",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
    {colno:0,name:"bankledger",inputType:0,type:"LOV",caption:"Bank Ledger",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"remarks",lovOptions:{url:"/inventory/service/ajax",ajax:"banks",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"bankledger",tt:true,id:"1"},{tgt:"bankledger",tt:false,id:"0"}]}},
    ]
  },
  {name:"chequedetails",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"chequeno",inputType:0,type:"TEXT",caption:"Cheque No",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"chequedate"},
  {name:"chequedate",inputType:0,type:"DATE",caption:"Cheque Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"bankname"},  
  {name:"bankname",inputType:0,type:"TEXT",caption:"Bank Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"bankbranch"},
  {name:"bankbranch",inputType:0,type:"TEXT",caption:"Branch Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"outstanding_data"}
  ]
  },
  {name:"carddetails",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"cardbank",inputType:0,type:"TEXT",caption:"Bank Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"cardtype"},
  {name:"cardtype",inputType:0,type:"TEXT",caption:"Card Type",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"cardtranno"},
  {name:"cardtranno",inputType:0,type:"TEXT",caption:"Transaction No",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"outstanding_data"}
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
  //var screenProps=changeScreenAttributes(610002,sProps);
  var payments=new FlexUI.Screen("xyz",sProps);
  setDefaultBranch();
 </script>
</body>
</html>
