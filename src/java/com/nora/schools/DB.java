/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nora.schools;

import java.sql.*;

public class DB {
    private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/school";
    private static Connection con;
    
    public static Connection getCon() throws ClassNotFoundException, SQLException {
        if(con == null){
            con = DriverManager.getConnection(DB_URL, "root", "root");
        }
        return con;
    }
    
    public static User login(String username, String password) 
        throws ClassNotFoundException, SQLException {
        
        String sql = 
            "SELECT user_id, firstname, lastname, usertype from users " + 
            "WHERE username = ? AND password = ?";
        PreparedStatement pst = getCon().prepareStatement(sql);
        pst.setString(1, username);
        pst.setString(2, password);
        ResultSet rs = pst.executeQuery();
        if(rs.next()) {
            String firstname = rs.getString("firstname");
            String lastname = rs.getString("lastname");
            int user_id = rs.getInt("user_id");
            int usertype = rs.getInt("usertype");
            return new User(user_id, username, firstname, lastname, usertype);
        } else {
            return null;
        }
    }
    
    public static boolean addUser(){
        return false; //TODO
    }
    
    public static void deleteCourse(int course_id) throws ClassNotFoundException, SQLException {
        String sql = "DELETE FROM course WHERE course_id = ?";
        PreparedStatement pst = getCon().prepareStatement(sql);
        pst.setInt(1, course_id);
        pst.executeUpdate();
    }
    
    //Student's methods
    public static ResultSet enrolledCourses(int userId)throws ClassNotFoundException, SQLException {
        String sql= "SELECT * FROM course " + 
                    "INNER JOIN student_course " + 
                    "ON course.course_id = student_course.course_id Where user_id = ?"; 
        PreparedStatement ps = getCon().prepareStatement(sql);
        ps.setInt(1,userId);   
        return ps.executeQuery();
        
    }
    public static ResultSet availableCourses(int userId)throws ClassNotFoundException, SQLException {
        String query =  "   SELECT " +
                        "	c.teacher_id, " +
                        "	c.course_name, " +
                        "	c.course_id, " +
                        "	c.fee, " +
                        "	c.start_date, " +
                        "       c.maxStudents, " +
                        "	c.end_date, " +
                        "	u.firstname," +
                        "	u.lastname," +
                        "	CASE " +
                        "		WHEN COUNT(sc.user_id) < c.maxStudents THEN 1" +
                        "		ELSE 0" +
                        "	END AS can_enroll" +
                        "       FROM course c" +
                        "   LEFT JOIN student_course sc " +
                        "   ON c.course_id = sc.course_id" +
                        "   INNER JOIN users u " +
                        "   ON u.user_id = c.teacher_id" +
                        "   WHERE c.course_id NOT IN" +
                        "   (SELECT course_id FROM student_course WHERE user_id = ?)" +
                        "   GROUP BY c.course_id";
        PreparedStatement pst = con.prepareStatement(query);
        pst.setInt(1,userId);
        return pst.executeQuery();
    }
    
    
    public static ResultSet countCourses()throws ClassNotFoundException, SQLException {
        String sql= "SELECT COUNT(course_id) AS nrCourses FROM student_course GROUP BY course_id";
        PreparedStatement ps = getCon().prepareStatement(sql);  
        return ps.executeQuery();
        
    }
    
   
    public static void enrollCourse(int userId, int course_id)throws ClassNotFoundException, SQLException {
        PreparedStatement pst = con.prepareStatement("Insert into student_course(user_id,course_id) values(?,?)");
        pst.setInt(1, userId);
        pst.setInt(2, course_id);
        pst.executeUpdate();         
    }
    
    
    //Teacher's methods
    public static void addCourse(String course,int userId,int fee,int maxStudents, Date startDate,Date endDate)throws ClassNotFoundException, SQLException {
        PreparedStatement pst = 
             getCon().prepareStatement("INSERT INTO course(course_name, teacher_id, fee,maxStudents, start_date,end_date) VALUES(?,?,?,?,?,?)");
        pst.setString(1, course);
        pst.setInt(2, userId);
        pst.setInt(3, fee);
        pst.setInt(4, maxStudents);
        pst.setDate(5, startDate);
        pst.setDate(6, endDate);
        pst.executeUpdate();   
    }
    
    public static ResultSet getCourses(int userId)throws ClassNotFoundException, SQLException {
        String query = 
        "SELECT course_id,course_name, fee,maxStudents, DATE_FORMAT(start_date, '%d-%m-%Y') AS start_date, DATE_FORMAT(end_date, '%d-%m-%Y') AS end_date  FROM course " + 
        "INNER JOIN users " + 
        "ON course.teacher_id = users.user_id " + 
        "WHERE user_id = ?";
        PreparedStatement pst = getCon().prepareStatement(query);
        pst.setInt(1,userId);
        return  pst.executeQuery();
    }
    
    public static void updateCourse(String course,int fee,int maxStudents,Date startDate,Date endDate,int id )throws ClassNotFoundException, SQLException {
        PreparedStatement pst = getCon().prepareStatement("UPDATE course SET course_name=?,fee=?,maxStudents = ? ,start_date = ?, end_date = ?  WHERE course_id = ?");
        pst.setString(1, course);
        pst.setInt(2, fee); 
        pst.setInt(3, maxStudents);
        pst.setDate(4, startDate);
        pst.setDate(5, endDate);
        pst.setInt(6, id);
        pst.executeUpdate();
    }
    
    public static ResultSet selectCourseToUpdate(int course_id)throws ClassNotFoundException, SQLException {
        PreparedStatement pst = getCon().prepareStatement("SELECT course_id,course_name,maxStudents,teacher_id,fee, DATE_FORMAT(start_date, '%d-%m-%Y') AS start_date, DATE_FORMAT(end_date, '%d-%m-%Y') AS end_date FROM course WHERE course_id = ?");
        pst.setInt(1, course_id );
        return pst.executeQuery();
    }
    
    
    public static ResultSet signUp(String firstname,String lastname,int usertype,String username,String password)throws ClassNotFoundException, SQLException {
        String sql = 
                "INSERT INTO users(firstname, lastname, usertype, username, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement st = getCon().prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
            st.setString(1, firstname);
            st.setString(2, lastname);
            st.setInt(3, usertype);
            st.setString(4, username);
            st.setString(5, password);
            st.executeUpdate();
            return st.getGeneratedKeys();
    }
                     
                                
    
}
