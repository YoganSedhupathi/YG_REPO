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
	let me=this;
	let screenProperties=null;
	let operation="ADD";
	let saveInProgress=false;
	let disableAllInputs=false;
	let prevVisibleGroupField;
	let screenCode=0;
		
	this.getOperation=function(){
		return operation;
	}
	this.setOperation=function(op){
		operation=op;
	}
	this.getScreenCode=function(){
		return screenCode;
	}
	this.setScreenCode=function(screencode){
		screenCode=screencode;
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
  	this.init=function(){
  		if(screen.js!=""){
	  		let ls=new FlexUI.Ajax();
	  		ls.loadScript("GET",screen.js);
	  	}
  		screenProperties=screen.screen;
  		let conId="";
  		if(screen.container){
  			conId=screen.container.id || "";
  		}
  		let s=screenProperties.length;
		for(let i=0;i<s;i++){
			let g=screenProperties[i];
			let parent=$('#'+g.name);
			if(parent.length==0 && conId!="" && !g.predesigned){
				$('#'+conId).append('<div class=""><div id="'+g.name+'" class="table-container"></div></div>');
				parent=$('#'+g.name);
				if(g.contentType=='Table'){
					parent.height(300);
				}
			}
			if(g.title && !g.predesigned){
			    let t=$("<div class='bline'><h6>"+g.title+"</h6></div>");
			    t.data("gname",g.name);
				parent.append(t);
			}			
			if(g.contentType=='Table'){
				this.createPartitionTable(g.name,g.tableProperties);
			}else if(g.contentType=='Fields'){
				let iscolumns=false;
				if(g.pcolumns && !g.predesigned){
					iscolumns=true;
					let colcss=g.colcss || "";
					if(colcss==""){
						colcss="col-sm-6 col-md-6 col-lg-6";
					}
					for(let j=0;j<g.pcolumns;j++){
						if(j==0 || j==g.columns-1){
							parent.append("<div id='"+g.name+"_c_"+j+"' class='"+colcss+" mpZero'></div>");
						}else{
							parent.append("<div id='"+g.name+"_c_"+j+"' class='"+colcss+"'></div>");
						}
					}					
				}
				this.createPartitionFields(parent,g.name,g.fields,iscolumns,g.layout,g.predesigned);				
			}
		}
		this.setDefaults();
  	}
  	this.createPartitionFields=function(parent,groupName,fields,iscolumns,layout,predesigned){
  		let s=fields.length;
  		let visibleFields=0;
  		let currentDiv=$('<div class="row w-100"></div>');
  		let cls1 = "col-md-" + (12 / layout);
		if (cls1==="col-md-12"){
			cls1="row w-100";
		}
  		let prevVisibleField=prevVisibleGroupField;
  		if(!iscolumns && !predesigned){
  			parent.append(currentDiv);
  		}  			  		
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
    		if(f.inputType!='3' && f.inputType!='4'){
    			field.addClass('form-control');    			
    		}
			if(f.inputType=='1' && f.inputType!='2'){
    			field.addClass('form-select');    			
    		}
    		if(!iscolumns && visibleFields!=0 && visibleFields%layout==0 && !predesigned){
				currentDiv=$('<div class="row w-100"></div>');
				parent.append(currentDiv);			
		    }
		    if(f.visible){
		        visibleFields++;
    			if(prevVisibleField!=undefined){
    				prevVisibleField.setNextFocus(f.name);
    			}    			
    			prevVisibleField=field;    			
		    }
		    if(!predesigned){
	    		if(f.visible && iscolumns){
	    		    let col=f.colno;
	    		    let cp=$('#'+groupName+'_c_'+col);    		    
			    	fDiv=$("<div id='d_"+fieldId+"' class='form-group mbotto'/>");
			    	let fld;
			    	if(f.type=="SPAN"){
			    		fld=$('<div class="row w-100" style="text-align:right"></div>');
			    	}else{
			    		fld=$('<div class="col-sm-9 mpRes"></div>');
			    	}
			    	if(f.inputType!='3' && f.caption!=""){
						fDiv.append('<label class="col-sm-2 form-lable">'+f.caption+'</label>');						
			    	}						
			    	fDiv.append(fld);						    		    
			    	field.appendTo(fld);
			    	cp.append(fDiv);
			    	cp.append('<div class="clearfix"></div>');	
	    		}else{
	    			let divFeildContainer = $("<div id='f_" + f.name + "' class='" + cls1 + " marBt'/>");
			    	fDiv=$("<div id='d_"+fieldId+"' class='form-group mbotto'/>");
			    	let fld=$('<div class="col-sm-10 mpRes"></div>');
			    	if(f.inputType!='3' && f.caption!=""){
						fDiv.append('<label class="col-sm-2 form-lable">'+f.caption+'</label>');						
			    	}
			    	fDiv.append(fld);						    		        		    	
			    	field.appendTo(fld);
			    	divFeildContainer.append(fDiv);
			    	currentDiv.append(divFeildContainer);
			    	if(!f.visible){
			    		divFeildContainer.css('display','none');
			    	}    
	    		}
	    	}
  			screenObjects.addScreenObject(fieldId,field);
  		}
  		prevVisibleGroupField=prevVisibleField;
  	}
  	this.createPartitionTable=function(groupName,tableProperties){
  		  let options = {
    		enableCellNavigation: true,
    		enableColumnReorder: false,
    		enableAddRow:true,
    		enableDeleteRow:true
  			};  			
  		  options.rowEmptyCheckColumn=tableProperties.rowEmptyCheckColumn || -1;
  		  options.rowObject=tableProperties.rowObject || false;
  		  if(tableProperties.enableAddRow==false){
  		  	options.enableAddRow=tableProperties.enableAddRow;
  		  }
  		  if(tableProperties.enableDeleteRow==false){
  		  	options.enableDeleteRow=tableProperties.enableDeleteRow;
  		  }
  		  options.serialNumberColumn=tableProperties.serialNumberColumn || "";
  		  options.tableIsOptional=tableProperties.optional || false;
  		  options.tableIsReadOnly=tableProperties.readOnly || false;
  		  options.nextFocus=tableProperties.nextFocus;
  		  let grid = new FlexUI.Grid(groupName+"_data",'#'+groupName, tableProperties.columns, options);
  		  if(prevVisibleGroupField!=undefined){
  		  		prevVisibleGroupField.setNextFocus(groupName+"_data");
  		  }
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
  	this.processDataToSave=function(additionalData,isList,lastnoOfRows){  	
  		saveInProgress=true;
		
  		let s=screenProperties.length;
		//   alert(" screenProperties length" + s);
  		let comma=""; 
  		let data='data={"screencode":"'+screenCode+'","operation":"'+operation+'","savedata":{';
		// alert("data" + data);
  		for(let i=0;i<s;i++){
			// alert("iiiiiiiiiiiiii" + i);
			let g=screenProperties[i];
			// alert("g.contentType"+" " + g.contentType);

			if(g.contentType=='Table'){
				let t=screenObjects.getScreenObject(g.name+"_data");
				if(t.validateAllRows()){
					if(t.getOptions().rowObject){
						data+=comma+t.getObjectData(lastnoOfRows);
						// alert("if 1");
					}else{
						if(isList){
							data+=comma+t.getData();
						}else{
							data+=comma+t.getDataWithRelatedValues();
						}
					}
				}else{
					
					return "FAILED";	
								
				}
			}else if(g.contentType=='Fields'){
				
				let fields=g.fields;
				// alert("fields" + " " +g.fields   );

				let fs=fields.length;
				// alert("fields.length" + " " + fs   );

				let v="";
				for(let p=0;p<fs;p++){				
					let f=fields[p];
						// alert("fffffff" + " " + f   );				
					let fieldId=f.name;
					    // alert("f.name fieldId" + " " + fieldId   );	
						// alert("f.id fieldId" + " " + f.id   );		
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
							
						
							alert(f.caption.replace("*","")+" is mandatory");
							

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
							if(f.type=="TEXTAREA"){
								data+=comma+'"'+f.name+'":"'+encodeURIComponent(v.replace(/"/g,'\\"').replace(/\n/g,'\\n'))+'"';
							}else{
								data+=comma+'"'+f.name+'":"'+escape(v.replace(/"/g,'\\"'))+'"';
							}							
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
					if(t.getOptions().rowObject){
						t.clear();
						t.setObjectData(screenData[g.name+"_data"]);
					}else{
						t.setData(screenData[g.name+"_data"]);
					}
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
  	this.loadObjectData=function(screenData){
  		let s=screenProperties.length;
  		for(let i=0;i<s;i++){
			let g=screenProperties[i];
			if(g.contentType=='Table'){
				let t=screenObjects.getScreenObject(g.name+"_data");
				if(screenData[g.name+"_data"]!=null){
					t.clear();
					t.setObjectData(screenData[g.name+"_data"]);
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
						if(screenData[f.name].v){
							w.setValue(screenData[f.name].v);
							w.setTag(screenData[f.name].t);
						}else{
							w.setValue(screenData[f.name]);
							w.setTag(screenData[f.name]);
						}
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
	    				let v="";
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
  		let t=screenObjects.getScreenObject("myGrid_data");
  		let d=[[{v:"Aru",t:"255"},{v:"Debtors",t:"16"},{v:4}]
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
  })(jQuery); 