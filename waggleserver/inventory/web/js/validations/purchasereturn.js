function getAttributeDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("return_data").getCols();
	if(me.getCellTag(row,cols.product)!="" && !prscreen.getSaveInProgress()){
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getCellPopup(row,col)){
			invokeAttributeDialog(me,row,col,"productprops",me.getInputField());
			return false;				
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			return onAttributeClose(me,row,col);			
		}		
	}
	return true;
}
function validateRow(id,me,row,col){
	let cols=me.getCols();
	if(col==cols.rate || col==cols.quantity){
		calculateAmount(row);
	}
	return true;
}
function validateStock(id,me,row,col){
	let cols=screenObjects.getScreenObject("return_data").getCols();
	let stock=me.getText(row,cols.stock);
	let qty=me.getText(row,cols.basequantity);
	let negativestock=me.getText(row,cols.allownegative);
	if(toNumber(negativestock)==0){
		if(toNumber(qty)>toNumber(stock)){
			alert("insufficient Stock");
			return false;
		}
	}
	return true;
}
function onRateQuantityChange(id,me){
	let t=me.getParent();
	calculateAmount(t.getCurrentRow());
	calculateTotal();
	return true;
}
function onTaxChange(id,me){
	calculateTotal();
	return true;
}
function calculateTotal(){
	let total=0;
	let totalTax=0;
	let totalServiceTax=0;
	let netTotal=0;
	let totalDisc=0;
	let t=screenObjects.getScreenObject("return_data");
	let cols=t.getCols();
	let s=t.getSize();
	for(let i=0;i<s;i++){
		total+=toNumber(t.getText(i,cols.amount));
		totalTax+=toNumber(t.getText(i,cols.ptaxamt));
		totalServiceTax+=toNumber(t.getText(i,cols.srtaxamt));
		totalDisc+=toNumber(t.getText(i,cols.discamt));
		netTotal+=toNumber(t.getText(i,cols.netamount));
	}
	screenObjects.getScreenObject("total").setValue(roundOff(total,2));
	screenObjects.getScreenObject("taxamt").setValue(roundOff(totalTax,2));
	screenObjects.getScreenObject("servtaxamt").setValue(roundOff(totalServiceTax,2));
	screenObjects.getScreenObject("discamt").setValue(roundOff(totalDisc,2));
	let pf=toNumber(screenObjects.getScreenObject("pf").getValue());
	let roundedoff=toNumber(screenObjects.getScreenObject("roundedoff").getValue());
	netTotal+=pf;
	netTotal+=roundedoff;
	screenObjects.getScreenObject("totalamt").setValue(roundOff(netTotal,2));
	
	$("#gross").html(roundOff(total,2));
	$("#totamt").html(roundOff(total,2));
	$("#vat").html(roundOff(totalTax,2));
	$("#disc").html(roundOff(totalDisc,2));
	$("#netAmt").html(""+roundOff(netTotal,2));
	
}
function calculateAmount(row){
	let t=screenObjects.getScreenObject("return_data");
	let cols=t.getCols();	
	let baseqty=0;
	baseqty=toNumber(t.getText(row,cols.conversionvalue))*toNumber(t.getText(row,cols.quantity));
	t.setText(row,cols.basequantity,baseqty);
	let amt=roundOff(toNumber(t.getText(row,cols.rate))*baseqty,2);
	let tax=0;
	let netAmt=0;
	let servTax=0;
	let taxableamt=((amt / (100 + toNumber(t.getText(row,cols.ptaxperc)))) * 100);	
	if(toNumber(t.getText(row,cols.taxincl))==0){
		taxableamt=amt;
	}
	let disc=roundOff(taxableamt*toNumber(t.getText(row,cols.discperc))/100,2);
	taxableamt-=disc;	
	tax=roundOff(taxableamt*toNumber(t.getText(row,cols.ptaxperc))/100,2);
	servTax=roundOff(taxableamt*toNumber(t.getText(row,cols.srtaxperc))/100,2);
	netAmt=roundOff(taxableamt+toNumber(servTax)+toNumber(tax),2);
	t.setText(row,cols.ptaxamt,tax);
	t.setText(row,cols.srtaxamt,servTax);
	t.setText(row,cols.discamt,roundOff(disc,2));
	t.setText(row,cols.amount,amt);
	t.setText(row,cols.netamount,netAmt);
	t.setText(row,cols.taxableamt,roundOff(taxableamt,2));
}    
function save(id,me){
	let d=prscreen.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/purchasereturn",d);
		
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.returnno+"]");
			prscreen.clearScreen();
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);		
		}
	return 0;
}
}
function delete1(id,me){
	prscreen.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"purchasereturn",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	
function add(id,me){
	prscreen.clearScreen();
	setDefaultBranch();
	prscreen.setOperation("ADD");
	screenObjects.getScreenObject("suppname").focus();
}
function edit(id,me){
	prscreen.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"purchasereturn",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	screenObjects.getScreenObject("suppname").focus();
	let branch=screenObjects.getScreenObject("branch");
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/purchasereturn","returnno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	prscreen.setOperation("EDIT");
	prscreen.loadData(r);
	calculateTotal();
	hideLoader();
}
function loadDataView(no){	
	screenObjects.getScreenObject("suppname").focus();
	let branch=screenObjects.getScreenObject("branch");
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/purchasereturn","returnno="+no+"&branch="+branch.getTag());
	prscreen.disableInputs(true);
	prscreen.loadData(r);
	calculateTotal();
	hideLoader();
}
function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("return_data").getCols();
	let suppcode=screenObjects.getScreenObject("suppname").getTag();
	let branch=screenObjects.getScreenObject("branch");
	let location=screenObjects.getScreenObject("location");
	let v=null;
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=purstock&branch="+branch.getTag()+"&location="+location.getTag()+"&suppcode="+suppcode+"&pmcode="+me.getCellTag(row,col)+"&udw="+me.getRelatedValues(row,col).condition);
	}else{
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=purstock&branch="+branch.getTag()+"&location="+location.getTag()+"&suppcode="+suppcode+"&pmcode="+me.getCellTag(row,col));
	}
	if(v!=null){
		if(v.data && v.data.length==1){
			setBatchInfo(v.data[0]);
			return true;
		}else if(v.data && v.data.length>1){
			let d=null;
			if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
				d={url:"/inventory/service/ajax?udw="+me.getRelatedValues(row,col).condition,ajax:"purstock",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"suppcode",src:"suppname",ft:true},{n:"pmcode",src:"return_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			}else{
				d={url:"/inventory/service/ajax",ajax:"purstock",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"suppcode",src:"suppname",ft:true},{n:"pmcode",src:"return_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			}
			let lov=new FlexUI.LOV("s_lov",me,d,v.data);
			lov.onLovClose.subscribe(onStockClose);
			lov.show();
			return false;
		}else{
			let r=l.callAjax("GET","/inventory/service/ajax","ic=0&id=productrate&pmcode="+me.getCellTag(row,col));
			if(r!=null){
				if(r.data && r.data.length==1){
					setRateDetails(me,cols,r)
				}
			}
		}	
	}	
	return true;
}
function getSerialDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("return_data").getCols();
	if(me.getCellTag(row,cols.product)!=""){
		if(toNumber(me.getText(row,cols.serialized))==1 && me.getCellPopup(row,col)){
			invokeSerialDialog(me,row,col,"productserial",me.getInputField(),toNumber(me.getText(row,col))+toNumber(me.getText(row,cols.quantity)),true);
			return false;				
		}
	}
	//let cols=screenObjects.getScreenObject("return_data").getCols();
	let stock=me.getText(row,cols.stock);
	let qty=me.getText(row,cols.basequantity);
	let negativestock=me.getText(row,cols.allownegative);
	if(toNumber(negativestock)==0){
		if(toNumber(qty)>toNumber(stock)){
			alert("insufficient Stock");
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
	screenObjects.getScreenObject("suppname").focus();	
}
function onStockClose(e,args){
	setBatchInfo(args.result);
	screenObjects.getScreenObject("return_data").checkAndMove('Next',false);
}
function setBatchInfo(result){
	let products=screenObjects.getScreenObject("return_data");
	let cols=products.getCols();	
	products.setCurrentRowText(cols.csdid,result[0]);
	products.setCurrentRowText(cols.batchno,result[2]);
	products.setCurrentRowText(cols.expdt,result[3]);
	products.setCurrentRowText(cols.rate,result[1]);
	products.setCurrentRowText(cols.stock,result[11]);
	products.setCurrentRowText(cols.batchdt,result[7]);
	products.setCurrentRowText(cols.selling,result[9]);
	products.setCurrentRowText(cols.mrp,result[8]);
	products.setCurrentRowText(cols.discperc,result[4]);
	products.setCurrentRowText(cols.ptaxperc,result[5]);
	products.setCurrentRowText(cols.isdid,result[10]);
	products.setCurrentRowText(cols.attribid,result[12]);
	products.setCurrentRowText(cols.srtaxperc,result[6]);
	
}
function setRateDetails(me,cols,v){
	me.setCurrentRowText(cols.rate,v.data[0][0]);
	me.setCurrentRowText(cols.discperc,v.data[0][1]);
	me.setCurrentRowText(cols.mrp,v.data[0][2]);
	me.setCurrentRowText(cols.selling,v.data[0][3]);
	
	me.setCurrentRowText(cols.csdid,0);
	me.setCurrentRowText(cols.batchno,0);
	me.setCurrentRowText(cols.expdt,"01/04/2012");
	me.setCurrentRowText(cols.stock,0);
	me.setCurrentRowText(cols.batchdt,0);
	me.setCurrentRowText(cols.isdid,0);
	me.setCurrentRowText(cols.attribid,0);
	me.setCurrentRowText(cols.srtaxperc,0);	
}
function closeScreen(){
	$('#listContainer').show();
	$("#jqcontainer").css("display","block");
	$('#rep').show();
	$('#filter').css("display","block");
	$('#dtfilter').css("display","block");
	$('#brdCr').css("display","block");
	$('#maincontent').empty();
}
function onEscClose(){	
	add('','');
}