function setDefaultBranch(){
	let branch=screenObjects.getScreenObject("branch");
	let mode=screenObjects.getScreenObject("mode");
	branch.setTag(defbranch[0][1]);
	branch.setValue(defbranch[0][0]);
	onModeChange('mode',mode);	
	screenObjects.getScreenObject("trantype").focus();
}
function onModeChange(id,me){
	screenObjects.getScreenObject("bankledger").setMandatory(false);
	screenObjects.getScreenObject("chequeno").setMandatory(false);
	screenObjects.getScreenObject("chequedate").setMandatory(false);
	screenObjects.getScreenObject("bankname").setMandatory(false);
	screenObjects.getScreenObject("bankbranch").setMandatory(false);
	screenObjects.getScreenObject("cardtype").setMandatory(false);
	screenObjects.getScreenObject("cardtranno").setMandatory(false);
	if(me.getValue()=='CA'){
		payments.showHideGroup('chequedetails',false);
		payments.showHideGroup('carddetails',false);
		payments.showHideGroup('bankdetails',false);
	}else if(me.getValue()=='CC'){
		payments.showHideGroup('chequedetails',false);
		payments.showHideGroup('carddetails',true);	
		payments.showHideGroup('bankdetails',true);
		screenObjects.getScreenObject("bankledger").setMandatory(true);
		screenObjects.getScreenObject("cardbank").setMandatory(true);
		screenObjects.getScreenObject("cardtype").setMandatory(true);
		screenObjects.getScreenObject("cardtranno").setMandatory(true);
	}else if(me.getValue()=='CQ'){
		payments.showHideGroup('chequedetails',true);
		payments.showHideGroup('carddetails',false);
		payments.showHideGroup('bankdetails',true);	
		screenObjects.getScreenObject("bankledger").setMandatory(true);
		screenObjects.getScreenObject("chequeno").setMandatory(true);
		screenObjects.getScreenObject("chequedate").setMandatory(true);
		screenObjects.getScreenObject("bankname").setMandatory(true);
		screenObjects.getScreenObject("bankbranch").setMandatory(true);
	}
}
function onPaidChange(id,me){
	let totalAdjustedAmount=0;
	let netAmount=0;
	let discount=screenObjects.getScreenObject('discount');
	let charges=screenObjects.getScreenObject('charges');
	let totalAmt=screenObjects.getScreenObject('total');
	let netAmt=screenObjects.getScreenObject('totalamt');
	totalAdjustedAmount=toNumber(totalAmt.getValue());
	netAmount=totalAdjustedAmount-toNumber(discount.getValue())+toNumber(charges.getValue());
	netAmt.setValue(roundOff(netAmount,2));
}

function delete1(id,me){
	payments.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"payments",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	
function add(id,me){
	payments.clearScreen();
	payments.setSaveInProgress(false);
	setDefaultBranch();
	payments.setOperation("ADD");
	screenObjects.getScreenObject("refno").focus();
	onVoucherTypeChange();
	onModeChange("mode",screenObjects.getScreenObject("mode"));
}
function edit(id,me){
	payments.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"alltrans",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	screenObjects.getScreenObject("refno").focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/account","code="+args.result[3]);
	payments.loadData(r);
	onModeChange("mode",screenObjects.getScreenObject("mode"));
	screenObjects.getScreenObject("address").setValue(r.address1.v+','+r.address2.v+','+r.city.v+'-'+r.pincode.v);
	hideLoader();
}
function save(id,me){
	if(payments.getSaveInProgress()) return;
	let totalAmt=screenObjects.getScreenObject('total');
	let paytype=screenObjects.getScreenObject('mode');
	let code=screenObjects.getScreenObject('code');
	let bankledger=screenObjects.getScreenObject('bankledger');
	if(paytype=="CQ" || paytype=="CC"){
		if(bankledger.getTag()=="" || banklegder.getTag()!="0"){
			alert("Please select the bank ledger for banking transactions");
			return;
		}
	}
	if(toNumber(totalAmt.getValue())<=0){
		alert("Total Amount should be greater than zero");
		return;
	}
	if(toNumber(code.getValue())!=0){
		payments.setOperation("EDIT");
	}
	let d=payments.processDataToSave();
	payments.setSaveInProgress(true);
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/account",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			printPayment(r.vno);			
			payments.clearScreen();
			payments.setSaveInProgress(false);
			setDefaultBranch();
			return r.key;			
		}else{
			payments.setSaveInProgress(false);
			alert(r.message);		
		}
		return 0;
	}else{
		payments.setSaveInProgress(false);
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
function onVoucherTypeChange(id,me){
	let vtype=screenObjects.getScreenObject("trantype").getValue();
	let account=screenObjects.getScreenObject("account");
	if(vtype=="1"){
		account.getLovOptions().ajax="expledgers";		
	}else if(vtype=="2"){
		account.getLovOptions().ajax="expledgers";
	}else if(vtype=="3"){
		account.getLovOptions().ajax="cashbanks";
	}
}