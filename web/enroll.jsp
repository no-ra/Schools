<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="com.nora.schools.*" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null || user.isTeacher()){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%
        int course_id = Utils.parseInt(request.getParameter("course_id"));
        if(course_id > 0) {
            DB.enrollCourse(user.getUserId(),course_id);   
        }
        response.sendRedirect("index.jsp");
      
%>
