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


<div class="card border-0 shadow">
  <div class="card-body">
    <!--Header-->
    <div class="row w-100">
      <div class="col-md-6 d-flex align-items-center">
        <h4 class="header-title">Vouchers</h4>
      </div>
      <div  class="col-md-6 text-right" ></div>
     
    </div>
    <!--Header End-->
    <!--Listing -->
    <div id="branch" class="brTp" style="display:block">
    </div>

      <div class="row" id="jqcontainer" style="display:none;">
        <div class="table-container">
          <div id="xyz" class="w-100">
          </div>
        </div>
      </div>	
			<!--Listing End-->
	  	<!--Content Start-->
      <div id="callback">
        <div id="divHide">
          <div  id="divFirst">
            <div class="row w-100">
                <div class="col-sm-4 col-md-4 col-lg-4">                    
                    <div id="group1" class="cBor"></div>
                </div>
               
                <div id="chequedetails" class="col-sm-8 col-md-8 col-lg-8 cBor"  style="display:none">                   

                </div>
                <div id="carddetails" class="col-sm-4 col-md-4 col-lg-4 cBor" class="" style="display:none">
                </div>
                
                <div class="col-sm-2 col-md-2 col-lg-2" style="display: none;">             
                  <div id="dummyDiv" class="">
                  </div>
                </div>
                <div class="col-sm-3 col-md-3 col-lg-3" style="display: none;">                   
                  <div id="trandetail" class="" >
                  </div>
                </div>
           </div>
          </div>
        </div>

        <div class="row">
            <div class="table-container">
                <div class="col-md-12 col-sm-12 garea" id="ledgers"></div>
            </div>
         </div>


        <div class="row w-100 mt-3">
          <div class="col-md-12">
            <div class="hstack justify-content-start">

            </div>
          </div>
        </div>
        <div class="row w-100 mt-3">
        <div class="col-md-4">
          <div class="hstack justify-content-start">
            <div id="saveGrp">
              <button type="button" class="btn btn-clear" onclick='add()'><span class="mdi mdi-refresh me-2"></span>Clear</button>
              <button type="button" class="btn btn-edit" onclick='edit()'><span class="mdi mdi-pencil me-2"></span>Edit</button>
              <button type="button" class="btn btn-save" onclick='save()'><span class="mdi mdi-check-circle-outline me-2"></span>Save</button>
            </div>
          </div>
        </div>
        <div class="col-md-8">
          <div id="group2" class="" style="display:block;"></div>
        </div>  
        </div>
         <div class="row w-100 mt-3">
          <div class="col-md-3">
            <div class="hstack justify-content-start">
              <div id="saveGrp">
              </div>
            </div>
          </div>
      </div>
 <!--Content End-->                    
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

  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/journalentry.js",screen:[
  {name:"group1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {colno:0,name:"trantype",inputType:1,type:"TEXT",caption:"TranType",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"trandate",values:"2~1~3~4",keys:"Payment~Receipt~Contra~Journal"},
  {name:"trandate",inputType:0,type:"DATE",caption:"Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"mode"},
  {name:"refno",inputType:0,type:"TEXT",caption:"No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mode"},
  {name:"mode",inputType:1,type:"TEXT",caption:"Transaction Mode",keys:"None~Cash~Cheque~Credit Card",values:"NA~CA~CQ~CC",defaultValue:"NA","readOnly":false,"chkTag":false,nf:"ledgers_data",visible:true,onchange:"onModeChange"}
  ]},
  {name:"branch",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"refno",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  ]},
  {name:"trandetail",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  
  ]
  },
  {name:"chequedetails",title:"",pcolumns:2,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"chequeno",inputType:0,type:"TEXT",caption:"Cheque No",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"chequedate"},
  {colno:0,name:"chequedate",inputType:0,type:"DATE",caption:"Cheque Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"bankname"},  
  {colno:1,name:"bankname",inputType:0,type:"TEXT",caption:"Bank Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"bankbranch"},
  {colno:1,name:"bankbranch",inputType:0,type:"TEXT",caption:"Branch Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"outstanding_data"}
  ]
  },
  {name:"carddetails",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"cardbank",inputType:0,type:"TEXT",caption:"Bank Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"cardtype"},
  {name:"cardtype",inputType:0,type:"TEXT",caption:"Card Type",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"cardtranno"},
  {name:"cardtranno",inputType:0,type:"TEXT",caption:"Transaction No",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"outstanding_data"}
  ]
  },
  {name:"ledgers",title:"",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,enableAddRow:true,enableDeleteRow:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "crdr", name: "CrDr", field: "crdr",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:100,chkTag:false,onchange:"crDrChange",validation:"validateCrdr"},
    {order:"2",id: "account", name: "Account", field: "account",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,chkTag:true,lovOptions:{url:"/inventory/service/ajax",ajax:"ledgers",scrollEnabled:true,searchFromList:false,eremove:false,dsi:0,params:[],results:[{tgt:"ledgers_data",row:"cr",col:"2",tt:true,id:"1"},{tgt:"ledgers_data",row:"cr",col:"2",tt:false,id:"0"},{tgt:"ledgers_data",row:"cr",col:"5",tt:false,id:"6"},{tgt:"ledgers_data",row:"cr",col:"6",tt:false,id:"7"}]}},
    {order:"3",id: "dramount", name: "Debit", field: "dramount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,chkTag:false,onchange:"amountChange",validation:"validateCrdr"},
    {order:"4",id: "cramount", name: "Credit", field: "cramount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,chkTag:false,onchange:"amountChange",validation:"validateCrdr"},
    {order:"5",id: "billwise", name: "Billwise", field: "billwise",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"6",id: "groupcode", name: "Group", field: "groupcode",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false}
    ]}},
      {name:"group2",title:"",pcolumns:3,colcss:"col-sm-4 col-md-4 col-lg-4",height:15,width:45,minWidth:250,minHeight:50,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"remarks",inputType:0,type:"TEXTAREA",caption:"Note ",mandatory:false,defaultValue:"","maxValue":0,"textLength":500,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
  {colno:1,name:"creditamount",inputType:0,type:"DECIMAL",caption:"Dr",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false},
  {colno:2,name:"debitamount",inputType:0,type:"DECIMAL",caption:"Cr",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false}
  
  ]
  }]};  
  var voucher=new FlexUI.Screen("vouchers",sProps);
  setDefaultBranch();
 </script>
</body>
</html>
