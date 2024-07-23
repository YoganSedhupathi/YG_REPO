(function ($) {
$.extend(true, window, {
    "FlexUI": {
      "Actions": Actions
      }
      });
      
  function Actions(menuId,iconsParent,buttonsParent) {
	  this.buildActions=function(){
	  	let l=new FlexUI.Ajax();
	  	let v=l.callAjax("GET","/inventory/service/ajax","ic=0&id=actions&menuid="+menuId);
	  	let icons=v.data;
	  	let s=icons.length;

		if($('#addGrp')){
			// $('#'+iconsParent).append("<div id='actionicons' class='mb-3'></div>");
		}
	  	if($('#'+iconsParent)){
	  		$('#'+iconsParent).append("<div id='actionicons'></div>");
	  	}
	  	if($('#'+buttonsParent)){
	  		$('#'+buttonsParent).append("<span id='actionbuttons'></span>");
	  	}
	  	let ul=$('#actionicons');
	  	let subMenuul=$('#submenu');   	
	  	let sp=$('#actionbuttons');
	  	for(let i=0;i<s;i++){
	  		let a=icons[i];
	  		if(a[5]==0){
				ul.append("<button type='button' class='"+a[3]+"' onclick='"+a[2]+"'><span class='"+a[4]+"'>"+a[1]+"</span></button>");
			}else if(a[5]==3){
				subMenuul.append("<li><a href='#' class='dropdown-item'  onclick='"+a[2]+"'>"+a[1]+"</a></li>");
			}else{
				sp.append("<button type='button' class='"+a[3]+"' onclick='"+a[2]+"'><span class='"+a[4]+"'></span>"+a[1]+"</button>")
			}
	  	}
	  };
  }
  })(jQuery);