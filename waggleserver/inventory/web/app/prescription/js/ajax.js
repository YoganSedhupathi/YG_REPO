(function ($) {
  // register namespace
  $.extend(true, window, {
    FlexUI: {
      Ajax: FlexAjax
    }
  });
  function FlexAjax() {
	var me=this;
	
	this.init=function(){
	}
    this.callAjax=function(method,url,parameters){
    	var response;
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
    	var response;
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