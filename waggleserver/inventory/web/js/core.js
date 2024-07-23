(function ($) {
$.extend(true, window, {
    "FlexUI": {
      "Event": Event,
      "EventData":EventData,
      "ScreenObjects":ScreenObjects
      }
      });
      
  function ScreenObjects() {
  	let screenObjects={};
  	
  	this.addScreenObject=function(name,reference){
  		screenObjects[name]=reference;
  	}
  	this.getScreenObject=function(name){
  		return screenObjects[name];
  	}
  }
      
  function EventData() {
    let isPropagationStopped = false;
    let isImmediatePropagationStopped = false;

    this.stopPropagation = function () {
      isPropagationStopped = true;
    };

    this.isPropagationStopped = function () {
      return isPropagationStopped;
    };

    this.stopImmediatePropagation = function () {
      isImmediatePropagationStopped = true;
    };

    this.isImmediatePropagationStopped = function () {
      return isImmediatePropagationStopped;
    }
  }

  function Event() {
    let handlers = [];

    this.subscribe = function (fn) {
      handlers.push(fn);
    };

    this.unsubscribe = function (fn) {
      for (let i = handlers.length - 1; i >= 0; i--) {
        if (handlers[i] === fn) {
          handlers.splice(i, 1);
        }
      }
    };
    this.notify = function (args, e, scope) {
      e = e || new EventData();
      scope = scope || this;

      let returnValue;
      for (let i = 0; i < handlers.length && !(e.isPropagationStopped() || e.isImmediatePropagationStopped()); i++) {
        returnValue = handlers[i].call(scope, e, args);
      }

      return returnValue;
    };
  }
  })(jQuery);
  jQuery.extend(FlexUI, { trigger: function (evt, args, e, scope) {
      e = e || new FlexUI.EventData();
      args = args || {};
      return evt.notify(args, e, scope);
  }});      
  
  function toNumber(value){
	if(value!='NaN' && value!=null && value.toString().trim().length>0){
		return Number(value);
	}else{
		return 0.0;
	}
 }
 function roundOff(value, digits){
  	return (Math.round((value*Math.pow(10,digits)).toFixed(digits-1))/Math.pow(10,digits)).toFixed(digits);
 }
 function getAppContextName(){
 	return window.location.pathname.split("/")[1];
 }
 let isMobile=/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ;
 
function clearTotalAmt(){ 
	$("#totamt").html("0.00");
	$("#gross").html("0.00");
	$("#vat").html("0.00");
	$("#disc").html("0.00");
	$("#netAmt").html("0.00");
}

function showHideField(grdName){
//alert($('#divHide').height());
	if( $('#divHide').is(':visible') ) {
		//$('#order').height($('#order').height()+100);
		screenObjects.getScreenObject(grdName).resetHeight($('#divHide').height());
		$('#divHide').css("display","none");
		$('#plusbutton1').removeClass("fa-angle-double-up");
		$('#plusbutton1').addClass("fa-angle-double-down");
	}else{
		//$('#order').height($('#order').height()-100);
		screenObjects.getScreenObject(grdName).resetHeight(0);
		$('#divHide').css("display","block");
		$('#plusbutton1').removeClass("fa-angle-double-down");
		$('#plusbutton1').addClass("fa-angle-double-up");
	}
}
function showSubMenu(){
	if( $('#submenu').is(':visible') ) {
		$('#submenu').css("display","none");
	}else{
		$('#submenu').css("display","block");
	}
}
function hideSubMenu(){
	if( $('#submenu').is(':visible') ) {
		$('#submenu').css("display","none");
	}
}

function showLoader(){
	$('#divLoading').css("display","block");
}
function hideLoader(){
	$('#divLoading').css("display","none");
}
function changeScreenAttributes(screencode,oldScreenProp){
		let l=new FlexUI.Ajax();
	  	let v=l.callAjax("GET","/inventory/service/screen","screencode="+screencode);
	  	
	  	let screenProp={};
		
	  	screenProp["screen"]=[];
	  	screenProp.js=v.screenprop[0].screenjs || "";
	  	screenProp.initfocus=oldScreenProp.initfocus;
	  	let gs=v.groups.length;
	  	for(let j=0;j<gs;j++){
	  		let sgroup=oldScreenProp.screen[j] || {};
	  		sgroup["name"]=v.groups[j].groupname;
	  		sgroup["title"]=v.groups[j].grouptitle;
	  		sgroup["layout"]=v.groups[j].grouplayout;
	  		if(v.groups[j].grouptype==1){
	  			//sgroup["contentType"]="Fields";
	  			//sgroup["fields"]=[];
	  			if(sgroup["layout"]!=0){
	  				sgroup["pcolumns"]=sgroup["layout"];
	  				let columns=Math.floor(12/sgroup["layout"]);
	  				sgroup["colcss"]="col-sm-"+columns+" col-md-"+columns+" col-lg-"+columns;
	  			}
	  		}else{
	  			//sgroup["contentType"]="Table";
	  			//sgroup["tableProperties"]=oldScreenProp.screen[j].tableProperties || {};
	  			/*if(v.groups[j].grouptablerowadd==0){
	  				sgroup.tableProperties.enableAddRow=false;
	  			}else{
	  				sgroup.tableProperties.enableAddRow=true;
	  			}
	  			if(v.groups[j].grouptableoptional==1){
					sgroup.tableProperties.optional=true;
				}else{
					sgroup.tableProperties.optional=false;
				}*/	  			
	  			//sgroup.tableProperties.columns=[];
	  		}
	  		screenProp.screen.push(sgroup);
	  		if(v.groups[j].groupvisible==0){
	  			$('#'+sgroup["name"]).css('display','none');
	  		}
	  	}
		let gas=v.attributes.length;
		for(let i=0;i<gas;i++){
			let attribute=v.attributes[i];
			let field=null;
			if(screenProp.screen[attribute.grouporder].contentType=="Fields"){
				field=screenProp.screen[attribute.grouporder].fields[attribute.attributeorder] || {};
			}else{
				field=screenProp.screen[attribute.grouporder].tableProperties.columns[attribute.attributeorder] || {};
			}
			field.name=attribute.name
			field.inputType=attribute.inputType;
			field.type=attribute.type;
			field.caption=attribute.caption;
			if(attribute.mandatory==1){
				field.mandatory=true;
			}else{
				field.mandatory=false;
			}
			field.defaultValue=attribute.defaultValue;
			field.maxValue=attribute.maximumValue!=undefined?Number(attribute.maximumValue):0;
			field.textLength=attribute.textLength!=undefined?Number(attribute.textLength):10;
			field.decimalLength=attribute.decimalLength!=undefined?Number(attribute.decimalLength):0;
			if(attribute.viewenabled==1){
				field.visible=true;
			}else{
				field.visible=false;
			}
			if(attribute.addenabled==1){
				field.readOnly=false;
			}else{
				field.readOnly=true;
			}
			field.align=attribute.align;
			if(attribute.chkTag!=null && attribute.chkTag!=undefined){
				if(attribute.chkTag==1){
					field.chkTag=true;
				}else{
					field.chkTag=false;
				}
			}
			if(attribute.saveTag!=null && attribute.saveTag!=undefined){
				if(attribute.saveTag==1){
					field.saveTag=true;
				}else{
					field.saveTag=false;
				}
			}
			if(screenProp.screen[attribute.grouporder].contentType=="Fields"){
				//screenFields.fields.push(field);
				field.nf=attribute.attributeevent;
				field.colno=attribute.attributeloadgroup;						
				screenProp.screen[attribute.grouporder].fields[attribute.attributeorder]=field;
			}else{
				field.order=attribute.attributeorder;
				field.id=attribute.name;
				field.field=attribute.name;
				field.name=attribute.caption;
				if(attribute.viewenabled==1){
					field.width=Number(attribute.width);
				}else{
					field.width=0;
				}
				screenProp.screen[attribute.grouporder].tableProperties.columns[attribute.attributeorder]=field;
				//screenFields.tableProperties.columns.push(field);
			}
		}
		return screenProp;
	};