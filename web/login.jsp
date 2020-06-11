<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.nora.schools.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");
    User user = (User) session.getAttribute("user");
    if(user != null){
        if(user.isTeacher())
            response.sendRedirect("teacher.jsp");
        else
            response.sendRedirect("index.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/login.css" rel="stylesheet" type="text/css"/>
        <title>School</title>
    </head>
    <body>
        <div class="container">
        <div class="row">
            
            <div class="col-md-6 col-md-offset-3">
                <div class="panel panel-login">
                    <div class="panel-heading">
                        <div class="row">
                          <div class="col-md-6">
                                <a href="#" class="active" id="login-form-link">Login</a>
                            </div>
                            <div class="col-md-6">
                                <a href="#" id="register-form-link">Register</a>
                            </div>
                        </div>
                    </div>
                    
                    <hr/>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <form id="login-form" action="auth.jsp" method="post" role="form" style="display: block;">
                                    <div class="form-group">
                                        <input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Username" value="">
                                    </div>
                                    <div class="form-group">
                                        <input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Password">
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-6 offset-md-3">
                                                <input  type="submit" id="login" value="Login" name="login" tabindex="4" class="form-control btn btn-login" value="Log In">
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <form id="register-form" action="signup.jsp" method="post" role="form" style="display: none;">
                                    <div class="form-group">
                                        <label>First Name</label>
                                        <input type="text" name="firstname" tabindex="1" class="form-control" placeholder="First Name" value="">
                                    </div>
                                    <div class="form-group">
                                        <label>Last Name</label>
                                        <input type="text" name="lastname"  tabindex="2" class="form-control" placeholder="Last Name" value="">
                                    </div>

                                    <div class="form-group">
                                        <label>Username</label>
                                        <input type="text" name="username" tabindex="3" class="form-control" placeholder="Username" value="">
                                    </div>
                                    <div class="form-group">
                                        <label>Password</label>
                                        <input type="password" name="password" tabindex="4" class="form-control" placeholder="Password">
                                    </div>
                                    <div class="form-group">
                                        <label>Confirm Password</label>
                                        <input type="password" name="password2" tabindex="5" class="form-control" placeholder="Confirm Password">
                                    </div>
                                    <div class="form-group">
                                        <select name="usertype" class="form-control">
                                            <option value="0">Student</option>
                                            <option value="1">Teacher</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-6 offset-md-3">
                                                <input type="submit" value="Register" name="register" tabindex="4" class="form-control btn btn-register" >
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</div>
        

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/login.js" type="text/javascript"></script>
    </body>
    
</html>
