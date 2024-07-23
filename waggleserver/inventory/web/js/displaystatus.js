
function displayStatus(parent,orderId){
	var status=0;
	var note=1;
	var processId=2;
	var scheduleTime=3;
	var type=4;
	var updTime=5;
	var updBy=6;
	var assignedTo=7;
	var processCaption=8;
	
	var x=new FlexUI.Ajax();
	var v=x.callAjax("GET","/Service/service/ajax","ic=0&id=orderstatus&order_id="+orderId);
	var data=v.data;
	var s=data.length;
	$('#'+parent).html("");
	for(var j=0;j<s;j++){
		var row=data[j];
		if(row[type]=='Created'){
			$('#'+parent).append($("<li class='created'><div class='createtitle'>Job Created</div><div class='by'>By "+row[updBy]+" at "+row[updTime]+"</div><div class='snote'>"+row[note]+"</div></li>"));
		}else if(row[type]=='Edited'){
			$('#'+parent).append($("<li class='edited'><div class='edittitle'>Job Edited</div><div class='by'>By "+row[updBy]+" at "+row[updTime]+"</div><div class='snote'>"+row[note]+"</div></li>"));
		}else if(row[type]=='Scheduled'){
			$('#'+parent).append($("<li class='scheduled'><div class='scheduletitle'>Job Scheduled</div><div class='by'>By "+row[updBy]+" at "+row[updTime]+"</div><div class='schedule'>Scheduled for "+row[assignedTo]+" on "+row[scheduleTime]+"</div><div class='snote'>"+row[note]+"</div></li>"));
		}else if(row[type]=='Status Updated'){
			$('#'+parent).append($("<li class='updated'><div class='statustitle'>Status Updated</div><div class='by'>By "+row[updBy]+" at "+row[updTime]+"</div><div class='status'>Process "+row[processCaption]+" is "+row[status]+"</div><div class='snote'>"+row[note]+"</div></li>"));
		}				
	}
}
function amcDetails(parent,customerCode){
	var code=0;
	var branchcode=1;
	var amcdate=2;
	var contractfrom=3;
	var contractto=4;
	var amcstatus=5;
	var expired=6;
	var agreementType=7;
	var x=new FlexUI.Ajax();
	var v=x.callAjax("GET","/Service/service/ajax","ic=0&id=amcstatus&custcode="+customerCode);
	var data=v.data;
	var s=data.length;
	$('#'+parent).html("");
	if(s>0){
		var row=data[0];
		if(row[expired]==0){
			$('#'+parent).append($("<div class='amcdetails'>Customer has Annual maintenance contract from "+row[contractfrom]+" to "+row[contractto]+".For product details <a href='#' onclick='showAmcDetails("+row[code]+")'>click here</a></div>"));
		}else{
			$('#'+parent).append($("<div class='amcdetails'>Annual maintenance contract for the Customer was expired on "+row[contractto]+"</div>"));
		}
		$('#'+parent).css('display','block');
	}else{
		$('#'+parent).css('display','none');
	}
}
function showAmcDetails(code){
	$("#amcdetails").html("");
	$("#amcdlg").dialog({
      autoOpen: false,
      modal: true,
      minWidth:410,
      dialogClass: 'amcproductdlg'
    });	
    jqReport(7,"#amcdetails","&amccode="+code,400,200);
	$("#amcdlg").dialog('open');
	toggleSearchToolBar("7");
}

var scheduleScreen=null;
function quickAssign(dlgId,parentId,ticketId,detailId){
	$("#"+dlgId).dialog({
	  autoOpen: false,
	  modal: true
	});
  var v=l.callAjax("GET","/Service/service/order/orderdetail","billno="+ticketId+"&detailid="+detailId);
  var assignScreen={title:{height:30,width:100,name:"Complaint"},container:{id:parentId,isdialog:false},js:"js/validations/assignjobs.js",screen:[
  {name:"group1",title:"Customer Details",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  fields:[{id:"cid_p",name:"cid",inputType:0,type:"INT",caption:"Complaint ID",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"code_p"},
  {id:"process_p",name:"process",inputType:0,type:"INT",caption:"Current Process ID",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"code_p"},
  {id:"did_p",name:"did",inputType:0,type:"INT",caption:"Complaint ID",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"code_p"},
  {id:"code_p",name:"code",inputType:0,type:"INT",caption:"Complaint#",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"name_p"},
  {id:"name_p",name:"name",inputType:0,type:"LOV",caption:"Name",mandatory:true,defaultValue:"","maxValue":0,"textLength":100,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"productname_p"}  
  ]},{name:"group2",title:"Service Details",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  fields:[
  {id:"productname_p",name:"productname",inputType:0,type:"TEXT",caption:"Service Item",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"desc_p"},
  {id:"servicegrp_p",name:"servicegrp",inputType:0,type:"TEXT",caption:"Service Type",mandatory:true,"false":true,"readOnly":true,"chkTag":false,nf:"desc_p"},
  {id:"desc_p",name:"desc",inputType:0,type:"TEXTAREA",caption:"Service Description",mandatory:true,defaultValue:"","textLength":2000,"visible":true,"readOnly":false,"chkTag":false,nf:"mode_p",colspan:2}
  ]},{name:"group3",title:"Schedule",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  fields:[
  {id:"mode_p",name:"mode",inputType:1,type:"TEXT",caption:"Mode",mandatory:false,defaultValue:"","visible":true,"readOnly":false,"chkTag":false,nf:"scheduledate_p",keys:"",values:""},
  {id:"scheduledate_p",name:"scheduledate",inputType:0,type:"DATETIME",caption:"Schedule",mandatory:false,"visible":true,"readOnly":false,"chkTag":false,nf:"currentprocess_p"},
  {id:"currentprocess_p",name:"currentprocess",inputType:0,type:"LOV",caption:"Process",mandatory:true,"visible":true,"readOnly":false,"chkTag":true,nf:"duration_p",lovOptions:{url:"/Service/service/ajax",ajax:"processcaption",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"pgcode",src:"servicegrp_p",ft:false},{n:"processid",src:"process_p",ft:false}],results:[{tgt:"currentprocess_p",tt:false,id:"0"},{tgt:"currentprocess_p",tt:true,id:"1"},{tgt:"duration_p",tt:false,id:"4"},{tgt:"durationin_p",tt:false,id:"5"}]}},
  {id:"duration_p",name:"duration",inputType:0,type:"INT",caption:"Duration",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"durationin"},
  {id:"duration_in",name:"durationin",inputType:1,type:"TEXT",caption:"Duration In",mandatory:true,defaultValue:"MINS","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"chkTag":false,nf:"assignedto",keys:"Minute(s)~Hour(s)~Day(s)",values:"MINS~HOUR~DAY"},  
  {id:"assignedto_p",name:"assignedto",inputType:0,type:"LOV",caption:"Assigned To",mandatory:true,"visible":true,"readOnly":false,"chkTag":true,nf:"note_p",lovOptions:{url:"/Service/service/ajax",ajax:"users",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"processid",src:"currentprocess_p",ft:true,df:"0"},{n:"branch",src:"branch",ft:true,df:"0"}],results:[{tgt:"assignedto_p",tt:false,id:"0"},{tgt:"assignedto_p",tt:true,id:"1"},{tgt:"empid_p",tt:false,id:"2"}]}},
  {id:"empid_p",name:"empid",inputType:0,type:"INT",caption:"EmpId",mandatory:true,"visible":false,defaultValue:"0","readOnly":false,"chkTag":false,nf:"note"},
  {id:"pempid_p",name:"pempid",inputType:0,type:"INT",caption:"PrevEmpId",mandatory:false,"visible":false,defaultValue:"0","readOnly":false,"chkTag":false,nf:"note"},
  {id:"note_p",name:"note",inputType:0,type:"TEXTAREA",caption:"Assignment Note",mandatory:true,defaultValue:"","textLength":2000,"visible":true,"readOnly":false,"chkTag":false,nf:"",colspan:2}
  ]
  }]};
  	if(scheduleScreen==null){
  		$("#"+parentId).html("");  			
		scheduleScreen=new FlexUI.Screen("schedule",assignScreen);
   	}
  	if(scheduleScreen!=null && v!=null){
  		fetchServiceMode(v['servicegrp'].v,"mode_p");	
		scheduleScreen.loadData(v);
	}
	$("#"+dlgId).dialog({
      buttons : {
        "Save" : function() {
        	onQuickAssignSave();    
        	$(this).dialog('close');    	
        },
        "Cancel" : function() {
        	$(this).dialog('close');
        }
      }      
    });
    $("#"+dlgId).dialog('open');	
}
function onQuickAssignSave(){
	var cid=screenObjects.getScreenObject("cid").getValue();
	var d=scheduleScreen.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		var r=s.callAjax("POST","/Service/service/order/assign",d);
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			scheduleScreen.clearScreen();
			reloadGrid("3");
			return r.key;			
		}else{
			alert(r.message);		
		}
		return 0;
	}	
}
var statusUpdateScreen=null;
function quickStatusUpdatePopup(dlgId,parentId,ticketId,detailId){
	$("#"+dlgId).dialog({
	  autoOpen: false,
	  modal: true
	});
  var v=l.callAjax("GET","/Service/service/order/orderdetail","billno="+ticketId+"&detailid="+detailId);
  var statusScreen={title:{height:30,width:100,name:"Complaint"},container:{id:parentId,isdialog:false},js:"js/validations/statusupdate.js",screen:[
  {name:"group1",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  fields:[{id:"cid_p",name:"cid",inputType:0,type:"INT",caption:"Complaint ID",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"code_p"},
  {id:"did_p",name:"did",inputType:0,type:"INT",caption:"Complaint ID",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"code_p"},
  {id:"code_p",name:"code",inputType:0,type:"INT",caption:"Complaint#",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"branch_p"},
  {id:"branch_p",name:"branch",inputType:0,type:"LOV",caption:"Branch",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":true,nf:"productname_p"}
  ]  
  },{name:"group2",title:"Service Details",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  fields:[
  {id:"productname_p",name:"productname",inputType:0,type:"TEXT",caption:"Service Item",mandatory:true,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"chkTag":false,nf:"mode_p"},
  {id:"servicegrp_p",name:"servicegrp",inputType:0,type:"TEXT",caption:"Service Type",mandatory:true,"visible":false,"readOnly":true,"chkTag":false,nf:"desc_p"},
  {id:"mode_p",name:"mode",inputType:0,type:"TEXT",caption:"Mode",mandatory:false,defaultValue:"","visible":true,"readOnly":true,"chkTag":false,nf:"desc_p"},
  {id:"desc_p",name:"desc",inputType:0,type:"TEXTAREA",caption:"Service Description",mandatory:true,defaultValue:"","textLength":2000,"visible":true,"readOnly":true,"chkTag":false,nf:"scheduledate_p",colspan:2},
  {id:"scheduledate_p",name:"scheduledate",inputType:0,type:"DATETIME",caption:"Schedule",mandatory:false,"visible":true,"readOnly":true,"chkTag":false,nf:"currentprocess_p"},
  {id:"currentprocess_p",name:"currentprocess",inputType:0,type:"TEXT",caption:"Process",mandatory:true,"visible":true,"readOnly":true,"chkTag":true,nf:"note_p"},
  {id:"duration_p",name:"duration",inputType:0,type:"INT",caption:"Duration",mandatory:false,defaultValue:"0","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"chkTag":false,nf:"durationin_p"},
  {id:"durationin_p",name:"durationin",inputType:1,type:"TEXT",caption:"Duration In",mandatory:true,defaultValue:"MINS","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":true,"chkTag":false,nf:"assignedto",keys:"Minute(s)~Hour(s)~Day(s)",values:"MINS~HOUR~DAY"},  
  {id:"assignedto_p",name:"assignedto",inputType:0,type:"LOV",caption:"Assigned To",mandatory:true,"visible":false,"readOnly":true,"chkTag":true,nf:"note_p"},
  {id:"empid_p",name:"empid",inputType:0,type:"INT",caption:"EmpId",mandatory:true,"visible":false,"readOnly":false,"chkTag":false,nf:"note"},
  {id:"note_p",name:"note",inputType:0,type:"TEXTAREA",caption:"Assignment Note",mandatory:true,defaultValue:"","textLength":2000,"visible":true,"readOnly":true,"chkTag":false,nf:"status_p",colspan:2}]
  },{name:"group3",title:"Status Update",height:40,width:98,minWidth:500,minHeight:200,colWidth:45,float:"left",backColor:"beige",contentType:"Fields",
  fields:[{id:"status_p",name:"status",inputType:1,type:"TEXT",caption:"Status",mandatory:true,defaultValue:"","textLength":10,"visible":true,"readOnly":false,"chkTag":false,nf:"completeddate_p",keys:"Pending~Waiting For Parts~Completed~Cannot Proceed",values:"Pending~Waiting For Parts~Completed~Cannot Proceed"},
  {id:"completeddate_p",name:"completeddate",inputType:0,type:"DATETIME",caption:"Completed Date",mandatory:false,"visible":true,"readOnly":false,"chkTag":false,nf:"statusnote_p"},
  {id:"statusnote_p",name:"statusnote",inputType:0,type:"TEXTAREA",caption:"Status Note",mandatory:true,defaultValue:"","textLength":2000,"visible":true,"readOnly":false,"chkTag":false,nf:"",colspan:2},
  ]
  }]};
  	if(statusUpdateScreen==null){
  		$("#"+parentId).html("");  			
		statusUpdateScreen=new FlexUI.Screen("statusupdatepopup",statusScreen);
   	}
  	if(statusUpdateScreen!=null && v!=null){
		statusUpdateScreen.loadData(v);
	}
	$("#"+dlgId).dialog({
      buttons : {
        "Save" : function() {
        	onQuickStatusUpdateSave();    
        	$(this).dialog('close');    	
        },
        "Cancel" : function() {
        	$(this).dialog('close');
        }
      }      
    });
    $("#"+dlgId).dialog('open');	
}
function onQuickStatusUpdateSave(){
	var cid=screenObjects.getScreenObject("cid").getValue();
	var d=statusUpdateScreen.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		var r=s.callAjax("POST","/Service/service/order/status",d);
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			statusUpdateScreen.clearScreen();
			reloadGrid("5");
			return r.key;			
		}else{
			alert(r.message);		
		}
		return 0;
	}	
}