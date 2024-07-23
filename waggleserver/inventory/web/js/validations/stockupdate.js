function getAttributeDetail(id,me,row,col){
	let t=screenObjects.getScreenObject("stocks_data");
	let cols=t.getCols();
	if(me.getCellTag(row,cols.product)!="" && toNumber(me.getText(row,cols.selling))==0 && !stockupdate.getSaveInProgress()){
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getCellPopup(row,col)){
			invokeAttributeDialog(me,row,col,"productprops",me.getInputField());
			return false;				
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			return onAttributeClose(me,row,col);
		}
	}
	return true;
}
function save(id,me){
	if(stockupdate.getSaveInProgress()) return;
	let d=stockupdate.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		let r=s.callAjax("POST","/inventory/service/stockupdate",d);
		console.log(Object(r));
		if(r.result=="Success"){
			setErrorMessage(r.message+" [No:"+r.tranno+"]")   ;
			stockupdate.clearScreen();
			stockupdate.setSaveInProgress(false);
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);		
			stockupdate.setSaveInProgress(false);
		}
	return 0;
	}
}

function add(id,me){
	stockupdate.clearScreen();
	stockupdate.setSaveInProgress(false);
	setDefaultBranch();
	stockupdate.setOperation("ADD");
	//screenObjects.getScreenObject(stockupdate.getInitialFocus()).focus();		
}
function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("stocks_data").getCols();
	let branch=screenObjects.getScreenObject("branch");
	let location=screenObjects.getScreenObject("location");
	let v=null;
	if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=stockforupdate&branch="+branch.getTag()+"&location="+location.getTag()+"&pmcode="+me.getCellTag(row,col)+"&udw="+me.getRelatedValues(row,col).condition);
	}else{
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=stockforupdate&branch="+branch.getTag()+"&location="+location.getTag()+"&pmcode="+me.getCellTag(row,col));
	}
	if(v!=null){
		if(v.data && v.data.length==1){
			setBatchInfo(v.data[0]);
			return true;
		}else if(v.data && v.data.length>1){
			let d=null;
			if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
				d={url:"/inventory/service/ajax?udw="+me.getRelatedValues(row,col).condition,ajax:"stockforupdate",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"stocks_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			}else{
				d={url:"/inventory/service/ajax",ajax:"stockforupdate",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"stocks_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			}
			let lov=new FlexUI.LOV("s_lov",me,d,v.data);
			lov.onLovClose.subscribe(onStockClose);
			lov.show();
			return false;
		}else{
			alert("No previous stock details available. Please use the opening stock screen for enter the fresh stock");
		}		
	}	
	return true;
}
function getSerialDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("stocks_data").getCols();
	if(me.getCellTag(row,cols.product)!=""){
		if(toNumber(me.getText(row,cols.serialized))==1 && me.getCellPopup(row,col)){
			invokeSerialDialog(me,row,col,"productserial",me.getInputField(),toNumber(me.getText(row,cols.nquantity)),false);
			return false;				
		}
	}
	return true;
}
function setDefaultBranch(){
	let branch=screenObjects.getScreenObject("branch");
	let location=screenObjects.getScreenObject("location");
	branch.setTag(defbranch[0][1]);
	branch.setValue(defbranch[0][0]);
	location.setTag(defbranch[0][3]);
	location.setValue(defbranch[0][2]);	
	//screenObjects.getScreenObject(stockupdate.getInitialFocus()).focus();
}
function onStockClose(e,args){
	setBatchInfo(args.result);
	screenObjects.getScreenObject("stocks_data").checkAndMove('Next',false);
}
function setBatchInfo(result){
	let products=screenObjects.getScreenObject("stocks_data");
	let cols=products.getCols();
	products.setCurrentRowText(cols.csdid,result[0]);
	products.setCurrentRowText(cols.batchno,result[1]);
	products.setCurrentRowText(cols.expdt,result[2]);
	products.setCurrentRowText(cols.selling,result[3]);
	products.setCurrentRowText(cols.stock,result[5]);
	products.setCurrentRowText(cols.batchdt,result[6]);
	products.setCurrentRowText(cols.selling,result[3]);		
	products.setCurrentRowText(cols.attribid,result[7]);
	products.setCurrentRowText(cols.mrp,result[8]);
	products.setCurrentRowText(cols.nbatchno,result[1]);
	products.setCurrentRowText(cols.nexpdt,result[2]);
	products.setCurrentRowText(cols.nselling,result[3]);
	products.setCurrentRowText(cols.nquantity,result[5]);
	products.setCurrentRowText(cols.nbatchdt,result[6]);
	products.setCurrentRowText(cols.nmrp,result[8]);			
}