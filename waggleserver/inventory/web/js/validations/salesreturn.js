var doitHospAttachedForPharmacy=true;
var discountBeforeTax=false;
function fetchCustomer(id,me){
	if(!sretscreen.getSaveInProgress()){
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
	getSalesBillDetail(id,me);
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
	if(doitHospAttachedForPharmacy){
		if(me.getValue()==1){
			custName.setEnabled(true);
			custAlias.setEnabled(false);
			me.setNextFocus("custname");
			custName.setMandatory(true);
			custAlias.setMandatory(false);
		}else if(me.getValue()==2){
			custName.setEnabled(false);
			custAlias.setEnabled(true);
			me.setNextFocus("custalias");
			custAlias.setMandatory(true);
			custName.setMandatory(false);	
		}
	}
	return true;
}
function getAttributeDetail(id,me,row,col){
	let t=screenObjects.getScreenObject("return_data");
	let cols=t.getCols();
	let billno=screenObjects.getScreenObject("billsno");
	let branch=screenObjects.getScreenObject("branch");
	if(toNumber(billno.getValue())==0){	
		if(me.getCellTag(row,cols.product)!="" && toNumber(me.getText(row,cols.selling))==0 && !sretscreen.getSaveInProgress()){
			if(toNumber(me.getText(row,cols.isattribute))==1 && me.getCellPopup(row,col)){
				invokeAttributeDialog(me,row,col,"productprops",me.getInputField());
				return false;				
			}else if(toNumber(me.getText(row,cols.isattribute))==0){
				return onAttributeClose(me,row,col);
			}
		}
	}else if(me.getCellTag(row,cols.product)!="" && toNumber(me.getText(row,cols.selling))==0 && !sretscreen.getSaveInProgress()){		
		let v=l.callAjax("GET","/inventory/service/invoice/invoicedetail","billno="+billno.getValue()+"&branch="+branch.getTag()+"&sno="+t.getText(row,cols.impsno));
		if(v!=null){
			v[0].v=t.getText(row,cols.sno);
			t.setRowData(row,v);
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
	let t=screenObjects.getScreenObject("return_data");
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
	let roundoffvalue=netTotal;
	netTotal+=pf;
	screenObjects.getScreenObject("roundedoff").setValue(roundOff(Math.round(roundOff(netTotal,2))-roundOff(netTotal,2),2));
	let roundedOff=toNumber(screenObjects.getScreenObject("roundedoff").getValue());
	netTotal+=roundedOff;	
	screenObjects.getScreenObject("totalamt").setValue(roundOff(netTotal,2));
	screenObjects.getScreenObject("cdiscamt").setValue(roundOff(totalCdisc,2));
	let roundoffTotal=(netTotal-roundoffvalue);	
	// $("#round").html(roundOff(roundoffTotal,2));
	$("#gross").html(roundOff(total,2));
	$("#totamt").html(roundOff(total,2));
	$("#vat").html(roundOff(totalTax,2));
	$("#disc").html(roundOff(totalDisc,2));
	$("#netAmt").html(""+ roundOff(netTotal,2));
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
	let taxableamt=0;
	let disc=0;
	let cashdisc=0;
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
		ttaxableamt=Number(amt)-disc;
		cashdisc=roundOff(ttaxableamt*toNumber(t.getText(row,cols.cashdiscperc))/100,2);
		ttaxableamt=Number(amt)-cashdisc;
		taxableamt=((ttaxableamt / (100 + toNumber(t.getText(row,cols.staxperc)))) * 100);
	}	
	tax=roundOff(taxableamt*toNumber(t.getText(row,cols.staxperc))/100,2);
	servTax=roundOff(taxableamt*toNumber(t.getText(row,cols.srtaxperc))/100,2);
	netAmt=roundOff(taxableamt+toNumber(servTax)+toNumber(tax),2);
	if(toNumber(t.getText(row,cols.taxincl))==1 && disc==0 && servTax==0 ){
		if(netAmt>amt){
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
	let t=screenObjects.getScreenObject("return_data");
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
	//let custType=screenObjects.getScreenObject("custtype").getValue();
	if(doitHospAttachedForPharmacy ){
		if("condition 1");
		let tenderOptions={};	
		tenderOptions.cash=true;
		tenderOptions.credit=false;
		tenderOptions.coupon=false;
		tenderOptions.sponsor=true;
		tenderOptions.creditcard=false;
		tenderOptions.cheque=false;
		tenderOptions.discount=true;
		let netamt=toNumber(screenObjects.getScreenObject("totalamt").getValue());
		if(screenObjects.getScreenObject("custname").getTag()!='' && screenObjects.getScreenObject("custname").getTag()!='0'){
			tenderOptions.credit=true;
			tenderOptions.cheque=false;
		}
		if(tenderOptions.discount ){
			let values={};		
			values.cashdiscperc=screenObjects.getScreenObject("cdisc").getValue();
			$("#tenderdlg").data('tdata',values);
		}
		let d=sretscreen.processDataToSave();
		if("FAILED"!=d){
			showTenderDialog(tenderOptions,'tenderdlg',netamt,true,0);
		}

	}else{
		if("condition 2");
		let values={};
		values.creditamount=screenObjects.getScreenObject("totalamt").getValue();
		values.totalamount=screenObjects.getScreenObject("totalamt").getValue();
		values.tendered="0";
		values.balance="0";
		values.billType="CR";
		onTenderDialogOk(values);		
	}
	/*let d=sretscreen.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		let r=s.callAjax("POST","/inventory/service/invoice",d);
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			sretscreen.clearScreen();
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);		
		}
	return 0;
	}*/
}
function onTenderDialogOk(values){
	console.log(Object.keys(values));
	console.log("values "+ Object.values(values));
	if(sretscreen.getSaveInProgress()) return;
	let s=',"tender":'+JSON.stringify(values);
	
	screenObjects.getScreenObject("returntype").setValue(values.billType);
	//alert(screenObjects.getScreenObject("return_data").getCellTag(0,1));
	if(values.billType==""){
		alert("Please fill in the Tender Correctly and continue");
		return;	
	}

	else if((values.billType=="CA" | values.billType=="CC" | values.billType=="CR" )& values.cashamount =="values.cashamount"){
		alert("Please fill in the Tender Correctly and continue ");
		return;	
	}

	if(toNumber(values.cashamount)+toNumber(values.creditamount)+toNumber(values.ccamount)+toNumber(values.couponamount)+toNumber(values.chequeamount)<toNumber(screenObjects.getScreenObject("totalamt").getValue())){
		console.log(toNumber(screenObjects.getScreenObject("advanceamt").getValue()));
		alert("Please fill in the Tender Correctly and continue");
		return;
	}
	let d=sretscreen.processDataToSave(s);
	sretscreen.setSaveInProgress(true);
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		console.log("SALES RETURN S="+ s);
		console.log("JsonJ"+ JSON.stringify(s));
		let r=s.callAjax("POST","/inventory/service/salesreturn",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.returnno+"]");
			let ps=JSON.parse(d.replace("data=","")).savedata;
			ps["returnno"]=r.returnno;
			if(window.confirm("Do you want to print sales return?")){
				printSaleReturn(ps);	
			}		
			sretscreen.clearScreen();
			sretscreen.setSaveInProgress(false);
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);
			sretscreen.setSaveInProgress(false);
			screenObjects.getScreenObject("return_data").getInputField().focus();		
		}
	return 0;
	}else{
		sretscreen.setSaveInProgress(false);
	}
}
function savePrint(id,me){
	let key= "1";
	save(id,me);
	if(key!="0"){
		//printSale(key);
	}
}
function printSaleReturn(data){
	try{
		let t=screenObjects.getScreenObject("return_data");
		let cols=t.getCols();
		let printData={};
		printData["type"]="PGSHSR";
		printData["branchcode"]=data["branch"];
		printData["company"]=" Medical Center(P) Ltd";
		printData["address1"]="27,Javulikara Street";
		printData["address2"]="Tiruletur - 610 001";
		printData["address3"]="Phone - 242292,240292";
		printData["tin"]="";
		printData["returnno"]=data["returnno"];
		printData["returndate"]=data["returndate"];
		printData["tax"]=data["taxamt"];
		printData["totalamt"]=data["totalamt"]+"";
		printData["roundoff"]=data["roundedoff"]+"";
		printData["doctorname"]=data["professional"]+"";
		printData["total"]=data["total"]+"";		
		printData["customer"]=data.name;
		printData["custalias"]=data["custalias"]+"";
		printData["cdiscamt"]=data["cdiscamt"]+"";
		printData["userid"]=userName;
		printData["invtype"]="CASH";
		printData["printtax"]="1";
		printData["printdisc"]="1";
		printData["printround"]="1";
		printData["printnetamount"]="1";
		printData["items"]=[];
		for(let x=0;x<data["return_data"].v.length;x++){
			let item={};
			item.name=t.getText(x,cols.product);
			item.rate=data["return_data"].v[x][cols.rate]+"";
			item.qty=data["return_data"].v[x][cols.quantity]+"";
			item.batch=data["return_data"].v[x][cols.batchno]+"";
			item.expdt=data["return_data"].v[x][cols.expdt]+"";
			item.amount=data["return_data"].v[x][cols.netamount]+"";;				
			item.totalamount=data["return_data"].v[x][cols.amount]+"";;
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
    }catch(e){
    	
    }		
}
function delete1(id,me){
	sretscreen.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"salesreturn",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	
function add(id,me){
	sretscreen.clearScreen();
	sretscreen.setSaveInProgress(false);
	setDefaultBranch();
	sretscreen.setOperation("ADD");
	screenObjects.getScreenObject(sretscreen.getInitialFocus()).setEnabled(true);
	screenObjects.getScreenObject(sretscreen.getInitialFocus()).focus();		
	if(doitHospAttachedForPharmacy){	
		screenObjects.getScreenObject("custname").setEnabled(true);
		screenObjects.getScreenObject("custalias").setEnabled(false);
	}else{
		screenObjects.getScreenObject("custname").setEnabled(true);
		screenObjects.getScreenObject("custalias").setEnabled(true);			
	}
	$('#tenderdlg').removeData('tdata');
}
function edit(id,me){
	sretscreen.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"salesreturn",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	screenObjects.getScreenObject("custname").focus();
	let branch=screenObjects.getScreenObject("branch");
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/salesreturn","returnno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	if(doitHospAttachedForPharmacy){
		screenObjects.getScreenObject("custtype").setEnabled(false);
		screenObjects.getScreenObject("custname").setEnabled(true);
		screenObjects.getScreenObject("custalias").setEnabled(false);
		screenObjects.getScreenObject("returndate").setEnabled(false);
		screenObjects.getScreenObject("professional").setEnabled(true);
		screenObjects.getScreenObject("professional").focus();
	}else{
		screenObjects.getScreenObject("custname").setEnabled(true);
		screenObjects.getScreenObject("custalias").setEnabled(true);				
	}
	
	sretscreen.setOperation("EDIT");
	sretscreen.loadData(r);
	$('#tenderdlg').data('tdata',r.tender);
	calculateTotal();
	hideLoader();
}
function loadDataView(no){	
	screenObjects.getScreenObject("custname").focus();
	let branch=screenObjects.getScreenObject("branch");
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/salesreturn","returnno="+no+"&branch="+branch.getTag());
	sretscreen.disableInputs(true);
	sretscreen.loadData(r);
	$('#tenderdlg').data('tdata',r.tender);
	calculateTotal();
	hideLoader();
}
function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("return_data").getCols();
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
				d={url:"/inventory/service/ajax?udw="+me.getRelatedValues(row,col).condition,ajax:"stock",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"return_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			}else{
				d={url:"/inventory/service/ajax",ajax:"stock",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"return_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
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
	screenObjects.getScreenObject(sretscreen.getInitialFocus()).focus();
	if(doitHospAttachedForPharmacy){
		screenObjects.getScreenObject("custname").setEnabled(true);
		screenObjects.getScreenObject("custalias").setEnabled(false);
	}else{
		screenObjects.getScreenObject("custname").setEnabled(true);
		screenObjects.getScreenObject("custalias").setEnabled(true);			
	}
	$('#tenderdlg').removeData('tdata');
}
function onStockClose(e,args){
	setBatchInfo(args.result);
	screenObjects.getScreenObject("return_data").checkAndMove('Next',false);
}
function setBatchInfo(result){
	let products=screenObjects.getScreenObject("return_data");
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


function getSalesBillDetail(id,me){
	let cols=screenObjects.getScreenObject("return_data").getCols();
	let billno=screenObjects.getScreenObject("billsno");
	let branch=screenObjects.getScreenObject("branch");
	let v=null;
	if(sretscreen.getOperation()=='ADD' && !sretscreen.getSaveInProgress()){
		if(toNumber(billno.getValue())!=0 ){
			v=l.callAjax("GET","/inventory/service/invoice/invoiceheader","branch="+branch.getTag()+"&billno="+billno.getValue());
			if(v!=null){
				setBillInfo(v);
			}
		}else{
		screenObjects.getScreenObject("return_data").getColumnProperties()[cols.product].lovOptions={url:"/inventory/service/ajax",ajax:"saleproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[    {tgt:"return_data",tt:false,row:"cr",col:"1",id:"0"},
	    {tgt:"return_data",tt:true,row:"cr",col:"1",id:"1"},
	    {tgt:"return_data",tt:false,row:"cr",col:"2",id:"2"},
	    {tgt:"return_data",tt:false,row:"cr",col:"23",id:"5"},
	    {tgt:"return_data",tt:false,row:"cr",col:"30",id:"7"},
	    {tgt:"return_data",tt:false,row:"cr",col:"6",id:"8"},
	    {tgt:"return_data",tt:false,row:"cr",col:"7",id:"10"},
	    {tgt:"return_data",tt:false,row:"cr",col:"8",id:"12"},
	    {tgt:"return_data",tt:false,row:"cr",col:"14",id:"10"},
	    {tgt:"return_data",tt:false,row:"cr",col:"15",id:"12"},
	    {tgt:"return_data",tt:false,row:"cr",col:"36",id:"13"},
	    {tgt:"return_data",tt:false,row:"cr",col:"16",id:"14"},
	    {tgt:"return_data",tt:false,row:"cr",col:"25",id:"16"},
	    {tgt:"return_data",tt:false,row:"cr",col:"3",id:"17"},
	    {tgt:"return_data",tt:false,row:"cr",col:"4",id:"18"}        
		]};
		screenObjects.getScreenObject("return_data").deleteAndMove();		
		}
	}	
	return true;
}
function setBillInfo(bill){
	let cols=screenObjects.getScreenObject("return_data").getCols();
	screenObjects.getScreenObject("custname").setTag(bill.custcode);
	screenObjects.getScreenObject("custname").setValue(bill.custname);
	screenObjects.getScreenObject("address").setValue(bill.address);
	screenObjects.getScreenObject("address1").setValue(bill.address1);
	screenObjects.getScreenObject("address2").setValue(bill.address2);
	screenObjects.getScreenObject("city").setValue(bill.city);
	screenObjects.getScreenObject("pincode").setValue(bill.pincode);
	screenObjects.getScreenObject("creditdays").setValue(bill.creditdays);
	screenObjects.getScreenObject("name").setValue(bill.custname);
	screenObjects.getScreenObject("mobile").setValue(bill.mobile);
	screenObjects.getScreenObject("billdate").setValue(bill.billdate);
	screenObjects.getScreenObject("showbilldate").setValue(bill.billdate);
	screenObjects.getScreenObject("cdisc").setValue(bill.discperc);
	screenObjects.getScreenObject("return_data").getColumnProperties()[cols.product].lovOptions={url:"/inventory/service/ajax",ajax:"billproducts",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"billno",src:"billsno",ft:false},{n:"branch",src:"branch",ft:true}],results:[
	{tgt:"return_data",tt:false,row:"cr",col:"1",id:"0"},
	{tgt:"return_data",tt:true,row:"cr",col:"1",id:"1"},
	{tgt:"return_data",tt:false,row:"cr",col:"32",id:"3"},
	{tgt:"return_data",tt:false,row:"cr",col:"33",id:"4"},
	{tgt:"return_data",tt:false,row:"cr",col:"6",id:"7"},
	{tgt:"return_data",tt:false,row:"cr",col:"8",id:"8"},
	{tgt:"return_data",tt:false,row:"cr",col:"7",id:"9"}
	]};
	screenObjects.getScreenObject("return_data").deleteAndMove();	
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
function callDiscountCalc(inp,e){
	let cashdiscperc=screenObjects.getScreenObject("cdisc");
	let cashdiscamt=screenObjects.getScreenObject("cdiscamt");
	cashdiscperc.setValue($(inp).val());	
	calculateCashDiscount();
	let netamt=toNumber(screenObjects.getScreenObject("totalamt").getValue());
	$('#tdiscamt').val(cashdiscamt.getValue());
	$('#tenderdlg').data('billamount',netamt);
	$('#billLabel').text("Bill Amount:"+roundOff(netamt,2));	
	$('#tcashamt').val('');
	$('#creditamt').val('');
	$('#tcreditcardamt').val('');
	$('#creditcardamt').val('');
	$('#couponamt').val('');
	$('#chequeamt').val('');
	tenderCalculate($('#tcashamt'));	
}