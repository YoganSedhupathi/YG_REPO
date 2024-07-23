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
    	if(tableWidth<dataViewWidth-50){
    		width=(width/tableWidth*100)*(dataViewWidth-50)/100;
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
	  
	  var totalColumnWidth=0;	  
	  for (var i = 0; i < columnProperties.length; i++) {
	    var m=columnProperties[i];
        m.adjustedWidth=calculateColumnWidth(m.width);
        totalColumnWidth+=m.adjustedWidth;
        cols[m.field]=m.order;
      }

      wTable = $("<table class='grid-canvas' border=0 style='tableLayout:fixed'/>");
      input=new FlexUI.TextBox(id+"_in",this,{});
      wTable.delegate("td", "click", handleCellClick);
      input.onTextKeyDown.subscribe(me.onTextKeyDown);
      input.onTextChanged.subscribe(me.onTextChanged);
      input.onClick.subscribe(me.onInputClick);
      input.addClass('form-control');
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
    	}else if(key==38){
    		if(me.getValidRowSize()<me.getSize() && currentRow==me.getSize()-1){
    			me.checkAndMove("Up",false);
    		}else{
    			me.checkAndMove("Up",true);
    		}
    	}else if(key==40){
			me.checkAndMove("Down",true);
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
			if(columnProperties[col].type=="DECIMAL" && columnProperties[col].decimalLength>0){
				if(text!=undefined && text!=""){
					cell.setText(Number(text).toFixed(columnProperties[col].decimalLength));
				}else{
					cell.setText(text);	
				}
			}else{
				cell.setText(text);
			}
		}
		FlexUI.trigger(me.onCellChanged,{"name":name,"row":row,"col":col,"table":me},null,this);
	}
	this.getText=function(row,col){
		var cell=this.getCell(row,col);
		var value="";
		if(row==currentRow && col==currentCol && !me.isOtherInput(currentRow,currentCol)){
			value=input.getValue(true);
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
			var text=input.getValue(true);
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
			}else if(direction=="Up"){
				if(currentRow>0){
					tmpCurrentRow=currentRow-1;
					tmpCurrentCol=currentCol-1;
					me.checkAndMoveToNextCell(tmpCurrentRow,tmpCurrentCol);
				}			
			}else if(direction=="Down"){
				if(currentRow<me.getValidRowSize()-1){
					tmpCurrentRow=currentRow+1;
					tmpCurrentCol=currentCol-1;
					me.checkAndMoveToNextCell(tmpCurrentRow,tmpCurrentCol);
				}else if(me.getValidRowSize()<me.getSize()){
					tmpCurrentRow=me.getSize()-1;
					tmpCurrentCol=-1;
					me.checkAndMoveToNextCell(tmpCurrentRow,tmpCurrentCol);
				}
			}
			me.getRow(tmpCurrentRow).addClass('alGrid');
			//me.getRow(currentRow).removeClass('alGrid');
		}
		return move;
	}
	this.checkAndMoveToNextCell=function(tmpCurrentRow,tmpCurrentCol){
		if(options.tableIsReadOnly){
			return;
		}
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
		var empty=FlexUI.trigger(me.isEmptyRow,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this);
		var onBeforeDelete=FlexUI.trigger(me.onBeforeDeleteRow,{"name":name,"row":currentRow,"col":currentCol,"table":me},null,this);
		if(onBeforeDelete==undefined){
			onBeforeDelete=true;
		}
		if(empty==undefined){
			empty=true;
		}
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

		if(columnProperties !=undefined && columnProperties[col].inputType !='0'  
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
		var v=(!m || ((type=="TEXT" || type=="LOV" || type=="UDF" || type=="TDATE" || type=="TDATETIME") && value!="") || (!(type=="TEXT" || type=="LOV" || type=="UDF" || type=="TDATE" || type=="TDATETIME") && toNumber(value)!=0) );
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
	this.setMaxWidth=function(width){
		wTable.css('max-width',width);
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
		var dl=0; 
		if(ds>0){
			dl=tData[0].length;
		} 
		for(var i=0;i<ds;i++){
			var r=tData[i];
			if(me.getSize()==i){
				me.addRow();
			}			
			for(var j=0;j<cs;j++){
				if(dl-1<j){
					continue;
				}
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
	this.clearRowData=function(row){
		var cs=columnProperties.length;
		for(var j=0;j<cs;j++){
			if(j!=options.serialNumberColumn){
				me.setText(row,j,"");
				me.setCellTag(row,j,"");
				me.setRelatedValues(row,j,undefined);
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
	this.addClass=function(rClass){
		wRow.addClass(rClass);
	}
	this.removeClass=function(rClass){
		wRow.removeClass(rClass);
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
