//var hamaliScreen=null;
function hamaliDetails(parentId,hamaliData){
	$('#'+parentId).append("<div id='hamali' style='height:250px;'/>");
	var hamaliScreen={title:{height:30,width:100,name:"Hamali Details"},size:{width:150,height:250},container:{id:parentId,isdialog:false},js:"",screen:[
	]};
		
	var hamaliGrid={name:"hamali",title:"Hamali",height:30,width:98,minWidth:500,minHeight:250,colWidth:50,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:2,optional:true,columns:[
    {order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
    {order:"1",id: "hamali", name: "Hamali", field: "hamali",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":false,"readOnly":false,"mandatory":false,width:0,chkTag:false,validation:""},
    {order:"2",id: "hamaliname", name: "Hamali", field: "hamaliname",defaultValue:"0","inputType":0,"type":"LOV","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,lovOptions:{url:"/inventory/service/ajax",ajax:"hamali",scrollEnabled:true,searchFromList:false,dsi:0,params:[],results:[{tgt:"hamali_data",tt:false,row:"cr",col:"1",id:"1"},{tgt:"hamali_data",tt:false,row:"cr",col:"2",id:"0"}]},width:200,chkTag:false,validation:""}
    ]}};
	
	hamaliScreen.screen.push(hamaliGrid);
	srScreen=new FlexUI.Screen("attr",hamaliScreen);
	var g=screenObjects.getScreenObject('hamali_data');
	//for(var k=0;k<quantity-1;k++){
		//g.addRow();
	//}
	if(hamaliData!=null){
		var hamalis={};
		hamalis['hamali_data']=hamaliData;
		srScreen.loadListData(hamalis);
	}
}

function invokeHamaliDialog(){	
	//var cols=grid.getCols();
	var properties=null;
	var data=null;
	var hamaliDialog="hamaliDialog";
	$("#"+hamaliDialog).html("");
	$("#"+hamaliDialog).dialog({
      autoOpen: false,
      modal: true,
      minWidth:360,
      minHeight:300
    });
    var hamaliContent=$("<div id='hamalicontent' class='pop_lov_inp_box'/>");
	var hamaliTitle=$("<div id='hamalititle' class='pop_lov_hed_box'></div>");
	hamaliTitle.append("<div class='pop_lov_clos'><a href='#' ><span class='fa fa-times-circle' onclick=\"hamaliCancel('"+hamaliDialog+"')\"></span></a></div><div class='pop_lov_hed_txt'>hamali</div>");
    
	//if(grid.getRelatedValues(row,col)){
		//data=grid.getRelatedValues(row,col).data;
	//}
	$('#'+hamaliDialog).append(hamaliTitle);
	$('#'+hamaliDialog).append(hamaliContent);
    hamaliDetails('hamalicontent',$('#hamaliData').data('tdata'));
    hamaliContent.append("<div id='hamalibutton' style='float:right'><button type='button' id='sok_button' class='btn btn-primary mRhAj' onclick=\"hamaliOk('"+hamaliDialog+"')\">Ok</button><button type='button' class='btn btn-default' onclick=\"hamaliCancel('"+hamaliDialog+"')\">Cancel</button></div>");        
    $("#"+hamaliDialog).dialog({
      close:function(){
      	//parentObject.focus();
      	$(this).dialog ('destroy');
      }      
    });
    $("#"+hamaliDialog).dialog('open');
	$('.butt_sav').click(function(e){
		e.preventDefault();
	});
	$('.butt_can').click(function(e){
		e.preventDefault();
	});			 
    screenObjects.getScreenObject('hamali_data').getInputField().focus();
}
function hamaliOk(dlg){
   	var rv={};
	rv.data=srScreen.processDataToSave("",true);
	if(rv.data!='FAILED'){
		var hamalis=$.parseJSON(rv.data.replace('data=',''));
		rv.data=hamalis.savedata.hamali_data;
		$("#hamaliData").data('tdata',hamalis.savedata.hamali_data);
			if(onHamaliDialogOk){
				onHamaliDialogOk(rv.data);
			}
    	$("#"+dlg).dialog('close');
    }
}
function hamaliCancel(dlg){
	$("#"+dlg).dialog('close');	
}
