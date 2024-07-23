var printPOInTextFormat=false;
function getAttributeDetail(id,me,row,col){
	let cols=screenObjects.getScreenObject("order_data").getCols();
	if(me.getCellTag(row,cols.product)!="" && !poscreen.getSaveInProgress()){
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
	let totalServiceTax=0;
	let netTotal=0;
	let totalDisc=0;
	let t=screenObjects.getScreenObject("order_data");
	let cols=t.getCols();
	let s=t.getSize();
	for(let i=0;i<s;i++){
		total+=toNumber(t.getText(i,cols.amount));
		totalTax+=toNumber(t.getText(i,cols.ptaxamt));
		totalServiceTax+=toNumber(t.getText(i,cols.srtaxamt));
		totalDisc+=toNumber(t.getText(i,cols.discamt));
		netTotal+=toNumber(t.getText(i,cols.netamount));
	}
	screenObjects.getScreenObject("total").setValue(roundOff(total,2));
	screenObjects.getScreenObject("taxamt").setValue(roundOff(totalTax,2));
	screenObjects.getScreenObject("discamt").setValue(roundOff(totalDisc,2));
	screenObjects.getScreenObject("servtaxamt").setValue(roundOff(totalServiceTax,2));
	let pf=toNumber(screenObjects.getScreenObject("pf").getValue());
	netTotal+=pf;
	screenObjects.getScreenObject("totalamt").setValue(roundOff(netTotal,2));
	
	
	$("#totamt").html(roundOff(total,2));
	$("#gross").html(roundOff(total,2));
	$("#vat").html(roundOff(totalTax,2));
	$("#disc").html(roundOff(totalDisc,2));
	$("#netAmt").html(""+roundOff(netTotal,2));
	
}
function calculateAmount(row){
	let t=screenObjects.getScreenObject("order_data");
	let cols=t.getCols();	
	let baseqty=0;
	let rate=0;
	let mrp=0;
	let selling=0;
	baseqty=toNumber(t.getText(row,cols.conversionvalue))*toNumber(t.getText(row,cols.quantity));	
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
		rate=toNumber(t.getText(row,cols.rate));
		mrp=t.getText(row,cols.mrp);
		selling=t.getText(row,cols.selling);
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
	let servTax=0;	
	let netAmt=0;
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
	let d=poscreen.processDataToSave();
	if("FAILED"!=d){
		let s=new FlexUI.Ajax();
		showLoader();
		let r=s.callAjax("POST","/inventory/service/purchaseorder",d);
		hideLoader();
		if(r.result=="Success"){
			alert(r.message+" [No:"+r.orderno+"]");
			let ps=JSON.parse(d.replace("data=","")).savedata;
			ps["orderno"]=r.orderno;
			if(printPOInTextFormat){
				printPO(ps);
			}else{
				writePOPDF(r.key);
			}
			add(id,me);
			return r.key;			
		}else{
			alert(r.message);		
		}
	return 0;
}
}
function delete1(id,me){
	poscreen.setOperation("DELETE");	
	let l={url:"/inventory/service/ajax",ajax:"purchaseorder",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}	
function add(id,me){
	poscreen.clearScreen();
	setDefaultBranch();
	poscreen.setOperation("ADD");
	screenObjects.getScreenObject("suppname").focus();
}
function edit(id,me){
	poscreen.setOperation("EDIT");	
	let l={url:"/inventory/service/ajax",ajax:"purchaseorder",scrollEnabled:true,searchFromList:false,dsi:2,params:[{n:"branch",src:"branch",ft:true},{n:"location",src:"location",ft:true}],results:[{tgt:"code",id:"0",tt:false}],closeFunction:"onEscClose"};
	let lov=new FlexUI.LOV("e_lov",me,l);
	lov.onLovClose.subscribe(onEditClose);
	lov.show();
}
function onEditClose(e,args){
    let branch=screenObjects.getScreenObject("branch");	
	branch.focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/purchaseorder","orderno="+args.result[0]+"&branch="+branch.getTag());
	add('','');
	poscreen.setOperation("EDIT");
	poscreen.loadData(r);
	calculateTotal();
	hideLoader();
}
function loadDataView(no){	
    let branch=screenObjects.getScreenObject("branch");	
	branch.focus();
	let a=new FlexUI.Ajax();
	showLoader();
	let r=a.callAjax("GET","/inventory/service/purchaseorder","orderno="+no+"&branch="+branch.getTag());
	poscreen.disableInputs(true);
	poscreen.loadData(r);
	calculateTotal();
	hideLoader();
}
function onAttributeClose(me,row,col){
	let cols=screenObjects.getScreenObject("order_data").getCols();
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
function setDefaultBranch(){
	let branch=screenObjects.getScreenObject("branch");
	let location=screenObjects.getScreenObject("location");
	branch.setTag(defbranch[0][1]);
	branch.setValue(defbranch[0][0]);
	location.setTag(defbranch[0][3]);
	location.setValue(defbranch[0][2]);	
	screenObjects.getScreenObject("suppname").focus();	
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
function loadIndentItems(id,me){
	let branch=screenObjects.getScreenObject("branch").getTag();
	let suppcode=screenObjects.getScreenObject("suppname").getTag();	
	let purdata=null;
	if(!poscreen.getSaveInProgress()){
	$.ajax({
		   url: "/inventory/service/ajax?ro=true&ic=0&id=indentproducts&suppcode="+suppcode+"&branch="+branch,
           type: "GET",
           async: false,
           contentType:"application/json",
           dataType: "json",
           success: function (r) {
			 purdata=r;		
           }
	});
	if(purdata!=null){
		/*{"pm_name":"AQUATEL CH 40","pm_code":"714","pm_pg_code":"1","pm_batch":"1","pm_expiry":"1","ptc_stax"
:"5","ptc_ptax":"5","ptc_pinclusive":"0","pm_ugm_id":"1","pm_purchaseunit":"10","um_name":"10's","pm_transferunit"
:"1","pm_saleunit":"1","cm_conv_value":"10.00000000","pm_unit":"1","pm_allownegative":"0","ptc_pserv_tax"
:"0.00000","pm_serialized":"0","pm_attributes":"0","pm_costtype":"0","unitprice":"1","orderqty":"14"
,"ind_id":"1"}*/
		let t=screenObjects.getScreenObject("order_data");
		let cols=t.getCols();
		let s=purdata.data.length;
		let indent=purdata.data;			
		for(let i=0;i<s;i++){
			if(i==t.getSize()){
				t.addRow();
				t.checkAndMove("Down",true);							
			}
			t.setText(i,cols.product,indent[i].pm_name);
			t.setCellTag(i,cols.product,indent[i].pm_code);
			t.setText(i,cols.pgcode,indent[i].pm_pg_code);
			t.setText(i,cols.staxperc,indent[i].ptc_stax);
			t.setText(i,cols.ptaxperc,indent[i].ptc_ptax);
			t.setText(i,cols.srtaxperc,indent[i].ptc_pservtax);
			t.setText(i,cols.taxincl,indent[i].ptc_pinclusive);
			t.setText(i,cols.unitgroup,indent[i].pm_ugm_id);
			t.setText(i,cols.unitname,indent[i].um_name);
			t.setText(i,cols.unitid,indent[i].pm_purchaseunit);
			t.setText(i,cols.funitname,indent[i].um_name);
			t.setText(i,cols.funitid,indent[i].pm_purchaseunit);
			t.setText(i,cols.conversionvalue,indent[i].cm_conv_value);
			t.setCellTag(i,cols.conversionvalue,indent[i].unitprice);
			t.setText(i,cols.isattribute,indent[i].pm_attributes);
			t.setText(i,cols.serialized,indent[i].pm_serialized);
			t.setText(i,cols.indentid,indent[i].ind_id);
			t.setText(i,cols.quantity,indent[i].orderqty);
			t.setText(i,cols.freeqty,indent[i].freeqty);
			onAttributeClose(t,i,cols.product);			
			calculateAmount(i);
		}
		calculateTotal();
	}
	}
	return true;
}
function printPO(data){
		let t=screenObjects.getScreenObject("order_data");
		let cols=t.getCols();
		let printData={};
		printData["type"]="POA";
		printData["branchcode"]=data["branch"];
		printData["company"]="N.G.D.C PHARMACY";
		printData["address1"]="No.11, DURGALAYA ROAD";
		printData["address2"]="Tiruletur - 610 001";
		printData["address3"]="Phone - 9489985111";
		printData["tin"]="";
		printData["orderno"]=data["orderno"];
		printData["orderdate"]=data["orderdate"];
		printData["tax"]=data["taxamt"];
		printData["totalamt"]=data["totalamt"]+"";
		printData["suppname"]=data.name;
		printData["items"]=[];
		for(let x=0;x<data["order_data"].v.length;x++){
			let item={};
			item.name=t.getText(x,cols.product);
			item.sno=t.getText(x,cols.sno);
			item.unit=data["order_data"].v[x][cols.unitname]+"";
			item.quantity=data["order_data"].v[x][cols.quantity]+"";
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
				
            }
        });		
}
function writePOPDF(poNo){
	let branchCode=screenObjects.getScreenObject("branch").getTag();
	window.open("/inventory/service/purchaseorder/print?branchcode="+branchCode+"&pokey="+poNo,"_blank");
}



function checkPrevPurchaseorderMrp(id,me,row,col){
	let cols=screenObjects.getScreenObject("order_data").getCols();
	
	if(toNumber(me.getText(row,cols.mrp))<toNumber(me.getText(row,cols.rate)))
		{
			setErrorMessage("Mrp should not be less than the  Pur.Rate");
			// alert("Mrp should not be less than the  Pur.Rate");	
			return false;
		}
		if(toNumber(me.getText(row,cols.mrp))<toNumber(me.getText(row,cols.selling)))
		{
			setErrorMessage("Mrp should not be less than the  Selling.Rate");
			// alert("Mrp should not be less than the  Selling.Rate");	
			return false;
		}
	return true;
}


function checkPoSellingrate(id,me,row,col){
	let cols=screenObjects.getScreenObject("order_data").getCols();
	
	if(toNumber(me.getText(row,cols.selling))<toNumber(me.getText(row,cols.rate)))
		{
			setErrorMessage("Selling Rate  should not be less than the  Rate");
			// alert("Selling Rate  should not be less than the  Rate");	
			return false;
		}
	// if(toNumber(me.getText(row,cols.selling))>toNumber(me.getText(row,cols.mrp)))
	// {
	// 	alert(" Selling.Rate should not be greater than the Mrp");	
	// 	return false;
	// }
	return true;
}
