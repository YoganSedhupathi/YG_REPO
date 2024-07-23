function getAttributeDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	if(me.getCellTag(row,cols.product)!="" && !grnscreen.getSaveInProgress()){
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
	let totalCdisc=0;
	let totalServiceTax=0;
	let t=screenObjects.getScreenObject("invoice_data");
	let cols=t.getCols();
	let s=t.getSize();
	for(let i=0;i<s;i++){
		total+=toNumber(t.getText(i,cols.amount));
		totalTax+=toNumber(t.getText(i,cols.ptaxamt));
		totalDisc+=toNumber(t.getText(i,cols.discamt));
		netTotal+=toNumber(t.getText(i,cols.netamount));
		totalCdisc+=toNumber(t.getText(i,cols.cashdiscamt));
		totalServiceTax+=toNumber(t.getText(i,cols.srtaxamt));
	}
	screenObjects.getScreenObject("total").setValue(roundOff(total,2));
	screenObjects.getScreenObject("taxamt").setValue(roundOff(totalTax,2));
	screenObjects.getScreenObject("servtaxamt").setValue(roundOff(totalServiceTax,2));
	screenObjects.getScreenObject("discamt").setValue(roundOff(totalDisc,2));
	let pf=toNumber(screenObjects.getScreenObject("pf").getValue());
	netTotal+=pf;
	screenObjects.getScreenObject("totalamt").setValue(roundOff(netTotal,2));
	screenObjects.getScreenObject("cdiscamt").setValue(roundOff(totalCdisc,2));
	$("#gross").html(roundOff(total,2));
	$("#totamt").html(roundOff(total,2));
	$("#vat").html(roundOff(totalTax,2));
	$("#disc").html(roundOff(totalDisc,2));
	$("#netAmt").html("Net Amount&nbsp;:&nbsp;   "+roundOff(netTotal,2));
	
}
function calculateAmount(row){
	let t=screenObjects.getScreenObject("invoice_data");
	let cols=t.getCols();	
	let baseqty=0;
	let fbaseqty=0;
	let rate=0;
	let mrp=0;
	let selling=0;
	baseqty=toNumber(t.getText(row,cols.conversionvalue))*toNumber(t.getText(row,cols.quantity));
	fbaseqty=toNumber(t.getText(row,cols.conversionvalue))*toNumber(t.getText(row,cols.freeqty));
	if(t.getCellTag(row,cols.conversionvalue)=="1"){
		rate=toNumber(roundOff(toNumber(t.getText(row,cols.rate))/toNumber(t.getText(row,cols.conversionvalue)),3));
		mrp=roundOff(toNumber(t.getText(row,cols.mrp))/toNumber(t.getText(row,cols.conversionvalue)),2);
		selling=roundOff(toNumber(t.getText(row,cols.selling))/toNumber(t.getText(row,cols.conversionvalue)),2);
		t.setText(row,cols.erate,t.getText(row,cols.rate));
		t.setText(row,cols.emrp,t.getText(row,cols.mrp));
		t.setText(row,cols.eselling,t.getText(row,cols.selling));
		t.setCellTag(row,cols.rate,rate+"");
		t.setCellTag(row,cols.mrp,mrp);
		t.setCellTag(row,cols.selling,selling);		
		t.setCellTag(row,cols.basequantity,"1");
	}else{
		let rate=toNumber(t.getText(row,cols.rate));
		let mrp=t.getText(row,cols.mrp);
		let selling=t.getText(row,cols.selling);
		t.setText(row,cols.erate,t.getText(row,cols.rate));
		t.setText(row,cols.emrp,t.getText(row,cols.mrp));
		t.setText(row,cols.eselling,t.getText(row,cols.selling));
		t.setCellTag(row,cols.rate,rate+"");
		t.setCellTag(row,cols.mrp,mrp);
		t.setCellTag(row,cols.selling,selling);	
		t.setCellTag(row,cols.basequantity,"0");					
	}	
	t.setText(row,cols.basequantity,baseqty);
	let amt=roundOff(rate*baseqty,2);
	let tax=0;
	let serviceTax=0;
	let netAmt=0;
	let taxableamt=((amt / (100 + toNumber(t.getText(row,cols.ptaxperc)))) * 100);	
	if(toNumber(t.getText(row,cols.taxincl))==0){
		taxableamt=amt;
	}
	let disc=roundOff(taxableamt*toNumber(t.getText(row,cols.discperc))/100,2);
	taxableamt-=disc;	
	let cashdisc=roundOff(taxableamt*toNumber(t.getText(row,cols.cashdiscperc))/100,2);
	taxableamt-=cashdisc;
	tax=roundOff(taxableamt*toNumber(t.getText(row,cols.ptaxperc))/100,2);
	serviceTax=roundOff(taxableamt*toNumber(t.getText(row,cols.srtaxperc))/100,2);
	netAmt=roundOff(taxableamt+toNumber(serviceTax)+toNumber(tax),2);
	t.setText(row,cols.ptaxamt,tax);
	t.setText(row,cols.srtaxamt,serviceTax);
	t.setText(row,cols.discamt,roundOff(disc,2));
	t.setText(row,cols.cashdiscamt,roundOff(cashdisc,2));
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
function calculateCashDiscount(id,me){
	let t=screenObjects.getScreenObject("invoice_data");
	let cashdiscperc=screenObjects.getScreenObject("cdisc");
	let pf=screenObjects.getScreenObject("pf").getValue();
	let totQty=$('#fd_invoice_databasequantity').text();
	let cols=t.getCols();
	let s=t.getSize();
	for(let i=0;i<s;i++){
		if(toNumber(pf)!=0){
			t.setText(i,cols.freight,roundOff(toNumber(pf)*(toNumber(t.getText(i,cols.basequantity))/toNumber(totQty)),2));
		}
		t.setText(i,cols.cashdiscperc,cashdiscperc.getValue());
		calculateAmount(i);
	}
	calculateTotal();
}  
function save(id,me){
	let hamaliEnabled=true;
	let v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=config&configname=enablehamali");
		if(v!=null){
			if(v.data && v.data.length==1){
				let value=v.data[0][0];
				if(value==0){
					hamaliEnabled=false;
				}
			}
	}
	if(validateInvoiceAmount()){
		if(hamaliEnabled){
			invokeHamaliDialog();
		}else{
			onHamaliDialogOk('');
		}
	}
	/*
	let d=grnscreen.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		let r=s.callAjax("POST","/inventory/service/grn",d);
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			grnscreen.clearScreen();
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);		
		}
	return 0;
}*/
}
function delete1(id,me){
	grnscreen.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"grn",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	
function add(id,me){
	grnscreen.clearScreen();
	setDefaultBranch();
	grnscreen.setOperation("ADD");
	screenObjects.getScreenObject('suppname').setEnabled(true);
	screenObjects.getScreenObject("suppname").focus();
}
function edit(id,me){
	grnscreen.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"grn",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	let branch=screenObjects.getScreenObject("branch");
	branch.focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/grn","billno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	grnscreen.setOperation("EDIT");
	grnscreen.loadData(r);
	$('#hamaliData').data('tdata',r.hamali);
	calculateTotal();
	hideLoader();
}
function loadDataView(no){	
	$('#spnSetting').css("display","none");
	let branch=screenObjects.getScreenObject("branch");
	branch.focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/grn","billno="+no+"&branch="+branch.getTag());
	grnscreen.disableInputs(true);
	grnscreen.loadData(r);
	calculateTotal();
	hideLoader();
}
function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	let suppcode=screenObjects.getScreenObject("suppname").getTag();
	let v=null;
	if(toNumber(me.getText(row,cols.rate))==0){
	
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
			v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=attribid,prevpurrate&suppcode="+suppcode+"&pmcode="+me.getCellTag(row,col)+"&udw="+me.getRelatedValues(row,col).condition);
		}else if(toNumber(me.getText(row,cols.isattribute))==0){
			v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=attribid,prevpurrate&suppcode="+suppcode+"&pmcode="+me.getCellTag(row,col));
		}
		if(v!=null){
			if(v.data.attribid && v.data.attribid.length==1){
				me.setCurrentRowText(cols.attribid,v.data.attribid[0][0]);
			}		
			if(v.data && v.data.prevpurrate.length==1){
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
	me.setCurrentRowText(cols.expdt,v[0][4]);
	me.setCurrentRowText(cols.batchno,v[0][5]);
	me.setCurrentRowText(cols.batchdt,v[0][6]);		
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
function onHamaliDialogOk(values){
	let s=',"hamali_data":'+JSON.stringify(values);
	let d=grnscreen.processDataToSave(s);
	if("FAILED"!=d){
		showLoader();
		let s=new FlexUI.Ajax();
		let r=s.callAjax("POST","/inventory/service/grn",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			add('','');
			return r.key;			
		}else{
			alert(r.message);		
		}
		return 0;
	}
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

function loadPurchaseOrder(id,me){
	let op=grnscreen.getOperation();
	if(op=="ADD"){
		let l={url:"/inventory/service/ajax",ajax:"purchaseorder",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"posno",src:"posno",ft:false}],results:[{tgt:"pono",id:"0",tt:false}]};
		let lov=new FlexUI.LOV("po_lov",me,l);
		lov.onLovClose.subscribe(onLoadPurchaseOrderClose);
		lov.show();
	}else{
		alert("Sorry... You Cannot Load purchase order in Edit Mode");
	}
}
function onLoadPurchaseOrderClose(e,args){	
	let branch=screenObjects.getScreenObject("branch");
	branch.focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/grn/purchaseorder","orderno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	grnscreen.loadData(r);
	screenObjects.getScreenObject('suppname').setEnabled(false);
	let t=screenObjects.getScreenObject("invoice_data");
	//let cols=t.getCols();
	let rows=t.getSize();
	for(let i=0;i<rows-1;i++){		
		calculateAmount(i);
	}
	calculateTotal();
	hideLoader();
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
function validateInvoiceAmount(){
	let rtnValue=true;
	let netAmt=screenObjects.getScreenObject("totalamt").getValue();
	let invAmt=screenObjects.getScreenObject("invamt").getValue();
	if(toNumber(netAmt)!=toNumber(invAmt)){
		alert("Invoice Amount and Net Amount not Tally. Please check Entry.....");
		screenObjects.getScreenObject("invamt").focus();
		rtnValue=false;
	}
	return rtnValue;
}
function onEscClose(){	
	add('','');
}