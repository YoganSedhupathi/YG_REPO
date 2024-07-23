function getAttributeDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	if(me.getCellTag(row,cols.product)!="" && !stockinwardscreen.getSaveInProgress()){
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getCellPopup(row,col)){
			invokeAttributeDialog(me,row,col,"productprops",me.getInputField());
			return false;				
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			//onAttributeClose(me,row,col);			
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
	let netTotal=0;
	let totalDisc=0;
	let totalServiceTax=0;
	let t=screenObjects.getScreenObject("invoice_data");
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
	netTotal+=pf;
	screenObjects.getScreenObject("totalamt").setValue(roundOff(netTotal,2));
	
	$("#totamt").html(roundOff(total,2));
	$("#vat").html(roundOff(totalTax,2));
	$("#disc").html(roundOff(totalDisc,2));
	$("#netAmt").html("Net Amount   "+roundOff(netTotal,2));
	
}
function calculateAmount(row){
	let t=screenObjects.getScreenObject("invoice_data");
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
	t.setText(row,cols.netcost,roundOff((taxableamt+toNumber(t.getText(row,cols.freight)))/baseqty,2));
} 
function calculateCashDiscount(id,me){
	let t=screenObjects.getScreenObject("invoice_data");
	let pf=screenObjects.getScreenObject("pf").getValue();
	let totQty=$('#fd_invoice_databasequantity').text();
	let cols=t.getCols();
	let s=t.getSize();
	for(let i=0;i<s;i++){
		if(toNumber(pf)!=0){
			t.setText(i,cols.freight,roundOff(toNumber(pf)*(toNumber(t.getText(i,cols.basequantity))/toNumber(totQty)),2));
		}
		calculateAmount(i);
	}
	calculateTotal();
}  
function save(id,me){
	let d=stockinwardscreen.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/inward",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			add(id,me);
			return r.key;			
		}else{
			alert(r.message);		
		}
	return 0;
}
}
function delete1(id,me){
	stockinwardscreen.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"inward",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	
function add(id,me){
	stockinwardscreen.clearScreen();
	setDefaultBranch();
	stockinwardscreen.setOperation("ADD");
	screenObjects.getScreenObject("branch").focus();
}
function edit(id,me){
	stockinwardscreen.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"inward",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	let branch=screenObjects.getScreenObject("branch");
	branch.focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/inward","billno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	stockinwardscreen.setOperation("EDIT");
	stockinwardscreen.loadData(r);
	calculateTotal();
	hideLoader();
}
function loadDataView(no){	
	let branch=screenObjects.getScreenObject("branch");
	branch.focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/inward","billno="+no+"&branch="+branch.getTag());
	stockinwardscreen.disableInputs(true);
	stockinwardscreen.loadData(r);
	calculateTotal();
	hideLoader();
}
function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	let suppcode=screenObjects.getScreenObject("frombranch").getTag();
	let v=null;
	if(toNumber(me.getText(row,cols.rate))==0){
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
			v=l.callAjax("GET","/Service/service/ajax","ic=0&id=attribid,prevpurrate&suppcode="+suppcode+"&pmcode="+me.getCellTag(row,col)+"&udw="+me.getRelatedValues(row,col).condition);
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			v=l.callAjax("GET","/Service/service/ajax","ic=0&id=attribid,prevpurrate&suppcode="+suppcode+"&pmcode="+me.getCellTag(row,col));
		}
		if(v!=null){
			if(v.data.attribid && v.data.attribid.length==1){
				me.setCurrentRowText(cols.attribid,v.data.attribid[0][0]);
			}
			if(v.data.prevpurrate && v.data.prevpurrate.length==1){
				me.setCurrentRowText(cols.rate,v.data.prevpurrate[0][0]);
				me.setCurrentRowText(cols.discperc,v.data.prevpurrate[0][1]);
				me.setCurrentRowText(cols.mrp,v.data.prevpurrate[0][2]);
				me.setCurrentRowText(cols.selling,v.data.prevpurrate[0][3]);
			}
		}
	}
	return true;	
}
function getSerialDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	if(me.getCellTag(row,cols.product)!=""){
		if(toNumber(me.getText(row,cols.serialized))==1 && me.getCellPopup(row,col)){
			invokeSerialDialog(me,row,col,"productserial",me.getInputField(),toNumber(me.getText(row,col)),false);
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
	screenObjects.getScreenObject("branch").focus();
}
function geTransferOutDetail(id,me){
	//let cols=screenObjects.getScreenObject("invoice_data").getCols();
	let billno=screenObjects.getScreenObject("outwardsno");
	let branch=screenObjects.getScreenObject("frombranch");
	let v=null;
	if(stockinwardscreen.getOperation()=='ADD' && !stockinwardscreen.getSaveInProgress()){
		if(toNumber(billno.getValue())!=0){
			v=l.callAjax("GET","/inventory/service/transferout","transferin=true&branch="+branch.getTag()+"&outno="+billno.getValue());
			if(v!=null){
				setTransferOutInfo(v);
			}
		}
	}	
	return true;
}
function setTransferOutInfo(bill){
	//let cols=screenObjects.getScreenObject("invoice_data").getCols();
	screenObjects.getScreenObject("recdthro").setValue(bill.sendthro.v);
	screenObjects.getScreenObject("documents").setValue(bill.documents.v);
	screenObjects.getScreenObject("lrno").setValue(bill.lrno.v);
	screenObjects.getScreenObject("lrdate").setValue(bill.lrdate.v);
	screenObjects.getScreenObject("pf").setValue(bill.pf.v);
	screenObjects.getScreenObject("invoice_data").setData(bill.out_data);
	//calculateCashDiscount('','');
	calculateTotal();
}
function closeScreen(){
		$('#rep').show();
		$('#filter').css("display","block");
		$('#dtfilter').css("display","block");
		$('#brdCr').css("display","block");
		$('#maincontent').empty();
}
function onEscClose(){	
	add('','');
}