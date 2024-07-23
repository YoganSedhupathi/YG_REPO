var attrScreen=null;

function productAttributeDetails(pgcode,parentId,properties,url,attrData){
		if(properties==null){
			var v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=groupattribute&pgcode="+pgcode);
			properties=v.data;
		}
		var attributesScreen={title:{height:30,width:100,name:"Attributes"},size:{width:150,height:250},container:{id:parentId,isdialog:false},js:"",screen:[
		]};
		if(properties!=null && properties.length>0){
			attributesScreen.screen.push({name:"Attributes",height:40,width:98,minWidth:150,minHeight:250,colWidth:98,float:"left",backColor:"beige",contentType:"Fields",
	    	fields:[]});
			var attributes=properties;
			var k=attributes.length;
			for(var m=0;m<k;m++){
				var f=attributes[m];
				var field={};
			  	field.name="attr_"+f[1];
			  	field.inputType=0;	
			  	field.chkTag=false;			  			  	
			  	if(f[3]=='S'){
			  		field.type="TEXT";
			  	}else if(f[3]=='D'){
			  		field.type="DATE";
			  	}else if(f[3]=='I'){
			  		field.type="INT";
			  	}else if(f[3]=='Z'){
			  		field.type="DECIMAL";
			  	}else if(f[3]=='L'){
			  		field.type="LOV";
			  		field.lovOptions={};
			  		field.lovOptions.url=url+"?pacode="+f[0];
			  		field.lovOptions.ajax="attributelist";
			  		field.lovOptions.scollEnabled=true;
			  		field.lovOptions.searchFromList=false;
			  		field.lovOptions.dsi=1;
			  		field.lovOptions.params=[];
			  		field.lovOptions.results=[{tgt:"attr_"+f[1],id:"0",tt:true},{tgt:"attr_"+f[1],id:"0",tt:false}];
			  		field.chkTag=true;
			  	}
			  	field.caption=f[2];
			  	if(f[4]=='1'){
			  		field.mandatory=true;
			  	}else{
			  		field.mandatory=false;
			  	}
			  	field.visible=true;
			  	field.readOnly=false;
			  	field.defaultValue="";
			  	if(m<k-1){
			  		field.nf="attr_"+attributes[m+1][1];
			  	}else if(m==k-1){
			  		field.nf="aok_button";
			  	}
			  	attributesScreen.screen[0].fields.push(field);
			  }					
		}
	if(attributesScreen.screen.length>0){		
		attrScreen=new FlexUI.Screen("attr",attributesScreen);
		if(attrData!=null){
			attrScreen.loadListData(attrData);
		}
	}
	return properties;
				
}

function invokeAttributeDialog(grid,row,col,attrDialog,parentObject,pgcodecolumn){	
	var cols=grid.getCols();
	var properties=null;
	var data=null;
	$("#"+attrDialog).html("");
	$("#"+attrDialog).data('grid',grid);
	$("#"+attrDialog).data('row',row);
	$("#"+attrDialog).data('col',col);	
	$("#"+attrDialog).dialog({
      autoOpen: false,
      modal: true
    });
    if(pgcodecolumn==undefined){
    	pgcodecolumn='pgcode';
    }
	if(grid.getRelatedValues(row,col)){
		if(grid.getRelatedValues(row,col).properties){
			properties=grid.getRelatedValues(row,col).properties;
		}
		data=grid.getRelatedValues(row,col).data;
	}
	var attributeContent=$("<div id='attributecontent' class='pop_lov_inp_box'><div id='Attributes'/>");
	var attributeTitle=$("<div id='attributetitle' class='pop_lov_hed_box'></div>");
	attributeTitle.append("<div class='pop_lov_clos'><a href='#'>X</a></div><div class='pop_lov_hed_txt'>Product Attributes</div>");
    $('#'+attrDialog).append(attributeTitle);
	$('#'+attrDialog).append(attributeContent);
    var props=productAttributeDetails(grid.getText(row,cols[pgcodecolumn]),'attributecontent',properties,"/inventory/service/ajax",data);
    $('#'+attrDialog).data('props',props);
    attributeContent.append("<div id='attributebutton' style='float:right'><button type='button' id='aok_button' class='btn btn-primary mRhAj' onclick=\"attributeOk('"+attrDialog+"')\">Ok</button><button type='button' class='btn btn-default' onclick=\"attributeCancel('"+attrDialog+"')\">Cancel</button></div>");
    $("#"+attrDialog).dialog({
      close:function(){
      	parentObject.focus();
      	$(this).dialog ('destroy');      	
      }      
    });
    $("#"+attrDialog).dialog('open');
	$('.butt_sav').click(function(e){
		e.preventDefault();
	});
	$('.butt_can').click(function(e){
		e.preventDefault();
	});			 
	screenObjects.getScreenObject("attr_"+props[0][1]).focus();    
}
function attributeOk(dlg){
	var rv={};
	var row=$("#"+dlg).data('row');
   	var col=$("#"+dlg).data('col');
   	var grid=$("#"+dlg).data('grid');
   	var props=$("#"+dlg).data('props');
	rv.properties=props;
	rv.data=attrScreen.processDataToSave();
	if(rv.data!='FAILED'){
		rv.data=$.parseJSON(rv.data.replace('data=','')).savedata;
		rv.condition=buildAttributeCondition(props,rv.data);
    	grid.setRelatedValues(row,col,rv);
    	$("#"+dlg).dialog('close');
    	grid.setCellPopup(row,col,false);
    	var b=true;
    	if(onAttributeClose){
      		b=onAttributeClose(grid,row,col);
      	}
      	if(b){	      	    	    	
    		grid.checkAndMove("Next",true);
    	}
    }
}
function attributeCancel(dlg){
	$("#"+dlg).dialog('close');
}
function buildAttributeCondition(props,data){
	var condition="";
	var k=props.length;	
	for(var m=0;m<k;m++){
		var f=props[m];
		var fname="attr_"+f[1];
		condition+=" and pav_attribute"+f[5]+"='"+data[fname]+"'";		
	}	
	return condition;
}