<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>CISSOL Technologies</title>
	<link rel="shortcut icon" href="images/titleicon.gif">
  	<link rel="icon" href="images/titleicon.gif">
	<link href="assets/css/bootstrap.css" rel="stylesheet">
        <link href="assets/css/icomoon.css" rel="stylesheet">
        <link href="assets/css/font-awesome.css" rel="stylesheet">
        <link href="assets/css/custom.css" rel="stylesheet">
		<style>
			*{
	   box-sizing: border-box;
	   padding: 0;
	   margin: 0;
	   font-family: 'Poppins', sans-serif;
   }
   
   body{
	   font-family: 'Poppins', sans-serif;
	   margin: 0;
	   background: url(https://images.unsplash.com/photo-1636955669242-11b90050e9ac?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D);
	   background-repeat: no-repeat;
	   background-size: 110%;
	   background-position: center;
   }
   
   
   .sign-in-container{
	   display: flex;
	   align-items: center;
	   flex-direction: row-reverse;
	   
   }
   .sign-column{
	   display: flex;
	   align-items: center;
	   justify-content: center;
	   text-align: center;
	   width: 50%;
	   font-size: 16px;
	   height: 100vh;
	  
   }
   
   
   .sign-in-title{
	   font-weight: 600;
	   font-size: 26px;
   }
   .sign-in-title{
	   margin-top: 50px;
   }
   .s2{
	  display: flex;
	  align-items: center;
	  justify-content: center;
	   padding: 50px 0;
	   overflow: auto;
	   background: #ffffff;
	   height: 97%;
	   width: 750px;
	   box-shadow: 0 0 25px #00000061;
	   border-radius: 8px;
   }
   .sign-in-title-alt{
	   color: #000;
	   
	   padding: 10px 0;
   }
   .sign-buttons{
	   display: flex;
	   justify-content: center;
	   flex-wrap: wrap;
	   gap: 12px;
	   padding: 25px 0;
   }
   .login-w-button{
	   display: flex;
	   justify-content: center;
	   align-items: center;
	   text-decoration: none;
	   gap: 10px;
	   border: 1px solid #3676FF;
	   background: #fff;
	   padding: 10px;
	   height: 40px;
	   width: 200px;
	   border-radius: 5px;
	   color: #222222;
	   transition: .3s ease all;
	   font-size: 14px;
	   box-shadow: 0 0 15px #00000020;
   }
   .login-w-button:hover{
	   background: #eef4ff;
	   border: 1px solid #a3c1f5;
	   box-shadow: 0 0 5px #00000020;
   }
   .slice-text-c{
	   position: relative;
	   display: flex;
	   align-items: center;
	   justify-content: center;
	   padding: 30px 0;
   }
   .slice-text{
	   color: #000;
	   background: #fff;
	   padding: 10px;
   }
   .slicer{
	   position: absolute;
	   height: 1px;
	   background: #e5e5e5;
	   width: 500px;
	   z-index: -1;
   }
   .input-container{
	   display: flex;
	   justify-content: center;
	   margin: auto;
	   gap: 20px;
	   flex-direction: column;
	   width: 400px;
   }
   .input-container input, .input-container button{
	   padding: 15px;
	   height: 40px;
	   border-radius: 5px;
	   outline: none;
	   border: 1px solid #3676FF;
	   box-shadow: 0 0 15px #00000020;
	   transition: .3s ease all;
   }
   .input-container input:focus{
	   border: 1px solid #3676FF;
	   background: #eff5ff;
   }
   .input-container button{
	   display: flex;
	   align-items: center;
	   justify-content: center;
	   background: #3676FF;
	   color: #fff;
	   cursor: pointer;
	   transition: .3s ease all;
   }
   .input-container button:hover{
	   box-shadow: 0 0 5px #00000020;
   }
   .alt-f-full{
	   color: #000;
	   font-size: 14px;
   }
   .alt-f {
	   color: #3676FF;
	   font-size: 14px;
	   text-decoration: none;
   }
   .footer-s{
	   position: absolute;
	   bottom: 30px;
	   display: flex;
	   gap:10px;
	   
   }
   .footer-s a{
	   color: #fff;
   }
   .sign-column:nth-child(2) {
	   position: relative;
	   display: flex;
	   align-items: center;
	   justify-content: space-around;
	   flex-direction: column;
	   
	 
   }
   input::placeholder{
	   color: #000;
	   
   }
   
   .intro-p{
	   color: #252525;
	   
	   max-width: 750px;
   }
   
   .intro-img{
   
	   height: 500px;
   }
   .intro-img img {
	   max-width: 600px;
   }
   /* Chrome, Safari, Edge, Opera */
   input::-webkit-outer-spin-button,
   input::-webkit-inner-spin-button {
	   -webkit-appearance: none;
	   margin: 0;
   }
   
   /* Firefox */
   input[type=number] {
	   -moz-appearance: textfield;
   }
   .canvas-logo{
	   background: #fff;
	   border-radius: 8px;
	   width: 350px;
	   box-shadow: 0 0 25px #00000061;
	   margin: 10px auto;
   
   }
   .canvas-logo img{
	   width: 100%;
   }
   .intro-title{
   
	   font-size: 18px;
	   padding: 10px 0;
	   color: #fff;
	  
   }
   
   
   .intro-title-alt{
	   color: #353535;
	   font-size: 16px;
   }
   .alt-f-full-ch{
	   display: flex;
	   align-items: center;
	   font-size: 14px;
	   gap: 5px;
	   
	   color: #000;
   }
   .alt-f-full-ch input{
	   box-shadow: 0 0 0;
   }
   
   /* @media only screen and (max-width: 1100px) {
	   body {
		   background: #fff;
	   }
   
	   .s2 {
		   display: flex;
		   align-items: start;
		   justify-content: center;
		   padding: 0px;
		   padding: 10px;
		   padding-top: 50px;
		   padding-bottom: 50px;
   
		   background: #ffffff;
		   height: auto;
		   width: 100%;
		   box-shadow: 0 0 0px #00000061;
		   border-radius: 0px;
	   }
   
	   .sign-column:nth-child(2) {
		   display: none;
	   }
   
	   .sign-column:nth-child(1) {
		   width: 100% !important;
		   height: auto;
	   }
   
	   .slicer {
		   width: 0px !important;
	   }
   
	   .login-w-button {
		   width: 100%;
	   }
   
	   .input-container {
		   display: flex;
		   justify-content: center;
		   margin: auto;
		   gap: 20px;
		   flex-direction: column;
		   width: 100%;
	   }
   }
   @media only screen and (max-height: 675px) {
	   body{
		   background: #fff;
	   }
	   .s2 {
			   display: flex;
			   align-items: start;
			   justify-content: center;
			   padding: 0px;
			   padding: 10px;
			   padding-top: 50px;
			   padding-bottom: 50px;
		   
			   background: #ffffff;
			   height: auto;
			   width: 100%;
			   box-shadow: 0 0 0px #00000061;
			   border-radius: 0px;
		   }
	   .sign-column:nth-child(2) {
		   display: none;
	   }
	   .sign-column:nth-child(1) {
		   width: 100% !important;
		   height: auto;
	   }
	   .slicer{
		   width: 0px !important;
	   }
	   .login-w-button{
		   width: 100%;
	   }
	   .input-container{
	   display: flex;
	   justify-content: center;
	   margin: auto;
	   gap: 20px;
	   flex-direction: column;
	   width: 100%;
   }
   } */
   .footer {
	  position: fixed;
	  left: 0;
	  bottom: 0;
	  width: 100%;
	  background-color:transparent;
	  color: rgb(253, 243, 243);
	  margin-left:15%;
	 
   }
	   </style>	
</head>
<body onload="setFocus()">	
<%@page import="com.cissol.core.servlet.InitProjectServlet"%>
<%String error=(String) request.getParameter("error"); 
	if(error==null){
		error="";
	}
	String host=request.getHeader("host");
	if (InitProjectServlet.isMultiTenant){
		host=host.replaceAll(":8080","");
		host=host.replaceAll(":8443","");
	}else{
		host="";
	}
%>
	<div id="error"><%=error%></div>
		
	<div class="sign-in-container">
		<div class="sign-column s1">
			<div class="sign-column-face s2">
				<div class="s3">
					<div class="">
						<img src="images/cissol_logo.png" alt="logo">
					</div>
					<!-- <div class="sign-header-section">
						<div class="sign-in-title " style="margin-bottom: 20px;">
							LOGIN
						</div>
					</div> -->
					
					<form class="input-container" method="post" action="j_security_check" name="loginform" onsubmit="return false">
						<input type="hidden" name="j_username" id="j_username" value=""/>
						<input type="text" class="form-control logInpBPad"  name="t_username" id="t_username" value="" placeholder="User Name" /> 
						<input type="password" class="form-control logInpBPad" name="j_password" id="j_password" value="" placeholder="Password" onkeydown='return handleElementKeyDown(this,event)'/>
						<a href="#" class="alt-f">
							Forgot Password ?
						</a>
						<button value="submit" class="btn" type="button" onclick="submit_page();">
							Sign in
						</button>
					</form>
				</div>
				
			</div>
		</div>
		
		<div class="sign-column w2">
			<div class="intro-p">
				<div class="">
					<img  src="images/q_svg.svg" alt="logo">
				</div>
				
			</div>
		</div>
		
		<div>
			<div class="footer" > Copyright  &copy; 2024 CISSOL Software Technologies Pvt Ltd</div>
		</div>
		
	</div>

    <!-- <div class="logiMt">
    <div class="logiLft">Procure, Manage, Dispatch & Sell your inventory online conveniently </div>
    <div class="">
    <div class="loginBg">
    <div class="loginInr">
    <div class="loginLog0Dw text-center"><img src="images/login_lgo.png"></div>
    <form method="post" action="j_security_check" name="loginform" onsubmit="return false" >
    <input type="hidden" name="j_username" id="j_username" value=""/>
    <div class="logInpB"><span class="icon-user logInpBIc"></span><input type="text" class="form-control logInpBPad"  name="t_username" id="t_username" value="" placeholder="User Name" /> </div>
    <div class="logInpB"><span class="fa fa-lock logInpBIc"></span><input type="password" class="form-control logInpBPad" name="j_password" id="j_password" value="" placeholder="Password" onkeydown='return handleElementKeyDown(this,event)'/></div>
    <div class=" pull-right"><a href="#" class="logFor">Forgot Password</a><button type="button" onclick="submit_page();" class="btn btn-default loginButt">Login</button></div>
    </form>
    </div>
    </div>
    </div>
    
    
    <div class=""></div>
    <div>
    <div class="footerTXT"><br> COPYRIGHT � 2014 CISSOL Technologies</div></div>
    <div class="footerTXT">
    
    <p></p>
    </div>
    </div>
		
		
		
		<%--<div class="log_wrapper">
    	<div class="log_comp_log"></div>
    	<div class="log_bck">
    	<div class="log_ico_top"></div>
		<form method="post" action="j_security_check" name="loginform" onsubmit="return false" >
						<ul id="log_txt_box">						
	  					<li><input type="hidden" name="j_username" id="j_username" value=""/></li>
	  					<li><input type="text" class="form_feild"  name="t_username" id="t_username" value="" placeholder="User Name" /></li>
	  					<li><input type="password" class="form_feild" name="j_password" id="j_password" value="" placeholder="Password" onkeydown='return handleElementKeyDown(this,event)'/></li>
					     <li><a href="#" onclick="submit_page();" class="log_butt">SIGN IN</a></li>
					     </ul>  
					</form>
		</div>
		</div>--%> -->
					
</body>
<script>
function handleElementKeyDown(t,e){
	var key=e.which || e.keyCode;
	if(key==13){
		submit_page();
		e.stopPropagation();
		e.preventDefault();
	}
	return true;	
}
var usrObj=document.getElementById('t_username');
var usrPasswd=document.getElementById('j_password');
 function submit_page(){
        if(usrObj.value.length==0){
		var enter_the_username="Enter the username";
         	alert(strToUnicode(enter_the_username));
         	usrObj.focus();
         	return;
        }
 	document.loginform.j_username.value="1"+"~"+usrObj.value;
	document.loginform.onsubmit='';
	document.loginform.submit();
}
function setFocus(){
		document.loginform.t_username.focus();
} 
</script>
</html>