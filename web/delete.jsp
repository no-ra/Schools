<%@page import="java.sql.*"%>
<%@ page import="com.nora.schools.*" %>

<%
        int id = Utils.parseInt(request.getParameter("course_id"));
        if(id > 0) {
            DB.deleteCourse(id);
        }
        response.sendRedirect("teacher.jsp");
%>
