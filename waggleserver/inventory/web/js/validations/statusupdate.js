function getAttributeDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("replacement_data").getCols();
	let statusscreen=null;
	if(statusupdate){
		statusscreen=statusupdate;
	}else{
		statusscreen=statusUpdateScreen;
	}
	if(me.getCellTag(row,cols.product)!="" && toNumber(me.getText(row,cols.quantity))==0 && !statusscreen.getSaveInProgress()){
		return onAttributeClose(me,row,col);
	}
	return true;
}
function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("replacement_data").getCols();
	let branch=screenObjects.getScreenObject("branch");
	let v=null;
	v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=stock&branch="+branch.getTag()+"&pmcode="+me.getCellTag(row,col));
	if(v!=null){
		if(v.data && v.data.length==1){
			me.setText(row,cols.csdid,v.data[0][0]);
			return true;
		}else if(v.data && v.data.length>1){
			let d=null;
			d={url:"/inventory/service/ajax",ajax:"stock",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"pmcode",src:"replacement_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			let lov=new FlexUI.LOV("s_lov",me,d,v.data);
			lov.onLovClose.subscribe(onStockClose);
			lov.show();
			return false;
		}
	}
}
function getSerialDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("replacement_data").getCols();
	if(me.getCellTag(row,cols.product)!=""){
		if(toNumber(me.getText(row,cols.serialized))==1 && me.getCellPopup(row,col)){
			invokeSerialDialog(me,row,col,"productserial",me.getInputField(),toNumber(me.getText(row,col)),true);
			return false;				
		}
	}
	return true;
}
function onStockClose(e,args){
	let replacements=screenObjects.getScreenObject("replacement_data");
	let cols=replacements.getCols();
	replacements.setCurrentRowText(cols.csdid,args.result[0]);
	replacements.checkAndMove('Next',false);
}