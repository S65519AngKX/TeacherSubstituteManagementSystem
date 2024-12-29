/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.User;
import java.util.*;
import java.sql.*;

public class UserDao {

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

    public static int save(User user) {
        int status = 0;
        try {
            Connection con = UserDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("INSERT INTO user(username,password,teacherId)VALUES(?,?,?)");
            myPS.setString(1, user.getUsername());
            myPS.setString(2, user.getPassword());
            myPS.setInt(3, user.getTeacherId());

            status = myPS.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }
    public static int update(User user) {
        int status = 0;
        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("Update user set username=?,password=? where teacherId=?");
            myPS.setString(1, user.getUsername());
            myPS.setString(2, user.getPassword());
            myPS.setInt(3, user.getTeacherId());

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
            PreparedStatement myPS = con.prepareStatement("delete from user where teacherId=?");
            myPS.setInt(1, id);

            status = myPS.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static User getUserByTeacherId(int id) {
        User user = new User();

        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from user where teacherId=?");
            myPS.setInt(1, id);
            ResultSet rs = myPS.executeQuery();
            if (rs.next()) {
                user.setUsername(rs.getString(1));
                user.setPassword(rs.getString(2));
                user.setTeacherId(rs.getInt(3));

            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return user;
    }

    public static User getUserByTeacherID(int teacherId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
