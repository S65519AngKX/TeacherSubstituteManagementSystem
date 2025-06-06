/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.Leave;
import com.Model.Report;
import java.util.*;
import java.sql.*;
import java.sql.Date;
import util.Database;

public class LeaveDao {

    public static int save(Leave leave) {
        int status = 0;
        try ( Connection con = Database.getConnection();  PreparedStatement myPS = con.prepareStatement(
                "INSERT INTO `leave`(absentTeacherId,leaveStartDate,leaveEndDate,leaveReason,leaveNotes,leaveStatus) "
                + "VALUES(?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS)) {

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
        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("UPDATE leave SET absentTeacherId=?,leaveStartDate=?, leaveEndDate=?,leaveReason=?, leaveNotes=?, leaveStatus=? WHERE leaveId=?");){
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

    public static int updateLeaveStatus(int leaveId, String status, Connection con) {
        int statusUpdate = 0;
        try (
            PreparedStatement myPS = con.prepareStatement("UPDATE `leave` SET leaveStatus = ? WHERE leaveId = ?");){
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
        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("delete from `leave` where leaveId=?");){
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

        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from `leave` where absentTeacherId=?");){
            myPS.setInt(1, id);
            ResultSet rs = myPS.executeQuery();
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
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public static List<Leave> getAllUnprocessedLeave() {
        List<Leave> list = new ArrayList<Leave>();

        try (
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from `leave`WHERE leaveStatus IN ('Pending') ORDER BY leaveStartDate ASC");){
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

        try (
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM `leave` WHERE leaveStatus NOT IN ('Pending') ORDER BY leaveStartDate DESC");){
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

    public static int getNumOfTodayUnprocessedLeave() {
        int num = 0;
        try ( Connection con = Database.getConnection();  PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) as num FROM `leave` WHERE CURDATE() BETWEEN leaveStartDate AND leaveEndDate AND leaveStatus='PENDING'")) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                num = rs.getInt("num");  
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }

    public static List<Leave> getAllTodayUnprocessedLeave() {
        List<Leave> list = new ArrayList<Leave>();

        try (
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM `leave` WHERE CURDATE() BETWEEN leaveStartDate AND leaveEndDate AND leaveStatus='PENDING'");){
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

    public static Leave getLeaveDetailsByLeaveID(int leaveID) {
        Leave leave = null;

        try (
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT leave.leaveId,teacher.teacherName, leave.absentTeacherId,teacher.telegramId,leave.leaveStartDate,leave.leaveEndDate,leave.leaveStatus FROM `leave` INNER JOIN teacher ON leave.absentTeacherId = teacher.teacherId WHERE leave.leaveId = ?"
            );){
            ps.setInt(1, leaveID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                leave = new Leave();
                leave.setLeaveID(rs.getInt("leaveID"));
                leave.setTeacherName(rs.getString("teacherName"));
                leave.setAbsentTeacherID(rs.getInt("absentTeacherId"));
                leave.setTelegramId(rs.getString("telegramId"));
                leave.setLeaveStartDate(rs.getDate("leaveStartDate"));
                leave.setLeaveEndDate(rs.getDate("leaveEndDate"));
                leave.setLeaveStatus(rs.getString("leaveStatus"));
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return leave;
    }

}
