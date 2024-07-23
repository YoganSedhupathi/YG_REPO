function fetchCustomer(id,me){
	if(!soscreen.getSaveInProgress()){
		let v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=checkcustomer&mobileno="+me.getValue());
		if(v!=null && v.data!=null && v.data.length>0){
			screenObjects.getScreenObject("custname").setTag(v.data[0][0]);
			screenObjects.getScreenObject("custname").setValue(v.data[0][1]);
			screenObjects.getScreenObject("address1").setValue(v.data[0][3]);
			screenObjects.getScreenObject("address2").setValue(v.data[0][4]);
			screenObjects.getScreenObject("city").setValue(v.data[0][5]);
			screenObjects.getScreenObject("pincode").setValue(v.data[0][6]);
			screenObjects.getScreenObject("creditdays").setValue(v.data[0][7]);
			screenObjects.getScreenObject("name").setValue(v.data[0][1]);
		}
	}
	return true;
}
function getAttributeDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("order_data").getCols();
	if(me.getCellTag(row,cols.product)!="" && toNumber(me.getText(row,cols.rate))==0 && !soscreen.getSaveInProgress()){
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
	let totalCdisc=0;
	let t=screenObjects.getScreenObject("order_data");
	let cols=t.getCols();
	let s=t.getSize();
	for(let i=0;i<s;i++){
		total+=toNumber(t.getText(i,cols.amount));
		totalTax+=toNumber(t.getText(i,cols.staxamt));
		totalServiceTax+=toNumber(t.getText(i,cols.srtaxamt));
		totalDisc+=toNumber(t.getText(i,cols.discamt));
		netTotal+=toNumber(t.getText(i,cols.netamount));
		totalCdisc+=toNumber(t.getText(i,cols.cashdiscamt));
	}
	screenObjects.getScreenObject("total").setValue(roundOff(total,2));
	screenObjects.getScreenObject("taxamt").setValue(roundOff(totalTax,2));
	screenObjects.getScreenObject("servtaxamt").setValue(roundOff(totalServiceTax,2));
	screenObjects.getScreenObject("discamt").setValue(roundOff(totalDisc,2));
	let pf=toNumber(screenObjects.getScreenObject("pf").getValue());
	netTotal+=pf;
	netTotal=Math.round(netTotal);
	screenObjects.getScreenObject("totalamt").setValue(roundOff(netTotal,2));
	screenObjects.getScreenObject("cdiscamt").setValue(roundOff(totalCdisc,2));
	$("#gross").html(roundOff(total,2));
	$("#totamt").html(roundOff(total,2));
	$("#vat").html(roundOff(totalTax,2));
	$("#disc").html(roundOff(totalDisc,2));
	$("#netAmt").html(""+roundOff(netTotal,2));
}
function calculateAmount(row){
	let t=screenObjects.getScreenObject("order_data");
	let cols=t.getCols();	
	let baseqty=0;
	baseqty=toNumber(t.getText(row,cols.conversionvalue))*toNumber(t.getText(row,cols.quantity));
	t.setText(row,cols.basequantity,baseqty);
	let amt=roundOff(toNumber(t.getText(row,cols.rate))*baseqty,2);
	let tax=0;
	let servTax=0;
	let netAmt=0;
	let taxableamt=((amt / (100 + toNumber(t.getText(row,cols.staxperc)))) * 100);	
	if(toNumber(t.getText(row,cols.taxincl))==0){
		taxableamt=amt;
	}
	let disc=roundOff(taxableamt*toNumber(t.getText(row,cols.discperc))/100,2);
	taxableamt-=disc;	
	let cashdisc=roundOff(taxableamt*toNumber(t.getText(row,cols.cashdiscperc))/100,2);
	taxableamt-=cashdisc;
	tax=roundOff(taxableamt*toNumber(t.getText(row,cols.staxperc))/100,2);
	vfv=roundOff(taxableamt*toNumber(t.getText(row,cols.srtaxperc))/100,2);
	netAmt=roundOff(taxableamt+toNumber(servTax)+toNumber(tax),2);
	t.setText(row,cols.staxamt,tax);
	t.setText(row,cols.srtaxamt,servTax);
	t.setText(row,cols.discamt,roundOff(disc,2));
	t.setText(row,cols.cashdiscamt,roundOff(cashdisc,2));
	t.setText(row,cols.amount,amt);
	t.setText(row,cols.netamount,netAmt);
	t.setText(row,cols.taxableamt,roundOff(taxableamt,2));
}    
 function calculateCashDiscount(id,me){
	let t=screenObjects.getScreenObject("order_data");
	let cashdiscperc=screenObjects.getScreenObject("cdisc");
	let cols=t.getCols();
	let s=t.getSize();
	for(let i=0;i<s;i++){
		t.setText(i,cols.cashdiscperc,cashdiscperc.getValue());
		calculateAmount(i);
	}
	calculateTotal();
}  
  
function save(id,me){
	let tenderOptions={};
	tenderOptions.cash=true;
	tenderOptions.credit=false;
	tenderOptions.coupon=true;
	tenderOptions.creditcard=true;
	tenderOptions.cheque=false;
	let netamt=toNumber(screenObjects.getScreenObject("totalamt").getValue());
	let advamt=toNumber(screenObjects.getScreenObject("advanceamt").getValue());
	if(screenObjects.getScreenObject("custname").getValue()!=''){
		tenderOptions.cheque=true;
	}
	
	let d=soscreen.processDataToSave();
		if("FAILED"!=d){
			showTenderDialog(tenderOptions,'tenderdlg',netamt,false,advamt);
		}
	/*let d=soscreen.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		let r=s.callAjax("POST","/inventory/service/invoice",d);
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.orderno+"]");
			soscreen.clearScreen();
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);		
		}
	return 0;
	}*/
}

function onTenderDialogOk(values){
	if(soscreen.getSaveInProgress()) return;
	let s=',"tender":'+JSON.stringify(values);
	
	// screenObjects.getScreenObject("ordertype").setValue(values.billType);
	// if(values.billType=="" | values.billType.length==0 ){  																			
	// 	alert("Please fill in the Tender Correctly and continue");
	// 	return;	
	// }
	// else if((values.billType=="CA" | values.billType=="CC" | values.billType=="CR" )& values.cashamount =="values.cashamount"){
	// 	alert("Please fill in the Tender Correctly and continue ");
	// 	return;	
	// }
	
	// if(toNumber(toNumber(screenObjects.getScreenObject("advanceamt").getValue())+values.cashamount)+toNumber(values.creditamount)+toNumber(values.ccamount)+toNumber(values.couponamount)+toNumber(values.chequeamount)<toNumber(screenObjects.getScreenObject("totalamt").getValue())){
	// 	console.log(toNumber(screenObjects.getScreenObject("advanceamt").getValue()));
	// 	alert("Please fill in the Tender Correctly and continue ");
	// 	return;
	// }

	if(values.cashamount =="values.cashamount" ){  																			
		alert("Please fill in the Tender Correctly and continue /CASH");
		return;	
	}

	let d=soscreen.processDataToSave(s);
	soscreen.setSaveInProgress(true);
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/salesorder",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.orderno+"]");
			soscreen.clearScreen();
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);	
			soscreen.setSaveInProgress(false);
			screenObjects.getScreenObject("order_data").getInputField().focus();	
		}
	return 0;
	}
}
function savePrint(id,me){
	let key="1";
	save(id,me);
	if(key!="0"){
		printSale(key);
	}
}
function delete1(id,me){
	soscreen.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"salesorder",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	
function add(id,me){
	soscreen.clearScreen();
	setDefaultBranch();
	soscreen.setOperation("ADD");
	screenObjects.getScreenObject("custname").focus();
}
function edit(id,me){
	soscreen.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"salesorder",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	screenObjects.getScreenObject("custname").focus();
	let branch=screenObjects.getScreenObject("branch");
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/salesorder","billno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	soscreen.setOperation("EDIT");
	soscreen.loadData(r);
	$('#tenderdlg').data('tdata',r.tender);
	calculateTotal();
	hideLoader();
}
function loadDataView(no){	
	screenObjects.getScreenObject("custname").focus();
	let branch=screenObjects.getScreenObject("branch");
	let a=new FlexUI.Ajax();
	showLoader();
	console.log("salesorder"+no);
	let r=a.callAjax("GET","/inventory/service/salesorder","billno="+no+"&branch="+branch.getTag());
	soscreen.disableInputs(true);
	soscreen.loadData(r);
	$('#tenderdlg').data('tdata',r.tender);
	calculateTotal();
	hideLoader();
}
function printSales(e,args){
	let n=screenObjects.getScreenObject("code").getValue();
	printSale(n);
}
function printSale(code){
	window.open("salesprint.html?billno="+code);
}
function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("order_data").getCols();
	let branch=screenObjects.getScreenObject("branch");
	let location=screenObjects.getScreenObject("location");
	let v=null;
		if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=stock&branch="+branch.getTag()+"&location="+location.getTag()+"&pmcode="+me.getCellTag(row,col)+"&udw="+me.getRelatedValues(row,col).condition);
	}else{
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=stock&branch="+branch.getTag()+"&location="+location.getTag()+"&pmcode="+me.getCellTag(row,col));
	}
	if(v!=null){
		if(v.data && v.data.length==1){
			setBatchInfo(v.data[0]);
			return true;
		}else if(v.data && v.data.length>1){
			let d=null;
			if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
				d={url:"/inventory/service/ajax?udw="+me.getRelatedValues(row,col).condition,ajax:"stock",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"order_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			}else{
				d={url:"/inventory/service/ajax",ajax:"stock",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"order_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
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
function setDefaultBranch(){
	let branch=screenObjects.getScreenObject("branch");
	let location=screenObjects.getScreenObject("location");
	branch.setTag(defbranch[0][1]);
	branch.setValue(defbranch[0][0]);
	location.setTag(defbranch[0][3]);
	location.setValue(defbranch[0][2]);	
	screenObjects.getScreenObject("custname").focus();	
}
function onStockClose(e,args){
	setBatchInfo(args.result);
	screenObjects.getScreenObject("order_data").checkAndMove('Next',false);
}
function setBatchInfo(result){
	let products=screenObjects.getScreenObject("order_data");
	let cols=products.getCols();
	
	products.setCurrentRowText(cols.csdid,result[0]);
	products.setCurrentRowText(cols.batchno,result[1]);
	products.setCurrentRowText(cols.expdt,result[2]);
	products.setCurrentRowText(cols.rate,result[3]);
	products.setCurrentRowText(cols.stock,result[5]);
	products.setCurrentRowText(cols.batchdt,result[6]);	
	products.setCurrentRowText(cols.attribid,result[7]);
}
function setRateDetails(me,cols,v){
	me.setCurrentRowText(cols.rate,v.data[0][3]);
	me.setCurrentRowText(cols.csdid,0);
	me.setCurrentRowText(cols.batchno,0);
	me.setCurrentRowText(cols.expdt,"01/04/2012");
	me.setCurrentRowText(cols.stock,0);
	me.setCurrentRowText(cols.batchdt,0);
	me.setCurrentRowText(cols.attribid,0);
}

function closeScreen(){
		// $('#rep').show();
		// $('#filter').css("display","block");
		// $('#dtfilter').css("display","block");
		// $('#brdCr').css("display","block");
		// $('#maincontent').empty();

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