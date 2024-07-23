function fetchCustomer(id,me){
	let v= l.callAjax("GET","/inventory/service/ajax","ic=0&id=checkcustomer&mobileno="+me.getValue());
	if(v!=null && v.data!=null && v.data.length>0){
		screenObjects.getScreenObject("name").setTag(v.data[0][0]);
		screenObjects.getScreenObject("name").setValue(v.data[0][1]);
		screenObjects.getScreenObject("address1").setValue(v.data[0][3]);
		screenObjects.getScreenObject("address2").setValue(v.data[0][4]);
		screenObjects.getScreenObject("city").setValue(v.data[0][5]);
		screenObjects.getScreenObject("pincode").setValue(v.data[0][6]);
	}
	return true;
}