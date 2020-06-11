<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="com.nora.schools.*" %>
<%@ page import=" java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<%
    User user = (User) session.getAttribute("user");
    if(request.getParameter("submit") != null)
    {
        int courseId = Utils.parseInt(request.getParameter("course_id"));
        System.out.println("Received ID: " + courseId);
        String course = request.getParameter("course");
        int fee = Utils.parseInt(request.getParameter("fee")); 
        int maxStudents = Utils.parseInt(request.getParameter("maxStudents"));
        Date startDate = Utils.stringToSqlDate(request.getParameter("start_date"));
        Date endDate = Utils.stringToSqlDate(request.getParameter("end_date"));
        
        Course c = Course.getById(courseId);
        System.out.println("Course ID : " + c.getCourseId());
        if(c != null){
            c.setCourseName(course);
            c.setFee(fee);
            c.setMaxStudents(maxStudents);
            c.setStartDate(startDate);
            c.setEndDate(endDate);
            c.save();
            
        }
        response.sendRedirect("teacher.jsp");
    } 
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teacher Page</title>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <link href="css/teacher.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1>Update</h1>
        <div class="row">
            <div class="col-sm-4">  
                <form method="POST" action="#" >
                    <%
                        String dbUrl = "jdbc:mysql://127.0.0.1:3306/school";
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(dbUrl,"root", "root");
                        int course_id = Utils.parseInt(request.getParameter("course_id"));
                        ResultSet result = DB.selectCourseToUpdate(course_id);
                        while(result.next())
                        {

                    %>
                       
                    <input type="hidden" name="id" value="<%=course_id%>">    
                    <div>
                        <label class="form-label"> Course </label>
                        <input type="text" class="form-control" placeholder="Course" name="course" value= "<%=result.getString("course_name")%>" id="course" required>    
                    </div> 
                    <div>
                        <label class="form-label"> Fee </label>
                        <input type="text" class="form-control" placeholder="Fee" name="fee" value= "<%=result.getString("fee")%>" id="fee" required>    
                    </div> 
                    <div class="form-group">
                        <label class="control-label">Max Students</label>
                        <input type="text" name="maxStudents" class="form-control" value= "<%=result.getString("maxStudents")%>" required>
                    </div>
                    <div class="form-group date" data-provide="datepicker">
                        <label class="control-label">Start</label>
                        <input type="text" class="form-control" id="datepicker1" name="start_date"   value= "<%=result.getString("start_date")%>">
                        <div class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                        </div>
                        
                    </div>
                   
                    <div class="form-group date" data-provide="datepicker">
                        <label class="control-label">End Date</label>
                        <input type="text" class="form-control" id="datepicker2" name="end_date"  value= "<%=result.getString("end_date")%>" >
                        <div class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                        </div>
                        
                    </div>
                    <%
                        }
                    %>
                    
                    </br>
                    <div>
                        <input type="submit" id="submit" value="submit" name="submit" class="btn-info"> 
                       
                        <input type="reset" id="reset" value="reset" name="reset" class="btn-warning"> 
                    </div> 
                    
                    <div align="right">
                        <p><a href="teacher.jsp">Back</a></p>
                        
                    </div>
                </form>
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
