<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="com.nora.schools.*" %>

<%
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teacher Page</title>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <link href="css/teacher.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        
        <div class="container">
            <div class="row">
                <div class="col-md-1 offset-11">
                    <a href="logout.jsp" class="btn btn-danger">Logout</a>
                </div>
            </div>
        <div class="row">
            
            <div class="col-sm-6"> 
                 <div class="panel-body">
                    <h3> Enrolled Courses </h3>
                    <table id="tbl-student" class="table table-responsive table-bordered" cellpadding="0" width="100%">
                        <table class="table table-bordered table-striped">
                        <thead><tr>
                            <th scope="col">Student</th>
                            <th scope="col">Enrolled Course</th>
                            <th scope="col">Fee</th>
                            <th scope="col">Start Date</th>
                            <th scope="col">End Date</th>
                          
                        </tr></thead>
                            <% 
                                ResultSet resultSet = DB.enrolledCourses(user.getUserId());          
                                while(resultSet.next()){
                            %>
                            <tr>
                               
                                <td><%=user.getFullName()%></td>
                                <td><%=resultSet.getString("course_name")%></td>
                                <td><%=resultSet.getString("fee")%></td>
                                <td><%=resultSet.getString("start_date")%></td>
                                <td><%=resultSet.getString("end_date")%></td>
                                
                                
                            </tr>
                            
                            <%
                                }
                            %>
                    </table>
                </div>
                
            </div>   
            
            <div class="col-sm-6">  
                <div class="panel-body">
                    <h3> Available Courses </h3>
                    <table id="tbl-student" class="table table-responsive table-bordered" cellpadding="0" width="100%">
                        <table class="table table-bordered table-striped">
                        <thead><tr>
                            <th scope="col">Teacher</th>
                            <th scope="col">Course</th>
                            <th scope="col">Fee</th>
                            <th scope="col">Start Date</th>
                            <th scope="col">End Date</th>
                            <th scope="col">Enroll</th>
                           
                           
                        </tr></thead>
                            
                            <% 
                               ResultSet result = DB.availableCourses(user.getUserId());
                               while(result.next()){
                               boolean can_enroll = result.getInt("can_enroll") == 1;
                                    
                            %>
                            <tr class="<%= !can_enroll ? "table-warning" : ""%>">
                               
                                <td><%=result.getString("firstname")%></td>
                                <td><%=result.getString("course_name")%></td>
                                <td><%=result.getInt("fee")%></td>
                                <td><%=result.getDate("start_date")%></td>
                                <td><%=result.getDate("end_date")%></td>
                                <% 
                                    if(can_enroll) {
                                %>
                                <td><a href="enroll.jsp?course_id=<%=result.getInt("course_id")%>">Enroll</a></td>
                                <%
                                   } else { 
                                %>
                                <td class="table-warning">Full</td>
                            </tr>
                             <%
                             } 
                             %>
                            
                            
                            <%
                             } 
                            %>
                    </table>
                </div>
            </div>     
        </div>
        </div>
    </body>
</html>
