function validate(e,event)
{
	var eleType;
	eleType=$(e).attr("inputType");
	//closeError();
	if(event.keyCode==13||event.keyCode==9){
		var tabInd= $(e).attr("tabindex");
		var mandi= $(e).attr("mandatory");
		if(mandi!=null && mandi!=0){
			var data=$.trim($(e).val());
			if(data.length<=0){
				//alert("Please enter "+$(e).attr("title"));
				//setErrorMessage("Please enter "+$(e).attr("data-original-title"));
				if(event.preventDefault){
				    event.preventDefault();
				    return;
				}else{
				    event.returnValue = false;
				    return; 
				};
				$(e).focus();
				return;
			}
			var mindata=$.trim($(e).attr("minVal"));
			if(eleType.toUpperCase()=="NUMERIC"||eleType.toUpperCase()=="DECIMAL"){
				if(data.length>0){
					if(parseFloat(data)<parseFloat(mindata)){
						//setErrorMessage("Please enter value greater than "+$(e).attr("minVal"));
						if(event.preventDefault){
					    	event.preventDefault();
					    	return;
						}else{
					    	event.returnValue = false;
					    	return; 
						};
						$(e).focus();
						return;
					}				
				}	
			}
		}
		if(eleType.toUpperCase()=="AJAX"){
			var subEle=$(e).attr("id")+"_ID";
			var subVal=$("#"+subEle).val();
			if(subVal==null || $.trim(subVal).length==0){
				$(e).focus();
				if(event.preventDefault){
				    event.preventDefault();
				    return;
				}else{
				    event.returnValue = false;
				    return; 
				};
			}		
		}
		if(event.keyCode==13){
			do{
				var nextEle=$("[tabindex=" +(parseInt(tabInd)+1)+ "]").attr("id");
				if(nextEle==null){
					if(parseInt(tabInd)<parseInt(max_tab_id)){
						tabInd++;
						continue;
					}
					break;
				}
				if($("#"+nextEle).is(':disabled') == true){
					tabInd=parseInt(tabInd)+1;
				}else{
					$("#"+nextEle).focus();
					break;
				}
			}while(1==1);
		}
	}
	if(eleType==null){
		return;
	}
	if(eleType.toUpperCase()=="NUMERIC"){
  		// Allow: backspace, delete, tab and escape
        if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || 
        	// Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) || 
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
        }else {
			//dont allow shiftkey 
			if(event.shiftKey==true){
		    	if(event.preventDefault){
				    event.preventDefault();
				    return;
				}else{
				    event.returnValue = false;
				    return; 
				};
			}
            // Ensure that it is a number and stop the keypress
            if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
	        	if(event.preventDefault){
				    event.preventDefault();
				    return;
				}else{
				    event.returnValue = false;
				    return; 
				};
    	    }   
    	    var maxValue=$(e).attr("maxVal");
    	    var value=eleType=$(e).val();
    	    if(maxValue!=null){
    	    	if(event.keyCode < 96 || event.keyCode > 105 ){
    	    		value=value*10+parseInt(String.fromCharCode(event.keyCode));
    	    	}else{
    	    		value=value*10+(parseInt(event.keyCode)-96);
    	    	}
    	    	
    	    	if(parseInt(value)>parseInt(maxValue)){
    	    		if(event.preventDefault){
					    event.preventDefault();
					    return;
					}else{
					    event.returnValue = false;
					    return; 
					};
    	    	}
    	    }
		}
	}else if(eleType.toUpperCase()=="DECIMAL"){
  		// Allow: backspace, delete, tab and escape
        if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || 
        	// Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) || 
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
        }else {
			//dont allow shiftkey 
			var value=$(e).val();
			if(event.shiftKey==true){
		    	if(event.preventDefault){
				    event.preventDefault();
				    return;
				}else{
				    event.returnValue = false;
				    return; 
				};
			}
            // Ensure that it is a number and stop the keypress
            if(event.keyCode==190 || event.keyCode==110){
            	if(value.lastIndexOf(".")>=0){
            		if(event.preventDefault){
					    event.preventDefault();
					    return;
					}else{
					    event.returnValue = false;
					    return; 
					};
            	}
            	if(value.length==0){
            		if(event.preventDefault){
					    event.preventDefault();
					    return;
					}else{
					    event.returnValue = false;
					    return; 
					};
            	}
            }else if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
	        	if(event.preventDefault){
				    event.preventDefault();
				    return;
				}else{
				    event.returnValue = false;
				    return; 
				};
    	    }
    	    var maxDecimal=$(e).attr("decimal");
    	    if(maxDecimal!=null){
    	    	var dotIndex=value.lastIndexOf(".");
    	    	var decimalStr=value.substr(dotIndex);
    	    	if(decimalStr.length>maxDecimal){
    	    		if(event.preventDefault){
						    event.preventDefault();
						    return;
					}else{
						    event.returnValue = false;
						    return; 
					};
    	    	}
    	    }
    	    var maxValue=$(e).attr("maxVal");
    	    if(maxValue!=null){
    	    	var dotIndex=value.lastIndexOf(".");
    	    	if((dotIndex>-1)){
    	    		if($(e).caret().start<value.lastIndexOf(".")){
						value=value.substr(0,dotIndex);  	 
		    	   		if(event.keyCode < 96 || event.keyCode > 105 ){
	    	    			value=value*10+parseInt(String.fromCharCode(event.keyCode));
	    	    		}else{
	    	    			value=value*10+(parseInt(event.keyCode)-96);
	    	    		}
	    	    	
		    	    	if(parseInt(value)>parseInt(maxValue)){
	    		    		if(event.preventDefault){
							    event.preventDefault();
							    return;
							}else{
							    event.returnValue = false;
							    return; 
							};
	    		    	}
	    	   		}  		
    	    	}else{
    	    		if(event.keyCode < 96 || event.keyCode > 105 ){
    	    			value=value*10+parseInt(String.fromCharCode(event.keyCode));
	    	    	}else{
	    	    		value=value*10+(parseInt(event.keyCode)-96);
	    	    	}
	    	    	if(parseFloat(value)>parseFloat(maxValue)){
	    	    		if(event.preventDefault){
						    event.preventDefault();
						    return;
						}else{
						    event.returnValue = false;
						    return; 
						};
	    	 		}
    	    	}
    	    }
    	    if(parseFloat($(e).val())>=parseFloat(maxValue)){
	    	    		if(event.preventDefault){
						    event.preventDefault();
						    return;
						}else{
						    event.returnValue = false;
						    return; 
						};
	    	 }
	    }
	}else if(eleType.toUpperCase()=="ALPHANUMERIC"){
		if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || 
        	// Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) || 
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39) || event.keyCode==32) {
            // let it happen, don't do anything
            return;
        }else {
			// Ensure that it is a number and stop the keypress
		  	if(event.keyCode > 64 && event.keyCode < 91){
		    	return;
		  	}else if(event.shiftKey==true){
		    	if(event.preventDefault){
				    event.preventDefault();
				    return;
				}else{
				    event.returnValue = false;
				    return; 
				};
		    	return;
		  	}else if ((event.keyCode>47 && event.keyCode<58) || (event.keyCode>95 && event.keyCode<106 )) {
				return;
		  	}
			if(event.preventDefault){
			    event.preventDefault();
			    return;
			}else{
			    event.returnValue = false;
			    return; 
			};
		}
	}else if(eleType.toUpperCase()=="DATEPICKER"){
		if(event.keyCode==8){
			$(e).val("");
			return;
		}else{
			if(event.preventDefault){
		  	  event.preventDefault();
		    	return;
			}else{
			    event.returnValue = false;
			    return; 
			};
		}
		if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || 
        	// Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) || 
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
        }else {
			// Ensure that it is a number and stop the keypress
		  if(event.shiftKey==true){
		    	if(event.preventDefault){
				    event.preventDefault();
				    return;
				}else{
				    event.returnValue = false;
				    return; 
				};
		    	return;
		  	}else if ((event.keyCode>47 && event.keyCode<58) || (event.keyCode>95 && event.keyCode<106 )) {
				return;
		  	}
			if(event.preventDefault){
			    event.preventDefault();
			    return;
			}else{
			    event.returnValue = false;
			    return; 
			};
		}
		if(event.preventDefault){
		    event.preventDefault();
		    return;
		}else{
		    event.returnValue = false;
		    return; 
		};
	}	
}