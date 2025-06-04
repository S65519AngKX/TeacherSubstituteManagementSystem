/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.User;
import java.util.*;
import java.sql.*;
import util.Database;

public class UserDao {

    public static int save(User user, Connection con) {
        int status = 0;
        try (
            PreparedStatement myPS = con.prepareStatement("INSERT INTO user(username,password,teacherId)VALUES(?,?,?)");){
            myPS.setString(1, user.getUsername());
            myPS.setString(2, user.getPassword());
            myPS.setInt(3, user.getTeacherId());

            status = myPS.executeUpdate();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static int update(User user) {
        int status = 0;
        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("Update user set username=?,password=? where teacherId=?");){
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

    public static String getUsernameByTeacherId(int teacherId) {
        String username = null;

        try (
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT username FROM user WHERE teacherId = ?");){
            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                username = rs.getString("username");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return username;
    }

    public static int delete(String username) {
        int status = 0;
        try (
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM user WHERE username = ?");){
            ps.setString(1, username);
            status = ps.executeUpdate();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static User getUserByTeacherId(int id) {
        User user = new User();

        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from user where teacherId=?");){
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

    public static boolean isUsernameIsTaken(String username) {
        boolean taken = false;
        try (
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from user where username=?");){
            myPS.setString(1, username);
            ResultSet rs = myPS.executeQuery();
            if (rs.next()) {
                taken = true;
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return taken;
    }
}
