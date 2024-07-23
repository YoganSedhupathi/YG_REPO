
<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Bill Receipts</title>
</head>
<body>
<%
	String code=(String)request.getParameter("code");
	String branch=(String)request.getParameter("branch");
%>
<script src="js/inputvalidation.js"></script>
<script src="js/tenderdialog.js"></script>

<div class="card border-0 shadow">
  <div class="card-body">
     <!--Header-->
     <div class="row w-100">
      <div class="col-md-6 d-flex align-items-center">
        <h4 class="header-title">Bill Receipts</h4>
      </div>
      <div  class="col-md-6 text-right" id="addGrp"></div>
    </div>
    <!--Header End-->
    <!--Content -->
    <div class="row lpage" id="jqcontainer" style="display:none;">
      <div class="table-container">
        <div id="xyz" class="w-100">

        </div>
      </div>
    </div>	

    <div id="callback">
      <div id="divHide">
        <div  id="divFirst">
            <div class="row w-100">
                <div class="col-sm-3 col-md-3 col-lg-3">                    
                  <div id="group1" class="cBor"></div>
                  <div id="dummyDiv" class=""></div>
                </div>
                <div class="col-sm-3 col-md-3 col-lg-3">                       
                  <div id="receiptdetail" class="cBor">
               </div>
             </div>
              <div class="col-sm-6 col-md-6 col-lg-6 cBor">          
                <div id="bankdetails" class=""></div>
                <div id="chequedetails" class=""></div>
                <div id="carddetails" class=""></div>
              </div>
            </div>
      </div>
    </div>
    <div class="row">
            <div class="table-container">
                <div class="col-md-12 col-sm-12 acarea" id="outstanding"></div>
            </div>
    </div>
        <div class="row w-100"  >
          <div class="col-sm-12 col-md-12 col-lg-12">                    
            <div id="group2">  </div>
          </div>
        </div>
        <div class="row w-100">
          <div class="col-sm-12 col-md-12 col-lg-12"  style="display:none">                    
            <div id="group7" >  </div>
          </div>
        </div>
        <div class="row w-100">
          <div class="col-sm-12 col-md-12 col-lg-12"  style="display:none">                    
            <div id="group3">  </div>
          </div>
        </div>


    <div class="row w-100 mt-3">
      <div class="col-md-5">
        <div class="hstack justify-content-start">
          <div id="saveGrp">
          </div>
        </div>
      </div>
      
      <div class="col-md-7">
        <div class="hstack justify-content-end">
                          <div class="gap-2 bg-white">
                              <div class="card-total px-3 rounded-3">
                                      <span class="text-dark">Net Amount:</span>
                                      <span class="net-amount" id="netAmt">0.00</span>
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
    
      var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/billreceipts.js",screen:[
      {name:"group1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
      fields:[
      {colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
      {colno:0,name:"trantype",inputType:0,type:"INT",caption:"Type",mandatory:false,defaultValue:"1","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mobile"},
      {colno:0,name:"dummy1",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:false},
      {colno:0,name:"mobile",inputType:0,type:"TEXT",caption:"Mobile",mandatory:true,defaultValue:"","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"account",validation:"fetchCustomer"},  
      {colno:0,name:"dummy2",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:false},
      {colno:0,name:"account",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"address1",lovOptions:{url:"/inventory/service/ajax",ajax:"receiptcustomer",scrollEnabled:true,searchFromList:false,dsi:1,params:[],results:[{tgt:"account",tt:true,id:"0"},{tgt:"account",tt:false,id:"1"},{tgt:"mobile",tt:false,id:"2"},{tgt:"address",tt:false,id:"3,4,5,6",m:true},{tgt:"address1",tt:false,id:"3"},{tgt:"address2",tt:false,id:"4"},{tgt:"city",tt:false,id:"5"},{tgt:"pincode",tt:false,id:"6"},{tgt:"creditdays",tt:false,id:"7"},{tgt:"showcreditdays",tt:false,id:"7"}]}},
      {colno:0,name:"address",inputType:4,type:"SPAN",caption:"Address",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address2"},  
      {colno:1,name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address2"},
      {colno:0,name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"city"},
      {colno:1,name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"pincode"},
      {colno:0,name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"creditdays"},
      {colno:1,name:"creditdays",inputType:0,type:"INT",caption:"Credit Days",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"go"},
      {colno:1,name:"showcreditdays",inputType:4,type:"INT",caption:"Credit Days",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"go"},
      {colno:1,name:"go",inputType:3,caption:"Go",onclick:"loadCustomerOutstanding",visible:true}
      ]},
      
      {name:"branch",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
      fields:[{colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"refno",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
      ]},
      {name:"receiptdetail",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
      fields:[
      {name:"trandate",inputType:0,type:"DATE",caption:"Receipt Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"refno"},
      {name:"refno",inputType:0,type:"TEXT",caption:"Reference No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"mode"},
      {name:"acrefno",inputType:0,type:"INT",caption:"VNo",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mode"},
      {name:"acno",inputType:0,type:"INT",caption:"VNo",mandatory:false,defaultValue:"0","maxValue":0,"textLength":20,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"mode"},  
      {name:"duebills",inputType:1,type:"TEXT",caption:"Filter ",keys:"Due Bills~All Bills",values:"D~A",defaultValue:"D","readOnly":false,"chkTag":false,nf:"account",visible:false},
      {name:"mode",inputType:1,type:"TEXT",caption:"Receipt Mode",keys:"Cash~Cheque~Credit Card",values:"CA~CQ~CC",defaultValue:"CA","readOnly":false,"chkTag":false,nf:"account",visible:true,onchange:"onModeChange"}
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
      {colno:0,name:"cardbank",inputType:0,type:"TEXT",caption:"Bank Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"cardtype"},
      {colno:0,name:"cardtype",inputType:0,type:"TEXT",caption:"Card Type",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"cardtranno"},
      {colno:1,name:"cardtranno",inputType:0,type:"TEXT",caption:"Transaction No",mandatory:false,defaultValue:"","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"outstanding_data"}
      ]
      },
      {name:"bankdetails",title:"",height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
      fields:[
      {colno:0,name:"bankledger",inputType:0,type:"LOV",caption:"Bank Ledger",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"remarks",lovOptions:{url:"/inventory/service/ajax",ajax:"banks",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"bankledger",tt:true,id:"1"},{tgt:"bankledger",tt:false,id:"0"}]}},
      ]
      },
      {name:"outstanding",title:"",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,enableAddRow:false,enableDeleteRow:false,columns:[
        {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
        {order:"1",id: "billno", name: "BillNo", field: "billno",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:100,chkTag:false},
        {order:"2",id: "billdate", name: "BillDate", field: "billdate",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:50,chkTag:false},
        {order:"3",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL",align:"right","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,chkTag:false},
        {order:"4",id: "recd", name: "Adjusted", field: "recd",defaultValue:"0","inputType":0,"type":"TEXT",align:"right","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:100,chkTag:false},
        {order:"5",id: "balance", name: "Balance", field: "balance",defaultValue:"0","inputType":0,"type":"TEXT",align:"right","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:100,chkTag:false},
        {order:"6",id: "sbalance", name: "sbalance", field: "sbalance",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
        {order:"7",id: "selected", name: "Rec", field: "selected",defaultValue:"0","inputType":2,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:20,chkTag:false,validation:"validateSelected"},    
        {order:"8",id: "received", name: "Received", field: "received",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":9999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,chkTag:false,onchange:"onReceivedChange"},
        {order:"9",id: "osdno", name: "osdno", field: "osdno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,chkTag:false},
        {order:"10",id: "osdtype", name: "osdtype", field: "osdtype",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":true,width:0,chkTag:false}
        ]}},
          {name:"group2",title:"",pcolumns:3,colcss:"col-sm-4 col-md-4 col-lg-4",height:15,width:45,minWidth:250,minHeight:50,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
      fields:[
      {colno:0,name:"discount",inputType:0,type:"DECIMAL",caption:"Discount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"charges",colspan:2,onchange:"onReceivedChange"},
      {colno:1,name:"charges",inputType:0,type:"NEGDEC",caption:"Charges",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"remarks",colspan:2,onchange:"onReceivedChange"},
      {colno:2,name:"remarks",inputType:0,type:"TEXTAREA",caption:"Note ",mandatory:false,defaultValue:"","maxValue":0,"textLength":500,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:""},
      {colno:0,name:"dummy1",inputType:4,type:"INT",caption:"",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:""}
      ]
      },
      {name:"group3",title:"",height:20,width:45,minWidth:250,minHeight:50,colWidth:98,float:"right",backColor:"biege",contentType:"Fields",
      fields:[  
      {name:"total",inputType:0,type:"DECIMAL",caption:"Total:",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"totalamt"},    
      {name:"totalamt",inputType:0,type:"DECIMAL",caption:"Net Amount",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false}
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
      var screenProps=changeScreenAttributes(610001,sProps);
      var cust=new FlexUI.Screen("xyz",screenProps);
      setDefaultBranch();
      function loadCustomerOutstanding(rcode,rbranch){
        var code=rcode;
        var branch=rbranch;
        if(code=="go"){
          code=screenObjects.getScreenObject("account").getTag();
          branch=screenObjects.getScreenObject("branch").getTag();
        }
        if(code!='0' && code!="" && cust.getOperation()!="EDIT"){
          showLoader();
          var	url="/inventory/service/customer/outstanding";
          var	data="code="+code+"&branch="+branch;
        var v=l.callAjax("GET",url,data);
        cust.loadData(v);
        hideLoader();
       }
       return true;
      }
      function goBack(){
        $("#bodyContainer").html("");
        $("#bodyContainer").load("/inventory/customerOutstanding.do",onSuccess);
        $("#currentMenuId").val(610003);
      }
      <%if(code!=null){%>
        loadCustomerOutstanding('<%=code%>','<%=branch%>');
      <%}%>
     </script>
    </body>
    </html>
    