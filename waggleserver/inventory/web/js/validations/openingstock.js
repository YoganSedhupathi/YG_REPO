function getAttributeDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	if(me.getCellTag(row,cols.product)!="" && !opstockscreen.getSaveInProgress()){
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getCellPopup(row,col)){
			invokeAttributeDialog(me,row,col,"productprops",me.getInputField());
			return false;				
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			onAttributeClose(me,row,col);			
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
	return true;
}
function calculateAmount(row){
	let t=screenObjects.getScreenObject("invoice_data");
	let cols=t.getCols();	
	let baseqty=0;
	let fbaseqty=0;
	baseqty=toNumber(t.getText(row,cols.conversionvalue))*toNumber(t.getText(row,cols.quantity));
	fbaseqty=toNumber(t.getText(row,cols.conversionvalue))*toNumber(t.getText(row,cols.freeqty));
	t.setText(row,cols.basequantity,baseqty);
	let amt=roundOff(toNumber(t.getText(row,cols.rate))*baseqty,2);
	let tax=0;
	let netAmt=0;
	let serviceTax=0;
	let taxableamt=((amt / (100 + toNumber(t.getText(row,cols.ptaxperc)))) * 100);	
	if(toNumber(t.getText(row,cols.taxincl))==0){
		taxableamt=amt;
	}
	let disc=roundOff(taxableamt*toNumber(t.getText(row,cols.discperc))/100,2);
	taxableamt-=disc;	
	tax=roundOff(taxableamt*toNumber(t.getText(row,cols.ptaxperc))/100,2);
	serviceTax=roundOff(taxableamt*toNumber(t.getText(row,cols.srtaxperc))/100,2);
	netAmt=roundOff(taxableamt+toNumber(tax),2);
	t.setText(row,cols.ptaxamt,tax);
	t.setText(row,cols.srtaxamt,serviceTax);
	t.setText(row,cols.discamt,roundOff(disc,2));
	t.setText(row,cols.amount,amt);
	t.setText(row,cols.netamount,netAmt);
	t.setText(row,cols.taxableamt,roundOff(taxableamt,2));
	let costType=t.getCellTag(row,cols.netcost);
	if(costType==1){
		t.setText(row,cols.netcost,roundOff((netAmt+toNumber(t.getText(row,cols.freight)))/(baseqty+fbaseqty),2));
	}else{
		t.setText(row,cols.netcost,roundOff((taxableamt+toNumber(t.getText(row,cols.freight)))/(baseqty+fbaseqty),2));
	}
}    
function save(id,me){
	let d=opstockscreen.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/openingstock",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			opstockscreen.clearScreen();
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);		
		}
	return 0;
}
}
function add(id,me){
	opstockscreen.clearScreen();
	setDefaultBranch();
	opstockscreen.setOperation("ADD");
	screenObjects.getScreenObject("branch").focus();
}

function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	let v=null;
	if(toNumber(me.getText(row,cols.rate))==0){
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
			v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=attribid,prevrate&pmcode="+me.getCellTag(row,col)+"&udw="+me.getRelatedValues(row,col).condition);
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=attribid,prevrate&pmcode="+me.getCellTag(row,col));
		}
		if(v!=null){
			if(v.data.attribid && v.data.attribid.length==1){
				me.setCurrentRowText(cols.attribid,v.data.attribid[0][0]);
			}		
			if(v.data && v.data.length==1){
				setRateDetails(me,cols,v.data.prevpurrate)
			}else{
				let r=l.callAjax("GET","/inventory/service/ajax","ic=0&id=productrate&pmcode="+me.getCellTag(row,col));
				if(r!=null){
					if(r.data && r.data.length==1){
						setRateDetails(me,cols,r.data)
					}
				}
			}
		}
	}
	return true;	
}
function setRateDetails(me,cols,v){
	me.setCurrentRowText(cols.rate,v[0][0]);
	me.setCurrentRowText(cols.discperc,v[0][1]);
	me.setCurrentRowText(cols.mrp,v[0][2]);
	me.setCurrentRowText(cols.selling,v[0][3]);
}
function getSerialDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	if(me.getCellTag(row,cols.product)!=""){
		if(toNumber(me.getText(row,cols.serialized))==1 && me.getCellPopup(row,col)){
			invokeSerialDialog(me,row,col,"productserial",me.getInputField(),toNumber(me.getText(row,col))+toNumber(me.getText(row,cols.quantity)),false);
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

function onEscClose(){	
	add('','');
}