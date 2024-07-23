(function ($) {
$.extend(true, window, {
    "FlexUI": {
      "ConstructScreen": Construct
      }
      });
      
  function Construct(screencode,iconsParent,buttonsParent,screenContainer) {
  	  let currentScreen=null;
  	  let vScreen=null;
  	  let me=this;
  	  let l=new FlexUI.Ajax();  	  
  	  this.getOperation=function(){
		return currentScreen.getOperation();
	  }
	  this.setOperation=function(op){
		currentScreen.setOperation(op);
	  }
	  this.getScreenProperties=function(){
		return currentScreen.getScreenProperties();
	  }
  	  this.clearScreen=function(){
  	  	currentScreen.clearScreen();
  	  	me.loadDefaultData();
  	  }	
  	  this.loadScreen=function(data){
  	  	currentScreen.loadObjectData(data);
  	  }
  	  this.saveData=function(){
  	  	 let d=currentScreen.processDataToSave();
			//  alert("finalmsg ddata"+" "+ d);
		 if("FAILED"!=d){
			let s=new FlexUI.Ajax();
			showLoader();
			let r=s.callAjax("POST","/waggle/service/screen/save",d);
			hideLoader();
			return r ;
		 }
		 return {"result":"Error","message":"Kindly correct the validation errors and continue..."};		 
  	  }
  	  this.loadDefaultData=function(){
  	  	let screenData=null;
  	  	let gs=vScreen.groups.length;
		for(let j=0;j<gs;j++){
			let values=null;
			if(vScreen.groups[j].grouploadtype==1){
				values=l.callAjax("GET","/waggle/service/ajax","&ic=0&ro=true&id="+vScreen.groups[j].grouploadurl);
			}else if(vScreen.groups[j].grouploadtype==2){
				values=l.callAjax("GET",vScreen.groups[j].grouploadurl,"");
			}
			if(values!=null && values.data.length>0){
				if(screenData==null){
					screenData={};
				}
				if(vScreen.groups[j].grouptype==1){
					if(values.data.length>0){
						for(let x in values.data[0]){
							screenData[x]=values.data[0][x] ;	
						}
					}
				}else if(vScreen.groups[j].grouptype==2){
					screenData[vScreen.groups[j].groupname+"_data" ]=values.data;			
				}
			}			
	  	}
	  	if(screenData!=null){
	  		currentScreen.loadObjectData(screenData );
	  	}
  	  }
  	  this.enableDisableOperatingFields=function(currentOperationType){
  	  	let screenData=null;
		let gas=vScreen.attributes.length;
		let screenProp=currentScreen.getScreenProperties();
		for(let i=0;i<gas;i++){
			let attribute=vScreen.attributes[i];
			let screenFields=screenProp[attribute.grouporder];
			if(screenFields.contentType=="Fields"){
				let field=screenObjects.getScreenObject(attribute.name);			
			 	if(currentOperationType=="ADD"){
				 	if(attribute.addenabled==0){
				 		field.setEnabled(false);
				 	}else{
				 		field.setEnabled(true);
				 	}
			 	}
			 	if(currentOperationType=="EDIT"){
				 	if(attribute.editenabled==0){
				 		field.setEnabled(false);
				 	}else{
				 		field.setEnabled(true);
				 	}
			 	}
			}else{
				let table=screenObjects.getScreenObject(screenFields.name+"_data");
				if(currentOperationType=="ADD"){
					if(attribute.addenabled==0){
				 		table.getColumnProperties()[attribute.attributeorder].readOnly=true;
				 	}else{
				 		table.getColumnProperties()[attribute.attributeorder].readOnly=false;
				 	}
			 	}
			 	if(currentOperationType=="EDIT"){
				 	if(attribute.editenabled==0){
				 		table.getColumnProperties()[attribute.attributeorder].readOnly=true;
				 	}else{
				 		table.getColumnProperties()[attribute.attributeorder].readOnly=false;
				 	}
			 	}
			}
		}
  	  }
	  this.buildScreen=function(){
	  	let v=l.callAjax("GET","/waggle/service/screen","screencode="+screencode);
	  	//construct the screen out here
	  	vScreen=v;
	  	let screenProp={};
	  	screenProp["container"]={};
	  	screenProp["screen"]=[];
	  	screenProp.container.id=screenContainer;
	  	screenProp.container.isdialog=false;
	  	screenProp.js=v.screenprop.screenjs || "";
	  	let gs=v.groups.length;
	  	for(let j=0;j<gs;j++){
	  		let sgroup={};
	  		sgroup["name"]=v.groups[j].groupname;
	  		sgroup["title"]=v.groups[j].grouptitle;
	  		sgroup["layout"]=v.groups[j].grouplayout;
	  		if(v.groups[j].grouptype==1){
	  			sgroup["contentType"]="Fields";
	  			sgroup["fields"]=[];
	  		}else{
	  			sgroup["contentType"]="Table";
	  			sgroup["tableProperties"]={};
	  			if(v.groups[j].grouptablerowadd==0){
	  				sgroup.tableProperties.enableAddRow=false;
	  			}else{
	  				sgroup.tableProperties.enableAddRow=true;
	  			}
	  			if(v.groups[j].tablerowcheckcolumn!=""){
	  				sgroup.tableProperties.rowEmptyCheckColumn=v.groups[j].tablerowcheckcolumn;
	  			}
	  			if(v.groups[j].serialnocolumn!=""){
	  				sgroup.tableProperties.serialNumberColumn=v.groups[j].serialnocolumn;
	  			}	  			
	  			if(v.groups[j].grouptableoptional==1){
					sgroup.tableProperties.optional=true;
				}else{
					sgroup.tableProperties.optional=false;
				}	  			
				sgroup.tableProperties.rowObject=true;
	  			sgroup.tableProperties.columns=[];
	  		}
	  		screenProp.screen.push(sgroup);
	  	}
		let gas=v.attributes.length;
		for(let i=0;i<gas;i++){
			let attribute=v.attributes[i];
			let field={};
			let screenFields=screenProp.screen[attribute.grouporder];
			field.name=attribute.name
			field.inputType=attribute.inputType;
			field.type=attribute.type;
			field.caption=attribute.caption;
			if(attribute.mandatory==1){
				field.mandatory=true;
				field.caption=field.caption+"*";
			}else{
				field.mandatory=false;
			}
			field.defaultValue=attribute.defaultValue;
			field.maxValue=attribute.maximumValue;
			field.textLength=attribute.textLength;
			field.decimalLength=attribute.decimalLength;
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
			if(attribute.chkTag==1){
				field.chkTag=true;
			}else{
				field.chkTag=false;
			}
			if(attribute.saveTag==1){
				field.saveTag=true;
			}else{
				field.saveTag=false;
			}
			field.align=attribute.align;
			field.tooltip=attribute.tooltip;
			if(field.type=="LOV"){
				field.lovOptions={};
				field.lovOptions.url="/waggle/service/ajax";
				field.lovOptions.ajax=attribute.attributelistid;
				field.lovOptions.scrollEnabled=true;
				field.lovOptions.searchFromList=false;
				field.lovOptions.dsi=attribute.dsi;
				field.lovOptions.params=[];
				field.lovOptions.results=[];
				if(attribute.attributeajaxparams!=""){
					let aparams=attribute.attributeajaxparams.split(",");
					let sparams=attribute.attributeajaxparamsrc.split(",");
					let stparams=attribute.attributeajaxsrctype.split(",");
					for(let p=0;p<aparams.length;p++){
					    let sp=sparams[p].split(":");
						let param={};
						param.n=aparams[p];
						param.src=sp[0];
						param.ft=false;
						param.row="cr";
						if(sp.length>1){
							param.col=sp[1];
						}
						if(stparams[p]=="ft"){
							param.ft=true;
						}
						field.lovOptions.params.push(param);
					}
				}
				if(attribute.attributeajaxresults!=""){
					let ares=attribute.attributeajaxresults.split(",");
					let sres=attribute.attributeajaxresultstgt.split(",");
					let stres=attribute.attributeajaxtgttype.split(",");
					for(let p=0;p<ares.length;p++){
					    let sp=sres[p].split(":");
						let result={};
						result.id=ares[p];
						result.tgt=sp[0];
						result.tt=false;
						result.row="cr";
						if(sp.length>1){
							result.col=sp[1];
						}
						if(stres[p]=="tt"){
							result.tt=true;
						}
						field.lovOptions.results.push(result);
					}
				}
			}else if(field.inputType==1){
			    if(attribute.attributekeyvalues!=""){
					let keys=attribute.attributekeyvalues.split(",");
					let tilled="";
					field.keys="";
					field.values="";
					for(const element of keys){
						let keyvalue=element.split(":");
						field.keys=field.keys+tilled+keyvalue[0];
						field.values=field.values+tilled+keyvalue[1];
						tilled="~";
					}
				}else if(attribute.attributelistid!=""){
					let keyvalues=l.callAjax("GET","/waggle/service/ajax","&ic=0&ro=true&id="+attribute.attributelistid);
					if(keyvalues.data.length>0){
						let tilled="";
						field.keys="";
						field.values="";										
						for(const element of keyvalues.data){
							field.keys=field.keys+tilled+element.name;
							field.values=field.values+tilled+element.value;
							tilled="~";
						}
					}
				}
			}
			if(v.events[attribute.name]){
				for(const element of v.events[attribute.name]){
					field[element.eventname]=element.eventhandlerfunc;
				}
			}			
			if(screenFields.contentType=="Fields"){
				screenFields.fields.push(field);			
			}else{
				field.order=attribute.attributeorder;
				field.id=attribute.name;
				field.field=attribute.name;
				field.name=attribute.caption;
				field.width=Number(attribute.width);
				screenFields.tableProperties.columns.push(field);
			}
		}
		currentScreen=new FlexUI.Screen("masters",screenProp);
		currentScreen.setScreenCode(screencode);
		let icons=v.actions;
	  	let s=icons.length;
	  	if($('#addGrp')){
	  		$('#'+iconsParent).append("<div id='actionicons' class='mb-3'></div>");
	  	}

	  	let ul=$('#actionicons');
	  	let subMenuul=$('#submenu');   	
	  	let sp=$('#actionbuttons');
	  	for(let i=0;i<s;i++){
	  		let a=icons[i];
	  		if(a.opertype==0){
				ul.append("<button type='button' class='"+a.operclass+"' onclick='"+a.operaction+"'><span class='"+a.opericon+"'>"+a.opercaption+"</span></button>");
			}else if(a[5]==3){
				subMenuul.append("<li><a href='#' onclick='"+a.operaction+"'>"+a.opercaption+"</a></li>");
			}else{
				sp.append("<div class='"+a.operclass+"' onclick='"+a.operaction+"'>"+a.opercaption+"</div>");
			}
	  	}
	  	for(let j=0;j<gs;j++){
	  		if(v.groups[j].groupvisible==0){
	  			$('#'+v.groups[j].groupname).css('display','none');
	  		}	
	  	}
		//load default values for the screen from groups
	  };
	  
  }
  })(jQuery);