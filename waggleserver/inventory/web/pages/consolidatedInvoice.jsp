<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Invoice</title>
</head>
<body>
<script src="js/inputvalidation.js"></script>
<script src="js/attributedialog.js"></script>
<script src="js/serialentrydialog.js"></script>
<script src="js/tenderdialog.js"></script>
<script>
<%String mode=request.getParameter("mode");
String code=request.getParameter("code");
String userId=(String)session.getAttribute("LOGIN_ID");
%>
var userName='<%=userId%>';
</script>
<!--add and search-->
<!-- JQ grid starts-->
	<div id="filter" style="display:block" class="col-sm-15 col-md-15 col-lg-15 mpRhZ mTBx">
			
				<div class="panelOrange hcH">
  					<div id="divFirstFilter" style="display:block">
	  					<div class="col-sm-3 col-md-3 col-lg-3 mpZero">
	  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">From Date</label><div class="col-sm-7 mpRes"><input id="fromDate" name="fromDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control"/></div></div>
							<div class="clearfix"></div>
	  					</div>
		    			<div class="col-sm-3 col-md-3 col-lg-3">
		  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">To Date</label><div class="col-sm-7 mpRes"><input id="toDate" name="toDate" inputType="date"  type="text" maxlength="50" mandatory="1" readonly class="form-control"/></div></div>
		  						<div class="clearfix"></div>
		  				</div>
		  				<div class="col-sm-3 col-md-3 col-lg-3" id="mfrfilter" style="display:none">
		  						<div class="form-group extrBT"><label class="col-sm-5 control-label mpRes" for="inputEmail3">MFR</label><div class="col-sm-7 mpRes"><input type="text" id="mfrname"  mandatory="1"  class="form-control"/><input type="hidden" id="mfrid"  mandatory="1"  class="form-control"/></div></div>
		  						<div class="clearfix"></div>
		  				</div>
		  				<div class="col-sm-3 col-md-3 col-lg-3 mpZero">
		  					<div class="form-group extrBT"><button type="button" class="btn btn-primary mRhAj btn-sm" onclick="reportGo('310004')">Go</button>	
							</div>
					    </div>
					    <div id="addGrp" class="btn-group pull-right">
						<div id="actionicons">
							<button onclick="toggleHeaderRow()" class="btn btn-sm seaColB"><i class="fa fa-search"></i></button>
						</div>
						</div>
					</div>
  				</div>
      		</div>			
      				    
					    <script>
					    $('#fromDate').datepicker({format:'dd/mm/yyyy'});			
							if($('#fromDate').val()==""){
								var cd=new Date();
								$('#fromDate').datepicker("setDate",cd);
							}
							$('#toDate').datepicker({format:'dd/mm/yyyy'});			
							if($('#toDate').val()==""){
								var cd=new Date();
								$('#toDate').datepicker("setDate",cd);
							}
					    </script>
<div id="xyz" style='position:relative;border:0px;display:block;' class="mTBx"></div>			    	 
<div id="callback" >
<input type="hidden" id="appid"/>
<div class="col-sm-12 col-md-12 col-lg-12 mpZero  mTBx1" >
<div  class="panelOrange hcH">
<div  class="subHe1">
Sales Invoice
<span id ="spnSetting" style="display:none" class="pull-right right-btn" onclick="showSubMenu()"><b id="settingsBtn" class="fa fa-cog"></b>
<div id="subMenus" class="col-lg-4" >
			<ul class="dropdown open" >
			<ul id="submenu" class="dropdown-menu" style="display:none">
			
			</ul>
			</ul>
	</div>
</span>
<span class="pull-right right-btn" onclick="showHideField('invoice')"><b id="plusbutton1" class="fa fa-angle-double-up"></b></span>
<span class="pull-right right-btn" onclick="showPrescription()"><b class="fa fa-list"></b></span>
<div id="branch" class="brTp" style="display:block">
   </div>
   <div id="subMenus" class="pull-right right-btn" style="display:none">
   <ul id="submenu">
     </ul>
   </div>
<div class="col-sm-12 col-md-12 col-lg-12 mpZero" id="divHide">
<div  id="divFirst">
	<div id="one" class="col-sm-5 col-md-5 col-lg-5">                    
    <div id="group1" class="">
   </div></div>
   <div id="two" class="col-sm-3 col-md-3 col-lg-3">                    
    <div id="group2" class="">
   </div></div>
   <div id="three" class="col-sm-3 col-md-3 col-lg-3"  >                    
    <div id="billdetail" class="">
   </div></div>
   <div id="four" class="col-sm-1 col-md-1 col-lg-1"  >                    
    <div id="dummyDiv" class="">
   </div></div>
   </div>
   <div  id="divTransport" style="display:none">
		<div class="col-sm-6 col-md-6 col-lg-6">                    
	    <div id="transport" class="">
	   </div></div>
	   <div class="col-sm-4 col-md-4 col-lg-4">                    
	    <div id="lrdet" class="">
	   </div></div>
	   <div class="col-sm-2 col-md-2 col-lg-2">                    
	    <div id="dummyDiv1" class="">
	   </div></div>
	</div>  
	
   <span id="showMoreButton" class="pull-right right-btn mrB" onclick="showHideTransport()"><b id="transbutton" class="labelText">More...</b></span>
   </div>
   </div></div>
   <div class="clearfix"></div>
   <div class="col-sm-12 col-md-12 col-lg-12 mpRes mTBx1">
    <div id="invoice" class="panelOrange hcH" style="min-height:385px;">
   </div></div>
   <div class="clearfix"></div>
   
   <div class="col-sm-7 col-md-7 col-lg-7 mTBx1" style="display:none;">                    
    <div id="group3" class="panelOrange hcH">
   </div></div>
</div>
<!-- JQ grid ends-->
<div class="clearfix"></div>
<div style="position:fixed; bottom:0; width:94.5%; background:#fff; z-index:1000;">
<div id="saveGrp" class="" >
</div>
<div class="col-sm-4 col-md-4 col-lg-4">
    <div style="background:#fedc34; display:inline-block; width:100%; padding:5px 10px" >
    <div class="netAm" id="netAmt">Net Amount 0.00</div>
    <div class="col-md-4 colBg2 mpZero"><div class="col-md-6">Disc</div><div class="col-md-6" id="disc">0.00</div></div>
    <div class="col-md-4 colBg2 mpZero"><div class="col-md-6">VAT</div><div class="col-md-6" id="vat">0.00</div></div>
    <div class="col-md-4 colBg2 mpZero"><div class="col-md-6">Total</div><div class="col-md-6" id="totamt">0.00</div></div>
    </div>
    </div>
    </div>
<div id='attrdlg'>
<div id='productprops' class="pop_lov_box" style="height:250px;display:none"/></div>
<div id='serialdlg'>
<div id='productserial' class="pop_lov_box" style="height:250px;display:none"/></div>
<div id='ttender' style="display:none">
<div id='tenderdlg' class='pop_lov_box'/>
</div>

<div id='showprescription' style="display:none">
<div id='prescriptiondlg' class='pop_lov_box'>
<div id='prestitle' class='pop_lov_hed_box'>
<div class='pop_lov_clos'><a href='#'><span class='fa fa-times-circle'></span></a></div><div class='pop_lov_hed_txt'>Prescription</div>
</div>
<div id='prescription' class='pop_lov_inp_box'>
<table class="table" cellspacing=0 cellpadding=0 border=0 style="min-height:400px">
	<thead>
	<tr>
		<th>S.No</th>
		<th>Name</th>
		<th>Generic</th>
		<th>Morning</th>
		<th>Afternoon</th>
		<th>Evening</th>
		<th>Night</th>
		<th>After/Before Meal</th>
		<th>Days</th>
		<th>Notes</th>
	</tr>
	</thead>	
	<tbody id="presitems">
	</tbody>
</table>
<div id='presbutton' style='float:right'><button type='button' class='btn btn-primary mRhAj' onclick="printPrescription()">Print</button><button type='button' class='btn btn-default' onclick="prescrCancel()">Cancel</button></div>
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
var v=l.callAjax("GET","/Fruits/service/ajax","ic=0&id=userdefbranch,config,custtype&configname=showmore");
var v1=l.callAjax("GET","/Fruits/service/ajax","ic=0&id=config&configname=calculate_roundoff");
var calculateRoundOff=v1.data[0][0]==1?true:false;
var defbranch=v.data.userdefbranch;
var showMore=v.data.config[0][0]==1?true:false;
var showExpiry=false;
var ew=0;
if(showExpiry){
	ew=100;
}
var cKeys="All";
var cValues="0";
var tilled="~";
if(!showMore){
	$('#showMoreButton').css('display','none');
	$('#one').removeClass('col-sm-5 col-md-5 col-lg-5');
	$('#one').css('margin-top','20px');
	$('#one').addClass('col-sm-8 col-md-8 col-lg-8');
	$('#three').css('display','none');
	$('#four').css('display','none');
	cKeys="";
	cValues="";
	tilled="";
}
if(v.data.custtype.length>0){
	for(var m=0;m<v.data.custtype.length;m++){
		cKeys=cKeys+tilled+v.data.custtype[m][0];
		cValues=cValues+tilled+v.data.custtype[m][1];
		tilled="~";
	}	
}

  var sProps={title:{height:25,width:100,name:"Invoice"},container:{id:"callback",isdialog:false},js:"js/validations/consolidatedInvoice.js",screen:[
  {name:"group1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[{colno:0,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {colno:0,name:"name",inputType:0,type:"TEXT",caption:"Name",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch"},
  {colno:0,name:"mobile",inputType:0,type:"TEXT",caption:"Mobile",mandatory:true,defaultValue:"","maxValue":0,"textLength":30,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"billdate",validation:"fetchCustomer"},  
  {colno:0,name:"custtype",inputType:1,type:"TEXT",caption:"Type",mandatory:true,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"custname",keys:cKeys,values:cValues,onchange:"validateCustType",validation:"validateCustType"},
  {colno:0,name:"custalias",inputType:0,type:"LOV",caption:"Alias",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":true,nf:"billdate",lovOptions:{url:"/Fruits/service/ajax",ajax:"customer",scrollEnabled:true,searchFromList:false,dsi:8,params:[{n:"custtype",src:"custtype",ft:false}],results:[{tgt:"custname",tt:true,id:"0"},{tgt:"name",tt:false,id:"1"},{tgt:"custname",tt:false,id:"1"},{tgt:"mobile",tt:false,id:"2"},{tgt:"address",tt:false,id:"3,4,5,6",m:true},{tgt:"address1",tt:false,id:"3"},{tgt:"address2",tt:false,id:"4"},{tgt:"city",tt:false,id:"5"},{tgt:"pincode",tt:false,id:"6"},{tgt:"creditdays",tt:false,id:"7"},{tgt:"showcreditdays",tt:false,id:"7"},{tgt:"custalias",tt:false,id:"8"},{tgt:"custalias",tt:true,id:"8"},{tgt:"prfcode",tt:false,id:"9"},{tgt:"professional",tt:true,id:"10"},{tgt:"professional",tt:false,id:"10"}]},validation:"validateCustomerAlias"},
  {colno:0,name:"custname",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,"saveTag":true,nf:"billdate",lovOptions:{url:"/Fruits/service/ajax",ajax:"customer",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"custtype",src:"custtype",ft:false}],results:[{tgt:"custname",tt:true,id:"0"},{tgt:"name",tt:false,id:"1"},{tgt:"custname",tt:false,id:"1"},{tgt:"mobile",tt:false,id:"2"},{tgt:"address",tt:false,id:"3,4,5,6",m:true},{tgt:"address1",tt:false,id:"3"},{tgt:"address2",tt:false,id:"4"},{tgt:"city",tt:false,id:"5"},{tgt:"pincode",tt:false,id:"6"},{tgt:"creditdays",tt:false,id:"7"},{tgt:"showcreditdays",tt:false,id:"7"},{tgt:"custalias",tt:false,id:"8"}]},validation:"validateCustName"},
  {colno:0,name:"address",inputType:4,type:"SPAN",caption:"Address",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"address2"},  
  {colno:0,name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"address2"},
  {colno:0,name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"city"},
  {colno:0,name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"","maxValue":0,"textLength":50,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"pincode"},
  {colno:0,name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billdate"},
  {colno:0,name:"creditdays",inputType:0,type:"INT",caption:"Credit Days",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"salesman"},
  {colno:0,name:"showcreditdays",inputType:4,type:"INT",caption:"Credit",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"salesman"}
  ]},
  {name:"branch",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"biege",contentType:"Fields",
  fields:[ {colno:0,name:"branch",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"location",lovOptions:{url:"/Fruits/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"branch",tt:true,id:"1"},{tgt:"branch",tt:false,id:"0"},{tgt:"location",tt:false,id:"5"},{tgt:"location",tt:true,id:"6"}]}},
  {colno:0,name:"location",inputType:0,type:"LOV",caption:"",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"custname",lovOptions:{url:"/Fruits/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[]}}
  ]},
    {name:"group2",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"billtype",inputType:1,type:"TEXT",caption:"Bill Type",keys:"Cash~Credit~Credit Card~Coupon~Cheque~Split",values:"CA~CR~CC~CO~CQ~SP",defaultValue:"C","readOnly":false,"chkTag":false,nf:"billdate",visible:false},
  {colno:0,name:"billno",inputType:0,type:"INT",caption:"Bill No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"billdate"},
  {colno:0,name:"showbillno",inputType:4,type:"INT",caption:"Bill No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"billdate"},
  {colno:0,name:"billdate",inputType:0,type:"DATE",caption:"Bill Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"salesman"},
  {colno:0,name:"salesman",inputType:0,type:"LOV",caption:"Salesman",mandatory:false,defaultValue:"","visible":true,"readOnly":false,"chkTag":false,nf:"invoice_data",lovOptions:{url:"/Fruits/service/ajax",ajax:"employee",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"salesman",tt:false,id:"0"},{tgt:"salesman",tt:true,id:"1"},{tgt:"empid",tt:false,id:"2"}]}},
  {colno:0,name:"empid",inputType:0,type:"INT",caption:"EmpId",mandatory:false,defaultValue:"0","visible":false,"readOnly":false,"chkTag":false,nf:""},
  {colno:0,name:"professional",inputType:0,type:"LOV",caption:"Professional",mandatory:false,defaultValue:"","visible":true,"readOnly":false,"chkTag":true,saveTag:false,nf:"invoice_data",lovOptions:{url:"/Fruits/service/ajax",ajax:"professional",scrollEnabled:true,searchFromList:false,cs:0,dsi:0,params:[],results:[{tgt:"professional",tt:false,id:"0"},{tgt:"professional",tt:true,id:"1"},{tgt:"prfcode",tt:true,id:"1"}]}},
  {colno:0,name:"prfcode",inputType:0,type:"INT",caption:"Prfcode",mandatory:false,defaultValue:"0","visible":false,"readOnly":false,"chkTag":false,nf:""},
  {colno:0,name:"despthro",inputType:0,type:"LOV",caption:"Transport",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pf",colspan:2,lovOptions:{url:"/Fruits/service/ajax",ajax:"transport",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}  
  ]},
  {name:"billdetail",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"dcno",inputType:0,type:"INT",caption:"DC No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"dcdate"},
  {colno:0,name:"dcdate",inputType:0,type:"DATE",caption:"DC Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:false,nf:"ordertype"},
  {colno:0,name:"ordertype",inputType:1,type:"TEXT",caption:"Order Type",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"sono",keys:"Direct Sale~Sales Order",values:"DS~SO",defaultValue:"SE"},
  {colno:0,name:"sono",inputType:0,type:"INT",caption:"SO No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"sodate"},
  {colno:0,name:"sosno",inputType:0,type:"INT",caption:"SO No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"sodate"},
  {colno:0,name:"sodate",inputType:0,type:"DATE",caption:"SO Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:false,nf:"despthro"}  ,
  {colno:0,name:"showordertype",inputType:4,type:"TEXT",caption:"Order Type",value:"Direct Sale",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"sono",keys:"Direct Sale~Sales Order",values:"DS~SO",defaultValue:"SE"},
  {colno:0,name:"showsono",inputType:4,type:"INT",caption:"SO No",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"sodate"},
  {colno:0,name:"showsodate",inputType:4,type:"DATE",caption:"SO Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"despthro"}
  ]},{name:"dummyDiv",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"dummy1",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true},
  {name:"dummy2",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true},
  {name:"dummy3",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true}
  ]},
  {name:"dummyDiv1",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {name:"dummy4",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true},
  {name:"dummy5",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true},
  {name:"dummy6",inputType:4,type:"TEXT",caption:"",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"documents",visible:true}
  ]},
  {name:"transport",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"documents",inputType:0,type:"TEXT",caption:"Documents",mandatory:false,defaultValue:"","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"paymode"},
  {colno:0,name:"paymode",inputType:1,type:"TEXT",caption:"Payment Mode",keys:"Cash~Cheque",values:"C~Q",defaultValue:"C","readOnly":false,"chkTag":false,nf:"lrno",visible:false},
  {colno:0,name:"pf",inputType:0,type:"DECIMAL",caption:"P&F",mandatory:false,defaultValue:"0","maxValue":99999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"discount",colspan:2,onchange:"onTaxChange"},
  {colno:0,name:"cdisc",inputType:0,type:"DECIMAL",caption:"Cash Disc%",mandatory:false,defaultValue:"0","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"chkTag":false,nf:"invoice_data",colspan:2,onchange:""},
  {colno:0,name:"cdiscamt",inputType:0,type:"DECIMAL",caption:"Cash Disc Amt",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"chkTag":false,nf:"invoice_data",colspan:2,onchange:""}
  ]},
  {name:"lrdet",title:"",pcolumns:0,height:30,width:98,minWidth:500,minHeight:200,colWidth:33,float:"left",backColor:"biege",contentType:"Fields",
  fields:[
  {colno:0,name:"lrno",inputType:0,type:"TEXT",caption:"LR No",mandatory:false,defaultValue:"NA","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"lrdate"},
  {colno:0,name:"lrdate",inputType:0,type:"DATE",caption:"LR Date",format:"dd/mm/yyyy",defaultValue:"","chkTag":false,visible:true,nf:"creditdays"},
  {colno:0,name:"go",inputType:3,caption:"Go",onclick:"calculateCashDiscount",visible:true}
  ]},
  {name:"invoice",title:"Products",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "product", name: "Product", field: "product",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/Fruits/service/ajax",ajax:"saleproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true},{n:"custtype",src:"custtype",ft:false}],results:[
    {tgt:"invoice_data",tt:false,row:"cr",col:"1",id:"0"},
    {tgt:"invoice_data",tt:true,row:"cr",col:"1",id:"1"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"2",id:"2"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"23",id:"5"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"30",id:"7"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"6",id:"8"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"7",id:"10"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"8",id:"12"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"14",id:"10"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"15",id:"12"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"36",id:"13"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"16",id:"14"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"38",id:"15"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"25",id:"16"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"3",id:"17"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"4",id:"18"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"39",id:"19"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"40",id:"20"},        
    {tgt:"invoice_data",tt:false,row:"cr",col:"41",id:"21"}
    
    ]},width:200,chkTag:true,validation:"getAttributeDetail"},
    {order:"2",id: "pgcode", name: "pgcode", field: "pgcode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"3",id: "serialized", name: "serialized", field: "serialized",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"4",id: "isattribute", name: "isattribute", field: "isattribute",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"5",id: "attribid", name: "AttributeId", field: "attribid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},        
    {order:"6",id: "unitgroup", name: "UnitGroup", field: "unitgroup",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"7",id: "unitname", name: "Units", field: "unitname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/Fruits/service/ajax",ajax:"units",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"unitgroup",src:"invoice_data",row:"cr",col:"6",ft:false}],results:[
    {tgt:"invoice_data",tt:false,row:"cr",col:"7",id:"0"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"8",id:"1"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"14",id:"0"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"15",id:"1"},
    {tgt:"invoice_data",tt:false,row:"cr",col:"36",id:"2"}
    ]},width:80,chkTag:false,validation:""},
    {order:"8",id: "unitid", name: "unitid", field: "unitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},
    {order:"9",id: "batchno", name: "BatchNo", field: "batchno",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"10",id: "batchdt", name: "BatchDt", field: "batchdt",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"11",id: "expdt", name: "ExpDt", field: "expdt",defaultValue:"","inputType":0,"type":"DATE","maxValue":0,"textLength":10,"decimalLength":0,"visible":showExpiry,"readOnly":true,"mandatory":showExpiry,width:ew,chkTag:false},
    {order:"12",id: "qty", name: "Qty", field: "quantity",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:100,onchange:"onRateQuantityChange",cTotal:true,validation:"validateStock"},
    {order:"13",id: "freeqty", name: "Free", field: "freeqty",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:80,onchange:"onRateQuantityChange",cTotal:true,validation:"getSerialDetail"},
    {order:"14",id: "funitname", name: "Units", field: "funitname",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":true,width:0,chkTag:false},
    {order:"15",id: "funitid", name: "unitid", field: "funitid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0},                    
    {order:"16",id: "unit", name: "Unit", field: "unit",defaultValue:"1","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},    
    {order:"17",id: "stock", name: "Stock", field: "stock",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"18",id: "rate", name: "Rate", field: "rate",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":true,width:100,onchange:"onRateQuantityChange",align:"right"},
    {order:"19",id: "discperc", name: "Disc%", field: "discperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":99.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"20",id: "discamt", name: "Disc Amt", field: "discamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
    {order:"21",id: "cashdiscperc", name: "Cash Disc%", field: "cashdiscperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,onchange:"onRateQuantityChange",align:"right"},
	{order:"22",id: "cashdiscamt", name: "Cash Disc Amount", field: "cashdiscamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,align:"right"},	
    {order:"23",id: "staxperc", name: "S.Tax%", field: "staxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"24",id: "staxamt", name: "S.Tax Amt", field: "staxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},
	{order:"25",id: "srtax", name: "Service Tax%", field: "srtaxperc",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":false,"mandatory":false,width:100,onchange:"onRateQuantityChange",align:"right"},
	{order:"26",id: "srtaxamt", name: "Service Tax Amount", field: "srtaxamt",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":false,width:100,align:"right"},		
    {order:"27",id: "amount", name: "Amount", field: "amount",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"28",id: "netamount", name: "NetAmount", field: "netamount",defaultValue:"y","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"mandatory":true,width:150,cTotal:true,align:"right"},
    {order:"29",id: "csdid", name: "CsdId", field: "csdid",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"30",id: "taxincl", name: "TaxInclu", field: "taxincl",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"31",id: "taxableamt", name: "TaxableAmt", field: "taxableamt",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"32",id: "impno", name: "impno", field: "impno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"33",id: "impsno", name: "impsno", field: "impsno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"34",id: "imptype", name: "imptype", field: "imptype",defaultValue:"NA","inputType":0,"type":"TEXT","maxValue":0,"textLength":2,"decimalLength":0,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"35",id: "selling", name: "selling", field: "selling",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":999999.99,"textLength":10,"decimalLength":2,"visible":false,"readOnly":false,"mandatory":false,width:0,align:"right"},
    {order:"36",id: "conversionvalue", name: "conversionvalue", field: "conversionvalue",defaultValue:"0","inputType":0,"type":"DECIMAL","maxValue":0,"textLength":20,"decimalLength":10,"visible":false,"readOnly":true,"mandatory":false,width:0,chkTag:false},
    {order:"37",id: "basequantity", name: "BaseQuantity", field: "basequantity",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"38",id: "allownegative", name: "AllowNegative", field: "allownegative",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"39",id: "composite", name: "Composite", field: "composite",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"40",id: "updatestock", name: "UpdateStock", field: "updatestock",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false},
    {order:"41",id: "hsncode", name: "HSN", field: "hsncode",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":30,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false}
    ]}},
  {name:"group3",height:20,width:45,minWidth:250,minHeight:50,colWidth:98,float:"right",backColor:"biege",contentType:"Fields",
  fields:[  {name:"discamt",inputType:0,type:"DECIMAL",caption:"Total Discount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"taxamt",onchange:"onTaxChange"},
  {name:"taxamt",inputType:0,type:"DECIMAL",caption:"VAT",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"total"},
  {name:"servtaxamt",inputType:0,type:"DECIMAL",caption:"Service Tax",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false,nf:"pf",onchange:"onTaxChange"},
  {name:"total",inputType:0,type:"DECIMAL",caption:"Total:",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false,nf:"totalamt"},    
  {name:"totalamt",inputType:0,type:"DECIMAL",caption:"Net Amount",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":true,"readOnly":true,"chkTag":false},
  {name:"advanceamt",inputType:0,type:"DECIMAL",caption:"Advance Amount",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false},
  {name:"roundedoff",inputType:0,type:"NEGDEC",caption:"Round Off",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":2,"visible":false,"readOnly":true,"chkTag":false}
  ]
  }]};
  /*
  ,
    {name:"group4",height:15,width:80,minWidth:500,minHeight:50,colWidth:15,float:"left",backColor:"beige",contentType:"Fields",fields:[
    {name:"add",inputType:3,caption:"Add",onclick:"add",visible:true},
    {name:"save",inputType:3,caption:"Save",onclick:"save",visible:true},
    {name:"savePrint",inputType:3,caption:"Save & Print",onclick:"savePrint",visible:true},
    {name:"loadservice",inputType:3,caption:"Load Service Order",onclick:"loadServiceOrder",visible:true},
    {name:"edit",inputType:3,caption:"Edit",onclick:"edit",visible:true},
    {name:"Delete",inputType:3,caption:"Delete",onclick:"delete1",visible:true},
    {name:"Print",inputType:3,caption:"Print",onclick:"printInvoice",visible:true}]}
    */
  var screenProps=changeScreenAttributes(310001,sProps);
  var invscreen=new FlexUI.Screen("xyz",screenProps);
  var params="";
  var newParams="";
  newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val();

  jqReport(310004,"#xyz",newParams);
  setDefaultBranch();
  screenObjects.getScreenObject("invoice_data").getInputField().onTextKeyDown.subscribe(tableTextKeyDown);
  <%if(mode!=null && mode.equals("VIEW")){%>
	  loadDataView(<%=code%>);
	  $('#saveGrp').html('<div class="col-sm-2 col-md-2 col-lg-2 adCl saVbN" onclick="closeScreen()">Close</div><div class="col-sm-2 col-md-2 col-lg-2 adCl1" >&nbsp;</div><div class="col-sm-2 col-md-2 col-lg-2 adCl1" >&nbsp;</div>');
		$('#spnSetting').css("display","none");
	<%}else{%>
		$('#spnSetting').css("display","block");
	<%}%>
	function showHideTransport(){
	if( $('#divTransport').is(':visible') ) {
		$('#divTransport').css("display","none");
		$('#divFirst').css("display","block");
		//$('#transbutton').removeClass("fa fa-minus-circle");
		//$('#transbutton').addClass("fa fa-plus-circle");
		$('#transbutton').html("More...");
	}else{
		$('#divTransport').css("display","block");
		$('#divFirst').css("display","none");
		//$('#transbutton').removeClass("fa fa-plus-circle");
		//$('#transbutton').addClass("fa fa-minus-circle");
		$('#transbutton').html("Less...");
	}
}
function getCardBankData(){
	var ajaxObj=new FlexUI.Ajax();
	var bData=ajaxObj.callAjax("GET","/Fruits/service/ajax","ic=0&id=cardbanks");
	var bankData=bData.data;
 	var bankCode=1;
 	var bankName=0;
 	invCardMachines+="<option value='0'>None</option>";
 	for(var i=0;i<bankData.length;i++){
 		invCardMachines+="<option value='"+bankData[i][bankCode]+"'>"+bankData[i][bankName]+"</option>";
 	}
}
function showPrescription(){
		if($('#appid').val()=="0" || $('#appid').val()==""){
			setErrorMessage("No prescription details available for this invoice");
			return;
		}
		$('#prescriptiondlg').dialog({autoOpen:false,modal:true,height:'auto',minHeight:600,minWidth:900,position:'center'});
		$('#prescriptiondlg').dialog('open');
		$('.butt_sav').click(function(e){
			e.preventDefault();
		});
		$('.butt_can').click(function(e){
			e.preventDefault();
		});			
	   	var vl=$('#presitems');
    	var v=l.callAjax("GET","/HMS/service/prescription/patientmedicines","page=1&rows=100&appid="+$('#appid').val()+"&doctorcode="+screenObjects.getScreenObject("prfcode").getValue()+"&hospitalcode=1","");
    	var s=v.rows.length;
    	var action="";    	
    	$('#presitems').children().remove();
    	for(var i=0;i<s;i++){
    		    vl.append('<tr><td>'+(i+1)+'</td>'+
						  '<td>'+v.rows[i].productname+'</td>'+
						  '<td>'+v.rows[i].genericname+'</td>'+
      					  '<td>'+v.rows[i].pdp_course1+'</td>'+
      					  '<td>'+v.rows[i].pdp_course2+'</td>'+
      					  '<td>'+v.rows[i].pdp_course3+'</td>'+
      					  '<td>'+v.rows[i].pdp_course4+'</td>'+
      					  '<td>'+v.rows[i].pdp_ABMeal+'</td>'+
      					  '<td>'+v.rows[i].pdp_numbers+'</td>'+
						  '</tr>');
    	}    
}
function prescrCancel(){
	$('#prescriptiondlg').dialog('close');
	$('#prescriptiondlg').dialog('destroy');
}
function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#xyz').css('display','block');
  	$('#addGrp').css('display','block');
  	$('#filter').css('display','block');
  	reloadGrid(310004);
}

 function loadOrderData(url,code,did){
  	var rowData=$("#report_310004").getRowData(did);
  	var branch=screenObjects.getScreenObject("branch");
  	var location=screenObjects.getScreenObject("location");
  	$('#appid').val(rowData.app_id);
  	if(rowData.paidstatus=="0"){
	  	if(code=="Invoice"){
	  		var a=new FlexUI.Ajax();	  	
	  		var r=a.callAjax("GET","/Fruits/service/ajax","id=custsalesorders&ic=0&ro=true&custcode="+rowData.prm_ref_code+"&branch="+branch.getTag()+"&location="+location.getTag());
			if(r.data!=null && r.data.length>0){	  	
			  	screenObjects.getScreenObject("custname").setTag(rowData.prm_ref_code);
				screenObjects.getScreenObject("custname").setValue(rowData.prm_name);
				screenObjects.getScreenObject("name").setValue(rowData.prm_name);
				loadSalesOrderForCustomer();  	
			  	
				$('#callback').css('display','block');
			  	$('#saveGrp').css('display','block');
			  	$('#addGrp').css('display','none');
			  	$('#xyz').css('display','none');
			  	$('#filter').css('display','none');
			  	hideLoader();
			  	screenObjects.getScreenObject("name").focus();
		  	}else{
		  		alert("No pending pharmacy orders found");
		  	}
	  	}else{
	  		var a=new FlexUI.Ajax();	  	
	  		var r=a.callAjax("GET","/Fruits/service/ajax","id=custsalesorders&ic=0&ro=true&custcode="+rowData.prm_ref_code+"&branch="+branch.getTag()+"&location="+location.getTag());
			if(r.data!=null && r.data.length>0){	  	
				alert("Invoice all the pharmacy orders");
				return;
	  		}
	  		var tenderOptions={};
			tenderOptions.cash=true;
			tenderOptions.credit=false;
			tenderOptions.coupon=false;
			tenderOptions.sponsor=false;
			tenderOptions.creditcard=true;
			tenderOptions.cheque=false;
			tenderOptions.discount=false;
			var netamt=toNumber(rowData.pdf_balance_amount);
			var advamt=0;
			showTenderDialog(tenderOptions,'tenderdlg',netamt,true,advamt);
	  	}
  	}else{
  		alert("Payment process already completed.");
  	}
  }
  	function toggleHeaderRow(){
  		toggleSearchToolBar(310004);
  	}
  	  function reportGo(id){
	showLoader();
	var newParams="&fromdate="+$('#fromDate').val()+"&todate="+$('#toDate').val();
	changeUrlAndReloadGrid(id,params,newParams);	
	hideLoader();
}
  	
  toggleHeaderRow();
  hideMasterData();
getCardBankData();
 </script>
</body>
</html>
