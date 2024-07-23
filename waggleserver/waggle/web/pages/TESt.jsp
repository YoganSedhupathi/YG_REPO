<div class="col-md-12 col-xs-12 mpZero borBot1 borBot2">'+
    
    '<div class="col-md-11 col-xs-11 mpZero">'+
   
                  '<div class="col-md-5 col-xs-5 mpZero">'+
                      '<h3 class="prhead1">'+v.data[i].productname+'</h3>'+
                      '<div class="prTxt">'+v.data[i].genericname+' | '+v.data[i].stock+'</div>'+
                      '<div class="clearfix"></div>'+
                  '</div>'+
                  '<div class="col-md-2 col-xs-2 padAdj text-right">'+
                      '<div class="input-group">'+
                          '<input type="text" class="form-control" placeholder="No Of Days" id="nod_'+v.data[i].productcode+'" data-role="none" inputType="NUMERIC"  decimal="0" mandatory="1"   maxlength="5" onkeydown="return validate(this,event)">'+
                      '</div>'+
                  '</div>'+
                   '<div class="col-md-2 col-xs-2 padAdj text-right">'+
                              '<div class="input-group">';
                                  if(v.data[i].PCT_consumetype!="No"){
                                      str=str+'<input type="text" class="form-control" placeholder="Total" id="tot_'+v.data[i].productcode+'" data-role="none" inputType="NUMERIC"  decimal="0" mandatory="1" value="1"  maxlength="5" onkeydown="return validate(this,event)">';
                                  }else{
                                      str=str+'<input type="text" class="form-control" disabled placeholder="Total" id="tot_'+v.data[i].productcode+'" data-role="none" inputType="NUMERIC"  decimal="0" mandatory="1"   maxlength="5" onkeydown="return validate(this,event)">';
                                  }
                                  
                                  str=str+'<input type="hidden"  id="medtype_'+v.data[i].productcode+'" value="'+v.data[i].PCT_consumetype+'">'+
                                  '<input type="hidden"  id="medtypeid_'+v.data[i].productcode+'" value="'+v.data[i].PCT_ID+'">'+
                                  '<input type="hidden"  id="hidecourse_'+v.data[i].productcode+'" value="'+v.data[i].pct_hidecourse+'"></div>'+
                   '</div>'+
                  '<div class="col-md-3 col-xs-3 padAdj text-right">'+
                      '<div class="input-group">'+
                      '<input type="text" class="form-control" placeholder="Addl.Info" id="remarks_'+v.data[i].productcode+'" data-role="none" inputType="ALPHANUMERIC"  decimal="0" mandatory="0"   maxlength="50" onkeydown="return validate(this,event)">'+
                  '</div>'+
                  '</div>'+

                    '<div class="clearfix"></div>'+
    '<div style="padding-top:5px" class="col-md-12 col-xs-12 mpZero">'+
                    '<div class="col-md-2 col-xs-2 mpZero">'+
                    '<div class="">Course  -  '+v.data[i].PCT_consumetype+'</div>'+
                    '</div>';
    if(v.data[i].pct_hidecourse=="1"){
    
    }else  if(v.data[i].PCT_consumetype!="No"){
        str=str+'<div class="col-md-2 col-xs-2 mpZero text-center">'+
          '<div class="input-group">'+
          '<input type="text" class="form-control" placeholder="'+v.data[i].PCT_consumetype+'" id="c1_'+v.data[i].productcode+'" data-role="none" inputType="NUMERIC"  decimal="0" mandatory="1"   maxlength="5" onkeydown="return validate(this,event)">'+
         '</div>'+
          '</div>'+
          '<div class="col-md-2 col-xs-2 mpZero text-center">'+
          '<div class="input-group">'+
          '<input type="text" class="form-control" placeholder="'+v.data[i].PCT_consumetype+'" id="c2_'+v.data[i].productcode+'" data-role="none" inputType="NUMERIC"  decimal="0" mandatory="1"   maxlength="5" onkeydown="return validate(this,event)">'+
         '</div>'+
          '</div>'+
          '<div class="col-md-2 col-xs-2 mpZero text-center">'+
          '<div class="input-group">'+
          '<input type="text" class="form-control" placeholder="'+v.data[i].PCT_consumetype+'" id="c3_'+v.data[i].productcode+'" data-role="none" inputType="NUMERIC"  decimal="0" mandatory="1"   maxlength="5" onkeydown="return validate(this,event)">'+
         '</div>'+
          '</div>'+
          '<div class="col-md-2 col-xs-2 mpZero text-center">'+
          '<div class="input-group">'+
          '<input type="text" class="form-control" placeholder="'+v.data[i].PCT_consumetype+'" id="c4_'+v.data[i].productcode+'" data-role="none" inputType="NUMERIC"  decimal="0" mandatory="1"   maxlength="5" onkeydown="return validate(this,event)">'+
         '</div>'+
          '</div>'+
          '<div class="col-md-2 col-xs-2 mpZero text-center">'+
          '<div class="input-group">'+
          '<select data-role="none" class="form-control" id="am_'+v.data[i].productcode+'"><option value="AM">After Meal</option><option value="BM">Before Meal</option></select>'+
         '</div>'+
          '</div>';
    }else{
        str=str+'<div class="col-md-2 col-xs-2 mpZero text-center">'+
          '<div class="input-group">'+
          '<select data-role="none" class="form-control" id="c1_'+v.data[i].productcode+'"><option value="0">None</option><option value="0.5">Half</option><option value="1">1</option><option value="1.5">1 and Half</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select>'+
         '</div>'+
          '</div>'+
          '<div class="col-md-2 col-xs-2 mpZero text-center">'+
          '<div class="input-group">'+
          '<select data-role="none" class="form-control" id="c2_'+v.data[i].productcode+'"><option value="0">None</option><option value="0.5">Half</option><option value="1">1</option><option value="1.5">1 and Half</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select>'+
         '</div>'+
          '</div>'+
          '<div class="col-md-2 col-xs-2 mpZero text-center">'+
          '<div class="input-group">'+
          '<select data-role="none" class="form-control" id="c3_'+v.data[i].productcode+'"><option value="0">None</option><option value="0.5">Half</option><option value="1">1</option><option value="1.5">1 and Half</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select>'+
         '</div>'+
          '</div>'+
          '<div class="col-md-2 col-xs-2 mpZero text-center">'+
          '<div class="input-group">'+
          '<select data-role="none" class="form-control" id="c4_'+v.data[i].productcode+'"><option value="0">None</option><option value="0.5">Half</option><option value="1">1</option><option value="1.5">1 and Half</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select>'+
         '</div>'+
          '</div>'+
          '<div class="col-md-2 col-xs-2 mpZero text-center">'+
          '<div class="input-group">'+
          '<select data-role="none" class="form-control" id="am_'+v.data[i].productcode+'"><option value="AM">After Meal</option><option value="BM">Before Meal</option></select>'+
         '</div>'+
          '</div>';
    }
                                                                                                       
    str=str+'</div>'+
    '</div>'+


    '<div class="col-md-1 col-xs-1 mpZero">'+
    '<div class="col-md-12 col-xs-12 text-right mpZero">&nbsp;</div><div class="col-md-12 col-xs-12 text-right mpZero">'+
      '<button class="btn btn-info ui-btn ui-shadow ui-corner-all" type="button" onclick="app.addMedicineItem('+v.data[i].productcode+')">Add</button>'+
    '</div>'+
    '</div>'+



    '</div>';