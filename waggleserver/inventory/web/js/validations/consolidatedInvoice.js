var doitHospAttachedForPharmacy=true;
var discountBeforeTax=false;
var salesCreditCardCharges=2;
function fetchCustomer(id,me){
	if(!invscreen.getSaveInProgress()){
		var v=l.callAjax("GET","/Fruits/service/ajax","ic=0&id=checkcustomer&mobileno="+me.getValue());
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
	var custName=screenObjects.getScreenObject("custname");
	var custTempName=screenObjects.getScreenObject("name");
	if(custName.getValue()=="" && doitHospAttachedForPharmacy){
		return false;
	}else{
		custTempName.setValue(custName.getValue());
	}
	return true;
}
function validateCustType(id,me){
    var custName=screenObjects.getScreenObject("custname");
    var custAlias=screenObjects.getScreenObject("custalias");
	if(me.getValue()!=0){
		custAlias.getLovOptions().ajax="customerbytype";
		custName.getLovOptions().ajax="customerbytype";
	}else{
		custName.getLovOptions().ajax="customer";
		custAlias.getLovOptions().ajax="customer";				
	}
	if(doitHospAttachedForPharmacy){
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
	var cols=screenObjects.getScreenObject("invoice_data").getCols();
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
	var cols=me.getCols();
	if(col==cols.rate || col==cols.quantity){
		calculateAmount(row);
	}
	return true;
}
function onRateQuantityChange(id,me){
	var t=me.getParent();
	calculateAmount(t.getCurrentRow());
	calculateTotal();
	return true;
}

function onTaxChange(id,me){
	calculateTotal();
	return true;
}
function calculateTotal(){
	var total=0;
	var totalTax=0;
	var netTotal=0;
	var totalServiceTax=0;
	var totalDisc=0;
	var totalCdisc=0;
	var t=screenObjects.getScreenObject("invoice_data");
	var cols=t.getCols();
	var s=t.getSize();
	for(var i=0;i<s;i++){
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
	var pf=toNumber(screenObjects.getScreenObject("pf").getValue());
	netTotal+=pf;
	screenObjects.getScreenObject("roundedoff").setValue(roundOff(Math.round(roundOff(netTotal,2))-roundOff(netTotal,2),2));
	var roundedOff=toNumber(screenObjects.getScreenObject("roundedoff").getValue());
	netTotal+=roundedOff;
	screenObjects.getScreenObject("totalamt").setValue(roundOff(netTotal,2));
	screenObjects.getScreenObject("cdiscamt").setValue(roundOff(totalCdisc,2));
	
	
	$("#totamt").html(roundOff(total,2));
	$("#vat").html(roundOff(totalTax,2));
	$("#disc").html(roundOff(totalDisc,2));
	$("#netAmt").html("Net Amount   "+roundOff(netTotal,2));
}
function calculateAmount(row){
	var t=screenObjects.getScreenObject("invoice_data");
	var cols=t.getCols();	
	var baseqty=0;
	baseqty=toNumber(t.getText(row,cols.conversionvalue))*toNumber(t.getText(row,cols.quantity));
	t.setText(row,cols.basequantity,baseqty);
	var amt=roundOff(toNumber(t.getText(row,cols.rate))*baseqty,2);
	var tax=0;
	var netAmt=0;
	var servTax=0;
	var taxableamt=0;
	var disc=0;
	var cashdisc=0;
	//debugger
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
		var ttaxableamt=0;
		disc=roundOff(Number(amt)*toNumber(t.getText(row,cols.discperc))/100,2);
		ttaxableamt=Number(amt)-Number(disc);
		cashdisc=roundOff(ttaxableamt*toNumber(t.getText(row,cols.cashdiscperc))/100,2);
		ttaxableamt=ttaxableamt-Number(cashdisc);
		taxableamt=((ttaxableamt / (100 + toNumber(t.getText(row,cols.staxperc)))) * 100);
	}
	tax=roundOff(taxableamt*toNumber(t.getText(row,cols.staxperc))/100,2);
	servTax=roundOff(taxableamt*toNumber(t.getText(row,cols.srtaxperc))/100,2);
	netAmt=roundOff(taxableamt+toNumber(servTax)+toNumber(tax),2);
	if(toNumber(t.getText(row,cols.taxincl))==1 && disc==0 && servTax==0 && cashdisc==0){		
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
	var t=screenObjects.getScreenObject("invoice_data");
	var cashdiscperc=screenObjects.getScreenObject("cdisc");
	var pf=screenObjects.getScreenObject("pf").getValue();
	var cols=t.getCols();
	var s=t.getSize();
	for(var i=0;i<s;i++){
		t.setText(i,cols.cashdiscperc,cashdiscperc.getValue());
		calculateAmount(i);
	}
	calculateTotal();
}  
function tableTextKeyDown(e,args){
	var key=e.which || e.keyCode;
	if(key==113){
		save();
		e.preventDefault();
	}
}
function save(id,me){
	calculateTotal();
    var orderType=screenObjects.getScreenObject("ordertype").getValue();
    var custType=screenObjects.getScreenObject("custtype").getValue();
    var custAlias=screenObjects.getScreenObject("custalias").getValue();
    var custCode=screenObjects.getScreenObject("custname").getTag();
	//if(!doitHospAttachedForPharmacy || (orderType!="SO" || orderType=="SO")){//&& custType!="2" && custType!="3" || (orderType!="SO"
		var tenderOptions={};
		tenderOptions.cash=true;
		tenderOptions.credit=false;
		if(custCode!="" && custCode!="0" && custCode!=undefined && custType=="2"){
			tenderOptions.credit=true;
		}
		tenderOptions.coupon=false;
		tenderOptions.sponsor=true;
		tenderOptions.creditcard=true;
		tenderOptions.cheque=false;
		tenderOptions.discount=true;
		var netamt=toNumber(screenObjects.getScreenObject("totalamt").getValue());
		var advamt=toNumber(screenObjects.getScreenObject("advanceamt").getValue());
		/*if(screenObjects.getScreenObject("custname").getValue()!=''){
			tenderOptions.credit=true;
			tenderOptions.cheque=true;
		}*/
		showTenderDialog(tenderOptions,'tenderdlg',netamt,true,advamt);
	/*}else{
		var values={};
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
	
	/*var d=invscreen.processDataToSave();
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		var r=s.callAjax("POST","/Fruits/service/invoice",d);
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
function onTenderDialogOk(values){
	if(invscreen.getSaveInProgress()) return;	
	var s=',"tender":'+JSON.stringify(values);
	screenObjects.getScreenObject("billtype").setValue(values.billType);
	if(values.billType==""){
		alert("Please fill in the Tender Correctly and continue");
		return;	
	}
	if(toNumber(values.cashamount)+toNumber(values.creditamount)+toNumber(values.ccamount)+toNumber(values.couponamount)+toNumber(values.chequeamount)<toNumber(screenObjects.getScreenObject("totalamt").getValue())){
		alert("Please fill in the Tender Correctly and continue");
		return;
	}
	var d=invscreen.processDataToSave(s);
	invscreen.setSaveInProgress(true);
	if("FAILED"!=d){
		var s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/invoice",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			var ps=JSON.parse(d.replace("data=","")).savedata;
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
	var key=save(id,me);
	if(key!="0"){
		printSale(key);
	}
}
function delete1(id,me){
	invscreen.setOperation("DELETE");	
	var l={url:"/Fruits/service/ajax",ajax:"invoice",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	var lov=new FlexUI.LOV("e_lov",me,l);
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
		screenObjects.getScreenObject("custalias").setEnabled(true);			
	}
	$('#appid').val("0");
	$('#tenderdlg').removeData('tdata');
}
function edit(id,me){
	invscreen.setOperation("EDIT");	
	var l={url:"/Fruits/service/ajax",ajax:"invoice",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	var lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	var branch=screenObjects.getScreenObject("branch");
	var a=new FlexUI.Ajax();
	showLoader();
	var r=a.callAjax("GET","/Fruits/service/invoice","billno="+args.result[0]+"&branch="+branch.getTag());
	add('','');

	if(doitHospAttachedForPharmacy){	
		screenObjects.getScreenObject("custtype").setEnabled(false);
		screenObjects.getScreenObject("custname").setEnabled(false);
		screenObjects.getScreenObject("custalias").setEnabled(false);
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
	$('#spnSetting').css("display","none");
	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	var branch=screenObjects.getScreenObject("branch")
	var a=new FlexUI.Ajax();
	showLoader();
	var r=a.callAjax("GET","/Fruits/service/invoice","billno="+no+"&branch="+branch.getTag());
	invscreen.disableInputs(true);
	invscreen.loadData(r);
	$('#tenderdlg').data('tdata',r.tender);
	calculateTotal();
	hideLoader();
}
function printSales(e,args){
	var n=screenObjects.getScreenObject("code").getValue();
	printSale(n);
}
function printSale(data){
		
		var t=screenObjects.getScreenObject("invoice_data");
		var cols=t.getCols();
		var printData={};
		printData["billType"]=data.tender["billType"];
		printData["type"]="PGSH";
		printData["branchcode"]=data["branch"];
		printData["company"]="Tiruvarur Medical Center(P) Ltd";
		printData["address1"]="27,Javulikara Street";
		printData["address2"]="Tiruvarur - 610 001";
		printData["address3"]="Phone - 242292,240292";
		printData["tin"]="";
		printData["billno"]=data["billno"];
		printData["billdate"]=data["billdate"]+" "+formatTimeHHMM(new Date());
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
		for(var x=0;x<data["invoice_data"].v.length;x++){
			var item={};
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
            url: "http://localhost:9191",
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
	var cols=screenObjects.getScreenObject("invoice_data").getCols();
	var branch=screenObjects.getScreenObject("branch");
	var location=screenObjects.getScreenObject("location");
	var v=null;
	if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
		v=l.callAjax("GET","/Fruits/service/ajax","ic=0&id=stock&branch="+branch.getTag()+"&location="+location.getTag()+"&pmcode="+me.getCellTag(row,col)+"&udw="+me.getRelatedValues(row,col).condition);
	}else{
		v=l.callAjax("GET","/Fruits/service/ajax","ic=0&id=stock&branch="+branch.getTag()+"&location="+location.getTag()+"&pmcode="+me.getCellTag(row,col));
	}
	if(v!=null){
		/*if(v.data && v.data.length==1){
			setBatchInfo(v.data[0]);
			return true;
		}else if(v.data && v.data.length>1){*/
		if(v.data ){
			var d=null;
			if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
				d={url:"/Fruits/service/ajax?udw="+me.getRelatedValues(row,col).condition,ajax:"stockonly",scrollEnabled:true,searchFromList:false,autoLoad:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"invoice_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			}else{
				d={url:"/Fruits/service/ajax",ajax:"stockonly",scrollEnabled:true,searchFromList:false,autoLoad:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"invoice_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			}
			var lov=new FlexUI.LOV("s_lov",me,d,v.data,);
			lov.onLovClose.subscribe(onStockClose);
			lov.show();
			return false;
		}else{
			var r=l.callAjax("GET","/Fruits/service/ajax","ic=0&id=productrate&pmcode="+me.getCellTag(row,col));
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
	var cols=screenObjects.getScreenObject("invoice_data").getCols();
	if(me.getCellTag(row,cols.product)!=""){
		if(toNumber(me.getText(row,cols.serialized))==1 && me.getCellPopup(row,col)){
			invokeSerialDialog(me,row,col,"productserial",me.getInputField(),toNumber(me.getText(row,col))+toNumber(me.getText(row,cols.quantity)),true);
			return false;				
		}
	}	
	return validateStock(id,me,row,col);
}
function setDefaultBranch(){
	var branch=screenObjects.getScreenObject("branch");
	var location=screenObjects.getScreenObject("location");
	branch.setTag(defbranch[0][1]);
	branch.setValue(defbranch[0][0]);
	location.setTag(defbranch[0][3]);
	location.setValue(defbranch[0][2]);	

	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	if(doitHospAttachedForPharmacy){
		screenObjects.getScreenObject("custname").setEnabled(false);
		screenObjects.getScreenObject("custalias").setEnabled(false);
	}else{
		screenObjects.getScreenObject("custname").setEnabled(true);
		screenObjects.getScreenObject("custalias").setEnabled(true);			
	}
}
function onStockClose(e,args){
	setBatchInfo(args.result);
	screenObjects.getScreenObject("invoice_data").checkAndMove('Next',false);
}
function setBatchInfo(result){
	var products=screenObjects.getScreenObject("invoice_data");
	var cols=products.getCols();
	 
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
	var l={url:"/Fruits/service/ajax",ajax:"serviceorders",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"sono",id:"0",tt:false}]};
	var lov=new FlexUI.LOV("so_lov",me,l);
	lov.onLovClose.subscribe(onLoadServiceOrderClose);
	lov.show();
}
function onLoadServiceOrderClose(e,args){	
	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	var branch=screenObjects.getScreenObject("branch");
	var a=new FlexUI.Ajax();
	showLoader();
	var r=a.callAjax("GET","/Fruits/service/invoice/serviceorder","orderno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	invscreen.loadData(r);
	var t=screenObjects.getScreenObject("invoice_data");
	var cols=t.getCols();
	var rows=t.getSize();
	for(var i=0;i<rows-1;i++){		
		calculateAmount(i);
	}
	calculateTotal();
	hideLoader();
}
function loadSalesOrder(id,me){
	var op=invscreen.getOperation();
	if(op=="ADD"){
		var l={url:"/Fruits/service/ajax",ajax:"salesorders",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"sono",id:"0",tt:false}]};
		var lov=new FlexUI.LOV("so_lov",me,l);
		lov.onLovClose.subscribe(onLoadSalesOrderClose);
		lov.show();
	}else{
		alert("Sorry... You Cannot Load Sales Order in Edit Mode");
	}
}
function loadSalesOrderForCustomer(id,me){
	var op=invscreen.getOperation();
	if(op=="ADD"){
		var l={url:"/Fruits/service/ajax",ajax:"custsalesorders",closeOnNoData:true,scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"custcode",src:"custname",ft:true}],results:[{tgt:"sono",id:"0",tt:false}]};
		var lov=new FlexUI.LOV("so_lov",me,l);
		lov.onLovClose.subscribe(onLoadSalesOrderClose);
		var s=lov.show();
		return !s;
	}else{
		alert("Sorry... You Cannot Load Sales Order in Edit Mode");
		return true;		
	}
}
function onLoadSalesOrderClose(e,args){	
	screenObjects.getScreenObject(invscreen.getInitialFocus()).focus();
	var branch=screenObjects.getScreenObject("branch");	
	var a=new FlexUI.Ajax();
	showLoader();
	var r=a.callAjax("GET","/Fruits/service/invoice/salesorder","orderno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	invscreen.loadData(r);
	screenObjects.getScreenObject(invscreen.getInitialFocus()).setEnabled(false);
	screenObjects.getScreenObject("custname").setEnabled(false);
	screenObjects.getScreenObject("custalias").setEnabled(false);
	screenObjects.getScreenObject("billdate").focus();
	var t=screenObjects.getScreenObject("invoice_data");
	var cols=t.getCols();
	var rows=t.getSize();
	for(var i=0;i<rows-1;i++){		
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
          var applet = document.jzebra;
      	    if (applet != null) {
               applet.findPrinter("\\{dummy printer name for listing\\}");
               while (!applet.isDoneFinding()) {
                    // Note, enless while loops are bad practice.
                    // Create a JavaScript function called "jzebraDoneFinding()"
                    // instead and handle your next steps there.
               }

               // Sample only: If a PDF printer isn't installed, try the Microsoft XPS Document
               // Writer.  Replace this with your printer name.
               var printers = applet.getPrinters().split(",");
               for (i in printers) {
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
	       applet.appendPDF("http://localhost:8080/Fruits/pdf_sample.pdf");
	    }

            // Very important for PDF, uses printPS() instead of print()
            // *Note:  monitorAppending2() still works but is too complicated and
            // outdated.  Instead create a JavaScript  function called 
            // "jzebraDoneAppending()" and handle your next steps there.
      }
      function closeScreen(){
		$('#rep').show();
		$('#filter').css("display","block");
		$('#dtfilter').css("display","block");
		$('#brdCr').css("display","block");
		$('#maincontent').empty();
}
function checkBarCode(id,me,row,col){
	var invtable=screenObjects.getScreenObject("invoice_data");
	var cols=invtable.getCols();
	var branch=screenObjects.getScreenObject("branch");
	if(me.getText(row,cols.product)!="" && toNumber(me.getCellTag(row,cols.product))==0 && !invscreen.getSaveInProgress()){
		var result=null;
		var v=null;
		v=l.callAjax("GET","/Fruits/service/ajax","ic=0&id=barcodeproduct&branch="+branch.getTag()+"&product="+me.getText(row,col));
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
	var cols=screenObjects.getScreenObject("invoice_data").getCols();
	var stock=me.getText(row,cols.stock);
	var qty=me.getText(row,cols.basequantity);
	var free=toNumber(me.getText(row,cols.freeqty))*toNumber(me.getText(row,cols.conversionvalue));
	var negativestock=me.getText(row,cols.allownegative);
	if(toNumber(negativestock)==0){
		if(toNumber(qty)+free>toNumber(stock)){
			alert("insufficient Stock");
			return false;
		}
	}
	return true;
}
function callDiscountCalc(inp,e){
	var cashdiscperc=screenObjects.getScreenObject("cdisc");
	var cashdiscamt=screenObjects.getScreenObject("cdiscamt");	
	cashdiscperc.setValue($(inp).val());	
	calculateCashDiscount();
	var netamt=toNumber(screenObjects.getScreenObject("totalamt").getValue());
	$('#tdiscamt').val(cashdiscamt.getValue());
	$('#tenderdlg').data('billamount',netamt);
	var advanceAmount=$('#tenderdlg').data('advanceamt');
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