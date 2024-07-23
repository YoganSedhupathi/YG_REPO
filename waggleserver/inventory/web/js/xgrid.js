(function ($) {
  $.extend(true, window, {
    FlexUI: {
      Grid:FlexGrid
    }
  });
  
  var scrollbarSize;
  var maxCssHeight;  // browser's breaking point
  
function FlexGrid(name,parent, columns, options) {
	  let wHeaderScroller;
    let wHeader;
    let wFooterScroller;
    let wFooter;
    let wHeaderRow, wHeaderRowScroller, wHeaderRowSpacer;
	  let wDataView;
	  let dataTable;
	  let dataviewHeight, dataviewWidth=0;
    let canvasWidth;
    let dataviewHasHScroll, dataviewHasVScroll;
    let headerColumnWidthDiff = 0, headerColumnHeightDiff = 0, // border+padding
        cellWidthDiff = 0, cellHeightDiff = 0;
    let absoluteColumnMinWidth;
    let numberOfRows = 0;
    let wParent;
    let wRowHtml;
    let input;
    let me=this;
    let wGridTop;
    let wAddRowButton;
    let wDeleteRowButton;
    let adjustedHeight=0;
    
    let defaults = {
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

	
	  wGridTop = $("<div style='display:none'/>").appendTo(wParent);
	  wAddRowButton=$("<button id='ar_"+name+"' class='btn btn-sm addColB'><i class='fa fa-plus'></i></button>");
	  wDeleteRowButton=$("<button id='dr_"+name+"' class='btn btn-sm borDelt'><i class='fa fa-trash-o'></i></button>");
	  
                        
	  if(options.enableAddRow){
	      let c1=$('<div class="subHe">Products</div>');
	      let c2=$('<div class="btn-group pull-right"/>');	 
	  	  wGridTop.append(c1);c1.append(c2); 
		  c2.append(wAddRowButton);
		  c2.append(wDeleteRowButton);
		  
	  }	  
	  wHeaderScroller = $("<div class='xgrid-header' style='overflow:hidden;position:relative;' />").appendTo(wParent);
      wHeader = $("<div class='xgrid-header-columns' />").appendTo(wHeaderScroller);

      measureCellPaddingAndBorder();

	  options.headerColumnWidthDiff=headerColumnWidthDiff;
	  
	  dataTable=new FlexUI.Table(name,dataviewWidth-scrollbarSize.width,options,{},columns,{});
	  
	  columns=dataTable.getColumnProperties();

	    let hwidth=getHeadersWidth(); 
      wHeader.width(hwidth);

      wHeaderRowScroller = $("<div class='xgrid-headerrow' style='overflow:hidden;position:relative;' />").appendTo(wParent);
      wHeaderRow = $("<div class='xgrid-headerrow-columns' />").appendTo(wHeaderRowScroller);
      wHeaderRowSpacer = $("<div style='display:block;height:1px;position:absolute;top:0;left:0;'></div>")
          .css("width", getCanvasWidth() + scrollbarSize.width+ "px")
          .appendTo(wHeaderRowScroller);

      wDataView = $("<div class='xgrid-viewport' style='width:100%;overflow:auto;outline:0;position:relative;;'>").appendTo(wParent);
      wDataView.css("overflow-y", options.autoHeight ? "hidden" : "auto");

      dataTable.appendTo(wDataView);

      createHeaderRow();

	  wFooterScroller = $("<div class='xgrid-footer' style='overflow:hidden;position:relative;display:none' />").appendTo(wParent);
      wFooter = $("<div class='xgrid-footer-columns' />").appendTo(wFooterScroller);

	  wFooter.width(hwidth);
	  
	  createFooterRow();

	  wDataView.height(getDataViewHeight());
      dataTable.setWidth(getCanvasWidth());
      dataTable.setMaxWidth(getCanvasWidth());
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
		let row=args.row;
		let col=args.col;
		if(columns[col].type!="TEXT" && columns[col].type!="LOV" && columns[col].cTotal){
			me.calculateColumnTotal(col);
		}
	}
	this.calculateColumnTotal=function(col){
		let total=0;
		let s=dataTable.getSize();
		for(let k=0;k<s;k++){
			total+=toNumber(dataTable.getText(k,col));
		}
		let t=total;
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
	this.resetHeight=function(cheight){
		let addedHeight=cheight;
		if(cheight==0){
			addedHeight=adjustedHeight*-1;
		}
		adjustedHeight=cheight;
		$(parent).height($(parent).height()+addedHeight);
		wDataView.height(getDataViewHeight());
	}	
	function handleHeaderRowScroll() {
      let scrollLeft = wDataView[0].scrollLeft;
      if (scrollLeft != wHeaderScroller[0].scrollLeft) {
        wHeaderScroller[0].scrollLeft = scrollLeft;
      }
    }
    function handleFooterRowScroll() {
      let scrollLeft = wDataView[0].scrollLeft;
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
    	let r=args.row;
    	let s=columns.length;
    	for(let k=0;k<s;k++){
    		if(columns[k].type!="TEXT" && columns[k].type!="LOV" && columns[k].cTotal){
    			let spn=$('#fd_'+name+columns[k].id);
    			let total=toNumber(spn.html());
    			total-=toNumber(dataTable.getText(r,k));
    			let t=total;
    			if(columns[k].decimalLength!=0){
					t=roundOff(total,columns[k].decimalLength);
				}
    			spn.html(t);
    		}
    	}
    }           
	function measureScrollbar() {
      let wC = $("<div style='position:absolute; top:-10000px; left:-10000px; width:100px; height:100px; overflow:scroll;'></div>").appendTo("body");
      let dim = {
        width: wC.width() - wC[0].clientWidth,
        height: wC.height() - wC[0].clientHeight
      };
      wC.remove();
      return dim;
    }
	function getHeadersWidth() {
      let headersWidth = 0;
      for (let i = 0, ii = columns.length; i < ii; i++) {
        let width = columns[i].adjustedWidth;
        headersWidth += width;
      }
      headersWidth += scrollbarSize.width;
      
      return Math.max(headersWidth, dataviewWidth);
    }

    function getCanvasWidth() {
      let availableWidth = dataviewHasVScroll ? dataviewWidth - scrollbarSize.width : dataviewWidth;
      let rowWidth = 0;
      let i = columns.length;
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
      let p = ["borderTopWidth", "borderBottomWidth", "paddingTop", "paddingBottom"];
      let delta = 0;
      $.each(p, function (n, val) {
        delta += parseFloat(wEl.css(val)) || 0;
      });
      return delta;
    }
    function createHeaderRow(){
     wHeader.empty();
     wHeader.width(getHeadersWidth());
    
     for (const element of columns) {
        let m = element;

        let header = $("<div class='ui-state-default xgrid-header-column' id='" + name + m.id + "' />")
            .html("<span class='xgrid-column-name'>" + m.name + "</span>")
            //.width(m.adjustedWidth - headerColumnWidthDiff) last column by siva
            .width(m.adjustedWidth)
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
    
     for (const element of columns) {
        let m = element;

        let header = $("<div class='ui-state-default xgrid-footer-column' id='f_" + name + m.id + "' />")
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
      let el;
      let h = ["borderLeftWidth", "borderRightWidth", "paddingLeft", "paddingRight"];
      let v = ["borderTopWidth", "borderBottomWidth", "paddingTop", "paddingBottom"];

      el = $("<div class='ui-state-default xgrid-header-column' style='visibility:hidden'>-</div>").appendTo(wHeader);
      headerColumnWidthDiff = headerColumnHeightDiff = 0;
      $.each(h, function (n, val) {
        headerColumnWidthDiff += parseFloat(el.css(val)) || 0;
      });
      $.each(v, function (n, val) {
        headerColumnHeightDiff += parseFloat(el.css(val)) || 0;
      });
      el.remove();
      //alert("HeaderWidth" + headerColumnWidthDiff + "   dataView" + cellWidthDiff);
      /*let r = $("<tr class='xgrid-row' />").appendTo(wDataTable);
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
}(jQuery));