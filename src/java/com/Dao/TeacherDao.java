/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.Teacher;
import java.util.*;
import java.sql.*;

public class TeacherDao {

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/substitutemanagement", "root", "admin");
            System.out.println("Database connection successful.");
        } catch (Exception e) {
            System.out.println("Failed to connect to the database: " + e.getMessage());
        }
        return con;
    }

    public static int save(Teacher teacher) {
        int status = 0;
        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("INSERT INTO teacher(teacherName,teacherEmail,teacherContact,teacherRole)VALUES(?,?,?,?)");
            myPS.setString(1, teacher.getTeacherName());
            myPS.setString(2, teacher.getTeacherEmail());
            myPS.setString(3, teacher.getTeacherContact());
            myPS.setString(4, teacher.getTeacherRole());

            status = myPS.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static int update(Teacher teacher) {
        int status = 0;
        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("Update teacher set teacherName=?,teacherEmail=?,teacherContact=?,teacherRole=? where teacherId=?");
            myPS.setString(1, teacher.getTeacherName());
            myPS.setString(2, teacher.getTeacherEmail());
            myPS.setString(3, teacher.getTeacherContact());
            myPS.setString(4, teacher.getTeacherRole());
            myPS.setInt(5, teacher.getTeacherID());

            status = myPS.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static int delete(int id) {
        int status = 0;
        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("delete from teacher where teacherId=?");
            myPS.setInt(1, id);

            status = myPS.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static Teacher getTeacherById(int id) {
        Teacher teacher = new Teacher();

        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from teacher where teacherId=?");
            myPS.setInt(1, id);
            ResultSet rs = myPS.executeQuery();
            if (rs.next()) {
                teacher.setTeacherID(rs.getInt(1));
                teacher.setTeacherName(rs.getString(2));
                teacher.setTeacherEmail(rs.getString(3));
                teacher.setTeacherContact(rs.getString(4));
                teacher.setTeacherRole(rs.getString(5));
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return teacher;
    }

    public static List<Teacher> getAllTeacher() {
        List<Teacher> list = new ArrayList<Teacher>();

        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from teacher");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setTeacherID(rs.getInt(1));
                teacher.setTeacherName(rs.getString(2));
                teacher.setTeacherEmail(rs.getString(3));
                teacher.setTeacherContact(rs.getString(4));
                teacher.setTeacherRole(rs.getString(5));
                list.add(teacher);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
