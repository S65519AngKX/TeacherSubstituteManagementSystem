/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.Schedule;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Khe Xin
 */
public class ScheduleDao {

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

    public static int save(Schedule schedule) {
        int status = 0;
        try {
            Connection con = ScheduleDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("INSERT INTO schedule(scheduleDay,schedulePeriod,scheduleSubject,className,teacherId)VALUES(?,?,?,?,?)");
            myPS.setString(1, schedule.getScheduleDay());
            myPS.setInt(2, schedule.getSchedulePeriod());
            myPS.setString(3, schedule.getScheduleSubject());
            myPS.setString(4, schedule.getClassName());
            myPS.setInt(5, schedule.getTeacherId());
            status = myPS.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static int update(Schedule schedule) {
        int status = 0;
        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("Update schedule set scheduleDay=?,schedulePeriod=?,scheduleSubject=?,className=?,teacherId=? where scheduleId=?");
            myPS.setString(1, schedule.getScheduleDay());
            myPS.setInt(2, schedule.getSchedulePeriod());
            myPS.setString(3, schedule.getScheduleSubject());
            myPS.setString(4, schedule.getClassName());
            myPS.setInt(5, schedule.getTeacherId());
            myPS.setInt(6, schedule.getScheduleId());

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
            PreparedStatement myPS = con.prepareStatement("delete from schedule where teacherId=?");
            myPS.setInt(1, id);

            status = myPS.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static Schedule getScheduleById(int id) {
        Schedule schedule = new Schedule();
        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from schedule where scheduleId=?");
            myPS.setInt(1, id);
            ResultSet rs = myPS.executeQuery();
            if (rs.next()) {
                schedule.setScheduleId(rs.getInt(1));
                schedule.setScheduleDay(rs.getString(2));
                schedule.setSchedulePeriod(rs.getInt(3));
                schedule.setScheduleSubject(rs.getString(4));
                schedule.setClassName(rs.getString(5));
                schedule.setTeacherId(rs.getInt(6));
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return schedule;
    }

    public static List<Schedule> getAllTeacher() {
        List<Schedule> list = new ArrayList<Schedule>();

        try {
            Connection con = TeacherDao.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from schedule");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setScheduleId(rs.getInt(1));
                schedule.setScheduleDay(rs.getString(2));
                schedule.setSchedulePeriod(rs.getInt(3));
                schedule.setScheduleSubject(rs.getString(4));
                schedule.setClassName(rs.getString(5));
                schedule.setTeacherId(rs.getInt(6));
                list.add(schedule);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
