(function ($) {
$.extend(true, window, {
    "FlexUI": {
      "Event": Event,
      "EventData":EventData,
      "ScreenObjects":ScreenObjects
      }
      });
      
  function ScreenObjects() {
  	var screenObjects={};
  	
  	this.addScreenObject=function(name,reference){
  		screenObjects[name]=reference;
  	}
  	this.getScreenObject=function(name){
  		return screenObjects[name];
  	}
  }
      
  function EventData() {
    var isPropagationStopped = false;
    var isImmediatePropagationStopped = false;

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
    var handlers = [];

    this.subscribe = function (fn) {
      handlers.push(fn);
    };

    this.unsubscribe = function (fn) {
      for (var i = handlers.length - 1; i >= 0; i--) {
        if (handlers[i] === fn) {
          handlers.splice(i, 1);
        }
      }
    };
    this.notify = function (args, e, scope) {
      e = e || new EventData();
      scope = scope || this;

      var returnValue;
      for (var i = 0; i < handlers.length && !(e.isPropagationStopped() || e.isImmediatePropagationStopped()); i++) {
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
	if(value!='NaN' && value!=null && value.trim().length>0){
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
 var isMobile=/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ;/***
 * Contains basic SlickGrid editors.
 * @module Editors
 * @namespace Slick
 */

(function ($) {
  // register namespace
  $.extend(true, window, {
    FlexUI: {
      TextBox: FlexInput,
      Select: FlexSelect,
      CheckBox:FlexCheck,
      Button:FlexButton,
      Label:FlexLabel
    }
  });

  function FlexInput(id,parent,attributes) {
    var wInput;
    var wTextBox;
    var wButton
	var type="TEXT";
	var decimalLength=2;
	var maxValue=0;
	var length=0;
	var mandatory=false;
	var chkTag=false;
	var lovOptions={};
	var me=this;
	var tag="";
	var lov=null;
	var nextFocus="";
	var format="dd/mm/yy";
	var validateFunction=null;
	var onChangeFunction=null;
	var preValidation=null;
	var readOnly=false;
	var userDefinedFunction=null;
	var enabled=true;
	
    this.init = function () {      
	  wButton = $("<INPUT type=button class='spanRow' style='width:98%' id='"+id+"' value='Select'/>");      
	  if(attributes.type=='TEXTAREA'){
	  	wTextBox = $("<TEXTAREA rows=5 cols=50 class='spanRow' style='width:98%;min-height:70px' id='"+id+"'/>");
	  }else{
	  	wTextBox = $("<INPUT type=text class='spanRow' style='width:98%' id='"+id+"'/>");	  	
	  }	      		
      wButton.bind("keypress",handleKeyPress);
      wButton.bind("keydown",handleKeyDown);
      wButton.bind("keyup",handleKeyUp);
      wButton.bind("click",handleClick);
      wButton.bind("blur",handleBlur);
      wButton.bind("focus",handleFocus);
      wButton.bind("change",handleChange);
      
      wTextBox.bind("keypress",handleKeyPress);
      wTextBox.bind("keydown",handleKeyDown);
      wTextBox.bind("keyup",handleKeyUp);
      wTextBox.bind("click",handleClick);
      wTextBox.bind("blur",handleBlur);
      wTextBox.bind("focus",handleFocus);
      wTextBox.bind("change",handleChange);
      
      this.setAttributes(attributes);
    };
    function handleChange(e){
    }
    function handleKeyUp(e){
		if(onChangeFunction){
			onChangeFunction(id,me);
		}
		FlexUI.trigger(me.onTextChanged,{"val":me.getValue(),"text":me},e,this);    
    }
	function handleBlur(e){
		me.removeBorder();
		e.preventDefault();
	}
	function handleFocus(e){
		me.removeBorder();
	}	
	function handleKeyPress(e){
		var key=e.which;
		var keycode=e.keyCode;
		switch(key){
		case 13:
			e.preventDefault();
			return;
		}
		switch(keycode){
		case 37:
		case 38:
		case 39:
		case 40:
		case 46:
			return;
		}
		if(readOnly){
			e.preventDefault();
			return;
		}
		if(type=="LOV" && key==8){
			if(lov==null){			
				lov=new FlexUI.LOV(id+"_in1",me,lovOptions);
			}		
			lov.setOptions(lovOptions);
			lov.clearResult();
			return;
		}
		if(type=="TEXT" || type=="LOV"){
			checkAlphaNumeric(e,key);
		}else if(type=="INT"){
			checkNumericValue(e,key,wInput.val(),decimalLength,false,false,maxValue);
		}else if(type=="NEGINT"){
			checkNumericValue(e,key,wInput.val(),decimalLength,false,true,maxValue);
		}else if(type=="DECIMAL"){
			if(decimalLength==-1){
				checkNumericValue(e,key,wInput.val(),decimalLength,false,false,maxValue);
			}else{
				checkNumericValue(e,key,wInput.val(),decimalLength,true,false,maxValue);
			}
		}else if(type=="NEGDEC"){
			if(decimalLength==-1){
				checkNumericValue(e,key,wInput.val(),decimalLength,false,true,maxValue);
			}else{
				checkNumericValue(e,key,wInput.val(),decimalLength,true,true,maxValue);
			}
		}else if(type=="DATE"){
			checkDate(e,key);
		}
		FlexUI.trigger(me.onTextKeyPress,{"val":me.getValue(),"text":me},e,this);
		e.stopPropagation();
	}
	this.checkAndInvokeLov=function(click){
		var value="";
		if(preValidation){
			if(parent instanceof FlexUI.Table){
				parent.preValidateCell();
			}else{
				preValidation(id,me);
			}
		}
		if(me.checkMove() && !click){
			if(!me.validate()){
			}else{		
				if(me.goToNextField()) return;
			}			
		}
		if(type=="LOV" && me.getCheckValue()==""){
			if(lov==null){			
				lov=new FlexUI.LOV(id+"_in1",this,lovOptions);
			}else{
				lov.setOptions(lovOptions);
			}			
			lov.show(); 			
		}else if(type=="UDF" && me.getCheckValue()==""){
			userDefinedFunction(id,me);
		}	
	}
	this.getCheckValue=function(){
		var value="";
		if(chkTag){
			value=me.getTag();
		}else{
			value=me.getValue();
		}
		return value;
	}
	this.checkMove=function(){
		var v=true;
		if(!(parent instanceof FlexUI.Table)){		
			v=(!mandatory || ((type=="TEXT" || type=="LOV" || type=="UDF") && me.getCheckValue()!="") || (!(type=="TEXT" || type=="LOV" || type=="UDF") && toNumber(me.getCheckValue())!=0));
			if(!v){
				me.setBorderColor('red');			
			}else{
	    		me.removeBorder();
	    	}
	    }
		return v;
	}
	this.goToNextField=function(){
		var m=true;
		if(type=="DECIMAL" || type=="NEGDEC"){
			wInput.val(roundOff(toNumber(wInput.val()),decimalLength));	
		}		
		if(screenObjects){
			var nf=me.findNextFocusableWidget(me);
			if(nf instanceof FlexUI.TextBox
				|| nf instanceof FlexUI.Select
				|| nf instanceof FlexUI.CheckBox){
				nf.focus();
			}else if(nf instanceof FlexUI.Table){
				nf.getInputField().focus();
			}else if(parent instanceof FlexUI.Table){
				m=parent.checkAndMove("Next",true);
			}else if(parent instanceof FlexUI.LOV){
				parent.returnResult(parent.getCurrentRow());				
			}else if(nextFocus!=null && ($('#'+nextFocus).is("button") || $('#'+nextFocus).is("a") || $('#'+nextFocus).is("input"))){
				$('#'+nextFocus).focus();
			}
		}
		return m;
	}
	this.findNextFocusableWidget=function(nf){
		var wenabled=false;
		if(screenObjects){
			while(!wenabled){
				nf=screenObjects.getScreenObject(nf.getNextFocus());				
				if(nf instanceof FlexUI.TextBox
					|| nf instanceof FlexUI.Select
					|| nf instanceof FlexUI.CheckBox){
					wenabled=nf.getEnabled();
				}else{
					wenabled=true;
				}
			}
		}
		return nf;
	}
	function isLetterOrDigit(key){
		var c = String.fromCharCode(key);
		if(c.match('[a-zA-Z]') || c.match('[0-9]')){
			return true;
		}
		return false;
    }
	//esc-27,ent-13,bp-8,.-46,del-127
	function isDigit(key){
		var c = String.fromCharCode(key);
		if(c.match('[0-9]')){
			return true;
		}
		return false;
    }
    function checkAlphaNumeric(e,key){ 
		var c = String.fromCharCode(key);
        if (!(isLetterOrDigit(key)  
        || (c == ' ') 
        || (c == '.')
        || (c == '+')
        || (c == '-')
        || (c == '_')
        || (c == '*')
        || (c == '/')
        || (c == '%')
        || (c == '@')
        || (c == ',')
        || (c == ':')
        || (c == '&')
        || (c == '"')
        || (c == "'")
        || (key ==8))){
            e.preventDefault();
        }
    }
	function checkNumericValue(e,key,checkString,decimalLength ,decimalAllowed,negativeAllowed ,maxValue){
	    if (key != 8){
		var c = String.fromCharCode(key);
	    	if (c=='0' && (checkString=="" || checkString=="0")){
	        	return;
	        }
	        if (c =='-' && ((!negativeAllowed || checkString.indexOf('-')!=-1) && c =='-')) {
	        	e.preventDefault();
	        }else if ((checkString.indexOf('.')!=-1 || !decimalAllowed) && c =='.'){
	        	e.preventDefault();
	        }else if(!isDigit(key) && c !='.' && c !='-'){
	        	e.preventDefault();
	        }else if(parseFloat(checkString+c)>maxValue && maxValue!=0){
	        	e.preventDefault();
	        }else if(checkString.indexOf('.')!=-1){
	        	var check=checkString.split(".");
	        	if(check.length>1 && check[1].length==decimalLength){
	        		e.preventDefault();
	        	}
	        }
	    }
    }
	function checkDate(e,key){ 
    	if (key != 8){
		var c = String.fromCharCode(key);
    		if(!(isDigit(key)) && (c != '-') && (c != '/')){
    		    e.preventDefault();			
    		}
        }
    }
	function handleKeyDown(e){
		var key=e.which || e.keyCode;
    	if(key==13 || key==9){
			me.checkAndInvokeLov(false);
			e.stopPropagation();
			e.preventDefault();
		}
		if(type=="LOV" && key==8){
			if(lov==null){			
				lov=new FlexUI.LOV(id+"_in1",me,lovOptions);
			}				
			lov.setOptions(lovOptions);
			lov.clearResult();
			return;
		}
		if(readOnly){
			e.preventDefault();
			return;
		}
		FlexUI.trigger(me.onTextKeyDown,{"val":me.getValue(),"text":me},e,this);
	}
	function handleClick(e){
		e.stopPropagation();
		me.checkAndInvokeLov(true);
		FlexUI.trigger(me.onClick,{"val":me.getValue(),"text":me},e,this);
	}
	this.setWidth=function(width){
		wInput.width(width);
	}
	this.setHeight=function(height){
		wInput.height(height);
	}
	this.setNextFocus=function(w){
    	nextFocus=w;
    }
    this.getNextFocus=function(){
    	return nextFocus;
    }
    this.reset=function(){
    	me.setValue("");
    	me.setTag("");
    	if(type=='DATE'){
			wInput.datepicker({dateFormat:format});			
			if(wInput.val()==""){
				var cd=new Date();
				wInput.datepicker("setDate",cd);
			}
			wInput.datepicker("option",{onClose:me.goToNextField});
		}else if(type=='DATETIME'){
			wInput.datetimepicker({
					timeFormat: 'hh:mm TT',
					dateFormat:format
			});
			if(wInput.val()==""){
				var cd=new Date();
				wInput.datetimepicker("setDate",cd);
			}
			wInput.datetimepicker("option",{onClose:me.goToNextField});	
		}
		me.setEnabled(true);
    }
    this.validate=function(){
    	var v=true;
    	if(validateFunction && !validateFunction(id,me)){
    		v=false;
    		me.setBorderColor('red');
    	}else{
    		me.removeBorder();
    	}
    	return v;
    }
    this.setBorderColor=function(color){
    	wInput.css('border-width','1');
    	wInput.css('border-style','solid');
    	wInput.css('border-color',color);
    }
    this.removeBorder=function(){
        wInput.css('border-width','1px');
    	wInput.css('border-color','#CCCCCC');    
    }    				        			
	this.setAttributes=function(attributes){
		type=attributes.type || "TEXT";
		decimalLength=attributes.decimalLength || 2;
		maxValue=attributes.maxValue || 0;
		length=attributes.textLength || 0;
		mandatory=attributes.mandatory || false;
		chkTag=attributes.chkTag || false;
		lovOptions=attributes.lovOptions || {};
		nextFocus=attributes.nf || "";
		format=attributes.format || format;
		validateFunction=window[attributes.validation];
		readOnly=attributes.readOnly || false;
		onChangeFunction=window[attributes.onchange];
		userDefinedFunction=window[attributes.udf];
		preValidation=window[attributes.prevalidate];
		
		if(isMobile && (type=="LOV" || type=="UDF")){
			wInput=wButton;
		}else{
			wInput=wTextBox;
		}
		if(type=="LOV"){
			wInput.addClass('listtype');
		}else{
			wInput.removeClass('listtype');
		}
		if(attributes.font){
			var ft=attributes.font;
			wInput.css('font-weight',ft.weight);
			wInput.css('color',ft.color);
			wInput.css('font-size',ft.size);
		}
		if(attributes.align){
			wInput.css('text-align',attributes.align);
		}
		if(type=='DATE'){
			wInput.datepicker({dateFormat:format});			
			if(wInput.val()==""){
				var cd=new Date();
				wInput.datepicker("setDate",cd);
			}
			wInput.datepicker("option",{onClose:me.goToNextField});
		}else if(type=='DATETIME'){
			wInput.datetimepicker({
					timeFormat: 'hh:mm TT',
					dateFormat:format
			});
			if(wInput.val()==""){
				var cd=new Date();
				wInput.datetimepicker("setDate",cd);
			}
			wInput.datetimepicker("option",{onClose:me.goToNextField});
		}else{
			wInput.datepicker('destroy');
			if(wInput.datatimepicker){
				wInput.datatimepicker('destroy');
			}
		}
	}
	this.getCursorPosition=function(){
		var iCaretPos = 0;
		if (document.selection) {
		    var oSel = document.selection.createRange ();
		    oSel.moveStart ('character', -wInput.val().length);
		    iCaretPos = oSel.text.length;
  		}else if (wInput[0].selectionStart || wInput[0].selectionStart == '0'){
    		iCaretPos = wInput[0].selectionStart;
    	}
		return iCaretPos;
  	}
	this.setCursorPosition=function(pos){
		return wInput.caretTo(pos);
	}
	this.setSelection=function(start, end) {
	    if(wInput[0].createTextRange) {
	      var selRange = wInput[0].createTextRange();
	      selRange.collapse(true);
	      selRange.moveStart('character', start);
	      selRange.moveEnd('character', end);
	      selRange.select();
	    }else if( wInput[0].setSelectionRange ) {
	      wInput[0].setSelectionRange(start, end);
	    }else if( typeof wInput[0].selectionStart != 'undefined' ) {
	      wInput[0].selectionStart = start;
	      wInput[0].selectionEnd = end;
	    }
	}
    this.destroy = function () {
      wInput.remove();
    };

    this.detach = function () {
      wInput.detach();
    };

    this.focus = function () {
      wInput.focus();
    };

    this.getValue = function () {
      return wInput.val();
    };

    this.setValue = function (val) {
      wInput.val(val);
    };

    this.setType = function (val) {
      this.type=val;
    };

    this.getInput= function () {
      return wInput;
    };
    
    this.setTag=function(text){
    	tag=text;
    }
    this.getTag=function(){
    	return tag;
    }
    this.appendTo=function(w){
    	w.append(wInput);
    }
    this.getParent=function(){
    	return parent;
    }
    this.setEnabled=function(enable){
    	enabled=enable;
    	if(!enable){
    		wInput.attr('disabled','disabled');
    		if(type=="LOV"){
    			wInput.removeClass('listtype');
    		}    		
    	}else{
    		wInput.removeAttr('disabled');
    		if(type=="LOV"){
    			wInput.addClass('listtype');
    		}
    	}
    }
    this.getEnabled=function(){
    	return enabled;
    }       
	$.extend(this, {
		"onTextKeyDown": new FlexUI.Event(),
		"onTextKeyPress": new FlexUI.Event(),
		"onTextChanged": new FlexUI.Event(),
		"onClick": new FlexUI.Event()
	});
    this.init();
  }
function FlexSelect(id,parent,attributes) {
    var wSelect;
	var me=this;
	var tag="";
	var nextFocus=null;
	var validateFunction=null;
	var onChangeFunction=null;
	var enabled=true;
	
    this.init = function () {
      wSelect = $("<SELECT class='spanRow' style='width:100%' id='"+id+"'/>");
      wSelect.bind("keypress",handleKeyPress);
      wSelect.bind("keydown",handleKeyDown);
      wSelect.bind("click",handleClick);
      wSelect.bind("change",handleChange);
      wSelect.bind("blur",handleBlur);
      wSelect.bind("focus",handleFocus);
      this.setOptions(attributes);
    };
	function handleBlur(e){
		e.preventDefault();
	}
	function handleFocus(e){
		me.removeBorder();
	}	
	this.setBorderColor=function(color){
    	wSelect.css('border-width','1');
    	wSelect.css('border-color',color);
    }
    this.removeBorder=function(){
        wSelect.css('border-width','1px');
    	wSelect.css('border-color','#CCCCCC');    
    }    				        				
	function handleKeyPress(e){
		var key=e.which;
		var keycode=e.keyCode;
		switch(key){
		case 13:
			e.stopPropagation();
			return;
		}
		switch(keycode){
		case 37:
		case 38:
		case 39:
		case 40:
			e.stopPropagation();
			e.preventDefault();
			return;
		}	
		FlexUI.trigger(me.onSelectKeyPress,{"val":me.getValue(),"select":me},e,this);
	}
	function handleKeyDown(e){
		var key=e.which || e.keyCode;
	  	if(key==13 || key==9){
	  		if(!me.validate()){
	  			//nothing
	  		}else{
				me.goToNextField();
			}
			e.stopPropagation();
			e.preventDefault();
		}
		FlexUI.trigger(me.onSelectKeyDown,{"val":me.getValue(),"select":me},e,this);
	}
	function handleClick(e){
		e.stopPropagation();
		FlexUI.trigger(me.onClick,{"val":me.getValue(),"select":me},e,this);
	}
	function handleChange(e){
		e.stopPropagation();
		if(onChangeFunction){
			onChangeFunction(id,me);
		}
		FlexUI.trigger(me.onSelectChange,{"val":me.getValue(),"select":me},e,this);
	}
	this.goToNextField=function(){
		if(screenObjects){
			var nf=me.findNextFocusableWidget(me);
			if(nf instanceof FlexUI.TextBox
				|| nf instanceof FlexUI.Select
				|| nf instanceof FlexUI.CheckBox){
				nf.focus();
			}else if(nf instanceof FlexUI.Table){
				nf.getInputField().focus();
			}else if(parent instanceof FlexUI.Table){
				parent.checkAndMove("Next",true);
			}
		}
	}
	this.findNextFocusableWidget=function(nf){
		var wenabled=false;
		if(screenObjects){
			while(!wenabled){
				nf=screenObjects.getScreenObject(nf.getNextFocus());				
				if(nf instanceof FlexUI.TextBox
					|| nf instanceof FlexUI.Select
					|| nf instanceof FlexUI.CheckBox){
					wenabled=nf.getEnabled();
				}else{
					wenabled=true;
				}
			}
		}
		return nf;
	}
    this.setKeyValues=function(keys,values){
        if(keys!=""){
			var caption=keys.split("~");
			var value=values.split("~");
			var s=caption.length;
			wSelect.find('option').remove();
			for(j=0;j<s;j++){
				wSelect.append($("<option></option>")
	            	        .attr("value",value[j])
	                	    .text(caption[j]));
			}
		}    
    }	
	this.setOptions=function(attribs){
		me.setKeyValues(attribs.keys,attribs.values);
		validateFunction=window[attribs.validation];
		nextFocus=attribs.nf;
		onChangeFunction=window[attribs.onchange];
		attributes=attribs;
		tag="";
	};	
	this.validate=function(){
    	var v=true;
    	if(validateFunction && !validateFunction(id,me)){
    		v=false;
    		me.setBorderColor('red');
    	}else{
    		me.removeBorder();
    	}
    	return v;
    }	
	
	this.reset=function(){
		me.setOptions(attributes);
		me.setEnabled(true);
	}
    this.destroy = function () {
      wSelect.remove();
    };
    this.detach = function () {
      wSelect.detach();
    };
    this.focus = function () {
      wSelect.focus();
    };
    this.getValue = function () {
      return wSelect.val();
    };
    this.setValue = function (val) {
      wSelect.val(val);
    };
    this.getSelect= function () {
      return wSelect;
    };
    this.setTag=function(text){
    	tag=text;
    }
    this.getTag=function(){
    	return tag;
    }
    this.appendTo=function(w){
    	w.append(wSelect);
    }
    this.setWidth=function(width){
		wSelect.width(width);
	}
	this.setHeight=function(height){
		wSelect.height(height);
	}			
    this.setNextFocus=function(w){
    	nextFocus=w;
    }
    this.getNextFocus=function(){
    	return nextFocus;
    }    
    this.setEnabled=function(enable){
    	enabled=enable;
    	if(!enable){
    		wSelect.attr('disabled','disabled');
    	}else{
    		wSelect.removeAttr('disabled');
    	}
    }
    this.getEnabled=function(){
    	return enabled;
    }             
	$.extend(this, {
		"onSelectKeyDown": new FlexUI.Event(),
		"onSelectKeyPress": new FlexUI.Event(),
		"onClick": new FlexUI.Event(),
		"onSelectChange": new FlexUI.Event()
	});
    this.init();
  }
function FlexCheck(id,parent,attributes) {
    var wCheck;
	var me=this;
	var tag="";
	var nextFocus=null;
	var validateFunction=null;
	var onClickFunction=null;
	var enabled=true;
	
    this.init = function () {
      wCheck = $("<input type='checkbox' class='spanRow' id='"+id+"'/>");
      wCheck.bind("keypress",handleKeyPress);
      wCheck.bind("keydown",handleKeyDown);
      wCheck.bind("click",handleClick);
      wCheck.bind("click",handleBlur);
      this.setAttributes(attributes);
    };
    function handleBlur(){
    	e.preventDefault();
 	}   
 	this.setBorderColor=function(color){
    	wCheck.css('border-width','1');
    	wCheck.css('border-color',color);
    }
    this.removeBorder=function(){
    	wCheck.css('border-width','1');
    	wCheck.css('border-color','#CCCCCC');    	
    }
	this.setAttributes=function(attributes){
		validateFunction=window[attributes.validation];
		onClickFunction=window[attributes.onclick];
	}
	function handleKeyPress(e){
		var key=e.which;
		var keycode=e.keyCode;
		switch(key){
		case 13:
			e.preventDefault();
			return;
		}
		switch(keycode){
		case 37:
		case 38:
		case 39:
		case 40:
			return;
		}	
		FlexUI.trigger(me.onCheckKeyPress,{"val":me.getValue(),"check":me},e,this);
	}
	function handleKeyDown(e){
		var key=e.which || e.keyCode;
	  	if(key==13 || key==9){
	  		if(!me.validate()){
	  			//nothing
	  		}else{
				me.goToNextField();
			}
			e.stopPropagation();
			e.preventDefault();
		}
		FlexUI.trigger(me.onCheckKeyDown,{"val":me.getValue(),"check":me},e,this);
	}
	function handleClick(e){
		e.stopPropagation();
		onClickFunction(id,me);
		FlexUI.trigger(me.onClick,{"val":me.getValue(),"check":me},e,this);
	}
	this.goToNextField=function(){
		if(screenObjects){
			var nf=me.findNextFocusableWidget(me);
			if(nf instanceof FlexUI.TextBox
				|| nf instanceof FlexUI.Select
				|| nf instanceof FlexUI.CheckBox){
				nf.focus();
			}else if(nf instanceof FlexUI.Table){
				nf.getInputField().focus();
			}else if(parent instanceof FlexUI.Table){
				parent.checkAndMove("Next",true);
			}
		}
	}
	this.findNextFocusableWidget=function(nf){
		var wenabled=false;
		if(screenObjects){
			while(!wenabled){
				nf=screenObjects.getScreenObject(nf.getNextFocus());				
				if(nf instanceof FlexUI.TextBox
					|| nf instanceof FlexUI.Select
					|| nf instanceof FlexUI.CheckBox){
					wenabled=nf.getEnabled();
				}else{
					wenabled=true;
				}
			}
		}
		return nf;
	}		
	this.validate=function(){
    	var v=true;
    	if(validateFunction && !validateFunction(id,me)){
    		v=false;
    		me.setBorderColor('red');
    	}else{
    		me.removeBorder();
    	}
    	return v;
    }	
    this.destroy = function () {
      wCheck.remove();
    };
    this.detach = function () {
      wCheck.detach();
    };
    this.focus = function () {
      wCheck.focus();
    };
    this.getValue = function () {
      return wCheck.is(':checked');
    };
    this.setValue = function (val) {
      var check=false;
      if(val=="1" || val=="true" || val==true){
      	check=true;
      }
      wCheck.prop('checked',check);
    };
    this.getCheckBox= function () {
      return wCheck;
    };
    this.setTag=function(text){
    	tag=text;
    }
    this.getTag=function(){
    	return tag;
    }
    this.appendTo=function(w){
    	w.append(wCheck);
    }
    this.reset=function(){    	
    	me.setValue(false);
    	me.setTag("");
    	me.setEnabled(true);
    }
    this.setWidth=function(width){
		wCheck.width(width);
	}
	this.setHeight=function(height){
		wCheck.height(height);
	}
	this.setNextFocus=function(w){
    	nextFocus=w;
    }
    this.getNextFocus=function(){
    	return nextFocus;
    }       
    this.setEnabled=function(enable){
    	enabled=enable;
    	if(!enable){
    		wCheck.attr('disabled','disabled');
    	}else{
    		wCheck.removeAttr('disabled');
    	}
    }
    this.getEnabled=function(){
    	return enabled;
    }              				      
	$.extend(this, {
		"onCheckKeyDown": new FlexUI.Event(),
		"onCheckKeyPress": new FlexUI.Event(),
		"onClick": new FlexUI.Event()
	});
    this.init();
  }
  function FlexButton(id,parent,attributes) {
    var wButton;
	var me=this;
	var tag="";
	var nextFocus=null;
	var caption="";
	var onClickFunction=null;
	var enabled=true;
	
    this.init = function () {
      wButton = $("<input type='button' value='"+attributes.caption+"' style='background-color:#F9F9F9;font-weight:bold;font-size:12px;height:100%;' id='"+id+"'/>");
      wButton.bind("click",handleClick);
      this.setAttributes(attributes);
    };
    this.setAttributes=function(attributes){
    	value=attributes.caption;
    	onClickFunction=window[attributes.onclick];
    }
	function handleClick(e){
		e.stopPropagation();
		if(onClickFunction){
			onClickFunction(id,me);
		}
		FlexUI.trigger(me.onClick,{"val":me.getValue(),"button":me},e,this);
	}
    this.destroy = function () {
      wButton.remove();
    };
    this.detach = function () {
      wButton.detach();
    };
    this.focus = function () {
      wButton.focus();
    };
    this.getValue = function () {
      return wButton.val();
    };
    this.setValue = function (val) {
      wButton.val(val);
    };
    this.getButton= function () {
      return wButton;
    };
    this.setTag=function(text){
    	tag=text;
    }
    this.getTag=function(){
    	return tag;
    }
    this.appendTo=function(w){
    	w.append(wButton);
    }
    this.setWidth=function(width){
		wButton.width(width);
	}
	this.setHeight=function(height){
		wButton.height(height);
	}
	this.setNextFocus=function(w){
    	nextFocus=w;
    }
    this.getNextFocus=function(){
    	return nextFocus;
    }       
	this.setEnabled=function(enable){
		enabled=enable;
    	if(!enable){
    		wButton.attr('disabled','disabled');
    	}else{
    		wButton.removeAttr('disabled');
    	}
    }
    this.getEnabled=function(){
    	return enabled;
    }           
	$.extend(this, {
		"onClick": new FlexUI.Event()
	});
    this.init();
  }
  function FlexLabel(id,parent,attributes) {
    var wLabel;
	var me=this;
	var tag="";
	var nextFocus=null;
	var caption="";
	var onClickFunction=null;
	
    this.init = function () {
      wLabel = $("<label class='Trueheadlabel'>"+attributes.caption+"</label>");
      wLabel.bind("click",handleClick);
      this.setAttributes(attributes);
    };
    this.setAttributes=function(attributes){
    	value=attributes.caption;
    	onClickFunction=window[attributes.onclick];
    }
	function handleClick(e){
		e.stopPropagation();
		if(onClickFunction){
			onClickFunction(id,me);
		}
		FlexUI.trigger(me.onClick,{"val":me.getValue(),"button":me},e,this);
	}
    this.destroy = function () {
      wLabel.remove();
    };
    this.detach = function () {
      wLabel.detach();
    };
    this.focus = function () {
      wLabel.focus();
    };
    this.getValue = function () {
      return wLabel.val();
    };
    this.setValue = function (val) {
      wLabel.val(val);
    };
    this.getLabel= function () {
      return wLabel;
    };
    this.setTag=function(text){
    	tag=text;
    }
    this.getTag=function(){
    	return tag;
    }
    this.appendTo=function(w){
    	w.append(wLabel);
    }
    this.setWidth=function(width){
		wLabel.width(width);
	}
	this.setHeight=function(height){
		wLabel.height(height);
	}
	this.setNextFocus=function(w){
    	nextFocus=w;
    }
    this.getNextFocus=function(){
    	return nextFocus;
    }   
	$.extend(this, {
		"onClick": new FlexUI.Event()
	});
    this.init();
  }          
})(jQuery);
/***
 * Contains basic SlickGrid editors.
 * @module Editors
 * @namespace Slick
 */

(function ($) {
  // register namespace
  $.extend(true, window, {
    FlexUI: {
      Table: FlexTable,
      Row: FlexRow,
      Cell: FlexCell
    }
  });

  function FlexTable(id,viewWidth,options,rowProperties,columnProperties,cellProperties) {
    var wTable;
    var rows=new Array();
	var input;
	var currentRow=0;
	var currentCol=0;
	var me=this;
	var tableWidth=0;
	var dataViewWidth=viewWidth;
	var cols={};
	var nextFocus=null;
			
	var defaults = {
      rowHeight: 25,
      defaultColumnWidth: 80,
      enableAddRow: true,
      enableDeleteRow: true,
      confirmRowDelete: true,
      enableCellNavigation: true,
      headerColumnWidthDiff:0,
      serialNumberColumn:0,
      rowEmptyCheckColumn:-1
    };
	
	var columnDefaults = {
      name: "",
      resizable: true,
      sortable: false,
      minWidth: 30,
      rerenderOnResize: false,
      headerCssClass: null,
      defaultSortAsc: true,
      focusable: true,
      selectable: true,
      adjustedWidth:30
    };
	
	function setColumnDefaults() {
      for (var i = 0, ii = columnProperties.length; i < ii; i++) {
        var m = columnProperties[i] = $.extend({}, columnDefaults, columnProperties[i]);
        tableWidth += m.width;
      }
    }
	
	function calculateColumnWidth(width){
    	if(tableWidth<dataViewWidth){
    		width=(width/tableWidth*100)*dataViewWidth/100;
    	}
    	return width;
    }

	this.getOptions=function(){
		return options;
	}	
    this.init = function () {

      options = $.extend({}, defaults, options);

	  columnDefaults.width = options.defaultColumnWidth;

	  setColumnDefaults();
	  	  
	  for (var i = 0; i < columnProperties.length; i++) {
	    var m=columnProperties[i];
        m.adjustedWidth=calculateColumnWidth(m.width);
        cols[m.field]=m.order;
      }
    
      wTable = $("<table class='grid-canvas table' border=0 style='tableLayout:fixed'/>");
      input=new FlexUI.TextBox(id+"_in",this,{});
      wTable.delegate("td", "click", handleCellClick);
      input.onTextKeyDown.subscribe(me.onTextKeyDown);
      input.onTextChanged.subscribe(me.onTextChanged);
      input.onClick.subscribe(me.onInputClick);
      me.addRow();
      currentRow=0;
      currentCol=-1;
      me.checkAndMove("Next",false);
      me.generateSerialNo();
    }
    function handleCellClick(e){
    	var col1=e.target;
    	var col = $(col1).parent().children().index($(col1));
  		var row = $(col1).parent().parent().children().index($(col1).parent());
  		if(me.validateMoveOnCellClick(row,col)){
  			me.moveWidget(row,col);
  		}
  		FlexUI.trigger(me.onCellClicked,{"name":name,"row":row,"col":col,"table":me},null,this);
    }
    this.onInputClick=function(e){
    	FlexUI.trigger(me.onCellClicked,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this);
    };
     this.onTextKeyDown=function(e,args){
    	var key=e.which || e.keyCode;

    	if(key==13 || key==9){
    		me.checkAndMove("Next",true);
    	}else if(key==37){
    		if(input.getCursorPosition()==0){
    			me.checkAndMove("Prev",true);
    		}
    	}else if(key==39){
    		if(!args.text || args.val.length<=input.getCursorPosition()){
    			me.checkAndMove("Forward",true);
    		}
    	}/*else if(key==46){
    		me.deleteAndMove();
    	}*/
    };
    this.onTextChanged=function(e,args){
    	FlexUI.trigger(me.onCellChanged,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this);
    }
    this.getColumnProperties = function () {
    	return columnProperties;
    }
    this.getRowProperties = function () {
    	return rowProperties;
    }
    this.getCellProperties = function () {
    	return cellProperties;
    }    
    this.getCols=function(){
    	return cols;
    }
	this.addRow=function(){
		var s=rows.length;
		var rProp=rowProperties[s];
		var r=new FlexUI.Row(this,s,rProp,columnProperties,cellProperties);
		r.appendTo(wTable);
		rows.push(r);
		if(options.serialNumberColumn!=-1){
			me.setText(s,options.serialNumberColumn,s+1);
		}
	}    
	this.deleteRow=function(row){
		var r=this.getRow(row);
		r.removeRow();
		rows.splice(row,1);
		if(options.serialNumberColumn!=-1){
			me.generateSerialNo();
		}		
	}
	this.generateSerialNo=function(){
		var s=me.getSize();
		for(var i=0;i<s;i++){
			me.setText(i,options.serialNumberColumn,i+1);
		}
	}	
	this.clear=function(row){
		me.detachWidget();
		var s=me.getSize();
		for(var i=s-1;i>=0;i--){
			me.deleteRow(i);
		}
		me.addRow();
		currentRow=0;
		currentCol=-1;
		me.checkAndMove("Next",false);
	}
	this.deletePagingRow=function(row){
		//TODO
	}	
	this.getSize=function(){
		return rows.length;
	}
	this.getCell=function(row,col){
		return rows[row].getCell(col);
	}
	this.getRow=function(row){
		return rows[row];
	}
	this.setText=function(row,col,text){
		var cell=this.getRow(row).getCell(col);
		if(row==currentRow && col==currentCol && !me.isOtherInput(currentRow,currentCol)){
			input.setValue(text);
		}else if(me.isOtherInput(row,col)){
			cell.getWidgetRef().setValue(text);
		}else{
			cell.setText(text);
		}
		FlexUI.trigger(me.onCellChanged,{"name":name,"row":row,"col":col,"table":me},null,this);
	}
	this.getText=function(row,col){
		var cell=this.getCell(row,col);
		var value="";
		if(row==currentRow && col==currentCol && !me.isOtherInput(currentRow,currentCol)){
			value=input.getValue();
		}else if(me.isOtherInput(row,col)){
			var tvalue=cell.getWidgetRef().getValue();
			if(typeof tvalue=="boolean"){
				value=tvalue+"";
			}else{
				value=tvalue;
			}						
		}else{
			value=cell.getText();
		}
		return value;
	}
	this.getCurrentRowText=function(col){
		return me.getText(currentRow,col);
	}
	this.getCurrentCellText=function(){
		return me.getText(currentRow,currentCol);
	}
	this.setCurrentRowText=function(col,text){
		return me.setText(currentRow,col,text);
	}
	this.setCurrentCellText=function(text){
		return me.setText(currentRow,currentCol,text);
	}
	this.setCellTag=function(row,col,text){
		var cell=this.getRow(row).getCell(col);
		if(row==currentRow && col==currentCol && !me.isOtherInput(currentRow,currentCol)){
			input.setTag(text);
		}else{
			cell.setTag(text);
		}
	}
	this.getCellTag=function(row,col){
		var cell=this.getCell(row,col);
		var value="";
		if(row==currentRow && col==currentCol && !me.isOtherInput(currentRow,currentCol)){
			value=input.getTag();
		}else{
			value=cell.getTag();
		}
		return value;
	}
	this.getCurrentRowTag=function(col){
		return me.getCellTag(currentRow,col);
	}
	this.getCurrentCellTag=function(){
		return me.getCellTag(currentRow,currentCol);
	}
	this.setCurrentRowCellTag=function(col,text){
		return me.setCellTag(currentRow,col,text);
	}
	this.setCurrentCellTag=function(text){
		return me.setCellTag(currentRow,currentCol,text);
	}			
	this.setWidget=function(row,col){
		var cell=this.getCell(row,col);
		var text=cell.getText();
		if(!me.isOtherInput(row,col)){
			me.setColumnAttributes(row,col);
			cell.setWidget(input.getInput());
			input.setValue(text);
			input.setTag(cell.getTag());
			input.setSelection(0,text.length);
			input.focus();
		}else{
			input.setValue("");
			cell.getWidgetRef().focus();
		}
		FlexUI.trigger(me.onEnterCell,{"name":name,"row":row,"col":col,"table":me},null,this);
		cell.setPopup(true);
		currentRow=row;
		currentCol=col;
	}
	this.moveWidget=function(row,col){
		this.detachWidget();
		this.setWidget(row,col);
	}
	this.detachWidget=function(){
		if(currentCol!=-1 && !me.isOtherInput(currentRow,currentCol)){
			var text=input.getValue();
			var cell=this.getCell(currentRow,currentCol);
			input.detach();
			cell.setText(text);
			cell.setTag(input.getTag());
			}
	}
	this.validateMoveOnCellClick=function(row,col){
		var move=FlexUI.trigger(me.onLeaveCell,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this);
		var m=true;
		m=me.validateCell(currentRow,currentCol);
		if(!move || !m  
		|| (currentRow==row && currentCol==col)
		|| !me.checkColumnEnabled(row,col) 		
		|| !me.checkRowEnabled(row)){
			return false;
		}
		return true;
	}
	this.checkColumnEnabled=function(row,col){
		if(columnProperties[col].visible==false 
		|| columnProperties[col].readOnly==true 
		|| (cellProperties[row+"_"+col]!=null && cellProperties[row+"_"+col].readOnly==true)){
			return false;
		}
		return true;
	}
	this.checkRowEnabled=function(row){
		var row=me.getRow(row);
		if((!row.isEditable() || !row.isVisible())){
			return false;
		}
		return true;
	}
	this.checkAndMove=function(direction,doValidate){
		var move=FlexUI.trigger(me.onLeaveCell,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this);
		if(doValidate){
			move=me.validateCell(currentRow,currentCol);
		}else if(currentRow!=-1 && currentCol!=-1){
			me.removeCellBorderColor(currentRow,currentCol);
		}
		if(!doValidate || (move)){
			var tmpCurrentCol=currentCol;
			var tmpCurrentRow=currentRow;
			if(direction=="Next"){
				me.checkAndMoveToNextCell(tmpCurrentRow,tmpCurrentCol);
			}else if(direction=="Prev"){
				me.checkAndMoveToPreviousCell(tmpCurrentRow,tmpCurrentCol);
			}else if(direction=="Forward"){
				me.checkAndMoveForward(tmpCurrentRow,tmpCurrentCol);
			}
		}
		return move;
	}
	this.checkAndMoveToNextCell=function(tmpCurrentRow,tmpCurrentCol){
		for(col=tmpCurrentCol;col<me.getRow(tmpCurrentRow).getSize();col++){
			tmpCurrentCol++;
			if(tmpCurrentRow<me.getSize()-1 && !me.checkRowEnabled(tmpCurrentRow)){
				if(FlexUI.trigger(me.onLeaveRow,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this)){
					tmpCurrentRow++;
					tmpCurrentCol=-1;
					me.checkAndMoveToNextCell(tmpCurrentRow,tmpCurrentCol);
				}
				break;
			}else if(tmpCurrentCol==me.getRow(tmpCurrentRow).getSize() && tmpCurrentRow<me.getSize()-1){
				if(FlexUI.trigger(me.onLeaveRow,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this)){
					tmpCurrentRow++;
					tmpCurrentCol=-1;
					me.checkAndMoveToNextCell(tmpCurrentRow,tmpCurrentCol);
				}
				break;
			}else if((tmpCurrentCol==me.getRow(tmpCurrentRow).getSize() || !me.checkRowEnabled(tmpCurrentRow)) && tmpCurrentRow==me.getSize()-1){
				if(FlexUI.trigger(me.onLeaveRow,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this)){
					if (options.enableAddRow){
						if(!me.getPagingEnable()){
							tmpCurrentRow++;
							me.addRow();
							tmpCurrentCol=-1;
							me.checkAndMoveToNextCell(tmpCurrentRow,tmpCurrentCol);
							return;
						}else if(me.getPagingEnable() && me.getNoOfPages()>me.getCurrentPage()){
							me.nextPage();
							return;
						}else if(me.getPagingEnable() && me.getNoOfPages()==me.getCurrentPage() && me.getSize()==me.getMaxRows()){
							me.createNewPage();
							tmpCurrentRow=0;
							currentRow=0;
							currentCol=-1;
						}else{
							tmpCurrentRow++;
						}
						me.addRow();
						me.createNewPagingRow();
						tmpCurrentCol=-1;
						me.checkAndMoveToNextCell(tmpCurrentRow,tmpCurrentCol);
						break;
					}else if (options.enableAddRow && me.getPagingEnable() && me.getNoOfPages()>me.getCurrentPage()){
						me.nextPage();
						return;
					}else{
						me.setNextFocus();
						return;
					}
				}else{
					return;
				}
			}else if(me.checkColumnEnabled(tmpCurrentRow,col+1)){
				me.moveWidget(tmpCurrentRow,tmpCurrentCol);
				return;
			}
		}
	}
	this.checkAndMoveToPreviousCell=function(tmpCurrentRow,tmpCurrentCol){
		for(col=tmpCurrentCol;col>0;col--){
			tmpCurrentCol--;
			if(me.checkColumnEnabled(tmpCurrentRow,col-1) && tmpCurrentCol>=0){
				me.moveWidget(tmpCurrentRow,tmpCurrentCol);
				break;
			}
		}
	}
	this.checkAndMoveForward=function(tmpCurrentRow,tmpCurrentCol){
		var cellCount=me.getRow(tmpCurrentRow).getSize();
		for(col=tmpCurrentCol;col<cellCount-1;col++){
			tmpCurrentCol++;
			if(me.checkColumnEnabled(tmpCurrentRow,col+1) && tmpCurrentCol<cellCount){
				me.moveWidget(tmpCurrentRow,tmpCurrentCol);
				break;
			}
		}
	}
	this.deleteAndMove=function(){
		var deleteRow=true;
		var empty=FlexUI.trigger(me.isEmptyRow,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this) || true;
		var onBeforeDelete=FlexUI.trigger(me.onBeforeDeleteRow,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this) || true;
		if(onBeforeDelete){
			if(me.getSize()>1 && options.enableDeleteRow && me.getRow(currentRow).isDeletable()){
				if(!empty && options.confirmRowDelete){
					deleteRow=confirm("Do you want to delete this row? ");
				}
				if(deleteRow){
					var tmpCurrentRow=currentRow;
					var tmpCurrentCol=currentCol;
					me.detachWidget();
					if(currentRow>=1){
						currentRow--;
						currentCol=0;
						me.setWidget(currentRow,currentCol);
					}else{
						currentRow=1;
						currentCol=0;
						me.setWidget(currentRow,currentCol);
						currentRow=0;
					}
					me.deleteRow(tmpCurrentRow);
					me.checkAndMoveToNextCell(currentRow,-1);
					if(me.getPagingEnable()){
						me.deletePagingRow(tmpCurrentRow);
					}
					FlexUI.trigger(me.onAfterDeleteRow,{"name":name,"row":tmpCurrentRow,"col":tmpCurrentCol,"table":me},null,this);
			}
		}else if(me.getSize()==1 && options.enableDeleteRow && me.getRow(currentRow).isDeletable()){
			if(!empty && options.confirmRowDelete){
				deleteRow=confirm("Do you want to delete this row? ");
			}
			if(deleteRow){
				me.detachWidget();
				me.deleteRow(currentRow);
				me.addRow();
				currentRow=0;
				currentCol=-1;
				if(me.getPagingEnable()){
					me.deletePagingRow(currentRow);
				}
				me.checkAndMoveToNextCell(currentRow,-1);				
				FlexUI.trigger(me.onAfterDeleteRow,{"name":name,"row":tmpCurrentRow,"col":tmpCurrentCol,"table":me},null,this);
			}
		}
		}
	}	
	this.setColumnAttributes=function(row,col){
		var attributes={};
		if(columnProperties[col]!=null){
			attributes.type=columnProperties[col].type || "TEXT";
			attributes.decimalLength=columnProperties[col].decimalLength || 2;
			attributes.maxValue=columnProperties[col].maxValue || 0;
			attributes.textLength=columnProperties[col].textLength || 0;
			attributes.mandatory=columnProperties[col].mandatory || false;
			attributes.chkTag=columnProperties[col].chkTag || false;
			attributes.lovOptions=columnProperties[col].lovOptions || {};
			attributes.onchange=columnProperties[col].onchange || null;
			attributes.align=columnProperties[col].align || "left";
			attributes.udf=columnProperties[col].udf || null;
			attributes.popup=columnProperties[col].popup || false;
			attributes.prevalidate=columnProperties[col].prevalidate || false;
			}
		if(cellProperties[row+"_"+col]!=null){
			attributes.type=cellProperties[row+"_"+col].type || "TEXT";
			attributes.decimalLength=cellProperties[row+"_"+col].decimalLength || 2;
			attributes.maxValue=cellProperties[row+"_"+col].maxValue || 0;
			attributes.textLength=cellProperties[row+"_"+col].textLength || 0;
			attributes.mandatory=cellProperties[row+"_"+col].mandatory || false;
			attributes.chkTag=cellProperties[row+"_"+col].chkTag || false;
			attributes.lovOptions=cellProperties[row+"_"+col].lovOptions || {};
			attributes.onchange=cellProperties[row+"_"+col].onchange || null;
			attributes.align=cellProperties[row+"_"+col].align || "left";
			attributes.udf=cellProperties[row+"_"+col].udf || null;
			attributes.popup=cellProperties[row+"_"+col].popup || false;
			attributes.prevalidate=cellProperties[row+"_"+col].prevalidate || false;
			}
		input.setAttributes(attributes);
	}
	this.isOtherInput=function(row,col){
		if(columnProperties[col].inputType!='0'  
			|| (cellProperties[row+"_"+col]!=null && cellProperties[row+"_"+col].inputType!='0')){
			return true;
		}
		return false;
	}
	this.checkCurrentCell=function(){
		return me.checkMove(currentRow,currentCol);
	}
	this.checkMove=function(row,col){
		var m=false;
		var chkTag=false;
		var type="TEXT";
		
		if(columnProperties[col]!=null){
			m=columnProperties[col].mandatory || false;
			chkTag=columnProperties[col].chkTag || false;
			type=columnProperties[col].type || "TEXT";
		}
		if(cellProperties[row+"_"+col]!=null){
			m=cellProperties[row+"_"+col].mandatory || false;
			chkTag=cellProperties[row+"_"+col].chkTag || false;
			type=columnProperties[col].type || "TEXT";
		}	
		var value="";
		if(chkTag){
			value=me.getCellTag(row,col);
		}else{
			value=me.getText(row,col);
		}
		var v=(!m || ((type=="TEXT" || type=="LOV" || type=="UDF") && value!="") || (!(type=="TEXT" || type=="LOV" || type=="UDF") && toNumber(value)!=0) );
		if(!v){
			me.setCellBorderColor(row,col,'red');			
		}else{
	    	me.removeCellBorderColor(row,col);
	    }		
		return v;
	}
	this.setCellBorderColor=function(row,col,color){
		var cell=this.getCell(row,col);
		cell.setBorderColor(color);
	}
	this.removeCellBorderColor=function(row,col){
		var cell=this.getCell(row,col);
		cell.removeBorderColor();		
	}
	this.validateCell=function(row,col){
		var vl=true;		
		if(row>=0 && col>=0){
			vl=me.checkMove(row,col);
			if(vl){			
				var cell=this.getCell(row,col);
				vl=cell.validate(name,me,row,col);
			}
		}
		return vl;
	}
	this.preValidateCell=function(){
		if(currentRow>=0 && currentCol>=0){
			var cell=this.getCell(currentRow,currentCol);
			cell.preValidate(name,me,currentRow,currentCol);
		}
	}
	this.getRelatedValues=function(row,col){
		var cell=this.getCell(row,col);
		return cell.getRelatedValues();
	}
	this.setRelatedValues=function(row,col,values){
		var cell=this.getCell(row,col);
		cell.setRelatedValues(values);
	}
	this.getCellPopup=function(row,col){
		var cell=this.getCell(row,col);
		return cell.getPopup();
	}
	this.setCellPopup=function(row,col,f){
		var cell=this.getCell(row,col);
		cell.setPopup(f);
	}
	
	this.appendTo=function(parent){
		wTable.appendTo(parent);
	}
	this.setWidth=function(width){
		wTable.width(width);
	}
	this.getPagingEnable=function(){
		//TODO
		return false;
	}
	this.getNoOfPages=function(){
		//TODO
		return 0;
	}
	this.getCurrentPage=function(){
		//TODO
		return 0;
	}
	this.getMaxRows=function(){
		//TODO
		return 0;
	}
	this.createNewPagingRow=function(){
		//TODO
	}
	this.nextPage=function(){
		//TODO
	}
	this.setNextFocus=function(){
		nextFocus=options.nextFocus;
		if(screenObjects){
			var nf=screenObjects.getScreenObject(nextFocus);
			if(nf instanceof FlexUI.TextBox
				|| nf instanceof FlexUI.Select
				|| nf instanceof FlexUI.CheckBox){
				nf.focus();
			}else if(nf instanceof FlexUI.Table){
				nf.getInputField().focus();
			}else if(nextFocus!=null && ($('#'+nextFocus).is("button") || $('#'+nextFocus).is("a") || $('#'+nextFocus).is("input"))){
				$('#'+nextFocus).focus();
			}
		}
	}
	this.getInputField=function(){
		return input;
	}
	this.getCurrentRow=function(){
		return currentRow;
	}
	this.getValidRowSize=function(){
		var z=me.getSize();
		if(z>1){
			z=z-1;
			me.setCellPopup(z,options.rowEmptyCheckColumn,false);			
			var b=me.validateCell(z,options.rowEmptyCheckColumn);
			if(b){
				z++;
			}			
		}else if(z==1 && options.tableIsOptional){
			me.setCellPopup(z-1,options.rowEmptyCheckColumn,false);			
			var b=me.validateCell(z-1,options.rowEmptyCheckColumn);
			if(!b){
				z--;
			}						
		}
		return z;
	}	
	this.validateAllRows=function(){
		var v=true;
		var s=columnProperties.length;
		var z=me.getValidRowSize();
		for(var i=0;i<z;i++){
			for(var j=0;j<s;j++){
				if(columnProperties[j]!=null){
					me.setCellPopup(i,j,false);
					var b=false;
					b=me.validateCell(i,j);
					if(v && !b){
						v=b;
					}
					me.setCellPopup(i,j,true);										
				}
			}
		}
		return v;
	}
	this.getData=function(){
		var data="";
		var s=columnProperties.length;
		var z=me.getValidRowSize();
		data='"'+id+'":[';
		for(var i=0;i<z;i++){
			data+='[';
			for(var j=0;j<s;j++){
				if(columnProperties[j]!=null){
					var saveTag=columnProperties[j].saveTag;
					var chkTag=columnProperties[j].chkTag || false;
					var value="";
					if(typeof saveTag=="undefined"){
						saveTag=chkTag;
					}					
					if(saveTag){
						value=me.getCellTag(i,j);
					}else{
						value=me.getText(i,j);
					}
					if(""==value){
						value=columnProperties[j].defaultValue;
					}
					data+='"'+value.replace(/"/g,'\\"')+'"';
					if(j!=s-1){
						data+=',';
					}					
				}
			}
			data+=']';
			if(i!=z-1){
				data+=',';
			}
		}
		data+=']';
		return data;
	}
	this.getDataWithRelatedValues=function(){
		var data="";
		var relatedValues="";
		var s=columnProperties.length;
		var z=me.getValidRowSize();
		data='"'+id+'":{"v":[';
		relatedValues='"r":[';
		for(var i=0;i<z;i++){
			data+='[';
			relatedValues+='[';
			for(var j=0;j<s;j++){
				if(columnProperties[j]!=null){
					var chkTag=columnProperties[j].chkTag || false;
					var value="";
					if(chkTag){
						value=me.getCellTag(i,j);
					}else{
						value=me.getText(i,j);
					}
					if(""==value){
						value=columnProperties[j].defaultValue;
					}
					data+='"'+value.replace(/"/g,'\\"')+'"';
					if(me.getRelatedValues(i,j)){
						relatedValues+=''+JSON.stringify(me.getRelatedValues(i,j).data);
					}else{
						relatedValues+='""';
					}
					if(j!=s-1){
						data+=',';
						relatedValues+=',';
					}					
				}
			}
			data+=']';
			relatedValues+=']';
			if(i!=z-1){
				data+=',';
				relatedValues+=',';
			}
		}
		data+=']';
		relatedValues+=']';
		var returnValue=data+','+relatedValues+'}';
		return returnValue;
	}	
	this.setData=function(tData){
		var cs=columnProperties.length;
		var ds=tData.length; 
		for(var i=0;i<ds;i++){
			var r=tData[i];
			if(me.getSize()==i){
				me.addRow();
			}			
			for(var j=0;j<cs;j++){
				var c=r[j];
				me.setText(i,j,c.v);
				me.setCellTag(i,j,c.t);
				if(c.r){
					var values={};
					values['data']=c.r;
					me.setRelatedValues(i,j,values);
				}
			}
		}
		if(ds>0 && options.enableAddRow){
			me.addRow();
		}
	}
	this.setRowData=function(row,rData){
		var cs=columnProperties.length;
		for(var j=0;j<cs;j++){
			var c=rData[j];
			me.setText(row,j,c.v);
			me.setCellTag(row,j,c.t);
			if(c.r){
				var values={};
				values['data']=c.r;
				me.setRelatedValues(row,j,values);
			}
		}
	}
	this.setListData=function(tData){
		var cs=columnProperties.length;
		var ds=tData.length; 
		for(var i=0;i<ds;i++){
			var r=tData[i];
			if(me.getSize()==i){
				me.addRow();
			}			
			for(var j=0;j<cs;j++){
				var c=r[j];
				me.setText(i,j,c);
			}
		}
		if(ds>0 && options.enableAddRow){
			me.addRow();
		}
	}		
	$.extend(this,{
		"onCellClicked": new FlexUI.Event(),
		"onLeaveCell": new FlexUI.Event(),
		"onEnterCell": new FlexUI.Event(),
		"onBeforeDeleteRow": new FlexUI.Event(),
		"onAfterDeleteRow": new FlexUI.Event(),
		"onLeaveRow": new FlexUI.Event(),
		"onCellChanged": new FlexUI.Event(),
		"isEmptyRow": new FlexUI.Event()
	});
	
    this.init();
  }
  
  function FlexRow(parent,row,rowProp,columnProperties,cellProperties) {
    var wRow;
	var cells=new Array();
	var rowDeletable=true;
	var rowEditable=true;
	var rowVisible=true;
	var table=parent;
	
    this.init = function () {
      wRow = $("<tr class='' ></tr>");
      this.createRow();
    };
	this.getSize=function(){
		return cells.length;
	}
	this.getCell=function(col){
		var cell=null;
		if(cells.length>col){
			cell=cells[col];
		}
		return cell;
	}
	this.createRow=function(){
	  if(rowProp!=null){
		  if(rowProp.readOnly){
	      	rowEditable=rowProp.readOnly;
	      }
	      if(rowProp.isDeletable){
	      	rowDeletable=rowProp.deletable;
	      }
	      if(rowProp.isVisible){
	      	rowVisible=rowProp.visible;
	      }
	   }
      for (var i = 0; i < columnProperties.length; i++) {
      		var cell=new FlexUI.Cell(this,columnProperties[i],cellProperties[row+"_"+i]);
      		cells.push(cell);
      		cell.appendTo(wRow);
		}
	}
	this.removeRow=function(){
      for (var i = 0; i < cells.length; i++) {
      		var cell=cells[i];
      		cell.removeCell();
      		cells=[];
		}
		wRow.remove();
	}
	this.isVisible=function(){
		return rowVisible;
	}
	this.setVisible=function(visible){
		rowVisible=visible;
	}
	this.isDeletable=function(){
		return rowDeletable;
	}
	this.setDeletable=function(deletable){
		rowDeletable=deletable;
	}
	this.isEditable=function(){
		return rowEditable;
	}
	this.setEditable=function(editable){
		rowEditable=editable;
	}
	this.getRow=function(){
		return this;
	}
	this.appendTo=function(tableHtml){
		wRow.appendTo(tableHtml);
	}
	this.getTable=function(){
		return table;
	}
    this.init();
  }
  function FlexCell(parent,columnProp,cellProp) {
    var wCell;
	var tag="";
	var relatedValues;
	var row=parent;
	var wRef=null;
	var validateFunction=null;
	var preValidation=null;
	var popup=false;

    this.init = function () {
    	var w=0;
    	if(columnProp.adjustedWidth-parent.getTable().getOptions().headerColumnWidthDiff>0){
    		w=columnProp.adjustedWidth-parent.getTable().getOptions().headerColumnWidthDiff;
    	}
      	wCell = $("<td class='' style='width:"+w+"px;height:20px'/>");
      	if(columnProp.align){
      		wCell.css('text-align',columnProp.align);
      	}
      	if(w==0){
      		wCell.css('display','none');
      	}
      	this.createWidget(columnProp,cellProp);
    };
    this.createWidget=function(columnProp,cellProp){
    	var select=null;
    	var check=null;
    	if(columnProp!=null){ 
    		if(columnProp.inputType=='1'){
    			var select=new FlexUI.Select("",row.getTable(),columnProp);
    			wCell.append(select.getSelect());
    		}else if(columnProp.inputType=='2'){
    			var check=new FlexUI.CheckBox("",row.getTable(),columnProp);
    			wCell.append(check.getCheckBox());
    		}
    		validateFunction=window[columnProp.validation] || null;
    		preValidation=window[columnProp.prevalidate] || null;
    		popup=columnProp.popup || false;    		
    	}
    	if(cellProp!=null){
    		if(cellProp.inputType=='1'){
    			var select=new FlexUI.Select("",row.getTable(),cellProp);
    			wCell.append(select.getSelect());
    		}else if(cellProp.inputType=='2'){
    			var check=new FlexUI.CheckBox("",row.getTable(),cellProp);
    			wCell.append(check.getCheckBox());
    		}
    		validateFunction=window[cellProp.validation] || null;
    		preValidation=window[cellProp.prevalidate] || null;
    	}
    	if(select!=null){
    		select.onSelectKeyDown.subscribe(row.getTable().onTextKeyDown);
    		select.onClick.subscribe(row.getTable().onInputClick);
    		wRef=select;
    	}
    	if(check!=null){
    		check.onCheckKeyDown.subscribe(row.getTable().onTextKeyDown);
    		check.onClick.subscribe(row.getTable().onInputClick);
    		wRef=check;
    	}
    }
	this.getCell=function(col){
		return this;
	}
	this.appendTo=function(rowHtml){
		wCell.appendTo(rowHtml);
	}
	this.removeCell=function(){
		wCell.remove();
	}
	this.setText=function(text){
		wCell.text(text);
	}
	this.getText=function(){
		return wCell.text();
	}
	this.setWidget=function(w){
		wCell.empty();
		w.appendTo(wCell);
		widget=w;
	}
	this.getWidget=function(){
		return widget;
	}
	this.getWidgetRef=function(){
		return wRef;
	}
	this.setRelatedValues=function(values){
		relatedValues=values;
	}
	this.getRelatedValues=function(){
		return relatedValues;
	}	
	this.setTag=function(value){
		tag=value;
	}
	this.getTag=function(value){
		return tag;
	}
	this.getRow=function(){
		return row;
	}
	this.setBorderColor=function(color){
		wCell.css('border-width','1');
		wCell.css('border-color',color);
		wCell.css('border-style','dotted');
	}
	this.removeBorderColor=function(){
		wCell.css('border-width','0');
		wCell.css('border-color','');
		wCell.css('border-style','');
	}
	this.validate=function(id,table,row,col){
		var v=true;
		if(validateFunction && !validateFunction(id,table,row,col)){
			v=false;
			this.setBorderColor('red');
		}else{
			this.removeBorderColor();
		}
		return v;
	}
	this.preValidate=function(id,table,row,col){
		if(preValidation){
		 	preValidation(id,table,row,col);
		}
	}
	this.setPopup=function(f){
		popup=f;
	}
	this.getPopup=function(){
		return popup;
	}
    this.init();
  }
})(jQuery);
(function ($) {
  // register namespace
  $.extend(true, window, {
    FlexUI: {
      LOV: FlexLov,
      Ajax: FlexAjax
    }
  });

  function FlexLov(id,parent,options,columnProperties,data) {
    var wDialog;
    var width=500;
    var height=400;
    var top=300;
    var left=0;
    var rows=20;
    var rowHeight=20;
    var paddingDiff=10;
    var searchTextHeight=25;
    var headerHeight=25;
	var me=this;
	var text;
	var scrollPanel;
	var headerPanel;
	var headerRow;
	var dlg;
	var dataTable;
	var currentRow=0;
	var dataLength=0;
	var beginingRow=0;
	var endingRow=0;
	var lovData=null;
	var searchIndex=-1;
	var searchColumnName="";
	var title="";
	var firstVisibleIndex=0;
	var timer=null;
	var lastText="";
	var lovHeader;
    this.init = function () {
    	wDialog=$("<div id='"+id+"' class='pop_lov_box'></div>");
    	lovHeader=$("<div id='lovheader_"+id+"' class='pop_lov_hed_box'></div>");
    	dlg=wDialog.dialog({autoOpen:false,modal:true,width:'auto',minHeight:200,minWidth:300,close:handleClose,position:'center'});
    	scrollPanel=$("<div id='"+id+"_panel' class='pop_lov_inp_box' style='overflow-y:auto;overflow-x:hidden;padding:0'></div>");
    	headerPanel=$("<div class='xgrid-header' id='"+id+"_hdrpanel' style='padding:0'></div>");
    	headerRow=$("<div class='xgrid-header-columns' id='"+id+"_hdrrow'></div>");
    	dataTable=$("<table  class='grid-canvas' cellpadding=0 cellspacing=0 style='table-layout:fixed' id='"+id+"_data'></table>");
    	text=new FlexUI.TextBox("lov",this,{});
    	wDialog.append(lovHeader);
    	lovHeader.append("<div class='pop_lov_clos'><a href='#'>X</a></div><div class='pop_lov_hed_txt'></div>");
    	wDialog.append("<div class='pop_lov_search_title' id='"+id+"_lovSearchLabel'></div>");    	
    	wDialog.append(text.getInput());
    	wDialog.append(headerPanel);
    	headerPanel.append(headerRow);
    	wDialog.append(scrollPanel);
    	scrollPanel.append(dataTable);
    	text.setHeight(searchTextHeight);
    	text.onTextKeyDown.subscribe(onTextKeyDown);
    	text.onTextKeyPress.subscribe(onTextKeyPress);
    	lovData=data;
    	dataTable.delegate("td","click",handleRowClick);    	
    };
    function handleClose(){
    	if(parent instanceof FlexUI.TextBox){
				parent.focus();
				if(parent.validate()){
		  			parent.goToNextField();
		  		}
			}
    }
    function onHeaderClick(e){
    	var target=e.target;
    	var data=$(target).data("column");
    	searchIndex=$(target).data("index");
    	searchColumnName=data.n;
    	//wDialog.dialog('option','title',title+" [Search: "+searchColumnName+"]");
    	$('.pop_lov_hed_txt').html(title);
    	$("#"+id+"_lovSearchLabel").html(searchColumnName);
    	text.setValue("");
    	e.stopPropagation();
    }
    function handleRowClick(e){
       	var col1=e.target;
    	var col = $(col1).parent().children().index($(col1));
  		var row = $(col1).parent().parent().children().index($(col1).parent());
  		me.deselectRow(currentRow);
  		currentRow=row;
  		me.setSelectedRow(currentRow);
  		text.focus();  		
  		me.returnResult(currentRow);
    }
    function onTextKeyDown(e,args){
    	var key=e.which || e.keyCode;
    	if(key==38){
    		me.movePrevious(lovData);
    	}else if(key==40){
    		me.moveForward(lovData);
    	}else if(key==13){
    		me.returnResult(currentRow);
    	}else if(key==8){
    		me.sendRequestOnKeyPress(key,args.val);
    	}
    }
    function onTextKeyPress(e,args){
    	var key=e.which || e.keyCode;    	
    	me.sendRequestOnKeyPress(key,args.val);
    }
    this.sendRequestOnKeyPress=function(key,val){
    	var t="";
    	if(key==8){
    		t=val.substring(0,val.length-1);
    	}else{
	    	t=val+String.fromCharCode(key);
	    }
	    lastText=t;
	    window.clearTimeout(timer);
	    timer=window.setTimeout(me.ajaxCall,600);
    }
    this.ajaxCall=function(){
	    if(options.searchFromList){
    		me.searchData(searchIndex,lastText);
    		}else{
    			me.sendRequest(lastText,false);
    		}
    }    
    this.setOptions=function(ops){
    	options=ops;
    }
    this.getCurrentRow=function(){
    	return currentRow;
    }
    this.sendRequest=function(text,show){
    	var a=new FlexUI.Ajax();
    	var data=me.getParameters(text);
    	if(show){
    		data+="&ic=1";
    	}else{
    		data+="&ic=0";
    	}
    	var s=a.callAjax("GET",options.url,data);
    	if(show){
    		title=s.title;
    		columnProperties=s.columns;
    		lovData=s.data;
    		}else{
    			lovData=s.data;
    			me.populateData(s.data);
    		}
    }
    this.getParameters=function(text){
    	var data="&id="+options.ajax;
    	if(screenObjects){
	    	var params=options.params || {};
	    	var s=params.length;
	    	for(var i=0;i<s;i++){
	    		var param=params[i];
	    		var src=screenObjects.getScreenObject(param.src);
	    		if(src instanceof FlexUI.TextBox 
	    			|| src instanceof FlexUI.CheckBox
	    			|| src instanceof FlexUI.Select){
	    			var v="";
	    			if(param.ft){    		
	    				v=src.getTag();
	    			}else{
	    				v=src.getValue();
	    			}
	    			if(v=="" && param.df){
	    				v=param.df;
	    			}
	    			data+="&"+param.n+"="+v;	    			
	    		}else if(src instanceof FlexUI.Table){
	    			var v="";
	    			if(param.row=='cr'){
	    				if(param.col=='cc'){
	    					if(param.ft){
	    						v=src.getCurrentCellTag();
	    					}else{
	    						v=src.getCurrentCellText();
	    					}
	    				}else{
	    					if(param.ft){
	    						v=src.getCurrentRowTag(parseInt(param.col));
	    					}else{
	    						v=src.getCurrentRowText(parseInt(param.col));
	    					}
	    				}
	    			}else{
	    				if(param.ft){
	    					v=src.getCellTag(parseInt(param.row),parseInt(param.col));
	    				}else{
	    					v=src.getText(parseInt(param.row),parseInt(param.col));
	    				}
	    			}
	    			if(v=="" && param.df){
	    				v=param.df;
	    			}	    			
	    			data+="&"+param.n+"="+v;
	    		}
	    	}
	    }
    	if(searchIndex!=-1){
    		data+="&F"+(searchIndex+1)+"="+text;
    	}else{
    		data+="&F"+(options.dsi)+"="+text;
    	}
    	return data;
    }
    this.returnResult=function(currentRow){
    	var values;
    	if(options.scrollEnabled){
    		values=lovData[currentRow];
    	}else{
    		values=lovData[currentRow+beginingRow];
    	}
    	var results=options.results || [];
	    var s=results.length;
	    var standalone=options.standalone || false;
    	if(s==0 && !standalone){
    		if(values.length>=2){
	    		parent.setValue(values[0]);
	    		parent.setTag(values[1]);
	    	}else if(values.length==1){
	    		parent.setValue(values[0]);
	    	}
    	}
    	if(screenObjects){
	    	for(var i=0;i<s;i++){
	    		var result=results[i];
	    		var tgt=screenObjects.getScreenObject(result.tgt);
	    		if(tgt instanceof FlexUI.TextBox 
	    			|| tgt instanceof FlexUI.CheckBox
	    			|| tgt instanceof FlexUI.Select){
	    			if(result.tt){    		
	    				tgt.setTag(values[result.id]);
	    			}else{
	    				tgt.setValue(values[result.id]);
	    			}
	    		}else if(tgt instanceof FlexUI.Table){
	    			var v="";
	    			if(result.row=='cr'){
	    				if(result.col=='cc'){
	    					if(result.tt){
	    						tgt.setCurrentCellTag(values[result.id]);
	    					}else{
	    						tgt.setCurrentCellText(values[result.id]);
	    					}
	    				}else{
	    					if(result.tt){
	    						tgt.setCurrentRowCellTag(parseInt(result.col),values[result.id]);
	    					}else{
	    						tgt.setCurrentRowText(parseInt(result.col),values[result.id]);
	    					}
	    				}
	    			}else{
	    				if(result.tt){
	    					tgt.setCellTag(parseInt(result.row),parseInt(result.col),values[result.id]);
	    				}else{
	    					tgt.setText(parseInt(result.row),parseInt(result.col),values[result.id]);
	    				}
	    			}
	    		}
	    	}
	    }
	    me.hide(values);    	
    }
    this.clearResult=function(){
       	var results=options.results || [];
	   	var s=results.length;
    	if(s==0){
    		parent.setValue("");
    		parent.setTag("");
    	}
    	if(screenObjects){
	    	for(var i=0;i<s;i++){
	    		var result=results[i];
	    		var tgt=screenObjects.getScreenObject(result.tgt);
	    		if(tgt instanceof FlexUI.TextBox 
	    			|| tgt instanceof FlexUI.CheckBox
	    			|| tgt instanceof FlexUI.Select){
	    			if(result.tt){    		
	    				tgt.setTag("");
	    			}else{
	    				tgt.setValue("");
	    			}
	    		}else if(tgt instanceof FlexUI.Table){
	    			var v="";
	    			if(result.row=='cr'){
	    				if(result.col=='cc'){
	    					if(result.tt){
	    						tgt.setCurrentCellTag("");
	    					}else{
	    						tgt.setCurrentCellText("");
	    					}
	    				}else{
	    					if(result.tt){
	    						tgt.setCurrentRowCellTag(parseInt(result.col),"");
	    					}else{
	    						tgt.setCurrentRowText(parseInt(result.col),"");
	    					}
	    				}
	    			}else{
	    				if(result.tt){
	    					tgt.setCellTag(parseInt(result.row),parseInt(result.col),"");
	    				}else{
	    					tgt.setText(parseInt(result.row),parseInt(result.col),"");
	    				}
	    			}
	    		}
	    	}
	    }
    }    
    this.show=function(){
    	me.sendRequest("",true);
    	rowHeight=20;
       	me.setHeight(text.getInput().height+(rows*rowHeight)+headerPanel.height);
    	me.createHeader();
    	text.setWidth(wDialog.css('width'));
    	if(lovData){
    		me.populateData(lovData);
    	}
    	wDialog.dialog('open');
    	text.focus();
    	scrollPanel.scrollTop(0);
    	FlexUI.trigger(me.onLovOpen,{},null,this);
    }
    this.searchData=function(index,text){
    	var siz=data.length; 
    	var matchingList=new Array();
    	for(var i=0;i<siz;i++){
    		var r=data[i];
    		if(r[index].match('^'+text)){
    			matchingList.push(r);
    		}
    	}
    	lovData=matchingList;
    	me.populateData(lovData);    	
    }
    this.hide=function(result){
    	wDialog.dialog('close');
    	FlexUI.trigger(me.onLovClose,{result:result},null,this);    	
    }
    this.setWidth=function(width){
		wDialog.width(width);
    }
    this.setHeight=function(height){
    	wDialog.height(height);
    }
    this.setColumnProperties=function(columns){
    	columnProperties=columns;
    }
    this.getColumnProperties=function(){    
    	return columnProperties;
    }
    this.setLovData=function(lData){
    	lovData=lData;
    }
    this.getLovData=function(){
    	return lovData;
    }            
    this.createHeader=function(){
    	headerRow.empty();
    	var totalWidth=0;
    	var siz=columnProperties.length;
    	firstVisibleIndex=0;
    	for (var i = 0; i <siz ; i++) {
        var m = columnProperties[i];
        var header = $("<div class='ui-state-default xgrid-header-column' id='" + id+ i + "' />")
            .html("<span class='xgrid-column-name'>" + m.n + "</span>")
            .width(m.w-paddingDiff)
            .attr("title", m.toolTip || "")
            .data("column", m)
            .data("index",i)
            .addClass(m.headerCssClass || "")
            .appendTo(headerRow)
            .bind("click",onHeaderClick);
            if(m.w==0){
				header.hide();
			}else{
				firsVisibleIndex=firstVisibleIndex || i;				
            	totalWidth=totalWidth+m.w;
            }
		}
    	me.setWidth(totalWidth);
    	headerRow.width(totalWidth);
    	headerPanel.width(totalWidth);
    	dataTable.width(totalWidth);
    	headerRow.height(headerHeight);
    	scrollPanel.width(totalWidth);
    	if(options.dsi){
    		firstVisibleIndex=options.dsi;
    	}
    	//wDialog.dialog('option','title',title+" [Search: "+columnProperties[firstVisibleIndex].n+"]");
    	$('.pop_lov_hed_txt').html(title);
    	searchColumnName=columnProperties[firstVisibleIndex].n;
    	searchIndex=firstVisibleIndex;
    	$("#"+id+"_lovSearchLabel").html(searchColumnName);		    	
    }
    this.populateData=function(data){
    	dataTable.empty();    	
    	dataLength=data.length;
    	beginingRow=0;
    	if(!options.scrollEnabled){
	    	endingRow=rows<dataLength?rows-1:dataLength-1;
    	}else{
    		endingRow=dataLength-1;
    	}
    	me.deselectRow(currentRow);
    	currentRow=0;
    	var row=null;
    	for(var i=0;i<=endingRow;i++){
    		var r=data[i];
    		var s=r.length;
    		row=me.createRow(r);
    		me.appendRow(row);
    	}
    	me.setSelectedRow(currentRow);
    	if(row!=null){
    		scrollPanel.height(rows*row.find('td').eq(0).height());
    		rowHeight=row.find('td').eq(0).height();
    	}else{
    		scrollPanel.height(rows*rowHeight);
    	}
    	scrollPanel.scrollTop(0);
    }
    this.setSelectedRow=function(row){
    	dataTable.find('tr').eq(row).children('td').css('background-color','#FFF9C2');
    }
    this.deselectRow=function(row){
    	dataTable.find('tr').eq(row).children('td').css('background-color','');
    }    
    this.createRow=function(data){
		var row=$("<tr></tr>");
		var s=data.length;
		for(var j=0;j<s;j++){
			var m=columnProperties[j];
			var cell=$("<td>"+data[j]+"</td>");
			cell.width(m.w-paddingDiff);
			cell.height(rowHeight);
			cell.css('overflow','hidden');
			if(m.w==0){
				cell.hide();
				}
			row.append(cell);
		}
		return row;
    }
    this.prependRow=function(row){
		dataTable.prepend(row);
    }
    this.appendRow=function(row){
		dataTable.append(row);
    }
    this.removeLastRow=function(){
    	dataTable.find('tr').eq(rows-1).remove();
    }
    this.removeFirstRow=function(){
    	dataTable.find('tr').eq(0).remove();
    }            
    this.moveForward=function(data){
    	if(currentRow==rows-1 && endingRow<dataLength-1 && !options.scrollEnabled){
    		me.deselectRow(currentRow);
	    	me.removeFirstRow();
	    	beginingRow++;
	    	endingRow++;        	    	
	    	var r=me.createRow(data[endingRow]);
	    	me.appendRow(r);
	    }else if((!options.scrollEnabled && currentRow<rows-1) 
	    		|| (options.scrollEnabled && currentRow<dataLength-1)){
	    	me.deselectRow(currentRow);
	    	currentRow++;
	    }
	    me.setSelectedRow(currentRow);	    
    	me.scrollToTop(currentRow);
    }
    this.movePrevious=function(data){
    	if(currentRow==0 && beginingRow>0 && !options.scrollEnabled){
    		me.deselectRow(currentRow);
			me.removeLastRow();
			beginingRow--;
			endingRow--;
			var r=me.createRow(data[beginingRow]);
			me.prependRow(r);
		}else if(currentRow>0){
			me.deselectRow(currentRow);
			currentRow--;
		}
		me.setSelectedRow(currentRow);		
    	me.scrollToTop(currentRow);
    }
    this.scrollToTop=function(row){
    	var rowPosition=dataTable.find('tr').eq(row).position();
    	var currentRowHeight=dataTable.find('tr').eq(row).height();
    	if((rowPosition.top+currentRowHeight)>(scrollPanel.position().top+(rows*rowHeight))){
    		scrollPanel.scrollTop(scrollPanel.scrollTop()+(currentRowHeight));
    	}else if(rowPosition.top<scrollPanel.position().top){
    		scrollPanel.scrollTop(scrollPanel.scrollTop()-(currentRowHeight));
    	}
    }
    this.calcBeginingRow=function(){
    	var begin=0;
    	begin=(endingRow-rows)+1;
    	return begin;
    }
    this.calcEndingRow=function(){
    	var end=0;
    	end=(beginingRow+rows)-1;
    	return end;
    }    
    this.createSearchList=function(){
    
    }
	$.extend(this, {
		"onLovOpen": new FlexUI.Event(),
		"onLovClose": new FlexUI.Event()
	});
    this.init();
  }
  function FlexAjax() {
	var me=this;
	
	this.init=function(){
	}
    this.callAjax=function(method,url,parameters){
    	var response;
		$.ajax({
		url:url,
		data:parameters,
		type:method,
		async:false,
		success:function(data){
			response=data;
		}
		});
		return response;
    }
    this.loadScript=function(method,url){
    	var response;
		$.ajax({
		url:url,
		type:method,
		async:false,
		dataType:"script",
		success:function(data){
			response=data;
		}
		});
		return response;
    }
    this.init();
  }
  })(jQuery);(function ($) {
  $.extend(true, window, {
    FlexUI: {
      Grid:FlexGrid
    }
  });
  
  var scrollbarSize;
  var maxCssHeight;  // browser's breaking point
  
function FlexGrid(name,parent, columns, options) {
	var wHeaderScroller;
    var wHeader;
    var wFooterScroller;
    var wFooter;
    var wHeaderRow, wHeaderRowScroller, wHeaderRowSpacer;
	var wDataView;
	var dataTable;
	var dataviewHeight, dataviewWidth=0;
    var canvasWidth;
    var dataviewHasHScroll, dataviewHasVScroll;
    var headerColumnWidthDiff = 0, headerColumnHeightDiff = 0, // border+padding
        cellWidthDiff = 0, cellHeightDiff = 0;
    var absoluteColumnMinWidth;
    var numberOfRows = 0;
    var wParent;
    var wRowHtml;
    var input;
    var me=this;
    var wGridTop;
    var wAddRowButton;
    var wDeleteRowButton;
    
    var defaults = {
      autoHeight: false
    };

	function initGrid() {
	  wParent = $(parent);
      scrollbarSize = scrollbarSize || measureScrollbar();

	  options = $.extend({}, defaults, options);
	  
	  wParent
	  .empty()
	  .css("overflow", "hidden")
	  .css("outline", 0);

      dataviewWidth = parseFloat($.css(wParent[0], "width", true))-1;

	
	  wGridTop = $("<div class='xgrid-header-columns' style='overflow:hidden;position:relative;' />").appendTo(wParent);
	  wAddRowButton=$("<input id='ar_"+name+"' type='button' value='Add Row' class='top-buttons'/>");
	  wDeleteRowButton=$("<input id='dr_"+name+"' type='button' value='Delete Row' class='top-buttons'/>");
	  if(options.enableAddRow){	  
		  wGridTop.append(wAddRowButton);
		  wGridTop.append(wDeleteRowButton);
	  }	  
	  wHeaderScroller = $("<div class='xgrid-header' style='overflow:hidden;position:relative;' />").appendTo(wParent);
      wHeader = $("<div class='xgrid-header-columns' />").appendTo(wHeaderScroller);

      measureCellPaddingAndBorder();

	  options.headerColumnWidthDiff=headerColumnWidthDiff;
	  
	  dataTable=new FlexUI.Table(name,dataviewWidth-scrollbarSize.width,options,{},columns,{});
	  
	  columns=dataTable.getColumnProperties();

	  var hwidth=getHeadersWidth(); 
      wHeader.width(hwidth);

      wHeaderRowScroller = $("<div class='xgrid-headerrow' style='overflow:hidden;position:relative;' />").appendTo(wParent);
      wHeaderRow = $("<div class='xgrid-headerrow-columns' />").appendTo(wHeaderRowScroller);
      wHeaderRowSpacer = $("<div style='display:block;height:1px;position:absolute;top:0;left:0;'></div>")
          .css("width", getCanvasWidth() + scrollbarSize.width + "px")
          .appendTo(wHeaderRowScroller);

      wDataView = $("<div class='xgrid-viewport' style='width:100%;overflow:auto;outline:0;position:relative;;'>").appendTo(wParent);
      wDataView.css("overflow-y", options.autoHeight ? "hidden" : "auto");

      dataTable.appendTo(wDataView);

      createHeaderRow();

	  wFooterScroller = $("<div class='xgrid-footer' style='overflow:hidden;position:relative;' />").appendTo(wParent);
      wFooter = $("<div class='xgrid-footer-columns' />").appendTo(wFooterScroller);

	  wFooter.width(hwidth);
	  
	  createFooterRow();

	  wDataView.height(getDataViewHeight());
      dataTable.setWidth(getCanvasWidth());
      wDataView.bind("scroll",handleHeaderRowScroll);
      wDataView.bind("scroll",handleFooterRowScroll);
      wAddRowButton.bind('click',handleAddRowClick);
      wDeleteRowButton.bind('click',handleDeleteRowClick);
      dataTable.onCellChanged.subscribe(me.cellChanged);
      dataTable.onBeforeDeleteRow.subscribe(handleDeleteRow);
	}
	this.getDataTable=function(){
		return dataTable;
	}
	this.cellChanged=function(e,args){
		var row=args.row;
		var col=args.col;
		if(columns[col].type!="TEXT" && columns[col].type!="LOV" && columns[col].cTotal){
			me.calculateColumnTotal(col);
		}
	}
	this.calculateColumnTotal=function(col){
		var total=0;
		var s=dataTable.getSize();
		for(var k=0;k<s;k++){
			total+=toNumber(dataTable.getText(k,col));
		}
		var t=total;
		if(columns[col].decimalLength!=0){
			t=roundOff(total,columns[col].decimalLength);
		}
		$('#f_'+name+columns[col].id).html("<span id='fd_"+name+columns[col].id+"' class='xgrid-column-footer'>" + t + "</span>");
	}
	this.subscribeLeaveCell=function(leaveCell){
      dataTable.onLeaveCell.subscribe(leaveCell);
	}
	this.subscribeLeaveRow=function(leaveRow){
      dataTable.onLeaveRow.subscribe(leaveRow);
	}
	function handleHeaderRowScroll() {
      var scrollLeft = wDataView[0].scrollLeft;
      if (scrollLeft != wHeaderScroller[0].scrollLeft) {
        wHeaderScroller[0].scrollLeft = scrollLeft;
      }
    }
    function handleFooterRowScroll() {
      var scrollLeft = wDataView[0].scrollLeft;
      if (scrollLeft != wFooterScroller[0].scrollLeft) {
        wFooterScroller[0].scrollLeft = scrollLeft;
      }
    }
    function handleAddRowClick(e){
    	dataTable.addRow();
    }
    function handleDeleteRowClick(e){
    	dataTable.deleteAndMove();
    }
    function handleDeleteRow(e,args){
    	var r=args.row;
    	var s=columns.length;
    	for(var k=0;k<s;k++){
    		if(columns[k].type!="TEXT" && columns[k].type!="LOV" && columns[k].cTotal){
    			var spn=$('#fd_'+name+columns[k].id);
    			var total=toNumber(spn.html());
    			total-=toNumber(dataTable.getText(r,k));
    			var t=total;
    			if(columns[k].decimalLength!=0){
					t=roundOff(total,columns[k].decimalLength);
				}
    			spn.html(t);
    		}
    	}
    }           
	function measureScrollbar() {
      var wC = $("<div style='position:absolute; top:-10000px; left:-10000px; width:100px; height:100px; overflow:scroll;'></div>").appendTo("body");
      var dim = {
        width: wC.width() - wC[0].clientWidth,
        height: wC.height() - wC[0].clientHeight
      };
      wC.remove();
      return dim;
    }
	function getHeadersWidth() {
      var headersWidth = 0;
      for (var i = 0, ii = columns.length; i < ii; i++) {
        var width = columns[i].adjustedWidth;
        headersWidth += width;
      }
      headersWidth += scrollbarSize.width;

      return Math.max(headersWidth, dataviewWidth);
    }

    function getCanvasWidth() {
      var availableWidth = dataviewHasVScroll ? dataviewWidth - scrollbarSize.width : dataviewWidth;
      var rowWidth = 0;
      var i = columns.length;
      while (i--) {
        rowWidth += columns[i].adjustedWidth;
      }
      return rowWidth;
    }
    
	function getDataViewHeight() {
      return parseFloat($.css(wParent[0], "height", true)) -
          parseFloat($.css(wParent[0], "paddingTop", true)) -
          parseFloat($.css(wParent[0], "paddingBottom", true)) -
          parseFloat($.css(wHeaderScroller[0], "height")) - getVBoxDelta(wHeaderScroller)-
          parseFloat($.css(wFooterScroller[0], "height")) - getVBoxDelta(wFooterScroller)-
          parseFloat($.css(wGridTop[0], "height")) - getVBoxDelta(wGridTop);
    }
    function getVBoxDelta(wEl) {
      var p = ["borderTopWidth", "borderBottomWidth", "paddingTop", "paddingBottom"];
      var delta = 0;
      $.each(p, function (n, val) {
        delta += parseFloat(wEl.css(val)) || 0;
      });
      return delta;
    }
    function createHeaderRow(){
     wHeader.empty();
     wHeader.width(getHeadersWidth());
    
     for (var i = 0; i < columns.length; i++) {
        var m = columns[i];

        var header = $("<div class='ui-state-default xgrid-header-column' id='" + name + m.id + "' />")
            .html("<span class='xgrid-column-name'>" + m.name + "</span>")
            .width(m.adjustedWidth - headerColumnWidthDiff)
            .attr("title", m.toolTip || "")
            .data("column", m)
            .addClass(m.headerCssClass || "")
            .appendTo(wHeader);
           if(m.adjustedWidth - headerColumnWidthDiff<=0){
           		header.css('display','none')           	
           }
	}
    	
    }
	function createFooterRow(){
     wFooter.empty();
     wFooter.width(getHeadersWidth());
    
     for (var i = 0; i < columns.length; i++) {
        var m = columns[i];

        var header = $("<div class='ui-state-default xgrid-footer-column' id='f_" + name + m.id + "' />")
            .width(m.adjustedWidth - headerColumnWidthDiff)
            .attr("title", m.toolTip || "")
            .data("column", m)
            .addClass(m.headerCssClass || "")
            .appendTo(wFooter);
        if(m.align){
        	header.css('text-align',m.align);        	
        }
        if(m.adjustedWidth - headerColumnWidthDiff<=0){
        	header.css('display','none');
        }
	}
    	
    }
    
   function measureCellPaddingAndBorder() {
      var el;
      var h = ["borderLeftWidth", "borderRightWidth", "paddingLeft", "paddingRight"];
      var v = ["borderTopWidth", "borderBottomWidth", "paddingTop", "paddingBottom"];

      el = $("<div class='ui-state-default xgrid-header-column' style='visibility:hidden'>-</div>").appendTo(wHeader);
      headerColumnWidthDiff = headerColumnHeightDiff = 0;
      $.each(h, function (n, val) {
        headerColumnWidthDiff += parseFloat(el.css(val)) || 0;
      });
      $.each(v, function (n, val) {
        headerColumnHeightDiff += parseFloat(el.css(val)) || 0;
      });
      el.remove();

      /*var r = $("<tr class='xgrid-row' />").appendTo(wDataTable);
      el = $("<td class='xgrid-cell' id='' style='visibility:hidden'>-</div>").appendTo(r);
      cellWidthDiff = cellHeightDiff = 0;
      $.each(h, function (n, val) {
        cellWidthDiff += parseFloat(el.css(val)) || 0;
      });
      $.each(v, function (n, val) {
        cellHeightDiff += parseFloat(el.css(val)) || 0;
      });
      r.remove();*/

      absoluteColumnMinWidth = Math.max(headerColumnWidthDiff, cellWidthDiff);
    }
    function defaultFormatter(row, cell, value, columnDef, dataContext) {
      if (value == null) {
        return "";
      } else {
        return (value + "").replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;");
      }
    }
    $.extend(this, {
      "FlexGridVersion": "2.1"
      });
      
      initGrid();
}
}(jQuery));var screenObjects=null;
if(!screenObjects){
	screenObjects=new FlexUI.ScreenObjects();
}

(function ($) {
  $.extend(true, window, {
    FlexUI: {
      Screen: FlexScreen
    }
  });

  function FlexScreen(id,screen) {
  	var container;
	var layOutDivs={};
	var screenHeight=600;
	var screenWidth=800;
	var me=this;
	var screenProperties=null;
	var operation="ADD";
	var saveInProgress=false;
	
	this.getOperation=function(){
		return operation;
	}
	this.setOperation=function(op){
		operation=op;
	}
	this.getLayOutDivs=function(){
		return layOutDivs;
	}
	this.show=function(){
		container.dialog('option','open');
	}
	this.getScreenProperties=function(){
		return screenProperties;
	}
	this.getSaveInProgress=function(){
		return saveInProgress;
	}
  	this.init=function(){
  		if(screen.js!=""){
	  		var ls=new FlexUI.Ajax();
	  		ls.loadScript("GET",screen.js);
	  	}
  		screenProperties=screen.screen;
  		var s=screenProperties.length;
  		if(screen.container){
  			container=$('#'+screen.container.id);
  			if(!container){
  				container=$("<div id='container' class='container'/>");
	  			screenHeight=screen.container.height-20;
	  			screenWidth=screen.container.width-20;
  			}else{
	  			screenHeight=container.height()-20;
	  			screenWidth=container.width()-20;
	  			if(screenWidth==-20){
	  				screenWidth=container.parent().width()-20;
	  			}
	  		}
	  		if(screen.container.isdialog){
	  			container.dialog({modal:true,width:screen.size.width,height:screen.size.height});
  				container.dialog('option','title',screen.title.name);
  				container.dialog('option','position','center');	   				 			
	  		}
  		}else{
  		  	$(document).attr('title',screen.title.name);  		
	  		screenHeight=$(window).height()-20;
	  		screenWidth=$(window).width()-20;
	  		container=$("<div id='container' class='container' style='height:"+screenHeight+"px;width:"+screenWidth+"px;float:left;padding-left:5px'/>");
  			container.append($("<div id='title' style='height:"+screen.title.height+"px;width:"+(screen.title.width)+"%;background:linear-gradient(#6FACD5, #497BAE) repeat scroll 0 0 #5E87B0;text-align:center;font-weight:bold;font-size:20px;color:white'>"+screen.title.name+"</div>"));  		
  			$('body').append(container);	  		
	  	}
		for(var i=0;i<s;i++){
			var g=screenProperties[i];
			var h=me.calculatePartitionHeight(g.height);
			var w=me.calculatePartitionWidth(g.width);
			if(h<g.minHeight){
				h=g.minHeight;
			}
			if(w<g.minWidth){
				w=g.minWidth;
			}
			if(g.title){
			    var t=$("<div id='t_"+g.name+"' style='width:100%;float:left'><h4 class='bottomLine'>"+g.title+"</h4></div>");
			    t.data("gname",g.name);
				container.append(t);
				t.bind("click",this.onGroupTitleClick);
			}			
			if(g.contentType=='Table'){
				layOutDivs[g.name]=$("<div id='"+g.name+"' style='height:"+h+"px;width:"+w+"px;float:"+g.float+"'/>");
				container.append(layOutDivs[g.name]);							
				this.createPartitionTable(g.name,g.tableProperties);
			}else if(g.contentType=='Fields'){
				layOutDivs[g.name]=$("<div id='"+g.name+"' style='width:"+g.width+"%;float:"+g.float+"'/>");
				container.append(layOutDivs[g.name]);							
				this.createPartitionFields(g.name,layOutDivs[g.name].width(),g.colWidth,g.fields);
			}
		}
		this.setDefaults();
  	}
  	this.createPartitionFields=function(groupName,pWidth,columnWidth,fields){
  		var s=fields.length;
  		var fDiv;
  		var w=this.calculatePartitionColumnWidth(pWidth,columnWidth);
  		var totalColumns=Math.floor(pWidth/w);
  		var totalWidthPerc=100;
  		var captionWidthPerc=20;
  		var totalWidthUsed=0;
  		var rowWrapperDiv=$("<div class='clearfix'/>");
  		var rowDiv=$("<div class='row'/>");
  		  			  		
  		for(var j=0;j<s;j++){
  			var f=fields[j];
  			var field=null;
  			var currentWidth=0;
  			var fieldId=f.name;
  			if(f.id){
  				fieldId=f.id;
  			}
  			if(f.inputType=='0'){
  				field=new FlexUI.TextBox(fieldId,this,f);
  			}else if(f.inputType=='1'){
    			field=new FlexUI.Select(fieldId,this,f);
    		}else if(f.inputType=='2'){
    			field=new FlexUI.CheckBox(fieldId,this,f);
    		}else if(f.inputType=='3'){
				field=new FlexUI.Button(fieldId,this,f);    		
    		}else if(f.inputType=='4'){
    			field=new FlexUI.Label(fieldId,this,f);
    		}
    		var sw=0;
    		sw=(totalWidthPerc/totalColumns); //to be changed in future    		
    		if(f.colspan>1){
    			sw=sw*f.colspan;
    		}
    		if(f.inputType!='3' && f.inputType!='4'){
    			sw-=captionWidthPerc;
    		}	    		
	    	if(f.visible){
	    		currentWidth=w;
	    		if(f.colspan){
	    			currentWidth=(w*f.colspan);
	    		}
	    		totalWidthUsed+=currentWidth;
	    	}
	    	if(totalWidthUsed>pWidth){
	    		totalWidthUsed=currentWidth;
	    		if(rowWrapperDiv){
	    			rowWrapperDiv.append(rowDiv);	    			
	    			layOutDivs[groupName].append(rowWrapperDiv);
	    		}	    		
	    		rowWrapperDiv=$("<div class='clearfix'/>");
	    		rowDiv=$("<div class='row'/>");
	    	}
    		/*var fw=w-sw-4; //to be changed in future
    		field.setWidth(fw);
    		field.getInput().css('width',sw+'%');*/
    		field.setNextFocus(f.nf);
    		/*var fh="25px";
    		var fontSize="12px";
    		if(f.height){
    			fh=f.height+"px";
    			fontSize=(f.height-15)+"px";
    		}*/
    		if(f.visible){
    		    fDiv=$("<div id='d_"+fieldId+"' style='float:left;width:"+sw+"%;'/>");//;display:"+(f.visible?'block':'none')+"'
    			if(f.inputType!='3' && f.inputType!='4' && f.caption!=""){
    				rowDiv.append($("<label class='Truelabel'>"+f.caption+"</label>"));//width:"+sw+"px;float:left;
    				var d=$("<div id='dl_"+fieldId+"' style='float:left;width:2%;'/>");
    				rowDiv.append(d);
    				if(f.mandatory){
    					d.append($("<label class='man'>&nbsp;*</label>"));
    				}else{
    					d.append($("<label class='man'>&nbsp;&nbsp;</label>"));
    				}
    			}else if(f.inputType=='4'){
	    				rowDiv.css('background-color','#f0f0f1');
	    		}else if(f.inputType=='3'){
	    		
	    		}	    			    			    		
    			field.appendTo(fDiv);
    			rowDiv.append(fDiv);    			
    		}
  			screenObjects.addScreenObject(fieldId,field);  			
  		}
  		if(rowWrapperDiv){
			rowWrapperDiv.append(rowDiv);	    			
			layOutDivs[groupName].append(rowWrapperDiv);
  		}
  	}
  	this.createPartitionTable=function(groupName,tableProperties){
  		  var options = {
    		enableCellNavigation: true,
    		enableColumnReorder: false,
    		enableAddRow:true,
    		enableDeleteRow:true
  			};  			
  		  options.rowEmptyCheckColumn=tableProperties.rowEmptyCheckColumn || -1;
  		  if(tableProperties.enableAddRow==false){
  		  	options.enableAddRow=tableProperties.enableAddRow;
  		  }
  		  if(tableProperties.enableDeleteRow==false){
  		  	options.enableDeleteRow=tableProperties.enableDeleteRow;
  		  }
  		  options.serialNumberColumn=tableProperties.serialNumberColumn || 0;
  		  options.tableIsOptional=tableProperties.optional || false;
  		  options.nextFocus=tableProperties.nextFocus;
  		  var grid = new FlexUI.Grid(groupName+"_data",'#'+groupName, tableProperties.columns, options);
  		  screenObjects.addScreenObject(groupName+"_data",grid.getDataTable());
  		  grid.subscribeLeaveCell(handleLeaveCell);
    	  grid.subscribeLeaveRow(handleLeaveRow);
  	}
  	this.onGroupTitleClick=function(e){
  		var g=e.target;
  		var gname=$(g).data("gname");
  		var gd=$('#'+gname);
  		if(gd.is(':visible')){
  			gd.hide();
  		}else{
  			gd.show();
  		}
  	}
  	this.showHideGroup=function(groupname,show){
  		var tg=$('#t_'+groupname);
  		var gd=$('#'+groupname);
  		if(show){
  			gd.show();
  			tg.show();
  		}else{
  			gd.hide();
  			tg.hide();
  		}
  	}
  	this.calculatePartitionHeight=function(heightPerc){
		return screenHeight*heightPerc/100;  		
  	}
  	this.calculatePartitionWidth=function(widthPerc){
		return screenWidth*widthPerc/100;  		
  	}
  	this.calculatePartitionColumnWidth=function(pWidth,widthPerc){
		return pWidth*widthPerc/100;  		
  	}
  	function handleLeaveCell(e,args){
		return true;
	}
	function handleLeaveRow(e,args){
		return true;
	}	
  	this.processDataToSave=function(additionalData){
  		saveInProgress=true;
  		var s=screenProperties.length;
  		var comma=""; 
  		var data='data={"operation":"'+operation+'","savedata":{';
  		for(var i=0;i<s;i++){
			var g=screenProperties[i];
			if(g.contentType=='Table'){
				var t=screenObjects.getScreenObject(g.name+"_data");
				if(t.validateAllRows()){
					data+=comma+t.getDataWithRelatedValues();
				}else{
					return "FAILED";					
				}
			}else if(g.contentType=='Fields'){
				var fields=g.fields;
				var fs=fields.length;
				var v="";
				for(var p=0;p<fs;p++){				
					var f=fields[p];
					var fieldId=f.name;
					if(f.id){
						fieldId=f.id;
					}
					if(f.inputType!='3'){
						var saveTag=f.saveTag;
						if(typeof saveTag=="undefined"){
							saveTag=f.chkTag;
						}
						var w=screenObjects.getScreenObject(fieldId);
						if(!w.validate() || (w instanceof FlexUI.TextBox && !w.checkMove())){
							return "FAILED";
						} 
						if(saveTag){
							v=w.getTag();
						}else{
							v=w.getValue();
						}
						if(v==null || v==""){
							v=f.defaultValue;
						}
						if(f.inputType!=2){
							data+=comma+'"'+f.name+'":"'+v.replace(/"/g,'\\"')+'"';							
						}else{
							data+=comma+'"'+f.name+'":"'+v+'"';
						}
						comma=',';
					}				
				}
			}
			comma=",";
		}
		if(additionalData!=null){
			data+=additionalData;
		}
		data+='}';		
		data+='}';
		saveInProgress=false;
		return data; 		
  	}
  	this.clearScreen=function(){
  		var s=screenProperties.length;
  		for(var i=0;i<s;i++){
			var g=screenProperties[i];
			if(g.contentType=='Table'){
				var t=screenObjects.getScreenObject(g.name+"_data");
				t.clear();
			}else if(g.contentType=='Fields'){
				var fields=g.fields;
				var fs=fields.length;
				for(var p=0;p<fs;p++){				
					var f=fields[p];
					var fieldId=f.name;
					if(f.id){
						fieldId=f.id;
					}
					var w=screenObjects.getScreenObject(fieldId);
					if(!(w instanceof FlexUI.Button)){ 
						w.reset();
					}
				}
			}
		}
		this.setDefaults();
  	}
  	this.loadListData=function(screenData){
  		var s=screenProperties.length;
  		for(var i=0;i<s;i++){
			var g=screenProperties[i];
			if(g.contentType=='Table'){
				var t=screenObjects.getScreenObject(g.name+"_data");
				if(screenData[g.name+"_data"]!=null){
					t.setListData(screenData[g.name+"_data"]);
				}
			}else if(g.contentType=='Fields'){
				var fields=g.fields;
				var fs=fields.length;
				for(var p=0;p<fs;p++){				
					var f=fields[p];
					var fieldId=f.name;
					if(f.id){
						fieldId=f.id;
					}
					var w=screenObjects.getScreenObject(fieldId);
					if(!(w instanceof FlexUI.Button) && screenData[f.name]){ 
						w.setValue(screenData[f.name]);
						w.setTag(screenData[f.name]);
					}
				}
			}
		}
  	}
  	this.loadData=function(screenData){
  		var s=screenProperties.length;
  		for(var i=0;i<s;i++){
			var g=screenProperties[i];
			if(g.contentType=='Table'){
				var t=screenObjects.getScreenObject(g.name+"_data");
				if(screenData[g.name+"_data"]!=null){
					t.setData(screenData[g.name+"_data"]);
				}
			}else if(g.contentType=='Fields'){
				var fields=g.fields;
				var fs=fields.length;
				for(var p=0;p<fs;p++){				
					var f=fields[p];
					var fieldId=f.name;
					if(f.id){
						fieldId=f.id;
					}
					var w=screenObjects.getScreenObject(fieldId);
					if(!(w instanceof FlexUI.Button) && screenData[f.name]){ 
						w.setValue(screenData[f.name].v);
						w.setTag(screenData[f.name].t);
					}
				}
			}
		}
  	}  	
  	this.setDefaults=function(){
  		if(screen.defaults){
  			var ls=new FlexUI.Ajax();
  			var r=ls.callAjax("GET",screen.defaults.url,"ic=0&id="+screen.defaults.id);
     		var results=screen.defaults.results || [];
	    	var s=results.length;
    		if(r!=null && screenObjects){
    			var values=r.data[0];
	    		for(var i=0;i<s;i++){
	    			var result=results[i];
	    			var tgt=screenObjects.getScreenObject(result.tgt);
	    			if(tgt instanceof FlexUI.TextBox 
	    				|| tgt instanceof FlexUI.CheckBox
	    				|| tgt instanceof FlexUI.Select){
	    				if(result.tt){    		
	    					tgt.setTag(values[result.id]);
	    				}else{
	    					tgt.setValue(values[result.id]);
	    				}
	    			}else if(tgt instanceof FlexUI.Table){
	    				var v="";
	    				if(result.row=='cr'){
	    					if(result.col=='cc'){
	    						if(result.tt){
	    							tgt.setCurrentCellTag(values[result.id]);
	    						}else{
	    							tgt.setCurrentCellText(values[result.id]);
	    						}
	    					}else{
	    						if(result.tt){
	    							tgt.setCurrentRowCellTag(parseInt(result.col),values[result.id]);
	    						}else{
	    							tgt.setCurrentRowText(parseInt(result.col),values[result.id]);
	    						}
	    					}
	    				}else{
	    					if(result.tt){
	    						tgt.setCellTag(parseInt(result.row),parseInt(result.col),values[result.id]);
	    					}else{
	    						tgt.setText(parseInt(result.row),parseInt(result.col),values[result.id]);
	    					}
	    				}
	    			}
	    		}
	    	}  			
  		}
  	}
  	this.addDataRow=function(){
  		var t=screenObjects.getScreenObject("myGrid_data");
  		var d=[[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
  				,[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]  				
  			  ]
		t.setData(d);       
  	}
 	this.init();
  }
  })(jQuery); function jqReport(id,parent,params,width,height) {
	var container=$(parent);
	container.append($("<table id='report_"+id+"'></table>")); 
	container.append($("<div id='paging_"+id+"'></div>"));			    	 
	var prm=params;
	var l=new FlexUI.Ajax();
	var v=l.callAjax("GET","/waggle/service/report/metadata","id="+id);
	v.url='/waggle/service/report/data?id='+id+params;
	v.datatype="json";
	v.rowNum=25;
	v.rowList=[25,50,75,100,500];  
	v.pager='#paging_'+id; 
	v.viewrecords=true; 
	v.altRows=true;
	v.gridView=true;
	v.shrinkToFit=false;
	if(width){
		v.width=width;
	}else{
		v.width=container.width();
	}
	if(height){
		v.height=height;
	}else{
		v.height=350;
	}
	var s=v.colModel.length;
	for(var i=0;i<s;i++){
		var col=v.colModel[i];
		if(col.formatter=='image'){
			var params=col.parameters.split(",");
			var columns=col.columns.split(",");
			var link=col.link;
			var image=col.image;
			var g=params.length;
			link='function imageFormat'+i+'(cellValue,options,rowObject){ var k="'+link+'?';
			for(x=0;x<g;x++){
				link+='&'+params[x]+'="+rowObject.'+columns[x]+'+"';
			}
			link+='"; return "<span class=\''+image+'\' onclick=\'openLink(\\""+k+"\\")\'/>";}';			
			var b=eval("("+link+")");
			v.colModel[i].formatter=b;
		}else if(col.formatter=='statusimage'){
			var image=col.image.split(",");
			link='function imageFormat'+i+'(cellValue,options,rowObject){ if(cellValue=="Active"){';
			link+=' return "<span class=\''+image[0]+'\'/>"; }else if(cellValue=="InActive"){ return "<span class=\''+image[1]+'\'/>";}'
			link+=' else if(cellValue=="Completed"){';
			link+=' return "<span class=\''+image[0]+'\'>Completed</span>"; }else if(cellValue=="Pending"){ return "<span class=\''+image[1]+'\'>Pending</span>";}}';			
			var b=eval("("+link+")");
			v.colModel[i].formatter=b;
		}
	}
	jQuery("#report_"+id).jqGrid(v);
	jQuery("#report_"+id).jqGrid('navGrid','#paging_'+id,{add:false,edit:false,del:false}, {}, {}, {}, {multipleSearch:true, multipleGroup:false, showQuery: false});
	jQuery("#report_"+id).jqGrid('filterToolbar');
	showPDFExportButton(id,prm);
}
function openLink(link){
	alert("link2");
	loadOrderData(link,"");
}
function toggleSearchToolBar(id){
	jQuery("#report_"+id).jqGrid('filterToolbar')[0].toggleToolbar();	
}
function unloadGrid(id){
	jQuery("#report_"+id).jqGrid('GridDestroy');
}
function reloadGrid(id){
	jQuery("#report_"+id).trigger('reloadGrid');
}
function changeUrlAndReloadGrid(id,params,newParams){
	alert("222");
	var newUrl='/Fruits/service/report/data?id='+id+params+newParams;
	jQuery("#report_"+id).setGridParam({url:newUrl});
	jQuery("#report_"+id).trigger('reloadGrid');
}
function getJqGridSelectedRow(id){	
	var selr = jQuery("#report_"+id).jqGrid('getGridParam','selrow');
	return selr;
}
function getSelectCellValue(id){
	var rowId=getJqGridSelectedRow(id);
	var r = jQuery("#report_"+id).jqGrid ('getRowData', rowId);
	return r;
}
function setJqGridFrozenColumns(id){
	jQuery("#report_"+id).jqGrid('setFrozenColumns');
}
function showPDFExportButton(id,params){
	jQuery("#report_"+id).jqGrid('navButtonAdd', 
            '#paging_'+id,
            {caption:"",
            title:"Export to PDF", 
            buttonicon:"pdf-icon", 
            onClickButton: function(){window.open('/Waggle/service/report/writepdf?id='+id+params);}, position:"last"});
}(function ($) {
$.extend(true, window, {
    "FlexUI": {
      "Actions": Actions
      }
      });
      
  function Actions(menuId,iconsParent,buttonsParent) {
	  this.buildActions=function(){
	  	var l=new FlexUI.Ajax();
	  	var v=l.callAjax("GET","/Fruits/service/ajax","ic=0&id=actions&menuid="+menuId);
	  	var icons=v.data;
	  	var s=icons.length;
	  	if($('#'+iconsParent)){
	  		$('#'+iconsParent).append("<div id='actionicons' class='btn-group pull-right'></div>");
	  	}
	  	if($('#'+buttonsParent)){
	  		$('#'+buttonsParent).append("<span id='actionbuttons'></span>");
	  	}
	  	var ul=$('#actionicons');  	
	  	var sp=$('#actionbuttons');
	  	for(var i=0;i<s;i++){
	  		var a=icons[i];
	  		if(a[5]==0){
				ul.append("<button class='"+a[3]+"' onclick='"+a[2]+"'><i class='"+a[4]+"'></i></button>");
			}else{
				//ul.append("<button class='"+a[3]+"' onclick='"+a[2]+"'><i class='"+a[1]+"'></i></button>");
				sp.append("<a class='"+a[3]+"' href='#' onclick='"+a[2]+"'>"+a[1]+"</a>");
			}
	  	}
	  };
  }
  })(jQuery);Date.prototype.adjust = function(part, amount){
	part = part.toLowerCase();
	
	var map = { 
				years: 'FullYear', months: 'Month', weeks: 'Hours', days: 'Hours', hours: 'Hours', 
				minutes: 'Minutes', seconds: 'Seconds', milliseconds: 'Milliseconds',
				utcyears: 'UTCFullYear', utcmonths: 'UTCMonth', weeks: 'UTCHours', utcdays: 'UTCHours', 
				utchours: 'UTCHours', utcminutes: 'UTCMinutes', utcseconds: 'UTCSeconds', utcmilliseconds: 'UTCMilliseconds'
			},
		mapPart = map[part];

	if(part == 'weeks' || part == 'utcweeks')
		amount *= 168;
	if(part == 'days' || part == 'utcdays')
		amount *= 24;
	
	this['set'+ mapPart]( this['get'+ mapPart]() + amount );

	return this;
}

Date.prototype.diff = function(date2, parts){
	var d1 = new Date(this.getTime()),
		d2 = new Date(date2.getTime()),
		pm = d1 <= d2? 1 : -1,
		result = { },
		factors = { weeks: (1000*60*60*24*7), days: (1000*60*60*24), hours: (1000*60*60), minutes: (1000*60), seconds: 1000, milliseconds: 1 };

	if(parts === undefined)
		parts = ['years', 'months', 'weeks', 'days', 'hours', 'minutes', 'seconds', 'milliseconds'];
	else if(typeof(parts) == "string")
		parts = [parts];
		
	for(var i=0, l=parts.length; i<l; i++){
		var k = parts[i];
		result[k] = 0;

		if(factors[k] === undefined){
			inaWhile: while( true ){
				d2.adjust(k, -1*pm);
				if( (pm === 1 && d1 > d2) || (pm === -1 && d1 < d2)){
					d2.adjust(k, 1*pm);
					break inaWhile;
				}
				result[k]++;
			}
		}
		else{
			var tmpDiff = Math.abs(d2.getTime() - d1.getTime());
			result[k] = Math.floor(tmpDiff / factors[k]);
			d2.adjust(k, result[k]*-1*pm);
		}
		result[k] *= pm;
	}
	
	if(parts.length == 1)
		return result[parts[0]];
	return result;
}