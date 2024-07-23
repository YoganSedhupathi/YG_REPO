<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>CISSOL Technologies</title>
	<link rel="shortcut icon" href="images/titleicon.gif">
  	<link rel="icon" href="images/titleicon.gif">
	 <!-- <link rel="stylesheet" href="css/jquery-ui.css" type="text/css"/>
	 <link rel="stylesheet" href="css/jqgrid/ui.jqgrid.css" type="text/css"/>
	 <link href="css/styles.css" rel="stylesheet" type="text/css" />
	 <link href="css/style1.css" rel="stylesheet" type="text/css" />	 
	 
	  -->
	 
	 
	
    <link href="css/xgrid.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/jqgrid/ui.jqgrid.css" type="text/css"/>
     <link rel="stylesheet" href="css/jquery-ui.css" type="text/css"/>
     
     <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/icomoon.css" rel="stylesheet">
    <link href="assets/css/font-awesome.css" rel="stylesheet">
    
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link href="assets/css/custom.css" rel="stylesheet">
	 
	 
	 
	 <script type="text/javascript" src="js/jquery/jquery-1.8.3.min.js"></script>
	 <script src="js/jquery/jquery-ui.min.js"></script>
	<script src="js/jquery/jquery-ui-timepicker-addon.js"></script>
	<script src="js/jquery/jquery-ui-sliderAccess.js"></script>
	<script src="js/jqgrid/i18n/grid.locale-en.js"></script>
	<script src="js/jqgrid/jquery.jqGrid.min.js"></script>
	<script type="text/javascript" src="js/jqgrideditable.js"></script>
	<script type="text/javascript" src="js/core.js"></script>	 
	<script type="text/javascript" src="js/newtext.js"></script>
	
	<script type="text/javascript" src="js/table.js"></script>
	<script type="text/javascript" src="js/lov.js"></script>
	<script type="text/javascript" src="js/xgrid.js"></script>
	<script type="text/javascript" src="js/newscreen.js"></script>
	<script type="text/javascript" src="js/jqimpl.js"></script>
	<script type="text/javascript" src="js/actions.js"></script>
	<script type="text/javascript" src="js/dateextn.js"></script>
	<script type="text/javascript" src="js/constructscreen.js"></script>
	<script type="text/javascript" src="js/constructreport.js"></script>
	
	
	
</head>

<body >
	<%
		String userId=(String)session.getAttribute("LOGIN_ID");
		String src=(String)request.getParameter("src");
		if(src==null){
			src="";
		}
		String menuID=(String)request.getParameter("menuID");
		String subMenuID=(String)request.getParameter("subMenuID");
		String parameters=(String)request.getParameter("parameters");
		if(parameters==null){
			parameters="";
		}
	%>
		
		<div class="loader1" id="divLoading" style="display:none">
    	<div class="circles">
    		Loading...
    	</div>
		</div>
	<!--header-->
  	 <div class="header">
     <div class="container">
     
     <!--lft-->
     <div class="col-md-1 col-sm-1">
     <span class="cisLo"><img src="images/hv_logo.jpg" ></span>
     </div>
     <!--end lft-->
     <!--mdl-->
     <div class="col-md-8 col-sm-8">
     <ul id="menu">
	         
     </ul>
     </div>
     
	
     <!--end mdl-->
     <!--rht-->
     <div >
     <div class="col-md-3 col-sm-3">
     <div class="welic3"><span class="margRhtGap"><span class="icon-user welIC"></span> <%=userId%></span>
     <!--<a href="#" class="welic2"><span class=""><span class="fa fa-sign-out welIC"></span>Logout</span></a>--></div>
     </div>
     </div>
     <!--end rht-->
     </div>
     </div>
    <!--header-->
    
    <!--container-->
    <!--sidebar-->
    
    <div id="sidBar" class="sideBar2">
    <div class="">
    <div id="leftbar" class="" style="display:block">
    <ul id='leftmenu'>
     
    </ul>
    </div>
    <div id="leftbar1" class="sideBar sideBar2" style="display:none">
    <ul>
     <li ><a href="#" title="Show Menu" onclick="showSideMenu(1)" class="sideBarSel selMaAf"><span  class="fa fa-angle-double-right fa-6 arrFntSi" "></span></a></li>
    </ul>
    </div>
    </div>
    </div>
    <!--end sidebar-->
    <!--body container-->
    <div id="contiF" class="contiF">
    <div class="col-md-12 col-sm-12 mpZero">
    <div class="bodyCont">
    <input type='hidden' id='currentMenuId' value='0'/>
    <!--inner-->
    <div class="bodyContInner">
    
	<div class="clearfix"></div>
	<div id="bodyContainer" ></div>        
    </div>
    <!--end inner-->
    </div>
    
    </div>
    </div>
    <!--end body container-->
    
	
	<div id="errorContainer" style='display:none;z-index:1001;' class="errorContainer">
	<div id="error" class="error">
		<span ><b id='error-message'> check </b><a id='errorClose' onclick='closeError()' class='close'>&times</a></span>
	</div>
</div>
	
	
	
	
	
 <script type="text/javascript">
 var ajaxObj=new FlexUI.Ajax();
 var menuData=ajaxObj.callAjax("GET","/waggle/service/ajax","ic=0&id=usermenu&login_id=<%=userId%>");
		function constructMenu(m){
			var menus=m.data;
			var s=menus.length;
			for(var i=0;i<s;i++){
				var menu=menus[i];
				if(menu[2]=='0'){
					var l=$('#menu').append($("<li id='"+menu[0]+"'><a href='#' menucap='"+menu[1]+"' menuid='"+menu[0]+"' onclick=\"mainMenuClick(this)\" menulink='"+menu[3]+"'><b class='"+menu[4]+"'></b><span>"+menu[1]+"</span></a></li>"));
				/*}else{
					var ul=$('#w_'+menu[2]);
					if(ul[0]){
						ul.append($("<li id='"+menu[0]+"'><a href='#' style='padding-bottom: 5px; padding-top: 5px;' onclick=\"menuClick('/eprocure"+menu[3]+"')\">"+menu[1]+"</a></li>"));
					}else{
						ul=$("<ul id='w_"+menu[2]+"'></ul>");
						$('#'+menu[2]).append(ul);
						ul.append($("<li id='"+menu[0]+"'><a href='#' style='padding-bottom: 5px; padding-top: 5px;' onclick=\"menuClick('/eprocure"+menu[3]+"')\">"+menu[1]+"</a></li>"));
					}*/
				}
			}
			if(<%=menuID%>!=null){
				$('#menu').find('li>a[menuid="<%=menuID%>"]').click();
			}else{
				$('#menu').find('li').eq(0).find('a').click();
			}
		}
		function mainMenuClick(h){
			var p=$(h).attr('menuid');
			var pn=$(h).attr('menucap');
			var menuLink=$(h).attr('menulink');
			var menus=menuData.data;
			var s=menus.length;
			if(menuLink!="#" && menuLink!=null && menuLink!="null" && menuLink!=""){
				window.open(menuLink);
			}else{
				var ul=$('#leftmenu');
				ul.html("");
				ul.append("<li ><a href='#' title='Hide Menu' onclick='showSideMenu(0)' class='sideBarSel selMaAf'><span class='fa fa-angle-double-left fa-6 arrFntSi'></span></a></li>");
				for(var i=0;i<s;i++){
					var menu=menus[i];
					if(menu[2]==p){
						if(ul.find('li').length==0){
							ul.append("<li><a href='#' menuid='"+menu[0]+"' pn='"+pn+"' class='menuSel' onclick='menuClick(this,\""+menu[3]+"\")' ><span class='"+menu[4]+"'></span>"+menu[1]+"</a></li>");
							//changeBreadCrumb(pn,menu[1]);									
						}else{
							ul.append("<li><a href='#' menuid='"+menu[0]+"' pn='"+pn+"' onclick='menuClick(this,\""+menu[3]+"\")'><span class='"+menu[4]+"'></span>"+menu[1]+"</a></li>");
						}
					}
				}
				if(<%=menuID%>!=null){
					$('#menu').find('li>a').attr('class','');
					$(h).attr('class','menuSel');
					ul.find('li>a[menuid="<%=subMenuID%>"]').click();					
				}else{
					showSideMenu(1);
	    
					$('#menu').find('li>a').attr('class','');
					$(h).attr('class','menuSel');
					ul.find('li>a').eq(1).click();
				}
			}
		}
		function changeBreadCrumb(l1,l2){
			$('#breadcrumbl1').html(l1);
			$('#breadcrumbl2').html(l2);
		}
		function menuClick(a,m){
			if(m!='#'){
				var mn=$(a).html();
				var pn=$(a).attr('pn');
				var menuId=$(a).attr('menuid');
				$('#leftmenu').find('li>a').attr('class','');
				$(a).attr('class','sideBarSel');
				//changeBreadCrumb(pn,mn);
				//document.getElementById('frame').src=m;
				if(m!=null && m!="" && m!="#"){
					$('.ui-dialog').children().remove();
					$('.ui-dialog').remove();
					$("#bodyContainer").children().remove();
					$("#bodyContainer").html("");
					$("#bodyContainer").load("/waggle"+m+decodeURI("<%=parameters%>"),onSuccess);
					$("#currentMenuId").val(menuId);
				}
				showSideMenu(2);
				
			}
		}
		constructMenu(menuData);
		
		var sourceLink='<%=src%>';
		if(sourceLink!='' && sourceLink!=null){
			menuClick(sourceLink);
		}
		function onSuccess(){
			var menuId=$("#currentMenuId").val();
			if(menuId=='910001' || menuId=='910002' || menuId=='500001'){
				var actions=new FlexUI.Actions(menuId,'addGrp','saveGrp');
				actions.buildActions();
			}									
		}
		function closeError(){
			$("#errorContainer").fadeOut();
		  }
		  function setErrorMessage(err){
			$("#error-message").html(err);
			if(!$("#error").is(":visible")){
				runEffect();
			}
		  }
		  function runEffect() {
			$("#errorContainer").show();
			var count = 5;
			countdown = setInterval(function(){
    				if (count ==0) {
      					clearInterval(countdown);
      					closeError();
    				}
    				count--;
  					}, 1000);
		  }
		  function showSideMenu(show){
			  if(show==1) {
					$('#sidBar').removeClass("sideBar2");
				    $('#sidBar').addClass("");
				    $('#leftbar').removeClass("sideBar sideBar2");
				    $('#leftbar').addClass("sideBar");
				    $('#contiF').removeClass("contiF2");
				    $('#contiF').addClass("contiF");
				    $('#leftbar1').css("display","none");
				    $('#leftbar').css("display","block");
			  }else{
			  		$('#sidBar').removeClass("sideBar2");
				    $('#sidBar').addClass("sideBar2");
				    $('#leftbar').removeClass("sideBar sideBar2");
				    $('#leftbar').addClass("sideBar sideBar2");
				    $('#contiF').removeClass("contiF2");
				    $('#contiF').addClass("contiF2");
	    			$('#leftbar1').css("display","block");
	    			$('#leftbar').css("display","none");
			  }
		  }		  		  
</script>
</body>
</html>