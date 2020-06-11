<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="com.nora.schools.*" %>
<%@ page import=" java.text.SimpleDateFormat" %>
 

<%
    User user = (User) session.getAttribute("user");
    if(user == null || !user.isTeacher()){
        response.sendRedirect("login.jsp");
        return;
    }
    
    if(request.getParameter("submit") != null)
    {
        String name = request.getParameter("tname");
        String course = request.getParameter("course");
        int fee = Utils.parseInt(request.getParameter("fee")); 
        int maxStudents = Utils.parseInt(request.getParameter("maxStudents")); 
        Date startDate = Utils.stringToSqlDate(request.getParameter("start_date"));
        Date endDate = Utils.stringToSqlDate(request.getParameter("end_date"));
        
        Course c = new Course(user.getUserId(),course,fee,maxStudents,startDate,endDate);
        c.save();
        
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
            </br>
            <div class="row">
                <div class="col-md-1 offset-11">
                    <a href="logout.jsp" class="btn btn-danger">Logout</a>
                </div>
            </div>
            </br>
            <div class="row">
            <div class="col-sm-6">
                <form action="#" method="POST" role="form">
                    <div class="form-group">
                        <label class="control-label">Course Name</label>
                        <input type="text" name="course" class="form-control" placeholder="Course Name" value="" required>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Course Fee</label>
                        <input type="text" name="fee" class="form-control" placeholder="Course Fee" required>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Max Students</label>
                        <input type="text" name="maxStudents" class="form-control" placeholder="Max Students" required>
                    </div>
                    
                    <div class="form-group date" data-provide="datepicker">
                        <label class="control-label">Start</label>
                        <input type="text" class="form-control" id="datepicker1" name="start_date">
                        <div class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                        </div>
                        
                    </div>
                    
                   
                    <div class="form-group date" data-provide="datepicker">
                        <label class="control-label">End Date</label>
                        <input type="text" class="form-control" id="datepicker2" name="end_date">
                        <div class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                        </div>
                        
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12">
                                <input type="submit" value="Save" id="save" name="submit" tabindex="4" class="btn btn-info" >
                                <input type="reset" value="Reset" name="reset" tabindex="4" class="btn btn-warning" >
                            </div>
                        </div>
                    </div>
                   
                </form>
            </div>   
            
            <div class="col-sm-6">  
                <div class="panel-body">
                    <table class="table table-bordered table-striped">
                        <thead><tr>
                            <th scope="col">Teacher</th>
                            <th scope="col">Course</th>
                            <th scope="col">Fee</th>
                            <th scope="col">Max Students</th>
                            <th scope="col">Start Date</th>
                            <th scope="col">End Date</th>
                            <th scope="col">Edit</th>
                            <th scope="col">Delete</th>
                           
                        </tr></thead>
                        <tbody>
                        <%      
                            ResultSet result = DB.getCourses(user.getUserId());
                            while(result.next()){ 
                                
                        %>
                        <tr>
                            <td><%=user.getFullName()%></td>
                            <td><%=result.getString("course_name")%></td>
                            <td><%=result.getInt("fee")%></td>
                            <td><%=result.getInt("maxStudents")%></td>
                            <td><%=result.getString("start_date")%></td>
                            <td><%=result.getString("end_date")%></td>
                            <td><a href="update.jsp?course_id=<%=result.getString("course_id")%>">Edit</a></td>
                            <td><a href="delete.jsp?course_id=<%=result.getString("course_id")%>">Delete</a></td>
                        </tr>
                            
                        <%
                            }
                        %>
                    </tbody>
                    </table>
                </div>
            </div>     
        </div>
        </div> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>


        
        <script>
           $('#datepicker1').datepicker({
                dateFormat: 'dd-mm-yy',
                startDate: '-3d'
            });
            
            $('#datepicker2').datepicker({
                dateFormat: 'dd-mm-yy',
                startDate: '-3d'
            });
        </script>
    </body>
</html>
