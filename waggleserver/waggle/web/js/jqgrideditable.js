
function handleElementKeyDown(e){
	var key=e.which || e.keyCode;
	var target=e.target;
	if(key==13 || key==9){
		moveNextCol($(target));
		e.stopPropagation();
		e.preventDefault();
	}	
}
function initializeGrid(id,colNames,colModel,emptyRow){
	$('#'+id).data("lastsel",0);
	$("#"+id).jqGrid(
	{ 
		datatype: "local", 
		height: 250, 
		viewrecords: true,
		colNames:colNames, 
		colModel:colModel, 
    	onSelectRow: function(rowid){
    				var lastsel=$('#'+id).data("lastsel");
    				if(rowid && rowid!==lastsel){ 
    					if(lastsel!=0){
    						saveGridRow(id,lastsel);
    					} 
    					$('#'+id).jqGrid('editRow',rowid); 
    					lastsel=rowid;
    					$('#'+id).data("lastsel",rowid);
    				} 
    				
    			}, 
    	editurl:'clientArray'}
    	);
    	$('#'+id).data('emptyRow',emptyRow);
    	addGridRow(id);    	
}
/*

editrules: {
    custom:true,
    custom_func: function(value,colname) {
        // return [true,""] in case of successful validation
        // [false,"Your error message"]; in case of validation error
    }
}

*/
function moveNextCol(elem){
	var nf=elem.data('nf');
	var id=elem.data('p');
	var rowid = $("#"+id).jqGrid('getGridParam', 'selrow');
	if(nf=='0'){
		var last = $('#'+id).jqGrid('getGridParam','records');
		if(last==rowid){
			addGridRow(id);
		}else{
			editNextRowJqGridRow(id,rowid);	
		}	
	}else{
		$("#"+(rowid)+"_"+nf).focus();
	}	
}
function getRowData(id){
	saveGridRow(id,0);
	$('#'+id).jqGrid('resetSelection');
	var rowData = $('#'+id).jqGrid('getRowData');
	$('#'+id).data('lastsel',0);
	return JSON.stringify(rowData);
}
function addGridRow(id){
	var last = $('#'+id).jqGrid('getGridParam','records');
    addNewJqGridRow(id,last,$('#'+id).data('emptyRow'));
}
function addGridRowWithData(id,rows){
	//row will be like {name:"product1",stock:"10",ship:"yes",note:"product1 is sold"}
	var s=rows.length;
	for(var i=0;i<s;i++){
		var r=rows[i];
		var last = $('#'+id).jqGrid('getGridParam','records');
		if(last-1<i){
			addNewJqGridRow(id,i+1,r);
		}else{
			$('#'+id).jqGrid('setRowData',i+1,r);
		}
	}
}	
function addNewJqGridRow(id,last,dataRow){
	saveGridRow(id,0);
    $('#'+id).jqGrid('resetSelection');
	var lastsel = parseInt(last) + 1;
    var su=$("#"+id).addRowData(lastsel,dataRow, "last") ;
    $("#"+id).jqGrid('setCell', lastsel, 'sno', lastsel);
    $('#'+id).jqGrid('editRow',lastsel);
    $("#"+id).setSelection (lastsel, true);
}
function addNewJqGridRowAfter(id,current,copyrow){
   	var dataRow=$("#"+id).data('emptyRow');   	
   	saveGridRow(id,0);
   	$('#'+id).jqGrid('resetSelection');
   	var nos = $('#'+id).jqGrid('getGridParam','records');
   	for(var j=nos;j>=current+1;j--){
		$("#" + j).attr("id", j+1);
		$("#"+id).jqGrid('setCell', j+1, 'sno', j+1);
	}
	if(copyrow){
		dataRow=$("#"+id).jqGrid('getRowData',current);
    }
    $("#"+id).addRowData(current+1,dataRow, "after",current) ;    
    $("#"+id).jqGrid('setCell', current+1, 'sno', current+1);
    $('#'+id).jqGrid('editRow',current+1);
    $("#"+id).setSelection (current+1, true);
}
function editNextRowJqGridRow(id,last){
	saveGridRow(id,0);
    $('#'+id).jqGrid('resetSelection');
	var ed = parseInt(last) + 1;
    $('#'+id).jqGrid('editRow',ed);
    $("#"+id).setSelection (ed, true);
}
function saveGridRow(id,row){
	var rowid;
	if(row==0){
		rowid = $("#"+id).jqGrid('getGridParam', 'selrow');
	}else{
		rowid=row;
	}
	if(rowid!=0){
    	$('#'+id).jqGrid('saveRow',rowid);
    }	
}
function delteteJqGridRow(id){
	var grid=$('#'+id);
	var myDelOptions = {
        onclickSubmit: function(options, rowid) {
            var grid_id = $.jgrid.jqID(grid[0].id),
                grid_p = grid[0].p,
                newPage = grid_p.page;
            options.processing = true;
            grid.delRowData(rowid);
            $.jgrid.hideModal("#delmod"+grid_id,
                              {gb:"#gbox_"+grid_id,
                              jqm:options.jqModal,onClose:options.onClose});

            if (grid_p.lastpage > 1) {// on the multipage grid reload the grid
                if (grid_p.reccount === 0 && newPage === grid_p.lastpage) {
                    newPage--; // go to the previous page
                }
                grid.trigger("reloadGrid", [{page:newPage}]);
            }
            return true;
        },
        processing:true
    };
	var rowid = $("#"+id).jqGrid('getGridParam', 'selrow');
	var last  = $("#"+id).jqGrid('getGridParam', 'records');
	$("#"+id).jqGrid('delGridRow',rowid,myDelOptions);
	for(var j=Number(rowid)+1;j<=last;j++){
		if(j-1==0) j=1;
		$("#" + j).attr("id", j-1);
	}
	$("#"+id).data('lastsel',0);
	setSelectionAfterDelete(id,rowid,last);
}
function delteteJqGridRowData(id){
	var grid=$('#'+id);
	var rowid = $("#"+id).jqGrid('getGridParam', 'selrow');
	var last  = $("#"+id).jqGrid('getGridParam', 'records');
	$("#"+id).jqGrid('delRowData',rowid);
	for(var j=Number(rowid)+1;j<=last;j++){
		if(j-1==0) j=1;
		$("#" + j).attr("id", j-1);
		$("#"+id).jqGrid('setCell', j-1, 'sno', j-1);
	}
	$("#"+id).data('lastsel',0);
	setSelectionAfterDelete(id,rowid,last);
}
function setSelectionAfterDelete(id,deletedRow,last){
	var records = $("#"+id).jqGrid('getGridParam', 'records');
	if(records==0){
		addGridRow(id);
	}
	var ed = 1;
	if(last>deletedRow){
		ed=deletedRow;
	}else if(deletedRow==1){
		ed=1;
	}else{
		ed=deletedRow-1;
	}	
    $('#'+id).jqGrid('editRow',ed);
    $("#"+id).setSelection (ed, true);	
}