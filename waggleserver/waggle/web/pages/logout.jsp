<%@page import="com.cissol.core.servlet.InitProjectServlet"%>
<%
	String context=InitProjectServlet.context;
%>
<html>
    <head><title>CISSOL Software Technologies</title></head>
    <body>
		
			<%
			session.invalidate();
			%>
		
    	<script>
    		window.location.href='<%=context%>';   
    	</script>
    </body>
</html>











