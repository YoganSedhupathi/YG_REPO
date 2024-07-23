function fetchCustomer(id,me){
	if(!cust.getSaveInProgress()){
		let v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=checkcustomer&mobileno="+me.getValue());
		if(v!=null && v?.data!=null && v.data.length>0){
			screenObjects.getScreenObject("account").setTag(v.data[0][0]);
			screenObjects.getScreenObject("account").setValue(v.data[0][1]);
			screenObjects.getScreenObject("address1").setValue(v.data[0][3]);
			screenObjects.getScreenObject("address2").setValue(v.data[0][4]);
			screenObjects.getScreenObject("city").setValue(v.data[0][5]);
			screenObjects.getScreenObject("pincode").setValue(v.data[0][6]);
			screenObjects.getScreenObject("address").setValue(v.data[0][3]+", "+v.data[0][4]+", "+v.data[0][5]+", "+v.data[0][6]);
			screenObjects.getScreenObject("creditdays").setValue(v.data[0][7]);
			screenObjects.getScreenObject("showcreditdays").setValue(v.data[0][7]);
		}
	}
	return true;
}

function setDefaultBranch(){
	let branch=screenObjects.getScreenObject("branch");
	let mode=screenObjects.getScreenObject("mode");
	branch.setTag(defbranch[0][1]);
	branch.setValue(defbranch[0][0]);
	onModeChange('mode',mode);	
	screenObjects.getScreenObject("refno").focus();
}
function onModeChange(id,me){
	if(me.getValue()=='CA'){
		cust.showHideGroup('chequedetails',false);
		cust.showHideGroup('carddetails',false);
		cust.showHideGroup('bankdetails',false);
	}else if(me.getValue()=='CC'){
		cust.showHideGroup('chequedetails',false);
		cust.showHideGroup('carddetails',true);	
		cust.showHideGroup('bankdetails',true);
	}else if(me.getValue()=='CQ'){
		cust.showHideGroup('chequedetails',true);
		cust.showHideGroup('carddetails',false);
		cust.showHideGroup('bankdetails',true);	
	}
}
function validateSelected(id,me,row,col){
	if(!cust.getSaveInProgress()){
		let t=screenObjects.getScreenObject("outstanding_data");
		let cols=t.getCols();
		if(col!=undefined){
			if("true"==t.getText(row,col) && toNumber(t.getText(row,cols.received))==0){
				t.setText(row,cols.received,t.getText(row,cols.balance));
			}else if("false"==t.getText(row,col)){
				t.setText(row,cols.received,"");
			}
		}
	}
	return true;	
}
function onReceivedChange(id,me){
	let t=screenObjects.getScreenObject("outstanding_data");
	let totalAdjustedAmount=0;
	let netAmount=0;
	let s=t.getSize();
	let cols=t.getCols();
	let discount=screenObjects.getScreenObject('discount');
	let charges=screenObjects.getScreenObject('charges');
	let totalAmt=screenObjects.getScreenObject('total');
	let netAmt=screenObjects.getScreenObject('totalamt');
	for(let x=0;x<s;x++){
		if(t.getText(x,cols.selected)){
			if(t.getText(x,cols.osdtype)=='R'){
				totalAdjustedAmount=totalAdjustedAmount+toNumber(t.getText(x,cols.received));
			}else{
				totalAdjustedAmount=totalAdjustedAmount-toNumber(t.getText(x,cols.received));
			}
		}				
	}
	netAmount=totalAdjustedAmount-toNumber(discount.getValue())+toNumber(charges.getValue());
	totalAmt.setValue(roundOff(totalAdjustedAmount,2));
	netAmt.setValue(roundOff(netAmount,2));
	
	
	$("#totamt").html(roundOff(totalAdjustedAmount,2));
	$("#netAmt").html(roundOff(netAmount,2));
	
}

function delete1(id,me){
	cust.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"receipts",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	
function add(id,me){
	cust.clearScreen();
	setDefaultBranch();
	cust.setOperation("ADD");
	screenObjects.getScreenObject("refno").focus();
}
function edit(id,me){
	cust.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"receipts",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){	
	screenObjects.getScreenObject("refno").focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/account","code="+args.result[3]);
	cust.loadData(r);
	cust.setOperation("EDIT");
	onModeChange("mode",screenObjects.getScreenObject("mode"));
	onReceivedChange();
	screenObjects.getScreenObject("address").setValue(r.address1.v+','+r.address2.v+','+r.city.v+'-'+r.pincode.v);
	
	hideLoader();
}
function save(id,me){
	let totalAmt=screenObjects.getScreenObject('total');
	let code=screenObjects.getScreenObject('code');
	if(toNumber(totalAmt.getValue())<0){
		alert("Total Adjusted Amount cannot be less than zero");
		return;
	}
	let paytype=screenObjects.getScreenObject('mode');
	let bankledger=screenObjects.getScreenObject('bankledger');
	if(paytype=="CQ" || paytype=="CC"){
		if(bankledger.getTag()=="" || banklegder.getTag()!="0"){
			alert("Please select the bank ledger for banking transactions");
			return;
		}
	}
	if(toNumber(code.getValue())!=0){
		cust.setOperation("EDIT");
	}
	let d=cust.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/account",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.billno+"]");
			printPayment(r.vno);
			cust.clearScreen();
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
	printData["address1"]="52,South Street";
	printData["address2"]="Aruppukottai - 626101";
	printData["address3"]="Phone - 222273,220936";		
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