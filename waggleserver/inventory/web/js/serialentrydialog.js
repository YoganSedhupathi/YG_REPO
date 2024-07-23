var serialScreen=null;

function productSerialDetails(parentId,serialData,quantity){
	var serialScreen={title:{height:30,width:100,name:"Serial Nos"},size:{width:150,height:250},container:{id:parentId,isdialog:false},js:"",screen:[
	]};
	var serialGrid={name:"serialno",height:30,width:98,minWidth:350,minHeight:300,colWidth:98,float:"left",backColor:"biege",contentType:"Table",tableProperties:{rowEmptyCheckColumn:1,enableAddRow:false,nextFocus:"sok_button",columns:[
		{order:"0",id: "sno", name: "SNo", field: "sno",defaultValue:"0","inputType":0,"type":"INT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":true,"mandatory":true,"chkTag":false,width:50,sno:true},
		{order:"1",id: "serial", name: "serial", field: "serial",defaultValue:"","inputType":0,"type":"TEXT","maxValue":0,"textLength":10,"decimalLength":0,"visible":true,"readOnly":false,"mandatory":true,width:200,chkTag:false}
	]}};
	serialScreen.screen.push(serialGrid);
	srScreen=new FlexUI.Screen("attr",serialScreen);
	var g=screenObjects.getScreenObject('serialno_data');
	for(var k=0;k<quantity-1;k++){
		g.addRow();
	}
	if(serialData!=null){
		var serials={};
		serials['serialno_data']=serialData;
		srScreen.loadListData(serials);
	}
}

function invokeSerialDialog(grid,row,col,serialDialog,parentObject,quantity,validateSerialNo){	
	var cols=grid.getCols();
	var properties=null;
	var data=null;
	$("#"+serialDialog).html("");
	$("#"+serialDialog).data('quantity',quantity);
	$("#"+serialDialog).data('grid',grid);
	$("#"+serialDialog).data('row',row);
	$("#"+serialDialog).data('col',col);
	$("#"+serialDialog).data('validateSerialNo',validateSerialNo);
	$("#"+serialDialog).dialog({
      autoOpen: false,
      modal: true,
      minWidth:360,
      minHeight:300
    });
    var serialContent=$("<div id='serialcontent' class='pop_lov_inp_box'><div id='serialno' style='height:300px'/></div>");
	var serialTitle=$("<div id='serialtitle' class='pop_lov_hed_box'></div>");
	serialTitle.append("<div class='pop_lov_clos'><a href='#'>X</a></div><div class='pop_lov_hed_txt'>Serial</div>");
    
	if(grid.getRelatedValues(row,col)){
		data=grid.getRelatedValues(row,col).data;
	}
	$('#'+serialDialog).append(serialTitle);
	$('#'+serialDialog).append(serialContent);
    productSerialDetails('serialcontent',data,quantity);
    serialContent.append("<div id='serialbutton' style='float:right'><button type='button' id='sok_button' class='btn btn-primary mRhAj' onclick=\"serialOk('"+serialDialog+"')\">Ok</button><button type='button' class='btn btn-default' onclick=\"serialCancel('"+serialDialog+"')\">Cancel</button></div>");        
    $("#"+serialDialog).dialog({
      close:function(){
      	parentObject.focus();
      	$(this).dialog ('destroy');
      }      
    });
    $("#"+serialDialog).dialog('open');
	$('.butt_sav').click(function(e){
		e.preventDefault();
	});
	$('.butt_can').click(function(e){
		e.preventDefault();
	});			 
    screenObjects.getScreenObject('serialno_data').getInputField().focus();
}
function serialOk(dlg){
   	var rv={};
   	var quantity=$("#"+dlg).data('quantity');
   	var row=$("#"+dlg).data('row');
   	var col=$("#"+dlg).data('col');
   	var grid=$("#"+dlg).data('grid');
   	var validateSerialNo=$("#"+dlg).data('validateSerialNo');
	rv.data=srScreen.processDataToSave();
	if(rv.data!='FAILED'){
		var serials=$.parseJSON(rv.data.replace('data=',''));
		rv.data=serials.savedata.serialno_data.v;
		var ssize=rv.data.length;
		if(quantity!=ssize){
			alert("Quantity ["+quantity+"] & Number of Serials entered ["+ssize+"] Differs");
			return;
		}
		if(validateSerialNo){
			var cr=checkSerialNumber(grid,row,col,rv.data);
			if(cr!=null){
				if(cr.length>0){
					var sss="";
					for(var n=0;n<cr.length;n++){
						sss=sss+cr[n]+"\n";						
					}
					alert("Following serial numbers are not available in the selected rate/record not exists ["+sss+"] ");
					return;
				}
			}
		}
    	grid.setRelatedValues(row,col,rv);
    	$("#"+dlg).dialog('close');
    	grid.setCellPopup(row,col,false);
    	grid.checkAndMove("Next",true);
    }
}
function serialCancel(dlg){
	$("#"+dlg).dialog('close');	
}
function checkSerialNumber(grid,row,col,serials){
	var csd=grid.getText(row,grid.getCols().csdid);
	var s=serials.length;
	var checkData='data={"csd":"'+csd+'","serials":[';
	for(var i=0;i<s;i++){
		var srlNo=serials[i];
		if(i!=0){
			checkData=checkData+",";
		}
		checkData=checkData+'"'+srlNo[1]+'"';
	}
	checkData=checkData+"]}";
	var check=new FlexUI.Ajax();
	var r=check.callAjax("POST","/inventory/service/invoice/checkserial",checkData);
	return r;
}