<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Data Import</title>
<script src="js/jquery/jquery-1.8.3.min.js"></script>
<script src="js/jquery/jquery-ui.min.js"></script>
<script src="js/jquery/jquery.form.min.js" type="text/javascript"></script>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<%
	String importId=(String)request.getParameter("type");
	String userCode=(String)request.getParameter("usercode");
	if(userCode!=null){
		userCode=(String)request.getSession().getAttribute(userCode);
	}else{
		userCode="0";
	}
%>
</head>
<body>
	<div class='importdiv'>
	<div id='content'>
	<div id='navigation' style='width:100%;float:left'>
	<ul id="header">
	<li class='selected'><a href='#step_1'>
		Upload excel file
		</a>
	</li>
	<li><a href='#step_2'>
		Map the fields
		</a>
	</li>
	<li><a href='#step_3'>
		Import data
		</a>
	</li>	
	</ul>
	</div>
	<div id="step_1" style='position:relative;width:100%;float:left;height:100%;padding-top:10px'>   	
	<form id='impForm' name='ImportForm'  method='POST'  enctype='multipart/form-data' action='dataImport.servlet'>
    	<ul class="pop_inp_lst">
		<li><b>Data File</b><label>		
		<span><input id="fileUpload" name="fileUpload" type="file" />
		<input id="uid" name="uid" type="hidden" value="0"/>
		<input id="impid" name="impid" type="hidden" value="<%=importId%>"/>
		<input id="usercode" name="usercode" type="hidden" value="<%=userCode%>"/>
		<input id="fileName" name="fileName" type="hidden" value=""/></span></li>
		<li><b></b><span><a class="butt_sav" onclick='uploadFile()'>Next</a></span></li>
		</ul>
	</form>
	</div>	
	<div id="step_2" style='display:none;position:relative;width:100%;float:left;padding-top:10px'>
	<form id='mappingForm' name='mappingForm'/>	
			<div id="step_21">
			</div>
	</form>			
	</div>
	<div id="step_3" style='display:none;position:relative;width:100%;float:left;padding-top:10px'>	
	<form id='importDataForm' name='importDataForm'/>	
			<div id="step_31">
			</div>
	</form>			
	</div>
	</div>	
	</div>
	<div id="errorContainer" style='display:none;z-index:1001;' class="errorContainer">
	<div id="error" class="error">
		<a id='errorClose' onclick='closeError()' class='close'>&times</a>
		<span id='error-message'> check </span>
		
	</div>
	</div>	
	 <script>
	 function closeError(){
		$("#errorContainer").fadeOut();
  	}
  	function setErrorMessage(err){
		$("#error-message").html(err);
		if(!$("#error").is(":visible")){
			runEffect(err);
		}
  	}
  	function runEffect(err) {
		$("#errorContainer").show();
  	}
	 $('.butt_sav').click(function(e){
		e.preventDefault();
	});
	 var migcolumns=null;
	 var datacolumns=null;
	 var saveData="";
	 $(document).ready(function()
	{  
        $('#impForm').ajaxForm({
        beforeSubmit: function() {
            setErrorMessage('Uploading the file...pls Wait');
        },
        success: function(data) {
            var columnData=eval('('+data+')');
            if("Success"==columnData.data.result){
        	var str="<table><tr><th style='text-align:center'>Import Field</th><th style='text-align:center'>Excel Field</th></tr>";
            migcolumns=columnData.data.migcolumns;
            datacolumns=columnData.data.datacolumns;
            var migLen=migcolumns.length;
            var sheetLen=datacolumns.length;
            for(i=0;i<migLen;i++){
            	var styleName="";
            	if(migcolumns[i][2]=='1'){
            		styleName="";
            	}
            	str=str+"<tr><td class='"+styleName+"'>"+migcolumns[i][1]+"</td><td><select name='mapping' id='"+migcolumns[i][0]+"'><option value='-1'>Not Mapped</option>";
            	for(j=0;j<sheetLen;j++){
            		if(datacolumns[j][0]==migcolumns[i][3]){
            			str=str+"<option value='"+datacolumns[j][1]+"' selected>"+datacolumns[j][0]+"</option>";
            		}else{
            			str=str+"<option value='"+datacolumns[j][1]+"'>"+datacolumns[j][0]+"</option>";
            		}	
            	}
            	str=str+"<td></tr>";
            }
            $('#uid').attr("value",columnData.data.uploadno);
            $('#step_21').html(str);
            $('#step_21').append("<a class='butt_sav' id='importData' value='Next' onclick='dataImportCall()'>Next</a><a class='butt_can' id='cancel' onclick='cancelAll()'>Cancel</a>");
            closeError();
            $('#step_1').css("display","none");
            $('#step_2').css("display","block");
            $('#header li').eq(0).removeClass('selected');
            $('#header li').eq(1).addClass('selected');
            }else{
            	setErrorMessage(columnData.data.result);
            }
        }
    });
})    
function uploadFile(){
	var importFileName=$.trim($("#fileUpload").val());
	if(importFileName.indexOf("\\")){
		importFileName=importFileName.substr(importFileName.lastIndexOf('\\')+1);
	}	
	var ext=importFileName.substr(importFileName.lastIndexOf('.')+1).toLowerCase();
	if(ext=='xls' || ext=='csv'){
		$("#fileName").attr("value",importFileName);
		$("#impForm").submit();
	}else{
		alert("Please upload xs,csv formats only");	
	}
}
function dataImportCall(){
	var res=validateColumnMapping();
	if("Success"==res){
		$("#mappingForm").submit();
		}else{
			alert(res);
		}
}
function validateColumnMapping(){
	var result="Success";
	var comma="";
	saveData='savedata={"type":"mapping","usercode":"'+<%=userCode%>+'","importid":"'+<%=importId%>+'","uploadid":"'+$("#uid").val()+'","filename":"'+$("#fileName").val()+'","data":[';
	$.each($('select[name="mapping"]'), function() {
		var id=$(this).attr("id");
  		if($(this).val()==-1 && migcolumns[id][2]=='1'){
			result="Mapping for  the field :"+migcolumns[id][1]+" is missing. Kindly map the field to continue"; 			
  		}else{
  			saveData+=comma+'["'+id+'","'+$(this).val()+'","'+$(this).find('option:selected').text()+'"]';
  			comma=",";
  		}
	});
	saveData+="]}";
	return result;
}
function cancelAll(){
	saveData='savedata={"type":"cancel","usercode":"'+<%=userCode%>+'","importid":"'+<%=importId%>+'","uploadid":"'+$("#uid").val()+'","filename":"'+$("#fileName").val()+'"}';
	$.ajax({
			url:"dataImportSave.servlet",
			data:saveData,
			type: "POST",
			success: function(data){
			if("Success"==data){
					clearScreen(false);
				 }else{
				 	setErrorMessage(data);
				 }
				}
			});
}
function clearScreen(save){
	if(!save){
	 closeError();
	 }
	 $('#step_21').html("");
	 $('#step_31').html("");
	 $('#fileName').val("");
	 $("#fileUpload").val("");
	 $('#step_1').css("display","block");
	 $('#step_2').css("display","none");
	 $('#step_3').css("display","none");
	 $('#header li').eq(0).addClass('selected');
	 $('#header li').eq(1).removeClass('selected');
	 $('#header li').eq(2).removeClass('selected');
}
function importAllData(){
	saveData='savedata={"type":"save","usercode":"'+<%=userCode%>+'","importid":"'+<%=importId%>+'","uploadid":"'+$("#uid").val()+'","filename":"'+$("#fileName").val()+'"}';
	$.ajax({
			url:"dataImportSave.servlet",
			data:saveData,
			type: "POST",
			success: function(data){
			if("Success"==data){
				 setErrorMessage("Data imported Successfully");
				 clearScreen(true);
				 }else{
				 	setErrorMessage(data);
				 }
				}
			});
}
$('#mappingForm').submit(function() {
		$.ajax({
			url:"dataImportSave.servlet",
			data:saveData,
			type: "POST",
			success: function(data){
            		var importDetail=eval('('+data+')');
            		if("Success"==importDetail.data.result){
	            		var str="<table>";
	            		str=str+"<tr><th colspan='2'><b>Number of Rows ready to be imported : ";
	            		var noOfRowstoImport=importDetail.data.rowstoimport;
	            		str=str+noOfRowstoImport+"</b></th></tr>";
	            		var invalidRows=importDetail.data.invalidrows;
	            		var len=invalidRows.length;
	            		str=str+"<tr><th colspan='2'><b> Number of invalid Rows : ";
	            		str=str+len+"</b></th>";
	            		if(len>0){
		            		str=str+"<tr><th>Row</th><th>Reason</th></tr>";
		            		for(k=0;k<len;k++){
		            			str=str+"<tr><td>";
		            			str=str+invalidRows[k][0];
		            			str=str+"</td><td>";
		            			str=str+invalidRows[k][1];
		            			str=str+"</tr>";
		            		}
		            	}
		            	$('#step_31').html(str);
		            	$('#step_31').append("<a href='#' id='importAll' class='butt_sav' value='Import' onclick='importAllData()'>Import</a><a id='cancel_3' class='butt_can' onclick='cancelAll()'>Cancel</a>");
		            	closeError();
           	            $('#step_2').css("display","none");
			            $('#step_3').css("display","block");
			            $('#header li').eq(2).addClass('selected');
			            $('#header li').eq(1).removeClass('selected');
		            }else{
		            	setErrorMessage(columnData.data.result);
		            }
				}
			});
		return false;
});
</script>
</body>
</html>