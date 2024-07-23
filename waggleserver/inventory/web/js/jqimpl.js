function jqReport(id,parent,params,width,height,rownum) {
	let container=$(parent);
	container.append($("<table id='report_"+id+"'></table>")); 
	container.append($("<div id='paging_"+id+"'></div>"));			    	 
	let prm=params;
	let l=new FlexUI.Ajax();
	let v=l.callAjax("GET","/inventory/service/report/metadata","id="+id+params);
	v.url='/inventory/service/report/data?id='+id+params;
	v.datatype="json";
	
	if(rownum){
		v.rowNum=rownum;
	}else{
		v.rowNum=25;
	}
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
		v.height=($(window).height()-290);
	}
	let s=v.colModel.length;
	for(let i=0;i<s;i++){
		let col=v.colModel[i];
		if(col.formatter=='image'){
			let params=col.parameters.split(",");
			let columns=col.columns.split(",");
			let link=col.link;
			let image=col.image;
			let g=params.length;
			link='function imageFormat'+i+'(cellValue,options,rowObject){ let k="'+link+'?';
			for(let x=0;x<g;x++){
				link+='&'+params[x]+'="+rowObject["'+columns[x]+'"]+"';
			}
			link+='"; return "<span class=\''+image+'\' onclick=\'openLink(\\""+k+"\\",\\"'+v.colModel[i].name+'\\","+options.rowId+")\'/>";}';
			let b=eval("("+link+")");
			v.colModel[i].formatter=b;
		}else if(col.formatter=='statusimage'){
			let image=col.image.split(",");
			let link='function imageFormat'+i+'(cellValue,options,rowObject){ if(cellValue=="Active" || cellValue=="Completed" || cellValue=="1" || cellValue=="Paid"  ){';
			link+=' return "<span class=\''+image[0]+'\'>"+cellValue+"</span>"; }else if(cellValue=="InActive" || cellValue=="Pending" || cellValue=="0"){ return "<span class=\''+image[1]+'\'>"+cellValue+"</span>";}';
			link+=' else if( cellValue=="Part Paid" ){ return "<span class=\''+image[2]+'\'>"+cellValue+"</span>";}}';
			
			let b=eval("("+link+")");
			v.colModel[i].formatter=b;
		}
	}
	
	jQuery("#report_"+id).jqGrid(v);
	jQuery("#report_"+id).jqGrid('navGrid','#paging_'+id,{add:false,edit:false,del:false}, {}, {}, {}, {multipleSearch:true, multipleGroup:false, showQuery: false});
	jQuery("#report_"+id).jqGrid('filterToolbar');
	
	$("#search_report_"+id+" span").removeClass("ui-icon ui-icon-search");
	$("#search_report_"+id+" span").addClass("mt-1 mdi mdi-file-find");
  
	$("#refresh_report_"+id+" span").removeClass("ui-icon ui-icon-refresh");
	$("#refresh_report_"+id+" span").addClass("mt-1 mdi mdi-refresh");

	$("#first_paging_"+id+" span").removeClass("ui-icon ui-icon-seek-first");
	$("#first_paging_"+id+" span").addClass(" mdi mdi-page-first");
	$("#prev_paging_"+id+" span").removeClass("ui-icon ui-icon-seek-prev");
	$("#prev_paging_"+id+" span").addClass(" mdi mdi-chevron-left");
	
	$("#next_paging_"+id+" span").removeClass("ui-icon ui-icon-seek-next");
	$("#next_paging_"+id+" span").addClass(" mdi mdi-chevron-right");
	$("#last_paging_"+id+" span").removeClass("ui-icon ui-icon-seek-end");
	$("#last_paging_"+id+" span").addClass(" mdi mdi-page-last");
	
	showPDFExportButton(id,prm);
}
function openLink(link,name,rowid){
	loadOrderData(link,name,rowid);
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
	let newUrl='/inventory/service/report/data?id='+id+params+newParams;
	jQuery("#report_"+id).setGridParam({url:newUrl});
	jQuery("#report_"+id).trigger('reloadGrid');
	showPDFExportButton(id,newParams);
}
function getJqGridSelectedRow(id){	
	let selr = jQuery("#report_"+id).jqGrid('getGridParam','selrow');
	return selr;
}

function getSelectCellValue(id){
	let rowId=getJqGridSelectedRow(id);
	let r = jQuery("#report_"+id).jqGrid ('getRowData', rowId);
	return r;
}

function setJqGridFrozenColumns(id){
	jQuery("#report_"+id).jqGrid('setFrozenColumns');
}

function showPDFExportButton(id,params){
	$("#pdfbutton_"+id).remove();
	if(!params){
		params="";
	}
	jQuery("#report_"+id).jqGrid('navButtonAdd', 
            '#paging_'+id,
            {caption:"",
            title:"Export to PDF", 
            buttonicon:"mdi mdi-file-multiple", 
            onClickButton: function(){window.open('/inventory/service/report/writepdf?id='+id+params);}, position:"last",id:"pdfbutton_"+id});
}

function showCSVExportButton(id,params){
	$("#csvbutton_"+id).remove();
	jQuery("#report_"+id).jqGrid('navButtonAdd', 
            '#paging_'+id,
            {caption:"",
            title:"Export to CSV", 
            buttonicon:"mdi mdi-download", 
            onClickButton: function(){window.open('/inventory/service/report/writecsv?id='+id+params);}, position:"last",id:"csvbutton_"+id});
}

