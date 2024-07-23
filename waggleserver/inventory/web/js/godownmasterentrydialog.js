//var hamaliScreen=null;
function godownDetails(parentId,godownData){
	$('#'+parentId).append("<div id='godown' style='height:250px;'/>");
	var godownScreen={title:{height:30,width:100,name:"Godown Details"},size:{width:150,height:250},container:{id:parentId,isdialog:false},js:"",screen:[
	]};
		
	var godownGrid={name:"godown",title:"Rack Details",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "rack", name: "Rack", field: "rack",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true},
    {order:"2",id: "shelf", name: "NoofShelf", field: "shelf",defaultValue:"0","inputType":0,"type":"TEXT","maxValue":0,"textLength":20,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true}
    ]}};
	
	godownScreen.screen.push(godownGrid);
	srScreen=new FlexUI.Screen("attr",godownScreen);
	var g=screenObjects.getScreenObject('godown_data');
	//for(var k=0;k<quantity-1;k++){
		//g.addRow();
	//}
	if(godownData!=null){
		var godowns={};
		godowns['godown_data']=godownData;
		srScreen.loadData(godowns);
	}
}

function invokeGodownDialog(){	
	//var cols=grid.getCols();
	var properties=null;
	var data=null;
	var godownDialog="godownDialog";
	$("#"+godownDialog).html("");
	$("#"+godownDialog).dialog({
      autoOpen: false,
      modal: true,
      minWidth:360,
      minHeight:300
    });
    var godownContent=$("<div id='godowncontent' class='pop_lov_inp_box'/>");
	var godownTitle=$("<div id='godowntitle' class='pop_lov_hed_box'></div>");
	godownTitle.append("<div class='pop_lov_clos'><a href='#' ><span class='fa fa-times-circle' onclick=\"godownCancel('"+godownDialog+"')\"></span></a></div><div class='pop_lov_hed_txt'>godown</div>");
    
	//if(grid.getRelatedValues(row,col)){
		//data=grid.getRelatedValues(row,col).data;
	//}
	$('#'+godownDialog).append(godownTitle);
	$('#'+godownDialog).append(godownContent);
    godownDetails('godowncontent',$('#godownData').data('tdata'));
    godownContent.append("<div id='godownbutton' style='float:right'><button type='button' id='sok_button' class='btn btn-primary mRhAj' onclick=\"godownOk('"+godownDialog+"')\">Ok</button><button type='button' class='btn btn-default' onclick=\"godownCancel('"+godownDialog+"')\">Cancel</button></div>");        
    $("#"+godownDialog).dialog({
      close:function(){
      	//parentObject.focus();
      	$(this).dialog ('destroy');
      }      
    });
    $("#"+godownDialog).dialog('open');
	$('.butt_sav').click(function(e){
		e.preventDefault();
	});
	$('.butt_can').click(function(e){
		e.preventDefault();
	});			 
    screenObjects.getScreenObject('godown_data').getInputField().focus();
}
function godownOk(dlg){
   	var rv={};
	rv.data=srScreen.processDataToSave();
	if(rv.data!='FAILED'){
		var godowns=$.parseJSON(rv.data.replace('data=',''));
		rv.data=godowns.savedata.godown_data.v;
		var ssize=rv.data.length;
		$("#"+dlg).data('tdata',rv.data);
			if(onGodownDialogOk){
				onGodownDialogOk(rv.data);
			}
    	$("#"+dlg).dialog('close');
    }
}
function godownCancel(dlg){
	$("#"+dlg).dialog('close');	
}
