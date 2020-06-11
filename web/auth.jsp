<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="com.nora.schools.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Page</title>
    </head>
    <body>
<%
Class.forName("com.mysql.jdbc.Driver");
if(request.getParameter("login") != null){
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    User user = DB.login(username, password);
    if(user != null){
        session.setAttribute("user", user);
        if(user.isTeacher() == true){
            response.sendRedirect("teacher.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
    
}
%>

    </body>
</html>
