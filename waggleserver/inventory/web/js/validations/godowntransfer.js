function getAttributeDetail(id,me,row,col){
	let t=screenObjects.getScreenObject("out_data");
	let cols=t.getCols();
	let billno=screenObjects.getScreenObject("outwardsno");
	let branch=screenObjects.getScreenObject("branch");
	if(toNumber(billno.getValue())==0){	
		if(me.getCellTag(row,cols.product)!="" && toNumber(me.getText(row,cols.selling))==0 && !godowntransferscreen.getSaveInProgress()){
			if(toNumber(me.getText(row,cols.isattribute))==1 && me.getCellPopup(row,col)){
				invokeAttributeDialog(me,row,col,"productprops",me.getInputField());
				return false;				
			}else if(toNumber(me.getText(row,cols.isattribute))==0){
				return onAttributeClose(me,row,col);
			}
		}
	}else if(me.getCellTag(row,cols.product)!="" && toNumber(me.getText(row,cols.selling))==0 && !godowntransferscreen.getSaveInProgress()){
		showLoader();
		let v=l.callAjax("GET","/inventory/service/grn/gindetail","billno="+billno.getValue()+"&branch="+branch.getTag()+"&sno="+t.getText(row,cols.impsno));
		if(v!=null){
			v[0].v=t.getText(row,cols.sno);
			t.setRowData(row,v);
		}		
		hideLoader();
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
function validateStock(id,me,row,col){
	let cols=screenObjects.getScreenObject("out_data").getCols();
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
function calculateTotal(){
	let total=0;
	let totalTax=0;
	let netTotal=0;
	let totalDisc=0;
	let totalServiceTax=0;
	let t=screenObjects.getScreenObject("out_data");
	let cols=t.getCols();
	let s=t.getSize();
	for(let i=0;i<s;i++){
		total+=toNumber(t.getText(i,cols.amount));
		totalTax+=toNumber(t.getText(i,cols.ptaxamt));
		totalDisc+=toNumber(t.getText(i,cols.discamt));
		totalServiceTax+=toNumber(t.getText(i,cols.srtaxamt));
		netTotal+=toNumber(t.getText(i,cols.netamount));
	}
	screenObjects.getScreenObject("total").setValue(roundOff(total,2));
	screenObjects.getScreenObject("taxamt").setValue(roundOff(totalTax,2));
	screenObjects.getScreenObject("servtaxamt").setValue(roundOff(totalServiceTax,2));
	screenObjects.getScreenObject("discamt").setValue(roundOff(totalDisc,2));
	let pf=toNumber(screenObjects.getScreenObject("pf").getValue());
	netTotal+=pf;
	screenObjects.getScreenObject("totalamt").setValue(roundOff(netTotal,2));
	
	
	$("#netAmt").html("Net Amount   "+roundOff(netTotal,2));
}
function calculateAmount(row){
	let t=screenObjects.getScreenObject("out_data");
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
	let d=godowntransferscreen.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/godowntransfer",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.outno+"]");
			godowntransferscreen.clearScreen();
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);		
		}
	return 0;
}
}
function delete1(id,me){
	godowntransferscreen.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"godowntransfer",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}]};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	
function add(id,me){
	godowntransferscreen.clearScreen();
	setDefaultBranch();
	godowntransferscreen.setOperation("ADD");
	screenObjects.getScreenObject("branch").focus();
}
function edit(id,me){
	godowntransferscreen.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"godowntransfer",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}]};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	let branch=screenObjects.getScreenObject("branch");
	branch.focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/godowntransfer","transferin=false&outno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	godowntransferscreen.setOperation("EDIT");
	godowntransferscreen.loadData(r);
	calculateTotal();
	hideLoader();
}
function loadDataView(no){	
	let branch=screenObjects.getScreenObject("branch");
	branch.focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/godowntransfer","transferin=false&outno="+no+"&branch="+branch.getTag());
	godowntransferscreen.disableInputs(true);
	godowntransferscreen.loadData(r);
	calculateTotal();
	hideLoader();
}
function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("out_data").getCols();
	let branch=screenObjects.getScreenObject("branch");
	let location=screenObjects.getScreenObject("location");
	let v=null;
	if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=transtock&branch="+branch.getTag()+"&location="+location.getTag()+"&pmcode="+me.getCellTag(row,col)+"&udw="+me.getRelatedValues(row,col).condition);
	}else{
		v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=transtock&branch="+branch.getTag()+"&location="+location.getTag()+"&pmcode="+me.getCellTag(row,col));
	}	
	if(v!=null){
		if(v.data && v.data.length==1){
			setBatchInfo(v.data[0]);
			return true;
		}else if(v.data && v.data.length>1){
			let d=null;
			if(toNumber(me.getText(row,cols.isattribute))==1 && me.getRelatedValues(row,col)){
				d={url:"/inventory/service/ajax?udw="+me.getRelatedValues(row,col).condition,ajax:"transtock",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"out_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
			}else{
				d={url:"/inventory/service/ajax",ajax:"transtock",scrollEnabled:true,searchFromList:false,dsi:1,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true},{n:"pmcode",src:"out_data",ft:true,row:"cr",col:"1"}],results:[],standalone:true};
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
	let cols=screenObjects.getScreenObject("out_data").getCols();
	if(me.getCellTag(row,cols.product)!=""){
		if(toNumber(me.getText(row,cols.serialized))==1 && me.getCellPopup(row,col)){
			invokeSerialDialog(me,row,col,"productserial",me.getInputField(),toNumber(me.getText(row,col)),true);
			return false;				
		}
	}
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
	screenObjects.getScreenObject("branch").focus();	
}
function onStockClose(e,args){
	setBatchInfo(args.result);
	screenObjects.getScreenObject("out_data").checkAndMove('Next',false);
}
function setBatchInfo(result){
	let products=screenObjects.getScreenObject("out_data");
	let cols=products.getCols();
	
	products.setCurrentRowText(cols.csdid,result[2]);
	products.setCurrentRowText(cols.batchno,result[4]);
	products.setCurrentRowText(cols.expdt,result[5]);
	products.setCurrentRowText(cols.rate,result[3]);
	products.setCurrentRowText(cols.stock,result[13]);
	products.setCurrentRowText(cols.batchdt,result[9]);
	products.setCurrentRowText(cols.selling,result[11]);
	products.setCurrentRowText(cols.mrp,result[10]);
	products.setCurrentRowText(cols.discperc,result[6]);
	products.setCurrentRowText(cols.ptaxperc,result[7]);
	products.setCurrentRowText(cols.isdid,result[12]);
	products.setCurrentRowText(cols.barcode,result[14]);
	products.setCurrentRowText(cols.obranch,result[15]);
	products.setCurrentRowText(cols.oisdid,result[16]);	
	products.setCurrentRowText(cols.attribid,result[17]);
	products.setCurrentRowText(cols.srtaxperc,result[8]);
	//products.setCurrentRowText(cols.supplier,result[18]);
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
	products.setCurrentRowText(cols.discperc,0);
	products.setCurrentRowText(cols.isdid,0);
	products.setCurrentRowText(cols.barcode,0);
	products.setCurrentRowText(cols.obranch,0);
	products.setCurrentRowText(cols.oisdid,0);
	products.setCurrentRowText(cols.attribid,0);
	products.setCurrentRowText(cols.srtaxperc,0);
	
}

function closeScreen(){
		$('#rep').show();
		$('#filter').css("display","block");
		$('#dtfilter').css("display","block");
		$('#brdCr').css("display","block");
		$('#maincontent').empty();
}
function getGinDetail(id,me){
	let cols=screenObjects.getScreenObject("out_data").getCols();
	let billno=screenObjects.getScreenObject("outwardsno");
	//let branch=screenObjects.getScreenObject("frombranch");
	let v=null;
	if(godowntransferscreen.getOperation()=='ADD' && !godowntransferscreen.getSaveInProgress()){
		if(toNumber(billno.getValue())!=0 ){
			/*v=l.callAjax("GET","/inventory/service/invoice/invoiceheader","branch="+branch.getTag()+"&billno="+billno.getValue());
			if(v!=null){
				setBillInfo(v);
			}*/
			
			let cols=screenObjects.getScreenObject("out_data").getCols();
			screenObjects.getScreenObject("out_data").getColumnProperties()[cols.product].lovOptions={url:"/inventory/service/ajax",ajax:"ginproducts",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"billno",src:"outwardsno",ft:false},{n:"branch",src:"branch",ft:false}],results:[{tgt:"out_data",tt:false,row:"cr",col:"1",id:"0"},
		    {tgt:"out_data",tt:true,row:"cr",col:"1",id:"1"},
    		{tgt:"out_data",tt:false,row:"cr",col:"2",id:"11"},
    		{tgt:"out_data",tt:false,row:"cr",col:"3",id:"12"},
    		{tgt:"out_data",tt:false,row:"cr",col:"4",id:"13"},
    		{tgt:"out_data",tt:false,row:"cr",col:"35",id:"3"},
    		{tgt:"out_data",tt:false,row:"cr",col:"36",id:"4"},
    		{tgt:"out_data",tt:false,row:"cr",col:"6",id:"7"},
    		{tgt:"out_data",tt:false,row:"cr",col:"8",id:"8"},
    		{tgt:"out_data",tt:false,row:"cr",col:"7",id:"9"},
    		{tgt:"out_data",tt:false,row:"cr",col:"49",id:"10"}]};
			screenObjects.getScreenObject("out_data").deleteAndMove();
		}else{
			screenObjects.getScreenObject("out_data").getColumnProperties()[cols.product].lovOptions={url:"/inventory/service/ajax",ajax:"transferproduct",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"branch",src:"branch",ft:true}],results:[
    		{tgt:"out_data",tt:false,row:"cr",col:"1",id:"0"},
    		{tgt:"out_data",tt:true,row:"cr",col:"1",id:"1"},
    		{tgt:"out_data",tt:false,row:"cr",col:"2",id:"2"},
    		{tgt:"out_data",tt:false,row:"cr",col:"29",id:"5"},
    		{tgt:"out_data",tt:false,row:"cr",col:"25",id:"6"},
    		{tgt:"out_data",tt:false,row:"cr",col:"33",id:"7"},
    		{tgt:"out_data",tt:false,row:"cr",col:"6",id:"8"},
    		{tgt:"out_data",tt:false,row:"cr",col:"7",id:"10"},
    		{tgt:"out_data",tt:false,row:"cr",col:"14",id:"10"},
    		{tgt:"out_data",tt:false,row:"cr",col:"8",id:"11"},
    		{tgt:"out_data",tt:false,row:"cr",col:"15",id:"11"},
    		{tgt:"out_data",tt:false,row:"cr",col:"43",id:"13"},
    		{tgt:"out_data",tt:false,row:"cr",col:"16",id:"14"}, 
    		{tgt:"out_data",tt:false,row:"cr",col:"45",id:"15"},
    		{tgt:"out_data",tt:false,row:"cr",col:"27",id:"16"},
    		{tgt:"out_data",tt:false,row:"cr",col:"3",id:"17"},
    		{tgt:"out_data",tt:false,row:"cr",col:"4",id:"18"}]};
			screenObjects.getScreenObject("out_data").deleteAndMove();		
		}
	}	
	return true;
}
function setBillInfo(bill){
	let cols=screenObjects.getScreenObject("out_data").getCols();
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
	screenObjects.getScreenObject("out_data").getColumnProperties()[cols.product].lovOptions={url:"/inventory/service/ajax",ajax:"billproducts",scrollEnabled:true,searchFromList:false,dsi:0,params:[{n:"billno",src:"billsno",ft:false}],results:[{tgt:"out_data",tt:false,row:"cr",col:"1",id:"0"},{tgt:"out_data",tt:true,row:"cr",col:"1",id:"1"},{tgt:"out_data",tt:false,row:"cr",col:"24",id:"3"},{tgt:"out_data",tt:false,row:"cr",col:"25",id:"4"},{tgt:"out_data",tt:false,row:"cr",col:"3",id:"7"},{tgt:"out_data",tt:false,row:"cr",col:"5",id:"8"},{tgt:"out_data",tt:false,row:"cr",col:"4",id:"9"}]};
	screenObjects.getScreenObject("out_data").deleteAndMove();	
}