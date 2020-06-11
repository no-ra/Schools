<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="com.nora.schools.*" %>
<%
    String firstname = request.getParameter("firstname");
    String lastname = request.getParameter("lastname");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String password2 = request.getParameter("password2");
    int usertype = request.getParameter("usertype").equals("1") ? 1 : 0;
    if(!( Utils.isNullOrEmpty(username) || Utils.isNullOrEmpty(password) || Utils.isNullOrEmpty(password2) ))
    {
        if(password.equals(password2))
        {
            ResultSet rs = DB.signUp(firstname,lastname,usertype,username,password);  
            if(rs.next()){
               int user_id = rs.getInt(1);
               out.write("USER ID : "+user_id);
                
                User user = new User(user_id, username, firstname, lastname, usertype);
                session.setAttribute("user", user);
                if(user.isTeacher())
                    response.sendRedirect("teacher.jsp");
                else
                    response.sendRedirect("index.jsp");
            }
            else{
                response.sendRedirect("signup.jsp");
            }
            
        }
        else
            response.sendRedirect("signup.jsp");
    } else {
        response.sendRedirect("signup.jsp");
    }
    
%>