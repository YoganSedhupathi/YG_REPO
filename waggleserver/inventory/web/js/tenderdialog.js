

var salesCreditCardCharges=2;
var invCardMachines="";
function tenderCalculate(e,event){
	var amount=$(e).val();
	var key=event?event.keyCode:0;
	var c=String.fromCharCode(key);
	/*if(event.ctrlKey && key==113){
		$('#limenu').find('a[href="tcash"]').click();
	}else if(event.ctrlKey && key==114){
		$('#limenu').find('a[href="tcredit"]').click();
	}else if(event.ctrlKey && key==115){
		$('#limenu').find('a[href="tcreditcard"]').click();
	}else if(event.ctrlKey && key==116){
		$('#limenu').find('a[href="tcoupon"]').click();
	}else if(event.ctrlKey && key==117){
		$('#limenu').find('a[href="tcheque"]').click();
	}*/
	/*if(key!=190 && key!=110){
		amount=amount+c;
	}*/
	var amt=toNumber(amount);
	var amts=$('#tender input[inputType="DECIMAL"]');
	var s=amts.length;
	var totalTenderAmount=0;	
	for(a=0;a<s;a++){
		if(amts.eq(a).attr('id')!=$(e).attr('id') && amts.eq(a).attr('id')!="tdiscperc"){
			amts.eq(a).val('0');
			if(amts.eq(a).attr('id')=="tcreditcardamt"){
				$('#creditcardamt').val('0');
				$('#cardcharges').val('0');
				// $('#credittranno').val();
				// $('#cardbank').val();
				// $('#cardtype').val('');
				// $('#cardmachine').val('');

			}else if(amts.eq(a).attr('id')=="tcashamt"){
				
				$('#cashamt').val('0');
				$('#tendered').val('');
				$('#balance').val('');
			}
			totalTenderAmount=totalTenderAmount+toNumber(amts.eq(a).val());
		}
	}
	var bamt=$("#tenderdlg").data('billamount');
	var advamt=$("#tenderdlg").data('advanceamt');
	if($(e).attr('id')=="tcashamt"){
		// if(amount>(bamt-advamt)){
		// 	$('#cashamt').val((bamt-advamt));
		// }else{
		// 	$('#cashamt').val(amount);
		// }
		$('#cashamt').val(amount);
	}
	if($(e).attr('id')=="tcreditcardamt"){
		
		var creditCardAmount=amt;
		var totalCardAmount=creditCardAmount;
		
		var serviceChargeAmount=0;
		if(salesCreditCardCharges && salesCreditCardCharges!=0 && creditCardAmount>0){
			serviceChargeAmount=0;//creditCardAmount*2/100;
			totalCardAmount=creditCardAmount+serviceChargeAmount;
		}
		$('#creditcardamt').val(roundOff(totalCardAmount,2));
		
		$('#cardcharges').val(roundOff(serviceChargeAmount,2));
	}
	
	var bal=(totalTenderAmount+amt)-(bamt-advamt);
	if($('#tcashamt').length>0 && $('#tcashamt').val()!="" && Number($('#tcashamt').val())>0){
		$('#tendered').val(roundOff(totalTenderAmount+amt,2));
		$('#balance').val(roundOff(bal,2));
	}

	//console.log(bamt+" "+advamt+" "+amt+" "+totalTenderAmount+" "+bal+" "+amount+" "+(totalTenderAmount+amt));
	if($('#tcashamt').length==0){
		if(totalTenderAmount+amt<(bamt-advamt)){
			if(event){
				if(event.preventDefault){
					event.preventDefault();
					return;
				}else{
					event.returnValue = false;
					return; 
				};
			}
		}
	}
}

function showTenderDialog(tenderOptions,dlg,billamount,checkAmount,advanceAmount){
	if($('#tenderdlg').length==0){
		$('#ttender').append("<div class='modal-content' id='tenderdlg' tabindex='-1' role='dialog' aria-hidden='true'></div>");
	}
	let values=$("#"+dlg).data('tdata');
	$("#"+dlg).html("");
	$("#"+dlg).data('billamount',billamount);
	$("#"+dlg).data('checkamount',checkAmount);
	$("#"+dlg).data('advanceamt',advanceAmount);
	let modalDialog=$("<div class='modal-dialog' role='document'>");
	let modalContent=$("<div class='modal-content' >");
	modalDialog.append(modalContent);
	let tender=$("<div id='tender' class='modal-body'>");
	let tenderTitle=$("<div id='tendertitle' class='modal-header'><h5 class='modal-title'>Tender</h5><button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close></button></div>");
//	tenderTitle.append("<div class='pop_lov_clos'><a href='#'><span class='fa fa-times-circle'></span></a></div><div class='pop_lov_hed_txt'>Tender</div>");
	var navDiv=$("<div id='limenu' name='limenu' class='mt-2 mb-2'></div>");
	var header=$("<ul id='navigation' class='nav nav-pills nav-fill'></ul>");
	if(advanceAmount!=0){
		tender.append("<div class='card-total rounded-3' id='billLabel'>Bill Amount &nbsp;:&nbsp;"+roundOff(billamount,2)+" &nbsp;|&nbsp; Advance Amount&nbsp;:&nbsp;"+roundOff(advanceAmount,2) +"</div>");
	}else{
		tender.append("<div class='card-total rounded-3'><h6 class='dicount-type hstack gap-1'><span class='text-dark'>Bill Amount:</span><span class='net-amount' id='billLabel'>"+roundOff(billamount,2)+"</span></h6></div>");
	}	
	tender.append(navDiv);
	navDiv.append(header);
	if(tenderOptions.discount){
		tender.append($("<div name='content' id='tdiscount' class='mTBx' style='display:none'><div id='discountgroup' class='panelOrange hcH'><div id='tdetail_0' class='col-sm-12 col-md-12 col-lg-12 cBor'><div id='tdetail0' class='form-group mbotto'><label for='tdiscperc' class='col-sm-5 control-label mpRes' >Disc %:</label><div class='col-sm-7 mpRes'><input type='text' class='form-control' id='tdiscperc' inputType='DECIMAL' decimal='2' onkeydown='validate(this,event);' onkeyup='callDiscountCalc(this,event);'/></div></div><div class='clearfix'></div><div id='tdetail00' class='form-group mbotto'><label for='tdiscamt' class='col-sm-5 control-label mpRes' >Disc Amount:</label><div class='col-sm-7 mpRes'><input type='text' class='form-control' id='tdiscamt' disabled/></div></div></div></div>"));
		header.append("<li class='nav-item'><a class='nav-link' href='#tdiscount'>Discount</a></li>");
	}
	if(tenderOptions.cash){
		tender.append($("<div name='content' id='tcash' value='' class='mTBx' style='display:none'><div id='group1' class='panelOrange hcH'><div id='tdetail_0' class='col-sm-12 col-md-12 col-lg-12  cBor'><div id='tdetail0' class='form-group mbotto'><label for='cashamt' class='col-sm-5 control-label mpRes' >Cash Amount:</label><div class='col-sm-7 mpRes'><input type='text' class='form-control' id='tcashamt' inputType='DECIMAL' decimal='2' onkeydown='validate(this,event);' onkeyup='tenderCalculate(this,event);'/><input type='hidden' class='form-control' id='cashamt'/></div></div><div class='clearfix'></div><div id='tdetail00' class='form-group mbotto'><label for='tendered' class='col-sm-5 control-label mpRes' >Tendered:</label><div class='col-sm-7 mpRes'><input type='text' class='form-control' id='tendered' disabled/></div></div><div class='clearfix'></div><div id='tdetail000' class='form-group mbotto'><label for='balance' class='col-sm-5 control-label mpRes' >Balance:</label><div class='col-sm-7 mpRes'><input type='text' class='form-control' id='balance' disabled/></div></div><div class='clearfix'></div></div></div>"));
		header.append("<li class='nav-item '><a class='nav-link' href='#tcash'>Cash</a></li>");
	}
	if(tenderOptions.credit){
		tender.append($("<div name='content' id='tcredit' class='mTBx' style='display:none'><div id='group1' class='panelOrange hcH'><div id='tdetail_0' class='col-sm-12 col-md-12 col-lg-12 cBor'><div id='tdetail0' class='form-group mbotto'><label for='creditamt' class='col-sm-5 control-label mpRes'>Credit Amount:</label><div class='col-sm-7 mpRes'><input type='text' class='form-control' id='creditamt' inputType='DECIMAL' decimal='2' onkeydown='validate(this,event);' onkeyup='tenderCalculate(this,event);'/></div></div><div class='clearfix'></div></div></div>"));
		header.append("<li class='nav-item'><a class='nav-link' href='#tcredit'>Credit</a></li>");	
	}
	if(tenderOptions.creditcard){
		tender.append($("<div name='content' id='tcreditcard' class='mTBx' style='display:none'><div id='group1' class='panelOrange hcH'><div id='tdetail_0' class='col-sm-12 col-md-12 col-lg-12  cBor'><div id='tdetail0' class='form-group mbotto'><label class='col-sm-5 control-label mpRes'>Amount :</label><div class='col-sm-7 mpRes'><input type='text' id='tcreditcardamt' class='form-control' inputType='DECIMAL' decimal='2' onkeydown='validate(this,event);' onkeyup='tenderCalculate(this,event);'/></div></div><div class='clearfix'></div><div id='tdetail0' class='form-group mbotto'><label class='col-sm-5 control-label mpRes'>Card Charges :</label><div class='col-sm-7 mpRes'><input type='text' id='cardcharges' class='form-control' disabled/></div></div><div class='clearfix'></div><div id='tdetail0' class='form-group mbotto'><label class='col-sm-5 control-label mpRes'>Card Amount :</label><div class='col-sm-7 mpRes'><input type='text' id='creditcardamt' class='form-control' disabled/></div></div><div class='clearfix'></div><div id='tdetail0' class='form-group mbotto' style='display:none'><label class='col-sm-5 control-label mpRes'>Bank Name :</label><div class='col-sm-7 mpRes'><input type='text' id='cardbank' class='form-control' inputType='ALPHANUMERIC' onkeydown='validate(this,event);'/></div><div class='clearfix'></div></div></div><div id='tdetail_1' class='col-md-12 col-sm-12 col-lg-12 sBor'><div id='tdetail1' class='form-group mbotto' style='display:none'><label class='col-sm-5 control-label mpRes'>Trans. No :</label><div class='col-sm-7 mpRes'><input type='text' id='credittranno' class='form-control' inputType='ALPHANUMERIC' onkeydown='validate(this,event);'/></div></div><div class='sBor'></div><div id='tdetail1' class='form-group mbotto' style='display:none'><label class='col-sm-5 control-label mpRes'>Card Type :</label><div class='col-sm-7 mpRes'><input type='text' id='cardtype' class='form-control' inputType='ALPHANUMERIC' onkeydown='validate(this,event);'/></div><div class='clearfix'></div><label class='col-sm-5 control-label mpRes' style='display:none'>Card Machine :</label><div style='display:none' class='col-sm-7 mpRes'><select id='cardmachine' class='form-control'>"+invCardMachines+"</select></div></div></div></div></div>"));
		header.append("<li class='nav-item'><a class='nav-link' href='#tcreditcard'>Credit Card</a></li>");
	}
	if(tenderOptions.coupon){
		tender.append($("<div name='content' id='tcoupon' class='mTBx' style='display:none'><div id='group1' class='panelOrange hcH'><div id='tdetail_0' class='col-sm-12 col-md-12 col-lg-12  cBor'><div id='tdetail0' class='form-group mbotto'><label class='col-sm-5 control-label mpRes'>Amount :</label><div class='col-sm-7 mpRes'><input type='text' id='couponamt' class='form-control' inputType='DECIMAL' decimal='2' onkeydown='validate(this,event);' onkeyup='tenderCalculate(this,event);'/></div></div><div class='clearfix'></div><div class='clearfix'></div></div><div id='tdetail_1' class='col-sm-12 col-md-12 col-lg-12 sBor'><div id='tdetail1' class='form-group mbotto'><label class='col-sm-5 control-label mpRes'>Coupon No :</label><div class='col-sm-7 mpRes'><input type='text' id='couponno' class='form-control' inputType='ALPHANUMERIC' onkeydown='validate(this,event);'/></div></div><div class='clearfix'></div></div></div></div>"));
		header.append("<li class='nav-item'><a class='nav-link' href='#tcoupon'>Coupon</a></li>");	
	}
	if(tenderOptions.sponsor){
		tender.append($("<div name='content' id='tcoupon' class='mTBx' style='display:none'><div id='group1' class='panelOrange hcH'><div id='tdetail_0' class='col-sm-12 col-md-12 col-lg-12 sBor'><div id='tdetail0' class='form-group mbotto'><label class='col-sm-5 control-label mpRes'>Amount :</label><div class='col-sm-7 mpRes'><input type='text' id='couponamt' class='form-control' inputType='DECIMAL' decimal='2' onkeydown='validate(this,event);' onkeyup='tenderCalculate(this,event);'/></div></div><div class='clearfix'></div><div class='clearfix'></div></div><div id='tdetail_1' class='col-sm-12 col-md-12 col-lg-12 sBor'><div id='tdetail1' class='form-group mbotto'><label class='col-sm-5 control-label mpRes'> No :</label><div class='col-sm-7 mpRes'><input type='text' id='couponno' class='form-control' inputType='ALPHANUMERIC' onkeydown='validate(this,event);'/></div></div><div class='clearfix'></div></div></div></div>"));
		header.append("<li class='nav-item'><a class='nav-link' href='#tcoupon'>Corporate</a></li>");	
	}
	if(tenderOptions.cheque){
		//tender.append($("<div name='content' id='tcheque' class='col-sm-14 col-md-14 col-lg-14 mTBx' style='display:none'><label>Cheque Amount :</label><input type='text' id='chequeamt' inputType='DECIMAL' decimal='2' onkeydown='validate(this,event);' onkeyup='tenderCalculate(this,event);'/><label>Cheque No :</label><input type='text' id='chequeno' inputType='ALPHANUMERIC' onkeydown='validate(this,event);'/><label>Cheque Date :</label><input type='text' id='chequedate' inputType='DATEPICKER' onkeydown='validate(this,event);'/><label>Bank Name :</label>	<input type='text' id='bankname' inputType='ALPHANUMERIC' onkeydown='validate(this,event);'/><label>Bank Branch :</label><input type='text' id='bankbranch' inputType='ALPHANUMERIC' onkeydown='validate(this,event);'/></div>"));
		tender.append($("<div name='content' id='tcheque' class='mTBx' style='display:none'><div id='group1' class='panelOrange hcH'><div class='col-sm-12 col-md-12 col-lg-12'><div class='form-group extrBT'><label class='col-sm-5 control-label mpRes' >Amount :</label><div class='col-sm-7 mpRes'><input type='text' id='chequeamt' inputType='DECIMAL' decimal='2' class='form-control' onkeydown='validate(this,event);' onkeyup='tenderCalculate(this,event);'/></div></div><div class='clearfix'></div><div class='form-group extrBT'><label class='col-sm-5 control-label mpRes' >Date :</label><div class='col-sm-7 mpRes'><input type='text' id='chequedate' inputType='DATEPICKER' class='hasDatepicker form-control' onkeydown='validate(this,event);'/></div></div>	<div class='clearfix'></div><div class='form-group extrBT'><label class='col-sm-5 control-label mpRes' >Branch :</label><div class='col-sm-7 mpRes'><input type='text' id='bankbranch' class='form-control' inputType='ALPHANUMERIC' onkeydown='validate(this,event);'/></div></div><div class='clearfix'></div></div><div class='col-sm-12 col-md-12 col-lg-12'><div class='form-group extrBT'><label class='col-sm-5 control-label mpRes' >Cheque No :</label><div class='col-sm-7 mpRes'><input type='text' id='chequeno' inputType='ALPHANUMERIC' class='form-control' onkeydown='validate(this,event);'/></div></div><div class='clearfix'></div><div class='form-group extrBT'><label class='col-sm-5 control-label mpRes' >Bank :</label><div class='col-sm-7 mpRes'><input type='text' id='bankname' class='form-control' inputType='ALPHANUMERIC' onkeydown='validate(this,event);'/></div></div><div class='clearfix'></div></div></div></div></div><div class='clearfix'></div>"));
		
		header.append("<li class='nav-item'><a class='nav-link' href='#tcheque'>Cheque</a></li>");	
	}
	tender.append("<div id='tenderbutton' style='float:right'><button type='button' class='btn btn-save' id='btnTenderOk' onclick=\"tenderOk('"+dlg+"')\">Ok</button><button type='button' class='btn btn-default' onclick=\"tenderCancel('"+dlg+"')\">Cancel</button></div>");
	
	// header.find("button").eq(1).attr('class','active');
	// header.find("button").bind('click',onTenderTitleClick);
	header.find("li").eq(0).attr('class','active');
	header.find("li>a").bind('click',onTenderTitleClick);
	
	//$('#'+dlg).append(tenderTitle);
	modalContent.append(tenderTitle);
	//$('#'+dlg).append(tender);
	modalContent.append(tender);
	$('#'+dlg).append(modalDialog);
	$('#'+dlg).data('tenderOptions',tenderOptions);	

	$('#'+dlg).modal({backdrop:'static',width:'auto',minHeight:400,minWidth:300,close:handleClose});
		$('#'+dlg).on('hidden.bs.modal', function (e) {
			//handleClose();
		});


	// $('#'+dlg).dialog({autoOpen:false,modal:true,height:'auto',minHeight:300,minWidth:550,position:'center',close: function(event, ui)
    //     {
	// $(this).modal('destroy').remove();
    //     }});
	$('#'+dlg).modal('show');
	
	$('.butt_sav').click(function(e){
		e.preventDefault();
	});
	$('.butt_can').click(function(e){
		e.preventDefault();
	});	
	if(tenderOptions.discount){
		header.find("li").eq(1).find("a").click();		
	}else{
		header.find("li").eq(0).find("a").click();		
	}
	var total=0; 
	if(values!=null){
		if(values.cashdiscperc){
			$('#tdiscperc').val(values.cashdiscperc);
			callDiscountCalc($('#tdiscperc')[0]);
		}
		if(values.cashamount){
			$('#cashamt').val("values.cashamount");
			total=total+toNumber(values.cashamount);
		}
		if(values.creditamount){
			$('#creditamt').val(values.creditamount);
			total=total+toNumber(values.creditamount);
		}
		if(values.ccamount){
			$('#creditcardamt').val(values.ccamount);
			$('#tcreditcardamt').val('');
			// $('#credittranno').val(values.cctranno);
			// $('#cardbank').val(values.ccbank);
			// $('#cardtype').val(values.cctype);
			$('#cardcharges').val(values.cardcharges);
			// $('#cardmachine').val(values.cardmachine);
			total=total+toNumber(values.ccamount);
		}
		if(values.couponamount){
			$('#couponamt').val(values.couponamount);
			$('#couponno').val(values.couponno);
			total=total+toNumber(values.couponamount);
		}
		if(values.chequeamount){
			$('#chequeamt').val(values.chequeamount);
			$('#chequeno').val(values.chequeno);
			$('#chequedate').val(values.chequedate);
			$('#bankname').val(values.chqbankname);
			$('#bankbranch').val(values.chqbankbranch);
			total=total+toNumber(values.chequeamount);
		}
		if(tenderOptions.cash){
			$('#tcashamt').val("");
			// $('#tcashamt').val((toNumber(values.tendered)-total)+toNumber($('#cashamt').val()));
		}
	}
	if(tenderOptions.cash){
		$('#tcash').css('display','block');
		$('#btnTenderOk').css('display','inline-block');
		$('#tcashamt').focus();		
	}else if(tenderOptions.discount){
		$('#tdiscount').css('display','block');
		$('#tdiscperc').focus();		
		$('#btnTenderOk').css('display','none');
	}else if(tenderOptions.credit){
		$('#tcredit').css('display','block');
		$('#btnTenderOk').css('display','inline-block');
		$('#creditamt').focus();		
	}else if(tenderOptions.creditcard){
		$('#tcreditcard').css('display','block');
		$('#btnTenderOk').css('display','inline-block');
		$('#creditcardamt').focus();		

	}else if(tenderOptions.sponsor || tenderOptions.coupon){
		$('#tcoupon').css('display','block');
		$('#btnTenderOk').css('display','inline-block');
		$('#couponamt').focus();		
	}else if(tenderOptions.cheque){
		$('#tcheque').css('display','block');
		$('#btnTenderOk').css('display','inline-block');
		$('#chequeamt').focus();		
	}	
}
function onTenderTitleClick(e,event){
	let a=$(e.target);
	$('#limenu').find("li").removeClass('active');
	a.parent().addClass('active');
	$("#tender [name='content']").css('display','none');
	let link=a.attr('href');
	$(link).css('display','block');
	if(link=="#tdiscount"){
		$('#tdiscperc').focus();
		$('#btnTenderOk').css('display','none');
	}else if(link=="#tcash"){
		$('#tcashamt').focus();
		$('#btnTenderOk').css('display','inline-block');
	}else if(link=="#tcredit"){
		$('#creditamt').focus();
		$('#btnTenderOk').css('display','inline-block');
	}else if(link=="#tcreditcard"){
		$('#creditcardamt').focus();
		$('#btnTenderOk').css('display','inline-block');
	}else if(link=="#tcoupon"){
		$('#couponamt').focus();
		$('#btnTenderOk').css('display','inline-block');
	}else if(link=="#tcheque"){
		$('#chequeamt').focus();
		$('#btnTenderOk').css('display','inline-block');
	}
	e.preventDefault();
}
function tenderOk(dlg){
			let tenderOptions=$('#'+dlg).data('tenderOptions');
        	let values={};
        	let billType="";
        	let totalAmount=0;
        	values.cashamount="0";
        	values.creditamount="0";
        	values.ccamount="0";
        	values.cctranno="";
			values.ccbank="";
			values.cctype="";
			values.couponamount="0";
			values.couponno="";
			values.chequeamount="0";
			values.chequeno="";
			values.chequedate="";
			values.chqbankname="";
			values.chqbankbranch="";
			values.totalamount="0";
			values.tendered="0";
			values.balance="0"; 
			values.cardmachine="0";           	
			if(tenderOptions.discount){
				
				values.cashdiscperc=$('#tdiscperc').val();
			}
			if(tenderOptions.cash){
				values.cashamount=$('#cashamt').val();
				if(toNumber(values.cashamount)>0){
					billType='CA';
				}else if(toNumber(values.cashamount)==0){
					values.cashamount='0';
				}
				totalAmount=totalAmount+toNumber(values.cashamount);

				if($('#tendered').length>0 && $('#tendered').val()!="" && Number($('#tendered').val())>0){
					values.tendered=$('#tendered').val();
					values.balance=$('#balance').val();
				}				
			}
			if(tenderOptions.credit){
				values.creditamount=$('#creditamt').val();
				if(toNumber(values.creditamount)>0 && billType!=""){
					billType='SP';
				}else if(toNumber(values.creditamount)>0){
					billType='CR';
				}else if(toNumber(values.creditamount)==0){
					values.creditamount='0';
				}
				totalAmount=totalAmount+toNumber(values.creditamount);
			}
			if(tenderOptions.creditcard){
				var creditCardAmount=toNumber($('#tcreditcardamt').val());
				var totalCardAmount=toNumber($('#creditcardamt').val());
				var serviceChargeAmount=toNumber($('#cardcharges').val());
				values.ccamount=roundOff(totalCardAmount,2);
				values.cctranno=$('#credittranno').val();
				values.ccbank=$('#cardbank').val();
				values.cctype=$('#cardtype').val();
				values.cardmachine=$('#cardmachine').val();
				values.cardcharges=roundOff(serviceChargeAmount,2);
				values.cardtender=roundOff(creditCardAmount,2);
				if(toNumber(values.ccamount)>0 && billType!=""){
					billType='SP';
				}else if(toNumber(values.ccamount)>0){
					billType='CC';
				}else if(toNumber(values.ccamount)==0){
					values.ccamount='0';
				}
				var netTotal=toNumber(screenObjects.getScreenObject("totalamt").getValue())+serviceChargeAmount;
				screenObjects.getScreenObject("totalamt").setValue(roundOff(netTotal,2));
				totalAmount=totalAmount+toNumber(values.ccamount);
				/*if(values.ccamount>0 && values.cardmachine=="0"){
					alert("Please select the card machine and continue");
					return;
				}else if(values.ccamount==0 && values.cardmachine!="0"){
					values.cardmachine="0";
				}*/
			}
			if(tenderOptions.coupon){
				values.couponamount=$('#couponamt').val();
				values.couponno=$('#couponno').val();
				if(toNumber(values.couponamount)>0 && billType!=""){
					billType='SP';
				}else if(toNumber(values.couponamount)>0){
					billType='CO';
				}else if(toNumber(values.couponamount)==0){
					values.couponamount='0';
				}				
				totalAmount=totalAmount+toNumber(values.couponamount);
			}
			if(tenderOptions.sponsor){
				values.couponamount=$('#couponamt').val();
				values.couponno=$('#couponno').val();
				if(toNumber(values.couponamount)>0 && billType!=""){
					billType='SP';
				}else if(toNumber(values.couponamount)>0){
					billType='CO';
				}else if(toNumber(values.couponamount)==0){
					values.couponamount='0';
				}				
				totalAmount=totalAmount+toNumber(values.couponamount);
			}
			if(tenderOptions.cheque){
				values.chequeamount=$('#chequeamt').val();
				values.chequeno=$('#chequeno').val();
				values.chequedate=$('#chequedate').val();
				values.chqbankname=$('#bankname').val();
				values.chqbankbranch=$('#bankbranch').val();
				if(toNumber(values.chequeamount)>0 && billType!=""){
					billType='SP';
				}else if(toNumber(values.chequeamount)>0){
					billType='CQ';
				}else if(toNumber(values.chequeamount)==0){
					values.chequeamount='0';
				}
				totalAmount=totalAmount+toNumber(values.chequeamount);				
			}
			var bamt=$("#"+dlg).data('billamount');
			var camt=$("#"+dlg).data('checkamount') || false;
			var advamt=$("#"+dlg).data('advanceamt');
			if(camt && totalAmount<(bamt-advamt)){
				alert("Total tender amount cannot be less than the bill amount");
				return;
			}
			values.billType=billType;
			values.totalamount=roundOff(totalAmount,2);
			$("#"+dlg).data('tdata',values);
			if(onTenderDialogOk){
				onTenderDialogOk(values);
			}
			$('#'+dlg).modal('hide');
			////$('#'+dlg).dialog('destroy');		
}


function tenderCancel(dlg){
	
	if(screenObjects.getScreenObject("invoice_data")!=null){
		screenObjects.getScreenObject("invoice_data").getInputField().focus();
	}else if(screenObjects.getScreenObject("return_data")!=null){
		screenObjects.getScreenObject("return_data").getInputField().focus();
	}
	$('#'+dlg).modal('hide');
}

function handleClose(){

  if(window[options.closeFunction]){
	  window[options.closeFunction]();
  }
	   

}