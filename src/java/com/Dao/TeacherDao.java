/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.Teacher;
import java.util.*;
import java.sql.*;
import util.Database;

public class TeacherDao {

    public static int save(Teacher teacher, Connection con) {
        int teacherId = 0;
        try (PreparedStatement myPS = con.prepareStatement("INSERT INTO teacher(teacherName,teacherEmail,teacherContact,teacherRole,telegramId)VALUES(?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);){
            myPS.setString(1, teacher.getTeacherName());
            myPS.setString(2, teacher.getTeacherEmail());
            myPS.setString(3, teacher.getTeacherContact());
            myPS.setString(4, teacher.getTeacherRole());
            myPS.setString(5, teacher.getTelegramId());
            int rowsAffected = myPS.executeUpdate();

            if (rowsAffected > 0) {
                ResultSet rs = myPS.getGeneratedKeys();
                if (rs.next()) {
                    teacherId = rs.getInt(1);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return teacherId;
    }

    public static int update(Teacher teacher) {
        int status = 0;
        try (Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("Update teacher set teacherName=?,teacherEmail=?,teacherContact=?,teacherRole=?,telegramId=? where teacherId=?");){
            myPS.setString(1, teacher.getTeacherName());
            myPS.setString(2, teacher.getTeacherEmail());
            myPS.setString(3, teacher.getTeacherContact());
            myPS.setString(4, teacher.getTeacherRole());
            myPS.setString(5, teacher.getTelegramId());
            myPS.setInt(6, teacher.getTeacherID());

            status = myPS.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static int delete(int id) {
        int status = 0;
        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("delete from teacher where teacherId=?");){
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
        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from teacher where teacherId=?");){
            myPS.setInt(1, id);
            ResultSet rs = myPS.executeQuery();
            if (rs.next()) {
                teacher.setTeacherID(rs.getInt(1));
                teacher.setTeacherName(rs.getString(2));
                teacher.setTeacherEmail(rs.getString(3));
                teacher.setTeacherContact(rs.getString(4));
                teacher.setTeacherRole(rs.getString(5));
                teacher.setTelegramId(rs.getString(6));
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return teacher;
    }

    public static int getTeacherIdByName(String name) {
        int teacherId = 0;
        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("select teacherId from teacher where teacherName=?");){
            myPS.setString(1, name);
            ResultSet rs = myPS.executeQuery();
            if (rs.next()) {
                teacherId = rs.getInt("teacherId");
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return teacherId;
    }

    public static String getTeacherNameById(int id) {
        String teacherName = "";
        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("select teacherName from teacher where teacherId=?");){
            myPS.setInt(1, id);
            ResultSet rs = myPS.executeQuery();
            if (rs.next()) {
                teacherName = rs.getString("teacherName");
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return teacherName;
    }

    public static List<Teacher> getAllTeacher() {
        List<Teacher> list = new ArrayList<Teacher>();

        try (
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from teacher");){
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setTeacherID(rs.getInt(1));
                teacher.setTeacherName(rs.getString(2));
                teacher.setTeacherEmail(rs.getString(3));
                teacher.setTeacherContact(rs.getString(4));
                teacher.setTeacherRole(rs.getString(5));
                teacher.setTelegramId(rs.getString(6));
                list.add(teacher);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean isEmailIsTaken(String email) {
        boolean taken=false;
        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from teacher where teacherEmail=?");){
            myPS.setString(1, email);
            ResultSet rs = myPS.executeQuery();
            if (rs.next()) {
                taken=true;
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return taken;
    }
}
