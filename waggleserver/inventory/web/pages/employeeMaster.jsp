<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Employeess</title>
</head>
<body>
<div class="card border-0 shadow">
	<div class="card-body lpage" >
		<div class="row w-100" >
			<div class="col-md-6 d-flex align-items-center">
				<h4 class="header-title">Employeess</h4>
			</div>
			<div  class="col-md-6 text-right" id="addGrp"></div>
			<div  class="col-md-6 text-right" id="saveGrp" style='display:none'>
				<div class="mb-3">
					<button type="button" class="btn btn-edit" onclick='onSaveClicked()'><span class="mdi mdi-check-circle-outline me-2"></span>Save</button>
					<button type="button" class="btn btn-clear mx-3" onclick='hideMasterData()'><span class="mdi mdi-refresh me-2"></span>Cancel</button>
				</div>
			</div>
		</div>
		<div class="row " id="jqcontainer" ><div class="table-container" ><div id="xyz" class="w-100"></div></div></div>	
		<div id="callback" style="display:none" >
			<div class="table-container">
				<div class="row w-100 ml-8">                    
					<div id="group1" class="row"></div>
				</div>
			   <div class="row w-100 ml-8">
					<div id="group2" class="row"></div>
			   </div>
			   <div class="row w-100 ml-8">
					<div id="group3" class="row"></div>
				</div>
			</div>
		   
		</div>

		</div>
	</div>
	

<script>
  	var l=new FlexUI.Ajax();
  	var defdata=l.callAjax("GET","/inventory/service/ajax","id=userbranch&ic=0");
  	var branches=defdata.data;
    var sProps={title:{height:30,width:100,name:"AMC"},container:{id:"callback",isdialog:false},js:"",screen:[
  	{name:"group1",title:"Employee Details",pcolumns:2,height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[{colno:1,name:"code",inputType:0,type:"INT",caption:"Code",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"name"},
  	{colno:0,name:"empname",inputType:0,type:"TEXT",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"username"},
  	{colno:1,name:"username",inputType:0,type:"TEXT",caption:"User Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"password"},
  	{colno:0,name:"password",inputType:0,type:"password",caption:"Password",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"role"},
  	{colno:1,name:"role",inputType:0,type:"LOV",caption:"Role",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"address1",lovOptions:{url:"/inventory/service/ajax",ajax:"roles",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}}
  	]
  	},{name:"group2",title:"Contact Details",pcolumns:2,height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  	fields:[
  	{colno:0,name:"address1",inputType:0,type:"TEXT",caption:"Building",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"address2"},
  	{colno:1,name:"address2",inputType:0,type:"TEXT",caption:"Street",mandatory:false,defaultValue:"0","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"city"},
  	{colno:0,name:"city",inputType:0,type:"TEXT",caption:"City",mandatory:false,defaultValue:"0","maxValue":0,"textLength":50,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"pincode"},
	{colno:1,name:"pincode",inputType:0,type:"TEXT",caption:"PinCode",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"mobile"},
	{colno:0,name:"mobile",inputType:0,type:"TEXT",caption:"Mobile",mandatory:false,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"phone"},  
	{colno:1,name:"phone",inputType:0,type:"TEXT",caption:"Phone",mandatory:false,defaultValue:"0","maxValue":0,"textLength":30,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"defbranch"},
	{colno:0,name:"defbranch",inputType:0,type:"LOV",caption:"Primary Branch",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":true,nf:"status",lovOptions:{url:"/inventory/service/ajax",ajax:"userbranch",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[]}},
	{colno:1,name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"branch_data",keys:"Active~InActive",values:"Active~InActive"},
	{colno:0,name:"usertype",inputType:0,type:"TEXT",caption:"Type",mandatory:false,defaultValue:"U","textLength":10,"visible":false,"readOnly":false,"chkTag":false,nf:"branch_data"}
	]
  	},{name:"branch",title:"Employee Branch Details",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,enableAddRow:false,optional:false,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "location", name: "Branch", field: "location",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,width:200,"chkTag":true},
    {order:"2",id: "selected", name: "Select", field: "selected",defaultValue:"0","inputType":2,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:120,chkTag:false},
    {order:"3",id: "lmname", name: "Default Location", field: "lmname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:200,"chkTag":true,lovOptions:{url:"/inventory/service/ajax",ajax:"branchlocations",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch_data",ft:true,row:"cr",col:"1"}],results:[]}}    
    ]
    }}
    /*,{name:"processes",title:"Employee Process Update",height:30,width:98,minWidth:500,minHeight:200,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,enableAddRow:false,optional:false,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:20,sno:true},
    {order:"1",id: "group", name: "Group", field: "group",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:100,"chkTag":false},
    {order:"2",id: "process", name: "Process", field: "process",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":false,width:100,"chkTag":true},
    {order:"3",id: "selected", name: "Select", field: "selected",defaultValue:"0","inputType":2,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":false,width:20,chkTag:false}
    ]
    }}*/
    ]};
  var screenProps=changeScreenAttributes(810002,sProps);
  var employee=new FlexUI.Screen("employeemaster",screenProps);
  jqReport(810002,"#xyz");
  function addMasterData(){ 
  	employee.clearScreen();
  	var b=screenObjects.getScreenObject('branch_data');
  	var s=branches.length;
  	for(var h=0;h<s;h++){
  		if(b.getSize()==h){
  			b.addRow();
  		}
  		b.setText(h,1,branches[h][0]);
  		b.setCellTag(h,1,branches[h][1]);
  		b.setText(h,3,branches[h][5]);
  		b.setCellTag(h,3,branches[h][6]);
  	}
  	/*var p=screenObjects.getScreenObject('processes_data');
  	s=processes.length;
  	for(var i=0;i<s;i++){
  		if(p.getSize()==i){
  			p.addRow();
  		}
  		p.setText(i,1,processes[i][6]);
  		p.setText(i,2,processes[i][0]);
  		p.setCellTag(i,2,processes[i][1]);
  	}*/
  	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
	$('#jqcontainer').css('display','none');
  }
  function hideMasterData(){
  	$('#callback').css('display','none');
  	$('#saveGrp').css('display','none');
  	$('#history').css('display','none');
  	$('#addGrp').css('display','block');
  	$('#xyz').css('display','block');
	$('#jqcontainer').css('display','block');
  }  
  function toggleHeaderRow(){
  	toggleSearchToolBar("810002");
  }
  toggleHeaderRow();
  function onSaveClicked(id,me){
    var cid=screenObjects.getScreenObject("code").getValue();
    if(cid!="0" && cid!=""){
    	employee.setOperation("EDIT");
    }
	var d=employee.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		var r=s.callAjax("POST","/inventory/service/users/employee",d);
		hideLoader();
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.code+"]");
			employee.clearScreen();
			hideMasterData();
			reloadGrid("810002");
			return r.key;			
		}else{
			setErrorMessage(r.message);		
		}
		return 0;
	}
  }
  
  function loadOrderData(url,code,did){
  	if(url==""){
  		url="/inventory/service/users/employee";
  	}
  	if(code!=""){
  		code="code="+code+"";
  	}
  	showLoader();
	var v=l.callAjax("GET",url,code);
	employee.clearScreen();
	employee.loadData(v);
	screenObjects.getScreenObject('username').setEnabled(false);
  	screenObjects.getScreenObject('password').setEnabled(false);	
	$('#callback').css('display','block');
  	$('#saveGrp').css('display','block');
  	$('#history').css('display','block');
  	$('#addGrp').css('display','none');
  	$('#xyz').css('display','none');
	 $('#jqcontainer').css('display','none');
  	hideLoader();
  }
</script> 
</body>
</html>