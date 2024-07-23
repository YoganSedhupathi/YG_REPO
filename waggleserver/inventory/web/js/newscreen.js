let screenObjects=null;
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
	// let me=this;
	let screenProperties=null;
	let operation="ADD";
	let saveInProgress=false;
	let disableAllInputs=false;
    let initialFocus="";
    	
	this.getOperation=function(){
		return operation;
	}
	this.setOperation=function(op){
		operation=op;
	}
	this.getScreenProperties=function(){
		return screenProperties;
	}
	this.getSaveInProgress=function(){
		return saveInProgress;
	}
	this.setSaveInProgress=function(sip){
		saveInProgress=sip;
	}
	this.disableInputs=function(disableInput){
		disableAllInputs=disableInput;	
	}
	this.getInitialFocus=function(){
		return initialFocus;
	}
  	this.init=function(){
  		if(screen.js!=""){
	  		let ls=new FlexUI.Ajax();
	  		ls.loadScript("GET",screen.js);
	  	}
	  	if(screen.initfocus!=undefined && screen.initfocus!=""){
	  		initialFocus=screen.initfocus;
	  	}
  		screenProperties=screen.screen;
  		let s=screenProperties.length;
		for(let i=0;i<s;i++){
			let g=screenProperties[i];
			let parent=$('#'+g.name);
			if(g.title){
			    let t=$("<div id='t_"+g.name+"' class='subHe'>"+g.title+"<span class='pull-right'><b class='fa fa-caret-down'></b></span></div>");
			    t.data("gname",g.name);
				parent.append(t);

			}			
			if(g.contentType=='Table'){
				this.createPartitionTable(g.name,g.tableProperties);
			}else if(g.contentType=='Fields'){
				let iscolumns=false;
				if(g.pcolumns){
					iscolumns=true;
					let colcss=g.colcss || "";
					if(colcss==""){
						colcss="col-sm-6 col-md-6 col-lg-6";
					}
					for(let j=0;j<g.pcolumns;j++){
						if(j==0 || j==g.columns-1){
							parent.append("<div id='"+g.name+"_c_"+j+"' class='"+colcss+" mpZero' style='display:inline-block'></div>");
						}else{
							parent.append("<div id='"+g.name+"_c_"+j+"' class='"+colcss+"' style='display:inline-block'></div>");
						}
					}					
				}
				this.createPartitionFields(parent,g.name,g.fields,iscolumns);				
			}
		}
		this.setDefaults();
  	}
  	this.createPartitionFields=function(parent,groupName,fields,iscolumns){
  		let s=fields.length;
  		  			  		
  		for(let j=0;j<s;j++){
  			let f=fields[j];
  			let field=null;
  			let fieldId=f.name;
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
    		field.setNextFocus(f.nf);
			
    		if(f.inputType!='3' && f.inputType!='4'){
    			field.addClass('form-control');    			
    		}
			if(f.inputType=='1'){
				field.addClass('form-select');    			
			}
    		if(f.visible){
    		    if(initialFocus==""){
    		    	initialFocus=fieldId;
    		    }
    		    let col=f.colno;
    		    let cp=$('#'+groupName+'_c_'+col);    		    
    		    if(iscolumns){
    		    	let fDiv=$("<div id='d_"+fieldId+"' class='form-group mbotto'/>");
    		    	let fld;
    		    	if(f.type=="SPAN"){
    		    		fld=$('<div class="col-sm-9" style="text-align:left"></div>');
    		    	}else{
    		    		fld=$('<div class="col-sm-9"></div>');
    		    	}
    		    	if(f.inputType!='3' && f.caption!=""){
						fDiv.append('<label class="col-sm-3 form-lable">'+f.caption+'</label>');						
    		    	}						
    		    	fDiv.append(fld);						    		    
    		    	field.appendTo(fld);
    		    	cp.append(fDiv);
    		    	
    		    }else{
    		    	let fDiv=$("<div id='d_"+fieldId+"' class='form-group mbotto '/>");
    		    	let fld=$('<div class="col-sm-8 mpRes"></div>');
    		    	if(f.inputType!='3' && f.caption!=""){
						fDiv.append('<label class="col-sm-4 form-lable mpRes">'+f.caption+'</label>');						
    		    	}
    		    	fDiv.append(fld);						    		        		    	
    		    	field.appendTo(fld);
    		    	parent.append(fDiv);
    		    	
    		    }
    		}
  			screenObjects.addScreenObject(fieldId,field);
  		}
  	}
  	this.createPartitionTable=function(groupName,tableProperties){
  		  let options = {
    		enableCellNavigation: true,
    		enableColumnReorder: false,
    		enableAddRow:true,
    		enableDeleteRow:true
  			};  			
  		  options.rowEmptyCheckColumn=tableProperties.rowEmptyCheckColumn || -1;
  		  if(!tableProperties.enableAddRow){
  		  	options.enableAddRow=tableProperties.enableAddRow;
  		  }
  		  if(!tableProperties.enableDeleteRow){
  		  	options.enableDeleteRow=tableProperties.enableDeleteRow;
  		  }
  		  options.serialNumberColumn=tableProperties.serialNumberColumn || 0;
  		  options.tableIsOptional=tableProperties.optional || false;
  		  options.tableIsReadOnly=tableProperties.readOnly || false;
  		  options.nextFocus=tableProperties.nextFocus;
  		  let grid = new FlexUI.Grid(groupName+"_data",'#'+groupName, tableProperties.columns, options);
  		  screenObjects.addScreenObject(groupName+"_data",grid.getDataTable());
  		  screenObjects.addScreenObject(groupName,grid);
  		  grid.subscribeLeaveCell(handleLeaveCell);
    	  grid.subscribeLeaveRow(handleLeaveRow);
  	}
  	this.onGroupTitleClick=function(e){
  		let g=e.target;
  		let gname=$(g).data("gname");
  		let gd=$('#'+gname);
  		if(gd.is(':visible')){
  			gd.hide();
  		}else{
  			gd.show();
  		}
  	}
  	this.showHideGroup=function(groupname,show){
  		let tg=$('#t_'+groupname);
  		let gd=$('#'+groupname);
  		if(show){
  			gd.show();
  			tg.show();
  		}else{
  			gd.hide();
  			tg.hide();
  		}
  	}
  	function handleLeaveCell(e,args){
		return true;
	}
	function handleLeaveRow(e,args){
		return true;
	}	
  	this.processDataToSave=function(additionalData,isList){
  		saveInProgress=true;
  		let s=screenProperties.length;
  		let comma=""; 
  		let data='data={"operation":"'+operation+'","savedata":{';
  		for(let i=0;i<s;i++){
			let g=screenProperties[i];
			if(g.contentType=='Table'){
				let t=screenObjects.getScreenObject(g.name+"_data");
				if(t.validateAllRows()){
					if(isList){
						data+=comma+t.getData();
					}else{
						data+=comma+t.getDataWithRelatedValues();
						}
				}else{
					return "FAILED";					
				}
			}else if(g.contentType=='Fields'){
				let fields=g.fields;
				let fs=fields.length;
				let v="";
				for(let p=0;p<fs;p++){				
					let f=fields[p];
					let fieldId=f.name;
					if(f.id){
						fieldId=f.id;
					}
					if(f.inputType!='3'){
						let saveTag=f.saveTag;
						if(typeof saveTag=="undefined"){
							saveTag=f.chkTag;
						}
						let w=screenObjects.getScreenObject(fieldId);
						if(!w.validate() || (w instanceof FlexUI.TextBox && !w.checkMove())){
							setErrorMessage(f.caption.replace("*","")+" "+"is Mandatory");
							// alert(f.caption.replace("*","")+" "+"is Mandatory");
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
  		let s=screenProperties.length;
  		for(let i=0;i<s;i++){
			let g=screenProperties[i];
			if(g.contentType=='Table'){
				let t=screenObjects.getScreenObject(g.name+"_data");
				t.clear();
			}else if(g.contentType=='Fields'){
				let fields=g.fields;
				let fs=fields.length;
				for(let p=0;p<fs;p++){				
					let f=fields[p];
					let fieldId=f.name;
					if(f.id){
						fieldId=f.id;
					}
					let w=screenObjects.getScreenObject(fieldId);
					if(!(w instanceof FlexUI.Button)){ 
						w.reset();
					}
				}
			}
		}
		operation="ADD";
		clearTotalAmt();
		this.setDefaults();
  	}
  	this.loadListData=function(screenData){
  		let s=screenProperties.length;
  		for(let i=0;i<s;i++){
			let g=screenProperties[i];
			if(g.contentType=='Table'){
				let t=screenObjects.getScreenObject(g.name+"_data");
				if(screenData[g.name+"_data"]!=null){
					t.setListData(screenData[g.name+"_data"]);
					if(disableAllInputs){
						t.getInputField().setEnabled(false);
						t.getInputField().addClass("disColB");
					}
				}
			}else if(g.contentType=='Fields'){
				let fields=g.fields;
				let fs=fields.length;
				for(let p=0;p<fs;p++){				
					let f=fields[p];
					let fieldId=f.name;
					if(f.id){
						fieldId=f.id;
					}
					let w=screenObjects.getScreenObject(fieldId);
					if(!(w instanceof FlexUI.Button) && screenData[f.name]){ 
						w.setValue(screenData[f.name]);
						w.setTag(screenData[f.name]);
					}
					if(!(w instanceof FlexUI.Label) && disableAllInputs){
						w.setEnabled(false);
						w.addClass("disColB");
					}
				}
			}
		}
  	}
  	this.loadData=function(screenData){
		
  		let s=screenProperties.length;
  		for(let i=0;i<s;i++){
			let g=screenProperties[i];
			if(g.contentType=='Table'){
				let t=screenObjects.getScreenObject(g.name+"_data");
				if(screenData[g.name+"_data"]!=null){
					t.setData(screenData[g.name+"_data"]);
					if(disableAllInputs){
						t.getInputField().setEnabled(false);
						t.getInputField().addClass("disColB");
					}
				}
			}else if(g.contentType=='Fields'){
				let fields=g.fields;
				let fs=fields.length;
				for(let p=0;p<fs;p++){				
					let f=fields[p];
					let fieldId=f.name;
					if(f.id){
						fieldId=f.id;
					}
					let w=screenObjects.getScreenObject(fieldId);
					if(!(w instanceof FlexUI.Button) && screenData[f.name]){ 
						w.setValue(screenData[f.name].v);
						w.setTag(screenData[f.name].t);
					}
					if(!(w instanceof FlexUI.Label) && disableAllInputs){
						w.setEnabled(false);
						w.addClass("disColB");
					}
				}
			}
		}
  	}  	
  	this.setDefaults=function(){
  		if(screen.defaults){
  			let ls=new FlexUI.Ajax();
  			let r=ls.callAjax("GET",screen.defaults.url,"ic=0&id="+screen.defaults.id);
     		let results=screen.defaults.results || [];
	    	let s=results.length;
    		if(r!=null && screenObjects){
    			let values=r.data[0];
	    		for(let i=0;i<s;i++){
	    			let result=results[i];
	    			let tgt=screenObjects.getScreenObject(result.tgt);
	    			if(tgt instanceof FlexUI.TextBox 
	    				|| tgt instanceof FlexUI.CheckBox
	    				|| tgt instanceof FlexUI.Select){
	    				if(result.tt){    		
	    					tgt.setTag(values[result.id]);
	    				}else{
	    					tgt.setValue(values[result.id]);
	    				}
	    			}else if(tgt instanceof FlexUI.Table){
	    				// let v="";
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
  	
 	this.init();
  }
  })(jQuery); 