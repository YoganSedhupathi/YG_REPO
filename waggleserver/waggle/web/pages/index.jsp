<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title>CISSOL Technologies</title>
	<meta charset="utf-8" name="viewport" content= "width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="images/titleicon.gif">
  	<link rel="icon" href="images/titleicon.gif">
   
     <!-- plugins:css -->
    <link rel="stylesheet" href="assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="assets/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="assets/vendors/jvectormap/jquery-jvectormap.css">
    <!-- End plugin css for this page -->
    <!-- Bootstrap css for this page -->
	
    <link rel="stylesheet" href="assets/css/demo/bootstrap.min.css">
	<link rel="stylesheet" href="assets/css/demo/bootstrap-datepicker.css">
	
	
    <!-- End Bootstrap css for this page -->
    <!-- Layout styles -->
	
	 
    <link rel="stylesheet" href="assets/css/demo/style.css">
	<link rel="stylesheet" href="assets/css/demo/custom_style.css">
	
	<link rel="stylesheet" href="assets/css/demo/ui.jqgrid-bootstrap.css" type="text/css"/>
	<link rel="stylesheet" href="assets/css/demo/searchFilter.min.css" type="text/css"/>
	<link rel="stylesheet" href="assets/css/demo/xgrid.css" type="text/css"/>
	
    <!-- End layout styles -->

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]
	 -->

	  <!-- Bootstrap js for this page-->
	<script type="text/javascript" src="assets/vendors/js/vendor.bundle.base.js"></script>  
	<script type="text/javascript" src="js/popper.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="js/autocomplete.js"></script>

	
	
    <!-- End Bootstrap js for this page-->
	

	<!-- Component js for this page-->
	<script type="text/javascript" src="js/jqgrid/i18n/grid.locale-en.js"></script>
	<script type="text/javascript" src="js/jqgrid/jquery.jqGrid.min.js"></script>

	
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

	<script src="assets/js/dashboard.js"></script>
    <script src="assets/js/key-bindings.js"></script>
	
</head>

<body >
	<script src="assets/js/preloader.js"></script>
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
	
<div class="body-wrapper">
<div class="loader1" id="divLoading" style="display:none">
    <div class="circles">
    		Loading...
    </div>
</div>


		<header class="mdc-top-app-bar">
            <div class="mdc-top-app-bar__row">
                <div class="col-sm-11">
                    <div class="mdc-top-app-bar__section mdc-top-app-bar__section--align-start w-100">
                        <div class="row w-100">
                            <div class="col-md-1">
                                <div class="mdc-drawer__header">
                                    <a href="index.html" class="brand-logo">
                                        <img src="assets/images/logo.png" alt="logo">
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-2 d-flex align-items-center">
                                <h4 class="mb-0 header-title">Quikue</h4>
                            </div>
							
                            <div class="col-md-4 col-lg-3 align-items-left ms-auto">
                                <div class="input-group d-flex align-items-center h-100">
                                
                                    <select  aria-label="Branch" class="form-control form-select" id="branch" onchange="changeBranchCodeAndClearSubScreenData()">
                                        <option value="S">Select Branch</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-1 d-flex align-items-center">
                    <div
                        class="mdc-top-app-bar__section mdc-top-app-bar__section--align-end mdc-top-app-bar__section-right">
                        <div class="menu-button-container menu-profile d-none d-md-block">
                            <button class="mdc-button mdc-menu-button">
                                <span class="d-flex align-items-center">
                                    <span class="figure">
                                        <img src="assets/images/faces/face1.jpg" alt="user" class="user">
                                    </span>
                                </span>
                            </button>
                            <div class="mdc-menu mdc-menu-surface" tabindex="-1">
                                <ul class="mdc-list" role="menu" aria-hidden="true" aria-orientation="vertical">
                                    <li class="mdc-list-item" role="menuitem">
                                        <div class="item-thumbnail item-thumbnail-icon-only">
                                            <i class="mdi mdi-settings-outline text-primary"></i>
                                        </div>
                                        <div
                                            class="item-content d-flex align-items-start flex-column justify-content-center">
                                            <h6 class="item-subject font-weight-normal">Logout</h6>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
		
		
		<!-- Construct Menu -->
		
		   <aside class="mdc-drawer mdc-drawer--dismissible">
            <div class="mdc-drawer__content">
                <div class="text-center">
                    <button
                        class="material-icons mdc-top-app-bar__navigation-icon mdc-icon-button sidebar-toggler">menu</button>
                </div>
                <div class="mdc-list-group">
                    <nav class="mdc-list mdc-drawer-menu" id="menu">
                        
                        
                    </nav>
                </div>
            </div>
        </aside>

	<!-- Menu Construction completed -->
	<!-- Loading Area --->
	<div id="contiF" class="main-wrapper mdc-drawer-app-content pt-2">
			<input type='hidden' id='currentMenuId' value='0'/>
            <div class="container-fluid px-2" id="bodyContainer">
                
			</div>
	</div>
	<!-- Loading Area Completed--->


</div>
	<div id="errorContainer" style='display:none;z-index:1001;' class="errorContainer">
		<div id="error" class="error">
			<span class="errorContent"><b id='error-message'> check </b><a id='errorClose' onclick='closeError()' class='close'>&times</a></span>
		</div>
	</div>

	
	
		
	
	
	
	
	
	
 <script type="text/javascript">
 
 
  loadBranchData(false);
 
 var ajaxObj=new FlexUI.Ajax();
 var menuData=ajaxObj.callAjax("GET","/waggle/service/ajax","ic=0&id=usermenu&login_id=<%=userId%>");
		function constructMenu(m){
			var menus=m.data;
			var s=menus.length;
			for(var i=0;i<s;i++){
				var menu=menus[i];
				if(menu[2]=='0'){
					var l=$('#menu').append("<div class='mdc-list-item mdc-drawer-item' id='main_"+menu[0]+"'><a class='mdc-drawer-link' href='#' menucap='"+menu[1]+"' menuid='"+menu[0]+"' menulink='"+menu[3]+"' data-toggle='expansionPanel'  data-target='submenu_"+menu[1]+"'><i class='"+menu[4]+" mdc-list-item__start-detail mdc-drawer-item-icon'></i><span>"+menu[1]+"</span></a><div class='mdc-expansion-panel' id='submenu_"+menu[1]+"'><nav class='mdc-list mdc-drawer-submenu' id='submenulist_"+menu[0]+"'></nav></div></div>");
				}else{
					var ul=$('#submenulist_'+menu[2]);
					ul.append($("<div class='mdc-list-item mdc-drawer-item'><a class='mdc-drawer-link' href='#' menuid='"+menu[0]+"' onclick=\"menuClick(this,'"+menu[3]+"')\">"+menu[1]+"</a></div>"));
				}

			}
			
		}

 		
		function changeBreadCrumb(l1,l2){
			$('#breadcrumbl1').html(l1);
			$('#breadcrumbl2').html(l2);
		}
		function menuClick(a,m){
			
			
			localStorage.setItem("fromdate","");
	localStorage.setItem("todate","");

			if(m!='#'){
				var mn=$(a).html();
				var pn=$(a).attr('pn');
				var menuId=$(a).attr('menuid');
				if(m!=null && m!="" && m!="#"){
					alert(m);
					if(menuId==1100001){
						if(window.confirm("Do you want to exit the application?")){
							$("#bodyContainer").html("");
							$("#bodyContainer").load("/waggle"+m,onSuccess);
							$("#currentMenuId").val(menuId);
						}
					}else if(menuId!=310005){
						$("#bodyContainer").html("");
						$("#bodyContainer").load("/waggle"+m,onSuccess);
						$("#currentMenuId").val(menuId);
					}else{
						window.open("/waggle"+m,"touch","fullscreen=yes,location=no,menubar=no,titlebar=no,toolbar=no");
					}
				}
				//showSideMenu(2);
				
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