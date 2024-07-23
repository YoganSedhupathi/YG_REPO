function setDefaultBranch(){
	let branch=screenObjects.getScreenObject("branch");
	let mode=screenObjects.getScreenObject("mode");
	branch.setTag(defbranch[0][1]);
	branch.setValue(defbranch[0][0]);
	onModeChange('mode',mode);	
	screenObjects.getScreenObject("trantype").focus();
}
function onModeChange(id,me){
	if(me.getValue()=='CA'){
		voucher.showHideGroup('chequedetails',false);
		voucher.showHideGroup('carddetails',false);
	}else if(me.getValue()=='CC'){
		voucher.showHideGroup('chequedetails',false);
		voucher.showHideGroup('carddetails',true);	
	}else if(me.getValue()=='CQ'){
		voucher.showHideGroup('chequedetails',true);
		voucher.showHideGroup('carddetails',false);	
	}
}
function validateCrdr(id,me,row,col){
	let t=screenObjects.getScreenObject("ledgers_data");
	let cols=t.getCols();
	if("Cr"==t.getText(row,cols.crdr)){
		t.setText(row,cols.dramount,"0.00");
	}else{
		t.setText(row,cols.cramount,"0.00");
	}
	amountChange(id,me.getInputField());
	return true;
}
function amountChange(id,me){
	let t=me.getParent();
	let cols=t.getCols();
	let crAmount=0;
	let drAmount=0;
	let s=t.getSize();
	for(let x=0;x<s;x++){
			if(t.getText(x,cols.crdr)=='Cr'){
				crAmount=crAmount+toNumber(t.getText(x,cols.cramount));
			}else{
				drAmount=drAmount+toNumber(t.getText(x,cols.dramount));
			}
	}
	screenObjects.getScreenObject("debitamount").setValue(drAmount);
	screenObjects.getScreenObject("creditamount").setValue(crAmount);
}
function crDrChange(id,me){
	let t=me.getParent();
	let cols=t.getCols();
	let row=t.getCurrentRow();
	if(t.getText(row,cols.crdr)=='C' || t.getText(row,cols.crdr)=='c' || t.getText(row,cols.crdr)=='Cr' || t.getText(row,cols.crdr)=='cr'){
		t.setText(row,cols.crdr,'Cr');
	}else if(t.getText(row,cols.crdr)=='D' || t.getText(row,cols.crdr)=='d' || t.getText(row,cols.crdr)=='Dr' || t.getText(row,cols.crdr)=='dr'){
		t.setText(row,cols.crdr,'Dr');
	}else{
		t.setText(row,cols.crdr,'');
	}
}

function delete1(id,me){
	voucher.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"vouchers",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	
function add(id,me){
	voucher.clearScreen();
	setDefaultBranch();
	voucher.setOperation("ADD");
	screenObjects.getScreenObject("refno").focus();
}
function edit(id,me){
	voucher.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"vouchers",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	screenObjects.getScreenObject("refno").focus();
	let a=new FlexUI.Ajax();
	showLoader();
	voucher.setOperation("EDIT");		
	let r=a.callAjax("GET","/inventory/service/account/vouchers","code="+args.result[0]+"&branchcode="+args.result[9]);
	voucher.loadData(r);
	onModeChange("mode",screenObjects.getScreenObject("mode"));
	amountChange("ledgers_data",screenObjects.getScreenObject("ledgers_data").getInputField());
	hideLoader();
}

function save(id,me){
	let totalCrAmt=screenObjects.getScreenObject('creditamount');
	let totalDrAmt=screenObjects.getScreenObject('debitamount');
	let tranType=screenObjects.getScreenObject('trantype').getValue();
	if(toNumber(totalCrAmt.getValue())!=toNumber(totalDrAmt.getValue())){
		alert("Credit and Debit Amount must be equal");
		return;
	}
	let d=voucher.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/account/vouchers",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			if(tranType=="1" || tranType=="2"){
				printPayment(r.key);
			}
			voucher.clearScreen();
			setDefaultBranch();
			return r.key;			
		}else{
			alert(r.message);		
		}
		return 0;
	}
}
function onEscClose(){	
	add('','');
}
function printPayment(code){
	let branch=screenObjects.getScreenObject("branch");
	let printData={};
	$.ajax({
    url: "/inventory/service/account/vouchers/print?branch="+branch.getTag()+"&code="+code,
    type: "GET",
    async: false,
    contentType:"application/json",
    dataType: "json",
    success: function (r) {
		printData=r;		
    }
	});			
	printData["branchname"]=branch.getValue();
	printData["address1"]="27,Javulikara Street";
	printData["address2"]="Tiruletur - 610 001";
	printData["address3"]="Phone - 242292,240292";		
	printData["type"]="VCHER";
	$.ajax({
        url: "http://localhost:9191",
        type: "POST",
        async: false,
        contentType:"application/x-www-form-urlencoded",
        data:"printdata="+JSON.stringify(printData),
        dataType: "json",
        success: function (r) {
			//alert(r.result);		
        }
    });		
}