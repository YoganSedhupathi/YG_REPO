var doitHospAttachedForPharmacy=false;
var discountBeforeTax=false;
var salesCreditCardCharges=2;
function fetchCustomer(id,me){
	if(!invscreen.getSaveInProgress()){
		let v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=checkcustomer&mobileno="+me.getValue());
		if(v!=null && v.data!=null && v.data.length>0){
			screenObjects.getScreenObject("custname").setTag(v.data[0][0]);
			screenObjects.getScreenObject("custname").setValue(v.data[0][1]);
			screenObjects.getScreenObject("address1").setValue(v.data[0][3]);
			screenObjects.getScreenObject("address2").setValue(v.data[0][4]);
			screenObjects.getScreenObject("city").setValue(v.data[0][5]);
			screenObjects.getScreenObject("pincode").setValue(v.data[0][6]);
			screenObjects.getScreenObject("creditdays").setValue(v.data[0][7]);
			screenObjects.getScreenObject("showcreditdays").setValue(v.data[0][7]);
			screenObjects.getScreenObject("name").setValue(v.data[0][1]);
			screenObjects.getScreenObject("address").setValue(v.data[0][3]+", "+v.data[0][4]+", "+v.data[0][5]+", "+v.data[0][6]);
		}
	}
	return true;
}
function validateCustName(id,me){
	let custName=screenObjects.getScreenObject("custname");
	let custTempName=screenObjects.getScreenObject("name");
	if(custName.getValue()=="" && doitHospAttachedForPharmacy){
		return false;
	}else{
		
		custTempName.setValue(custName.getValue());
	}
	return true;
}
function validateCustType(id,me){
    let custName=screenObjects.getScreenObject("custname");
    let custAlias=screenObjects.getScreenObject("custalias");
	if(me.getValue()!=0){
		custAlias.getLovOptions().ajax="customerbytype";
		custName.getLovOptions().ajax="customerbytype";
	}else{
		custName.getLovOptions().ajax="customer";
		custAlias.getLovOptions().ajax="customer";				
	}
	if(!doitHospAttachedForPharmacy){
		if(me.getValue()==1){
			custName.setEnabled(true);
			custAlias.setEnabled(false);
			me.setNextFocus("custname");
			custName.setMandatory(true);
			custAlias.setMandatory(false);
		}else if(me.getValue()==2 || me.getValue()==3){
			custName.setEnabled(false);
			custAlias.setEnabled(true);
			me.setNextFocus("custalias");
			custAlias.setMandatory(true);
			custName.setMandatory(false);	
		}
	}
	return true;
}
function validateCustomerAlias(id,me){
	if(!invscreen.getSaveInProgress()){
		return loadSalesOrderForCustomer();		
	}
	return true;
}
function getAttributeDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	console.log("JsonJ"+ JSON.stringify(cols));
	if(me.getCellTag(row,cols.product)!="" && toNumber(me.getText(row,cols.selling))==0 && !invscreen.getSaveInProgress()){
	
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
	let netTotal=0;
	let totalServiceTax=0;
	let totalDisc=0;
	let totalCdisc=0;
	let t=screenObjects.getScreenObject("invoice_data");
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
	screenObjects.getScreenObject("roundedoff").setValue(roundOff(Math.round(roundOff(netTotal,2))-roundOff(netTotal,2),2));
	let roundedOff=toNumber(screenObjects.getScreenObject("roundedoff").getValue());
	netTotal+=roundedOff;
	screenObjects.getScreenObject("totalamt").setValue(roundOff(netTotal,2));
	screenObjects.getScreenObject("cdiscamt").setValue(roundOff(totalCdisc,2));	
	$("#gross").html(roundOff(total,2));
	$("#vat").html(roundOff(totalTax,2));
	$("#disc").html(roundOff(totalDisc,2));
	$("#netAmt").html(""+roundOff(netTotal,2));
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
	let taxableamt=0;
	let disc=0;
	let cashdisc=0;
	//debugger
	if(toNumber(t.getText(row,cols.taxincl))==0){
		discountBeforeTax=true;
	}
	if(discountBeforeTax){
		taxableamt=((amt / (100 + toNumber(t.getText(row,cols.staxperc)))) * 100);	
		if(toNumber(t.getText(row,cols.taxincl))==0){
			taxableamt=amt;
		}
		disc=roundOff(taxableamt*toNumber(t.getText(row,cols.discperc))/100,2);
		taxableamt-=disc;	
		cashdisc=roundOff(taxableamt*toNumber(t.getText(row,cols.cashdiscperc))/100,2);
		taxableamt-=cashdisc;	
	}else{
		let ttaxableamt=0;
		disc=roundOff(Number(amt)*toNumber(t.getText(row,cols.discperc))/100,2);
		ttaxableamt=Number(amt)-Number(disc);
		cashdisc=roundOff(ttaxableamt*toNumber(t.getText(row,cols.cashdiscperc))/100,2);
		ttaxableamt=ttaxableamt-Number(cashdisc);
		taxableamt=((ttaxableamt / (100 + toNumber(t.getText(row,cols.staxperc)))) * 100);
	}
	tax=roundOff(taxableamt*toNumber(t.getText(row,cols.staxperc))/100,2);
	servTax=roundOff(taxableamt*toNumber(t.getText(row,cols.srtaxperc))/100,2);
	netAmt=roundOff(taxableamt+toNumber(servTax)+toNumber(tax),2) ;
	if(toNumber(t.getText(row,cols.taxincl)) == 1 && disc == 0 && servTax == 0 && cashdisc == 0){	
		if((toNumber(roundOff(taxableamt,2))+toNumber(tax))>amt){
			taxableamt-=(toNumber(roundOff(taxableamt,2))+toNumber(tax)-amt);
			netAmt=amt;
		}else if((toNumber(roundOff(taxableamt,2))+toNumber(tax))<amt){
			taxableamt+=(amt-toNumber(roundOff(taxableamt,2))+toNumber(tax));
			netAmt=amt;
		}
	}
	t.setText(row,cols.staxamt,tax);
	t.setText(row,cols.srtaxamt,servTax);
	t.setText(row,cols.discamt,roundOff(disc,2));
	t.setText(row,cols.cashdiscamt,roundOff(cashdisc,2));
	t.setText(row,cols.amount,amt);
	t.setText(row,cols.netamount,netAmt);
	t.setText(row,cols.taxableamt,roundOff(taxableamt,2));
}   
function calculateCashDiscount(id,me){
	let t=screenObjects.getScreenObject("invoice_data");
	let cashdiscperc=screenObjects.getScreenObject("cdisc");
	//let pf=screenObjects.getScreenObject("pf").getValue();
	let cols=t.getCols();
	let s=t.getSize();
	for(let i=0;i<s;i++){
		t.setText(i,cols.cashdiscperc,cashdiscperc.getValue());
		calculateAmount(i);
	}
	calculateTotal();
}  
function tableTextKeyDown(e,args){
	let key=e.which || e.keyCode;
	if(key==113){
		save();
		e.preventDefault();
	}
}
function save(id,me){
	// 
	 calculateTotal();
    //let orderType=screenObjects.getScreenObject("ordertype").getValue();
    let custType=screenObjects.getScreenObject("custtype").getValue();
    //let custAlias=screenObjects.getScreenObject("custalias").getValue();
    let custCode=screenObjects.getScreenObject("custname").getTag();
	//if(!doitHospAttachedForPharmacy || (orderType!="SO" || orderType=="SO")){//&& custType!="2" && custType!="3" || (orderType!="SO"
		let tenderOptions={};
		tenderOptions.cash=true;
		tenderOptions.credit=false;
		if(custCode!="" && custCode!="0" && custCode!=undefined ){//&& custType=="2"
			tenderOptions.credit=true;
		}
		tenderOptions.coupon=false;
		tenderOptions.sponsor=true;
		tenderOptions.creditcard=true;
		tenderOptions.cheque=false;
		tenderOptions.discount=true;
		let netamt=toNumber(screenObjects.getScreenObject("totalamt").getValue());
		let advamt=toNumber(screenObjects.getScreenObject("advanceamt").getValue());
		/*if(screenObjects.getScreenObject("custname").getValue()!=''){
			tenderOptions.credit=true;
			tenderOptions.cheque=true;
		}*/
		let d=invscreen.processDataToSave();
		if("FAILED"!=d){
			showTenderDialog(tenderOptions,'tenderdlg',netamt,true,advamt);
		}
		
	/*}else{
		let values={};
		values.cashamount="0";
		values.ccamount="0";
		values.cardcharges="0";
		values.cardtender="0";
		values.couponamount="0";
		values.chequeamount="0";
		values.cardmachine="0";
		values.creditamount=screenObjects.getScreenObject("totalamt").getValue();
		values.totalamount=screenObjects.getScreenObject("totalamt").getValue();
		values.tendered="0";
		values.balance="0";
		values.billType="CR";
		onTenderDialogOk(values);
	}*/
	
	/*let d=invscreen.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		let r=s.callAjax("POST","/inventory/service/invoice",d);
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			invscreen.clearScreen();
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);		
		}
	return 0;
	}*/
}

function onTenderDialogOk(values)
{
	if(invscreen.getSaveInProgress()) return;	
	let s=',"tender":'+JSON.stringify(values);
	screenObjects.getScreenObject("billtype").setValue(values.billType);
	if( values.cashamount =="values.cashamount" ){
		alert("Please fill in the Tender Correctly and continue /CASH");
		return;	
	}
	if(toNumber(toNumber(screenObjects.getScreenObject("advanceamt").getValue())+values.cashamount)+toNumber(values.creditamount)+toNumber(values.ccamount)+toNumber(values.couponamount)+toNumber(values.chequeamount)<toNumber(screenObjects.getScreenObject("totalamt").getValue())){
		console.log(toNumber(screenObjects.getScreenObject("advanceamt").getValue()));
		alert("Please fill in the Tender Correctly and continue ");
		return;
	}

	// if( ( toNumber(values.cashamount)+toNumber(values.creditamount)+toNumber(values.ccamount)+toNumber(values.couponamount)+toNumber(values.chequeamount) )  > ( toNumber(screenObjects.getScreenObject("totalamt").getValue()) -  toNumber(screenObjects.getScreenObject("advanceamt").getValue()))  )
	// {
	// 	alert("Please Enter the Bill Amount Correctly and Continue  ");
	// 	return;
	// }
	
	let d=invscreen.processDataToSave(s);
	invscreen.setSaveInProgress(true);
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/invoice",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			let ps=JSON.parse(d.replace("data=","")).savedata;
			ps["billno"]=r.billno;
			if(window.confirm("Do you want to print the bill?")){
				printSale(ps);
			}
			add('','');
			return r.key;			
		}else{
			alert(r.message);
			invscreen.setSaveInProgress(false);
			screenObjects.getScreenObject("invoice_data").getInputField().focus();		
		}
	return 0;
	}else{
		invscreen.setSaveInProgress(false);
	}
}
function savePrint(id,me){
	let key=1; // save(id,me);
	save(id,me);
	if(key!="0"){
		printSale(key);
	}
}
function delete1(id,me){
	invscreen.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"invoice",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	

function add(id,me){
	invscreen.clearScreen();
	invscreen.setSaveInProgress(false);
	setDefaultBranch();
	invscreen.setOperation("ADD");
	screenObjects.getScreenObject(invscreen.getInitialFocus()).setEnabled(true);
	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	if(doitHospAttachedForPharmacy){
		screenObjects.getScreenObject("custname").setEnabled(false);
		screenObjects.getScreenObject("custalias").setEnabled(false);
	}else{
		screenObjects.getScreenObject("custname").setEnabled(true);
		screenObjects.getScreenObject("custalias").setEnabled(false);			
	}
	$('#appid').val("0");
	$('#tenderdlg').removeData('tdata');
}

function edit(id,me){
	invscreen.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"invoice",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	let branch=screenObjects.getScreenObject("branch");
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/invoice","billno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	if(doitHospAttachedForPharmacy){
		screenObjects.getScreenObject("custtype").setEnabled(false);
		screenObjects.getScreenObject("custname").setEnabled(false);
		screenObjects.getScreenObject("custalias").setEnabled(true);
		screenObjects.getScreenObject("billdate").setEnabled(false);
		screenObjects.getScreenObject("professional").setEnabled(true);
		screenObjects.getScreenObject("professional").focus();
	}else{	
		screenObjects.getScreenObject("custname").setEnabled(true);
		screenObjects.getScreenObject("custalias").setEnabled(true);
	}	
	invscreen.setOperation("EDIT");
	invscreen.loadData(r);
	$('#tenderdlg').data('tdata',r.tender);
	calculateTotal();
	hideLoader();
}
function onEscClose(){	
	add('','');
}
function loadDataView(no){	
	
	console.log("load bill no="+ no);
	$('#spnSetting').css("display","none");
	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	let branch=screenObjects.getScreenObject("branch")
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/invoice","billno="+no+"&branch="+branch.getTag());
	invscreen.disableInputs(true);
	invscreen.loadData(r);
	$('#tenderdlg').data('tdata',r.tender);
	calculateTotal();
	hideLoader();
}
function printSales(e,args){
	let n=screenObjects.getScreenObject("code").getValue();
	printSale(n);
}
function printSale(data){
		
		let t=screenObjects.getScreenObject("invoice_data");
		let cols=t.getCols();
		let printData={};
		printData["billType"]=data.tender["billType"];
		printData["type"]="PGSH";
		printData["branchcode"]=data["branch"];
		printData["company"]="Tiruletur Medical Center(P) Ltd";
		printData["address1"]="27,Javulikara Street";
		printData["address2"]="Tiruletur - 610 001";
		printData["address3"]="Phone - 242292,240292";
		printData["tin"]="";
		printData["billno"]=data["billno"];
		printData["billdate"]=data["billdate"] ;
		printData["tax"]=data["taxamt"];
		printData["totalamt"]=data["totalamt"]+"";
		printData["cardcharges"]=data["tender"].cardcharges+"";
		printData["tendered"]=data["tender"].tendered+"";
		printData["balance"]=data["tender"].balance+"";
		printData["roundoff"]=data["roundedoff"]+"";
		printData["doctorname"]=data["professional"]+"";
		printData["custalias"]=data["custalias"]+"";
		printData["despthro"]=data["despthro"]+"";
		printData["total"]=data["total"]+"";		
		printData["cdiscamt"]=data["cdiscamt"]+"";
		printData["cdisc"]=data["cdisc"]+"";
		printData["customer"]=data.name;
		printData["printtax"]="1";
		printData["printdisc"]="1";
		printData["printround"]="1";
		printData["printcardchg"]="1";
		if(printData["billType"]=="CR"){		
			printData["invtype"]="CREDIT";
		}else if(data.billType=="CO"){
			printData["invtype"]="CORPORATE";
		}else{
			printData["invtype"]="TAX";
		}
		printData["userid"]=userName;
		printData["items"]=[];
		for(let x=0;x<data["invoice_data"].v.length;x++){
			let item={};
			item.name=t.getText(x,cols.product);
			item.rate=data["invoice_data"].v[x][cols.rate]+"";
			item.qty=data["invoice_data"].v[x][cols.quantity]+"";
			item.batch=data["invoice_data"].v[x][cols.batchno]+"";
			item.expdt=data["invoice_data"].v[x][cols.expdt]+"";
			item.amount=data["invoice_data"].v[x][cols.netamount]+"";				
			item.totalamount=data["invoice_data"].v[x][cols.amount]+"";
			item.taxableamt=data["invoice_data"].v[x][cols.taxableamt]+"";
			item.staxamt=data["invoice_data"].v[x][cols.staxamt]+"";
			item.staxperc=data["invoice_data"].v[x][cols.staxperc]+"";
			item.discamt=data["invoice_data"].v[x][cols.discamt]+"";
			item.cashdiscamt=data["invoice_data"].v[x][cols.cashdiscamt]+"";
			item.hsncode=data["invoice_data"].v[x][cols.hsncode]+"";
			printData.items.push(item);
		}
		$.ajax({
            url: "http://localhost:9696",
            type: "POST",
            async: true,
            contentType:"application/x-www-form-urlencoded",
            data:"printdata="+JSON.stringify(printData),
            dataType: "json",
            success: function (r) {
				//alert(r.result);		
            }
        });		
}
function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	let branch=screenObjects.getScreenObject("branch");
	let location=screenObjects.getScreenObject("location");
	let v=null;
	if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
	
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=stock&branch="+branch.getTag()+"&location="+location.getTag()+"&pmcode="+me.getCellTag(row,col)+"&udw="+me.getRelatedValues(row,col).condition);
	}else{
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=stock&branch="+branch.getTag()+"&location="+location.getTag()+"&pmcode="+me.getCellTag(row,col));
	}
	if(v!=null){
		/*if(v.data && v.data.length==1){
			setBatchInfo(v.data[0]);
			return true;
		}else if(v.data && v.data.length>1){*/
		if(v.data ){			
			let d=null;
			if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
				d={url:"/inventory/service/ajax?udw="+me.getRelatedValues(row,col).condition,ajax:"stockonly",scrollEnabled:true,searchFromList:false,autoLoad:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"invoice_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			}else{
				d={url:"/inventory/service/ajax",ajax:"stockonly",scrollEnabled:true,searchFromList:false,autoLoad:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"invoice_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			
			}
			let lov=new FlexUI.LOV("s_lov",me,d,v.data,);
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
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	if(me.getCellTag(row,cols.product)!=""){
		if(toNumber(me.getText(row,cols.serialized))==1 && me.getCellPopup(row,col)){
			invokeSerialDialog(me,row,col,"productserial",me.getInputField(),toNumber(me.getText(row,col))+toNumber(me.getText(row,cols.quantity)),true);
			return false;				
		}
	}	
	return validateStock(id,me,row,col);
}
function setDefaultBranch(){
	let branch=screenObjects.getScreenObject("branch");
	let location=screenObjects.getScreenObject("location");
	branch.setTag(defbranch[0][1]);
	branch.setValue(defbranch[0][0]);
	location.setTag(defbranch[0][3]);
	location.setValue(defbranch[0][2]);	

	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	if(doitHospAttachedForPharmacy){
		screenObjects.getScreenObject("custname").setEnabled(false);
		screenObjects.getScreenObject("custalias").setEnabled(true);
	}else{
		screenObjects.getScreenObject("custname").setEnabled(true);
		screenObjects.getScreenObject("custalias").setEnabled(false);			
	}
}
function onStockClose(e,args){
	setBatchInfo(args.result);
	screenObjects.getScreenObject("invoice_data").checkAndMove('Next',false);
}
function setBatchInfo(result){
	let products=screenObjects.getScreenObject("invoice_data");
	let cols=products.getCols();
	 
	products.setCurrentRowText(cols.csdid,result[0]);
	products.setCurrentRowText(cols.batchno,result[1]);
	products.setCurrentRowText(cols.expdt,result[2]);
	products.setCurrentRowText(cols.rate,result[3]);
	products.setCurrentRowText(cols.stock,result[5]);
	products.setCurrentRowText(cols.batchdt,result[6]);
	products.setCurrentRowText(cols.selling,result[3]);	
	products.setCurrentRowText(cols.attribid,result[7]);	
}
function setRateDetails(me,cols,v){
	me.setCurrentRowText(cols.csdid,0);
	me.setCurrentRowText(cols.batchno,0);
	me.setCurrentRowText(cols.expdt,"01/04/2012");
	me.setCurrentRowText(cols.rate,v.data[0][3]);
	me.setCurrentRowText(cols.stock,0);
	me.setCurrentRowText(cols.batchdt,0);
	me.setCurrentRowText(cols.selling,v.data[0][3]);
	me.setCurrentRowText(cols.attribid,0);
}

function loadServiceOrder(id,me){
	invscreen.setOperation("ADD");	
	let l={url:"/inventory/service/ajax",ajax:"serviceorders",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"sono",id:"0",tt:false}]};
	let lov=new FlexUI.LOV("so_lov",me,l);
	lov.onLovClose.subscribe(onLoadServiceOrderClose);
	lov.show();
}
function onLoadServiceOrderClose(e,args){	
	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	let branch=screenObjects.getScreenObject("branch");
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/invoice/serviceorder","orderno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	invscreen.loadData(r);
	let t=screenObjects.getScreenObject("invoice_data");
	//let cols=t.getCols();
	let rows=t.getSize();
	for(let i=0;i<rows-1;i++){		
		calculateAmount(i);
	}
	calculateTotal();
	hideLoader();
}
function loadSalesOrder(id,me){
	let op=invscreen.getOperation();
	if(op=="ADD"){
		let l={url:"/inventory/service/ajax",ajax:"salesorders",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"sono",id:"0",tt:false}]};
		let lov=new FlexUI.LOV("so_lov",me,l);
		lov.onLovClose.subscribe(onLoadSalesOrderClose);
		lov.show();
	}else{
		alert("Sorry... You Cannot Load Sales Order in Edit Mode");
	}
}
function loadSalesOrderForCustomer(id,me){
	
	let op=invscreen.getOperation();
	if(op=="ADD"){
		let l={url:"/inventory/service/ajax",ajax:"custsalesorders",closeOnNoData:true,scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"custcode",src:"custname",ft:true}],results:[{tgt:"sono",id:"0",tt:false}]};
		let lov=new FlexUI.LOV("so_lov",me,l);
		lov.onLovClose.subscribe(onLoadSalesOrderClose);
		let s=lov.show();
		return !s;
	}else{
		alert("Sorry... You Cannot Load Sales Order in Edit Mode");
		return true;		
	}
}
function onLoadSalesOrderClose(e,args){	

	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	let branch=screenObjects.getScreenObject("branch");	
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/invoice/salesorder","orderno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	console.log(r);
	invscreen.loadData(r);

	screenObjects.getScreenObject(invscreen.getInitialFocus()).setEnabled(false);
	screenObjects.getScreenObject("custname").setEnabled(false);
	screenObjects.getScreenObject("custalias").setEnabled(true);
	screenObjects.getScreenObject("billdate").focus();

	let cus_type =toNumber(screenObjects.getScreenObject("custtype").getValue());	
	if (cus_type==0){
		screenObjects.getScreenObject("custtype").setValue(1);
		screenObjects.getScreenObject("custalias").setValue("");	
		screenObjects.getScreenObject("custalias").setEnabled(false);
	}

	let t=screenObjects.getScreenObject("invoice_data");
	// let cols=t.getCols();
	let rows=t.getSize();
	for(let i=0;i<rows-1;i++){		
		calculateAmount(i);
	}
	calculateTotal();
	$('#appid').val(r.appid.v);
	hideLoader();
	if(r.appid.v!="0"){
		showPrescription();
	}
}
function printInvoice(){
	printPDF();
}

function printPDF() {
          let applet = document.jzebra;
      	    if (applet != null) {
               applet.findPrinter("\\{dummy printer name for listing\\}");
               while (!applet.isDoneFinding()) {
                    // Note, enless while loops are bad practice.
                    // Create a JavaScript function called "jzebraDoneFinding()"
                    // instead and handle your next steps there.
               }

               // Sample only: If a PDF printer isn't installed, try the Microsoft XPS Document
               // Writer.  Replace this with your printer name.
               let printers = applet.getPrinters().split(",");
               for (let i in printers) {
		    if (printers[i].indexOf("Microsoft XPS") != -1 || 
			printers[i].indexOf("PDF") != -1) {
			   applet.setPrinter(i);      
		    }	       
               }
               
               // No suitable printer found, exit
               if (applet.getPrinter() == null) {
                   alert("Could not find a suitable printer for a PDF document");
                   return;
               }
               
               // Append our pdf (only one pdf can be appended per print)
	       applet.appendPDF("http://localhost:8080/inventory/pdf_sample.pdf");
	    }

            // Very important for PDF, uses printPS() instead of print()
            // *Note:  monitorAppending2() still works but is too complicated and
            // outdated.  Instead create a JavaScript  function called 
            // "jzebraDoneAppending()" and handle your next steps there.
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
function checkBarCode(id,me,row,col){
	let invtable=screenObjects.getScreenObject("invoice_data");
	let cols=invtable.getCols();
	let branch=screenObjects.getScreenObject("branch");
	if(me.getText(row,cols.product)!="" && toNumber(me.getCellTag(row,cols.product))==0 && !invscreen.getSaveInProgress()){
		let result=null;
		let v=null;
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=barcodeproduct&branch="+branch.getTag()+"&product="+me.getText(row,col));
		result=v.data[0];
		//a.pm_name,a.pm_code,a.pm_pg_code,a.pm_batch,a.pm_expiry,b.ptc_stax,b.ptc_ptax,b.ptc_inclusive,a.pm_ugm_id,a.pm_purchaseunit,
		//um.um_name,a.pm_transferunit,a.pm_saleunit,cm.cm_conv_value,a.pm_unit from 
	 
		invtable.setCurrentRowText(cols.product,result[0]);
		invtable.setCellTag(row,cols.product,result[1]);
		invtable.setCurrentRowText(cols.staxperc,result[5]);
		invtable.setCurrentRowText(cols.taxincl,result[7]);
		invtable.setCurrentRowText(cols.unitgroup,result[8]);
		invtable.setCurrentRowText(cols.unitname,result[10]);
		invtable.setCurrentRowText(cols.unitid,result[12]);
		invtable.setCurrentRowText(cols.conversionvalue,result[13]);
		invtable.setCurrentRowText(cols.unit,result[14]);
	
	
	}
	return true;
}
function validateStock(id,me,row,col){
	let cols=screenObjects.getScreenObject("invoice_data").getCols();
	let stock=me.getText(row,cols.stock);
	let qty=me.getText(row,cols.basequantity);
	let free=toNumber(me.getText(row,cols.freeqty))*toNumber(me.getText(row,cols.conversionvalue));
	let negativestock=me.getText(row,cols.allownegative);
	if(toNumber(negativestock)==0){
		if(toNumber(qty)+free>toNumber(stock)){
			alert("insufficient Stock");
			return false;
		}
	}
	return true;
}
function callDiscountCalc(inp,e){
	let cashdiscperc=screenObjects.getScreenObject("cdisc");
	let cashdiscamt=screenObjects.getScreenObject("cdiscamt");	
	cashdiscperc.setValue($(inp).val());	
	calculateCashDiscount();
	let netamt=toNumber(screenObjects.getScreenObject("totalamt").getValue());
	$('#tdiscamt').val(cashdiscamt.getValue());
	$('#tenderdlg').data('billamount',netamt);
	let advanceAmount=$('#tenderdlg').data('advanceamt');
	if(advanceAmount!=0){
		$('#billLabel').text("Bill Amount:"+roundOff(netamt,2)+" Advance Amount:"+roundOff(advanceAmount,2));
	}else{
		$('#billLabel').text("Bill Amount:"+roundOff(netamt,2));
	}		
	$('#tcashamt').val('');
	$('#creditamt').val('');
	$('#tcreditcardamt').val('');
	$('#creditcardamt').val('');
	$('#couponamt').val('');
	$('#chequeamt').val('');
	tenderCalculate($('#tcashamt'));
}






