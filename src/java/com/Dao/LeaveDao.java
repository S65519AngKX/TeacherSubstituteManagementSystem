/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.Leave;
import java.util.*;
import java.sql.*;

public class LeaveDao {

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

    public static int save(Leave leave) {
        int status = 0;
        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement(
                    "INSERT INTO `leave`(absentTeacherId,leaveStartDate,leaveEndDate,leaveReason,leaveNotes,leaveStatus) "
                    + "VALUES(?, ?, ?, ?, ?, ?)");

            myPS.setInt(1, leave.getAbsentTeacherID());
            myPS.setDate(2, leave.getLeaveStartDate());
            myPS.setDate(3, leave.getLeaveEndDate());
            myPS.setString(4, leave.getLeaveReason());
            myPS.setString(5, leave.getLeaveNotes());
            myPS.setString(6, leave.getLeaveStatus());

            status = myPS.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static int update(Leave leave) {
        int status = 0;
        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("UPDATE leave SET absentTeacherId=?,leaveStartDate=?, leaveEndDate=?,leaveReason=?, leaveNotes=?, leaveStatus=? WHERE leaveId=?");
            myPS.setInt(1, leave.getAbsentTeacherID());
            myPS.setDate(2, leave.getLeaveStartDate());
            myPS.setDate(3, leave.getLeaveEndDate());
            myPS.setString(4, leave.getLeaveStatus());
            myPS.setString(5, leave.getLeaveNotes());
            myPS.setString(6, leave.getLeaveStatus());
            myPS.setInt(7, leave.getLeaveID());

            status = myPS.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return status;
    }

    public static int updateLeaveStatus(int leaveId, String status) {
        int statusUpdate = 0;
        try ( Connection con = TeacherDao.getConnection()) {
            PreparedStatement myPS = con.prepareStatement("UPDATE `leave` SET leaveStatus = ? WHERE leaveId = ?");
            myPS.setString(1, status);
            myPS.setInt(2, leaveId);

            // Execute the update
            statusUpdate = myPS.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return statusUpdate;
    }

    public static int delete(int id) {
        int status = 0;
        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("delete from `leave` where leaveId=?");
            myPS.setInt(1, id);

            status = myPS.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static List<Leave> getLeaveByTeacherId(int id) {
        List<Leave> list = new ArrayList<Leave>();

        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from `leave` where absentTeacherId=?");
            myPS.setInt(1, id);
            ResultSet rs = myPS.executeQuery();
            while(rs.next()) {
                Leave leave = new Leave();
                leave.setLeaveID(rs.getInt(1));
                leave.setAbsentTeacherID(rs.getInt(2));
                leave.setLeaveStartDate(rs.getDate(3));
                leave.setLeaveEndDate(rs.getDate(4));
                leave.setLeaveReason(rs.getString(5));
                leave.setLeaveNotes(rs.getString(6));
                leave.setLeaveStatus(rs.getString(7));
                list.add(leave);
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public static List<Leave> getAllUnprocessedLeave() {
        List<Leave> list = new ArrayList<Leave>();

        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from `leave`WHERE leaveStatus IN ('Pending')");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Leave leave = new Leave();
                leave.setLeaveID(rs.getInt(1));
                leave.setAbsentTeacherID(rs.getInt(2));
                leave.setLeaveStartDate(rs.getDate(3));
                leave.setLeaveEndDate(rs.getDate(4));
                leave.setLeaveReason(rs.getString(5));
                leave.setLeaveNotes(rs.getString(6));
                leave.setLeaveStatus(rs.getString(7));
                list.add(leave);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Leave> getAllProcessedLeave() {
        List<Leave> list = new ArrayList<Leave>();

        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM `leave` WHERE leaveStatus NOT IN ('Pending')");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Leave leave = new Leave();
                leave.setLeaveID(rs.getInt(1));
                leave.setAbsentTeacherID(rs.getInt(2));
                leave.setLeaveStartDate(rs.getDate(3));
                leave.setLeaveEndDate(rs.getDate(4));
                leave.setLeaveReason(rs.getString(5));
                leave.setLeaveNotes(rs.getString(6));
                leave.setLeaveStatus(rs.getString(7));
                list.add(leave);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
