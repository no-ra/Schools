package com.nora.schools;
import java.sql.*;

public class Course {
    
    private int courseId;
    private int teacherId;
    private String courseName;
    private int fee;
    private int maxStudents;
    private Date startDate;
    private Date endDate;
    
    public Course(int courseId,int teacherId,String courseName,int fee,int maxStudents,Date startDate, Date endDate){
        this.courseId = courseId;
        this.teacherId = teacherId;
        this.courseName = courseName;
        this.fee = fee;
        this.maxStudents = maxStudents;
        this.startDate = startDate;
        this.endDate = endDate;
    }
    
    public Course(int teacherId, String courseName, int fee, int maxStudents, Date startDate, Date endDate){
        this(0, teacherId, courseName, fee, maxStudents, startDate, endDate);
    }
    
    public static Course getById(int courseId) throws ClassNotFoundException, SQLException {     
        String sql = "SELECT * FROM course WHERE course_id = ?";
        PreparedStatement ps = DB.getCon().prepareStatement(sql);
        ps.setInt(1, courseId);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            String courseName = rs.getString("course_name");
            int fee = rs.getInt("fee");
            int maxStudents = rs.getInt("maxStudents");
            Date startDate = rs.getDate("start_date");
            Date endDate = rs.getDate("end_date");
            int teacherId = rs.getInt("teacher_id");
            return new Course(courseId, teacherId, courseName, fee, maxStudents, startDate, endDate);         
        }
        return null;
    }
    
    public boolean validate(){
        return 
            fee > 0 
            && !Utils.isNullOrEmpty(courseName) 
            && maxStudents > 0 
            && endDate.compareTo(startDate) > 0;
    }
    
    public void save()throws ClassNotFoundException, SQLException {
        if(!validate()) throw  new RuntimeException("invalid course");
        if(this.courseId == 0){ // new Course, INSERT in DB, get new id and set it 
            PreparedStatement pst = 
            DB.getCon().prepareStatement(
                    "INSERT INTO "
                    + "course(course_name, teacher_id, fee,maxStudents, start_date,end_date) "
                    + "VALUES(?,?,?,?,?,?)" ,Statement.RETURN_GENERATED_KEYS);
            pst.setString(1, courseName);
            pst.setInt(2, teacherId);
            pst.setInt(3, fee);
            pst.setInt(4, maxStudents);
            pst.setDate(5, startDate);
            pst.setDate(6, endDate);
            pst.executeUpdate();   
            ResultSet rs = pst.getGeneratedKeys();
            if(rs.next()){
                this.courseId = rs.getInt(1);
            } else {
                throw new SQLException("Cannot create course!");
            }
        } else { // existing Course, UPDATE DB for current course id
            PreparedStatement pst =
                  DB.getCon().prepareStatement("UPDATE course "
                          + "SET course_name=?,"
                          + "fee=?,"
                          + "maxStudents = ? ,"
                          + "start_date = ?,"
                          + " end_date = ? "
                          + " WHERE course_id = ?");
            pst.setString(1, courseName);
            pst.setInt(2, fee); 
            pst.setInt(3, maxStudents);
            pst.setDate(4, startDate);
            pst.setDate(5, endDate);
            pst.setInt(6, courseId);
            pst.executeUpdate();
          
            
        }
    }
    
    public static void createCourse(){
        
    }
    

   
    public int getCourseId() {
        return courseId;
    }

    
    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    
    public int getTeacherId() {
        return teacherId;
    }

    
    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getCourseName() {
        return courseName;
    }

    
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

   
    public int getFee() {
        return fee;
    }

   
    public void setFee(int fee) {
        this.fee = fee;
    }

   
    public int getMaxStudents() {
        return maxStudents;
    }

   
    public void setMaxStudents(int maxStudents) {
        this.maxStudents = maxStudents;
    }

   
    public Date getStartDate() {
        return startDate;
    }

    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

   
    public Date getEndDate() {
        return endDate;
    }

    
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
   
    
   
}
