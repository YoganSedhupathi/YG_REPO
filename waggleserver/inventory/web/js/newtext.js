/***
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
	  var format="dd/mm/yyyy";
	  var maxdate="1d";
	  var validateFunction=null;
	  var onChangeFunction=null;
	  var preValidation=null;
	  var readOnly=false;
	  var userDefinedFunction=null;
	  var enabled=true;
	  var lovTextChanged=false;
		  
	  this.setMandatory=function(mnd){
		  mandatory=mnd;
	  }
	  this.getLovOptions=function(){
		  return lovOptions;
	  }		
	  this.init = function () {      
		wButton = $("<INPUT type=button  id='"+id+"' value='Select'/>");      
		if(attributes.type=='TEXTAREA'){
			wTextBox = $("<TEXTAREA rows=0 cols=200 id='"+id+"'/>");
		}else{
			wTextBox = $("<INPUT autocomplete='off' type=text id='"+id+"'/>");	  	
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
			  if(type=="LOV"){
				  lovTextChanged=true;
			  }
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
		  }else if(type=="DATE" || type=="TDATE"){
			  checkDate(e,key);
		  }else if(type=="TDATETIME"){
			  checkDateTime(e,key);
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
			  var sd=lov.show();
			  if(!sd){
				  if(!me.validate()){
				  }else{		
					  if(me.goToNextField()) return;
				  }							
			  } 						
		  }else if(type=="UDF" && me.getCheckValue()==""){
			  userDefinedFunction(id,me);
		  }	
	  }
	  this.getCheckValue=function(){
		  var value="";
		  if(chkTag){
			  value=me.getTag();
		  }else{
			  value=me.getValue(true);
		  }
		  return value;
	  }
	  this.checkMove=function(){
		  var v=true;
		  if(!(parent instanceof FlexUI.Table)){		
			  v=(!mandatory || ((type=="TEXT" || type=="LOV" || type=="UDF" || type=="TDATE" || type=="TDATETIME") && me.getCheckValue()!="") || (!(type=="TEXT" || type=="LOV" || type=="UDF" || type=="TDATE" || type=="TDATETIME") && toNumber(me.getCheckValue())!=0));
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
	  function checkDateTime(e,key){
		  if (key != 8){
		  var c = String.fromCharCode(key);
			  if(!(isDigit(key)) && (c != ':') && (c != '/') && (c != 'P') && (c != 'A') && (c != 'M') && (c != 'p') && (c != 'a') && (c != 'm')){
				  e.preventDefault();			
			  }
		  }
	  }
	  function checkDateFormat(dt){
		  var corDate="";
		  if(dt.length==6){
			  var day=dt.substring(0,2);
			  var mon=dt.substring(2,4);
			  var yr=dt.substring(4,6);
			  if(checkDateValue(day,mon,yr)){
				  var firstTwo=((new Date()).getFullYear()+"").substring(0,2);
				  corDate=day+"/"+mon+"/"+firstTwo+yr;
			  }
		  }else if(dt.length==8){
			  var day=dt.substring(0,2);
			  var mon=dt.substring(2,4);
			  var yr=dt.substring(4,8);
			  if(checkDateValue(day,mon,yr)){
				  corDate=day+"/"+mon+"/"+yr;
			  }    	
		  }else if(dt.length==10){
			  var dt1=dt.split("/");
			  var day=dt1[0];
			  var mon=dt1[1];
			  var yr=dt1[2];
			  if(checkDateValue(day,mon,yr)){
				  corDate=day+"/"+mon+"/"+yr;
			  }    	    	
		  }
		  return corDate;
	  }
	  function formatDateddMMyyyy(d){
		  var formattedDate="";
		  var curr_date = d.getDate();
		  var curr_month = d.getMonth();
		  var curr_year = d.getFullYear();
		  curr_month++;
		  
			 var mon="";
			 var day="";
			 if(curr_month<=9){
				 mon="0"+curr_month;
			 }else{
				 mon=curr_month+"";
			 }
			 if(curr_date<=9){
				 day="0"+curr_date;
			 }else{
				 day=curr_date+"";
			 }   		
			 formattedDate=day+"/"+mon+"/"+curr_year;
			 return formattedDate;
	 }
	  function checkDateValue(day,mon,yr){
		  if(day>31 || day==0 ){
			  return false;
		  }
		  if(mon>12 || mon==0){
			  return false;
		  }
		  if(yr!=undefined && yr.length>4){
			  return false;
		  }
		  return true;
	  }
	  function checkTimeValue(hr,min){
		  if(hr>12 || hr==0 ){
			  return false;
		  }
		  if(min>59){
			  return false;
		  }
		  return true;
	  }
	  function checkDateTimeFormat(dt){
		  var corDate="";
		  if(dt.length==11){
			  corDate=checkDateFormat(dt.substring(0,6));
			  var hr=dt.substring(6,8);
			  var min=dt.substring(8,10);
			  var ap=dt.substring(10,11);
			  if(checkTimeValue(hr,min)){
				  corDate=corDate+" "+hr+":"+min+" "+ap.toUpperCase()+"M";
			  }
		  }else if(dt.length==13){
			  corDate=checkDateFormat(dt.substring(0,8));
			  var hr=dt.substring(8,10);
			  var min=dt.substring(10,12);
			  var ap=dt.substring(12,13);
			  if(checkTimeValue(hr,min)){
				  corDate=corDate+" "+hr+":"+min+" "+ap.toUpperCase()+"M";
			  }
		  }else if(dt.length==15){
			  corDate=checkDateFormat(dt.substring(0,10));
			  var hr=dt.substring(10,12);
			  var min=dt.substring(12,14);
			  var ap=dt.substring(14,15);
			  if(checkTimeValue(hr,min)){
				  corDate=corDate+" "+hr+":"+min+" "+ap.toUpperCase()+"M";
			  }    		
		  }else if(dt.length==19){
			  corDate=checkDateFormat(dt.substring(0,10));
			  var hr=dt.substring(11,13);
			  var min=dt.substring(14,16);
			  var ap=dt.substring(17,19);
			  if(checkTimeValue(hr,min)){
				  corDate=corDate+" "+hr+":"+min+" "+ap.toUpperCase();
			  }    		
		  }
		  return corDate;
	  }
	  function handleKeyDown(e){
		  var key=e.which || e.keyCode;
		  if(key==13 || key==9){
			  var prevText="";
			  if(type=="LOV" && lov!=null && lovTextChanged){
				  prevText=me.getValue();
				  lov.setOptions(lovOptions);
				  lov.clearResult();
				  lovTextChanged=false;					
			  }
			  if(prevText!=""){
				  me.setValue(prevText);
			  }
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
		  }else if(key==46 && e.ctrlKey){
			  if(parent instanceof FlexUI.Table){
				  parent.deleteAndMove();
				  e.stopPropagation();
				  e.preventDefault();							
			  }
		  }else if(key==46){
			  if(type=="LOV"){
				  if(lov!=null){
					  lov.setOptions(lovOptions);
					  lov.clearResult();
					  e.stopPropagation();
					  e.preventDefault();																
				  }
			  }
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
			  
			  wInput.datepicker({format:format,endDate:maxdate});			
			  if(wInput.val()==""){
				  var cd=new Date();
				  wInput.datepicker("setDate",cd);
			  }
			  wInput.datepicker("option",{onClose:me.goToNextField});
		  }else if(type=='DATETIME'){
			  wInput.datetimepicker({
					  timeFormat: 'hh:mm TT',
					  format:format
			  });
			  if(wInput.val()==""){
				  var cd=new Date();
				  wInput.datetimepicker("setDate",cd);
			  }
			  wInput.datetimepicker("option",{onClose:me.goToNextField});	
		  }else if(type=='TIME'){
			  wInput.timepicker({
					  timeFormat: 'hh:mm TT',
					  format:""
			  });
			  if(wInput.val()==""){
				  var cd=new Date();
				  wInput.timepicker("setTime",cd);
			  }
			  wInput.timepicker("option",{onClose:me.goToNextField});
		  }else if(type=="TDATE"){
			  if(wInput.val()==""){
				  var cd=new Date();
				  wInput.val(formatDateddMMyyyy(cd));
			  }
		  }else if(type=="TDATETIME"){
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
		  maxdate=attributes.maxdate || "1d";
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
			  wInput.datepicker({
				  format:format,
				  language: "en",
				  autoclose: true
			  });			
			  if(wInput.val()==""){
				  var cd=new Date();
				  wInput.datepicker("setDate",cd);
			  }
			  wInput.datepicker("option",{onClose:me.goToNextField});
		  }else if(type=='DATETIME'){
			  wInput.datetimepicker({
					  format:format,
					  language: "en",
					  autoclose: true,
					  timeFormat: 'hh:mm TT',
					  dateFormat:format
			  });
			  if(wInput.val()==""){
				  var cd=new Date();
				  wInput.datetimepicker("setDate",cd);
			  }
			  wInput.datetimepicker("option",{onClose:me.goToNextField});
		  }else if(type=='TIME'){
			  wInput.timepicker({
					  timeFormat: 'hh:mm TT',
					  dateFormat:""
			  });
			  if(wInput.val()==""){
				  var cd=new Date();
				  wInput.timepicker("setTime",cd);
			  }
			  wInput.timepicker("option",{onClose:me.goToNextField});
		  }else if(type=='TDATE'){
			  if(wInput.val()==""){
				  var cd=new Date();
				  wInput.val(formatDateddMMyyyy(cd));
			  }
		  }
		  else if(type=='TODAYDATE'){
			wInput.datepicker({
				format:format,
				language: "en",
				autoclose: true,
				endDate:maxdate
			});			
			if(wInput.val()==""){
				var cd=new Date();
				wInput.datepicker("setDate",cd);
			}
			wInput.datepicker("option",{onClose:me.goToNextField});
		}else if(type=='TDATETIME'){
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
		  if(wInput[0].createTextRange) {
			var selRange = wInput[0].createTextRange();
			selRange.moveStart('character', pos);
			selRange.select();
		  }else if( wInput[0].setSelectionRange ) {
			wInput[0].setSelectionRange(pos, pos);
		  }else if( typeof wInput[0].selectionStart != 'undefined' ) {
			wInput[0].selectionStart = pos;
			wInput[0].selectionEnd = pos;
		  }
	  }
	  this.setSelection=function(start, end) {
		  if(wInput[0].createTextRange) {
			var selRange = wInput[0].createTextRange();
			selRange.collapse(true);
			selRange.moveStart('character', start);
			selRange.moveEnd('character', end);
			//selRange.select();
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
  
	  this.getValue = function (format) {
		if(type=="TDATE" && format){
			 var dt=checkDateFormat(wInput.val());
			 wInput.val(dt);
		}else if(type=="TDATETIME" && format){
			 var dt=checkDateTimeFormat(wInput.val());
			 wInput.val(dt);      
		}
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
	  this.addClass=function(iclass){
		  wInput.addClass(iclass);
	  }
	  this.removeClass=function(iclass){
		  wInput.removeClass(iclass);
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
	  this.getLovOptions=function(){
		  return lovOptions;
	  }
	  this.setLovOptions=function(lovOpt){
		  lovOptions=lovOpt;
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
		wSelect = $("<SELECT id='"+id+"'/>");
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
		  //alert(keys+'---'+values);
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
	  if(attribs.keys!=""){
		  //alert(attribs.name+'---'+attribs.keys+"-----"+attribs.values);
		  
	  }
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
	  this.addClass=function(iclass){
		  wSelect.addClass(iclass);
	  }
	  this.removeClass=function(iclass){
		  wSelect.removeClass(iclass);
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
		wCheck = $("<input type='checkbox' id='"+id+"'/>");
		wCheck.bind("keypress",handleKeyPress);
		wCheck.bind("keydown",handleKeyDown);
		wCheck.bind("click",handleClick);
		wCheck.bind("click",handleBlur);
		this.setAttributes(attributes);
	  };
	  function handleBlur(e){
		  //e.preventDefault();
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
		  if(parent instanceof FlexUI.Table){
			  var col1=e.target;
			  var row = $(col1).parent().parent().parent().children().index($(col1).parent().parent());
				var col = $(col1).parent().parent().children().index($(col1).parent());
				if(parent.validateMoveOnCellClick(row,col)){
					parent.moveWidget(row,col);
				}
		  }else{
			  if(onClickFunction){
				  onClickFunction(id,me);
			  }
			  FlexUI.trigger(me.onClick,{"val":me.getValue(),"check":me},e,this);			
		  }
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
	  this.addClass=function(iclass){
		  wCheck.addClass(iclass);
	  }
	  this.removeClass=function(iclass){
		  wCheck.removeClass(iclass);
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
		if(attributes.type!="SPAN"){
			wButton = $("<button class='btn btn-primary btn-xs mRhAj' id='"+id+"'>"+attributes.caption+"</button>");
		}else{
			wButton = $("<span class='fa fa-plus-circle fonSizBi' id='"+id+"'/>");
		}
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
	  this.addClass=function(iclass){
		  wButton.addClass(iclass);
	  }
	  this.removeClass=function(iclass){
		  wButton.removeClass(iclass);
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
		if(attributes.type=="SPAN"){
			wLabel = $("<span class='labelText'></span>");
		}else{
			wLabel = $("<label class='labelText'></label>");
		}
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
		wLabel.html(val);
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
	  this.addClass=function(iclass){
		  wLabel.addClass(iclass);
	  }
	  this.removeClass=function(iclass){
		  wLabel.removeClass(iclass);
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
	  this.validate=function(){
		  var v=true;
		  return v;
	  }
	  this.reset=function(){
		  me.setValue("");
		  me.setTag("");
	  }  
	  $.extend(this, {
		  "onClick": new FlexUI.Event()
	  });
	  this.init();
	}          
  })(jQuery);
  