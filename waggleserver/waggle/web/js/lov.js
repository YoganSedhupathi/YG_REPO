(function ($) {
	// register namespace
	$.extend(true, window, {
	  FlexUI: {
		LOV: FlexLov,
		Ajax: FlexAjax
	  }
	});
  
	function FlexLov(id,parent,options,columnProperties,data) {
	  let wDialog;
	  let width=500;
	  let height=400;
	  let top=300;
	  let left=0;
	  let rows=20;
	  let rowHeight=20;
	  let paddingDiff=10;
	  let searchTextHeight=30;
	  let headerHeight=30;
	  let me=this;
	  let text;
	  let scrollPanel;
	  let headerPanel;
	  let headerRow;
	  let dlg;
	  let dataTable;
	  let currentRow=0;
	  let dataLength=0;
	  let beginingRow=0;
	  let endingRow=0;
	  let lovData=null;
	  let searchIndex=-1;
	  let searchColumnName="";
	  let title="";
	  let firstVisibleIndex=0;
	  let timer=null;
	  let lastText="";
	  let lovHeader;
	  let columnNames=[];
	  this.init = function () {
		  wDialog=$("<div class='modal' id='"+id+"' tabindex='-1' role='dialog' aria-hidden='true'></div>");
		  lovHeader=$("<div id='dlg_"+id+"' class='modal-dialog' role='document'><div class='modal-content'><div id='lovheader_"+id+"' class='modal-header'><span class='lovheadertxt'>Test Tilet</span><button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button></div><div class='modal-body'></div></div></div>");
		  wDialog.append(lovHeader);
  
		  let dlg=wDialog.modal({backdrop:'static',width:'auto',minHeight:400,minWidth:300,close:handleClose});
		  wDialog.on('hidden.bs.modal', function (e) {
			  handleClose();
		  });
		  scrollPanel=$("<div id='"+id+"_panel' class='pop_lov_inp_box' style='overflow-y:auto;overflow-x:hidden;padding:0'></div>");
		  headerPanel=$("<div class='xgrid-header' id='"+id+"_hdrpanel' style='padding:0'></div>");
		  headerRow=$("<div class='xgrid-header-columns' id='"+id+"_hdrrow'></div>");
		  dataTable=$("<table  class='grid-canvas table' cellpadding=0 cellspacing=0 style='table-layout:fixed' id='"+id+"_data'></table>");
		  text=new FlexUI.TextBox("lov_"+id,this,{});
		  lovHeader.append("<div class='pop_lov_clos'><a href='#' ><span class='fa fa-times-circle'></span></a></div><div class='pop_lov_hed_txt'></div>");
		  wDialog.find('.modal-body').append("<div class='pop_lov_search_title' id='"+id+"_lovSearchLabel'></div>");    	
		  wDialog.find('.modal-body').append(text.getInput());
		  wDialog.find('.modal-body').append(headerPanel);
		  headerPanel.append(headerRow);
		  wDialog.find('.modal-body').append(scrollPanel);
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
			  if(window[options.closeFunction]){
				  window[options.closeFunction]();
			  }
	  }
	  function onHeaderClick(e){
		  let target=e.target;
		  let data=$(target).data("column");
		  searchIndex=$(target).data("index");
		  searchColumnName=data.n;
		  $('.pop_lov_hed_txt').html(title);
		  $("#"+id+"_lovSearchLabel").html(searchColumnName);
		  text.setValue("");
		  e.stopPropagation();
	  }
	  function handleRowClick(e){
			 let col1=e.target;
		  let col = $(col1).parent().children().index($(col1));
			let row = $(col1).parent().parent().children().index($(col1).parent());
			me.deselectRow(currentRow);
			currentRow=row;
			me.setSelectedRow(currentRow);
			text.focus();  		
			me.returnResult(currentRow);
	  }
	  function onTextKeyDown(e,args){
		  let key=e.which || e.keyCode;
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
		  let key=e.which || e.keyCode;    	
		  me.sendRequestOnKeyPress(key,args.val);
	  }
	  this.sendRequestOnKeyPress=function(key,val){
		  let t="";
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
		  let a=new FlexUI.Ajax();
		  let data=me.getParameters(text);
		  if(show){
			  data+="&ic=1";
		  }else{
			  data+="&ic=0";
		  }
		  let s=a.callAjax("GET",options.url,data);
		  if(show){
			  title= s.title ;
			  columnProperties=s.columns;
			  columnNames=[];
			  let siz=columnProperties.length;
			  for (let i = 0; i <siz ; i++) {
				  let m = columnProperties[i];
				  columnNames.push(m.cn);	        
			  }	    		
			  lovData=s.data;
			  if(lovData.length==1){
				  let autoLoad=true;
				  if(options.autoLoad!=undefined){
					  autoLoad=options.autoLoad;
				  }
				  if(autoLoad){
					  me.populateData(lovData);
					  me.returnResult(currentRow);
					  return false;    								
				  }
			  }
			  }else{
				  lovData=s.data;
				  me.populateData(s.data);
			  }
		  return true;
	  }
	  this.getParameters=function(text){
		  let data="&id="+options.ajax;
		  if(screenObjects){
			  let params=options.params || {};
			  let s=params.length;
			  for(let i=0;i<s;i++){
				  let param=params[i];
				  let src=screenObjects.getScreenObject(param.src);
				  if(src instanceof FlexUI.TextBox 
					  || src instanceof FlexUI.CheckBox
					  || src instanceof FlexUI.Select){
					  let v="";
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
					  let v="";
					  if(param.ft){
						  v=src.getCurrentRowTag(src.getCols()[param.col]);
					  }else{
						  v=src.getCurrentRowText(src.getCols()[param.col]);
					  }
					  
					  if(v=="" && param.df){
						  v=param.df;
					  }	    			
					  data+="&"+param.n+"="+v;
				  }
			  }
		  }
		  if(options.cs!=undefined && (options.cs==searchIndex || searchIndex==-1)){
			  data+="&cs=1";
		  }else{
			  data+="&cs=0";
		  }
		  if(searchIndex!=-1){
			  data+="&F"+(Number(searchIndex)+1)+"="+text;
		  }else{
			  if(options.dsi==0){
				  data+="&F1="+text;
			  }else if(options.edsi){
				  data+="&F"+(options.dsi+options.edsi)+"="+text;
			  }else{
				  data+="&F"+(options.dsi)+"="+text;
			  }
		  }
		  return data;
	  }
	  this.returnResult=function(currentRow){
		  let values;
		  if(options.scrollEnabled){
			  values=lovData[currentRow];
		  }else{
			  values=lovData[currentRow+beginingRow];
		  }
		  let results=options.results || [];
		  let s=results.length;
		  let standalone=options.standalone || false;
		  if(s==0 && !standalone){
			  if(values.length>=2){
				  parent.setValue(values[0]);
				  parent.setTag(values[1]);
			  }else if(values.length==1){
				  parent.setValue(values[0]);
			  }
		  }
		  if(screenObjects){
			  for(let i=0;i<s;i++){
				  let result=results[i];
				  let tgt=screenObjects.getScreenObject(result.tgt);
				  if(tgt instanceof FlexUI.TextBox 
					  || tgt instanceof FlexUI.CheckBox
					  || tgt instanceof FlexUI.Select || tgt instanceof FlexUI.Label){
					  result.m=result.m || false;
					  if(result.m){
						  let ids=result.id.split(",");
						  let text="";
						  for(const element of ids){
							  text=text+values[columnNames.indexOf(element)]+", ";
						  }
						  if(result.tt){    		
							  tgt.setTag(text);
						  }else{
							  tgt.setValue(text);
						  }		    			
					  }else{
						  if(result.tt){    		
							  tgt.setTag(values[columnNames.indexOf(result.id)]);
						  }else{
							  tgt.setValue(values[columnNames.indexOf(result.id)]);
						  }		    		
					  }
				  }else if(tgt instanceof FlexUI.Table){
					  let v="";
					  if(result.tt){
						  tgt.setCurrentRowCellTag(tgt.getCols()[result.col],values[columnNames.indexOf(result.id)]);
					  }else{
						  tgt.setCurrentRowText(tgt.getCols()[result.col],values[columnNames.indexOf(result.id)]);
					  }
					  
				  }
			  }
		  }
		  me.hide(values);    	
	  }
	  this.clearResult=function(){
			 let results=options.results || [];
			 let s=results.length;
			 let clearRow=options.eremove;
			 if(clearRow==undefined){
				 clearRow=true;
			 }
		  if(s==0){
			  parent.setValue("");
			  parent.setTag("");
		  }
		  if(screenObjects){
			  for(let i=0;i<s;i++){
				  let result=results[i];
				  let tgt=screenObjects.getScreenObject(result.tgt);
				  if(tgt instanceof FlexUI.TextBox 
					  || tgt instanceof FlexUI.CheckBox
					  || tgt instanceof FlexUI.Select){
					  if(result.tt){    		
						  tgt.setTag("");
					  }else{
						  tgt.setValue("");
					  }
				  }else if(tgt instanceof FlexUI.Table){
					  let v="";
					  if(result.tt){
						  tgt.setCurrentRowCellTag(tgt.getCols()[result.col],"");
					  }else{
						  tgt.setCurrentRowText(tgt.getCols()[result.col],"");
					  }
					  
					  if(result.col==tgt.getOptions().rowEmptyCheckColumn && result.row=="cr" && clearRow){
						  tgt.clearRowData(tgt.getCurrentRow());
					  }
					  
				  }
			  }
		  }
	  }    
	  this.show=function(){
		  if(parent instanceof FlexUI.TextBox){
			  text.setValue(parent.getValue());
		  }
		  let f=me.sendRequest(text.getValue(),true);
		  if(f){
			  rowHeight=20;
				 me.setHeight(text.getInput().height+(rows*rowHeight)+headerPanel.height);
			  me.createHeader();
			  text.setWidth(wDialog.find('.xgrid-header-columns').css('width'));
			  if(lovData){
				  me.populateData(lovData);
			  }
			  wDialog.modal('show');
			  text.focus();
			  text.setCursorPosition(text.getValue().length+1);
			  scrollPanel.scrollTop(0);
			  FlexUI.trigger(me.onLovOpen,{},null,this);
		  }
		  return f;
	  }
	  this.searchData=function(index,text){
		  let siz=data.length; 
		  let matchingList=new Array();
		  for(let i=0;i<siz;i++){
			  let r=data[i];
			  if(r[index].match('^'+text)){
				  matchingList.push(r);
			  }
		  }
		  lovData=matchingList;
		  me.populateData(lovData);    	
	  }
	  this.hide=function(result){
		  wDialog.modal('hide');
		  FlexUI.trigger(me.onLovClose,{result:result},null,this);    	
	  }
	  this.setWidth=function(width){
		  wDialog.find('.modal-dialog').width(width);
		  wDialog.find('.modal-content').width(width);
		  wDialog.find('.modal-body').width(width);
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
		  let totalWidth=0;
		  let siz=columnProperties.length;
		  let firstVisibleIndex=0;
		  for (let i = 0; i <siz ; i++) {
		  let m = columnProperties[i];
		  let header = $("<div class='ui-state-default xgrid-header-column' id='" + id+ i + "' />")
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
		  me.setWidth(totalWidth+30);
		  headerRow.width(totalWidth);
		  headerPanel.width(totalWidth);
		  dataTable.width(totalWidth);
		  headerRow.height(headerHeight);
		  scrollPanel.width(totalWidth);
		  if(options.dsi){
			  firstVisibleIndex=options.dsi;
		  }
		  wDialog.find('.lovheadertxt').text(title);
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
		  let row=null;
		  for(let i=0;i<=endingRow;i++){
			  let r=data[i];
			  let s=r.length;
			  row=me.createRow(r);
			  me.appendRow(row);
		  }
		  me.setSelectedRow(currentRow);
		  scrollPanel.height(rows*rowHeight);
		  // if(row!=null){
			  // scrollPanel.height(rows*rowHeight);
		  // }else{
		  // 	scrollPanel.height(rows*rowHeight);
		  // }
		  scrollPanel.scrollTop(0);
	  }
	  this.setSelectedRow=function(row){
		  dataTable.find('tr').eq(row).children('td').css('background-color','#ffc356');
	  }
	  this.deselectRow=function(row){
		  dataTable.find('tr').eq(row).children('td').css('background-color','');
	  }    
	  this.createRow=function(data){
		  let row=$("<tr></tr>");
		  let s=data.length;
		  for(let j=0;j<s;j++){
			  let m=columnProperties[j];
			  let cell=$("<td>"+data[j]+"</td>");
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
			  let r=me.createRow(data[endingRow]);
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
			  let r=me.createRow(data[beginingRow]);
			  me.prependRow(r);
		  }else if(currentRow>0){
			  me.deselectRow(currentRow);
			  currentRow--;
		  }
		  me.setSelectedRow(currentRow);		
		  me.scrollToTop(currentRow);
	  }
	  this.scrollToTop=function(row){
		  let rowPosition=dataTable.find('tr').eq(row).position();
		  let currentRowHeight=dataTable.find('tr').eq(row).height();
		  if((rowPosition.top+currentRowHeight)>scrollPanel.height()){
			  scrollPanel.scrollTop(scrollPanel.scrollTop()+(currentRowHeight));
		  }else if(rowPosition.top<scrollPanel.scrollTop()){
			  scrollPanel.scrollTop(scrollPanel.scrollTop()-(currentRowHeight));
		  }
	  }
	  this.calcBeginingRow=function(){
		  let begin=0;
		  begin=(endingRow-rows)+1;
		  return begin;
	  }
	  this.calcEndingRow=function(){
		  let end=0;
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
	  let me=this;
	  
	  this.init=function(){
	  }
	  this.callAjax=function(method,url,parameters){
		  let response;
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
		  let response;
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
	})(jQuery);