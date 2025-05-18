/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.Substitution;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import util.Database;

/**
 *
 * @author Khe Xin
 */
public class SubstitutionDao {
    public static int save(Substitution substitution, Connection con) throws SQLException {
        try ( PreparedStatement myPS = con.prepareStatement(
                "INSERT INTO `substitution`(substitutionDate, leaveId, substitutionRequestId) VALUES(?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS)) {

            myPS.setDate(1, substitution.getSubstitutionDate());

            if (substitution.getLeaveID() > 0) {
                myPS.setInt(2, substitution.getLeaveID());
            } else {
                myPS.setNull(2, java.sql.Types.INTEGER);
            }

            if (substitution.getSubstitutionRequestId() > 0) {
                myPS.setInt(3, substitution.getSubstitutionRequestId());
            } else {
                myPS.setNull(3, java.sql.Types.INTEGER);
            }

            int affectedRows = myPS.executeUpdate();

            if (affectedRows > 0) {
                try ( ResultSet generatedKeys = myPS.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        }
        return -1; // Return -1 if insertion failed
    }

    public static int delete(int id) {
        int status = 0;
        try {
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("delete from `substitution` where substitutionId=?");
            myPS.setInt(1, id);

            status = myPS.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static Date getSubstitutionDateById(int substitutionId) {
        Date substitutionDate = null;
        try {
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT substitutionDate FROM substitution WHERE substitutionId=?");
            ps.setInt(1, substitutionId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                substitutionDate = rs.getDate("substitutionDate");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return substitutionDate;
    }

    public static List<Substitution> displayAllTodaySubstitution() {
        List<Substitution> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "SELECT \n"
                    + "    s.substitutionId, \n"
                    + "    s.substitutionDate,  \n"
                    + "    sr.substitutionRequestId,  \n"
                    + "    l.leaveStatus,  \n"
                    + "    CASE \n"
                    + "        WHEN l.leaveId IS NOT NULL THEN 'Leave' \n"
                    + "        WHEN sr.substitutionRequestId IS NOT NULL THEN 'Substitution Request' \n"
                    + "        ELSE ''\n"
                    + "    END AS type, \n"
                    + "    COALESCE(l.absentTeacherId, sr.requestTeacherId) AS teacherId, \n"
                    + "    MAX(COALESCE(l.leaveReason, sr.substitutionRequestReason)) AS reason, \n"
                    + "    MAX(COALESCE(l.leaveNotes, sr.substitutionRequestNotes)) AS notes\n"
                    + "FROM substitution s \n"
                    + "LEFT JOIN substitutionAssignments sa ON sa.substitutionId = s.substitutionId \n"
                    + "LEFT JOIN `leave` l ON s.leaveId = l.leaveId \n"
                    + "LEFT JOIN substitutionRequest sr ON s.substitutionRequestId = sr.substitutionRequestId \n"
                    + "WHERE s.substitutionDate = CURDATE() \n"
                    + "GROUP BY teacherId, s.substitutionId, s.substitutionDate, sr.substitutionRequestId\n"
                    + "ORDER BY s.substitutionDate ASC, s.substitutionId ASC;";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Substitution sa = new Substitution();
                sa.setSubstitutionId(rs.getInt("substitutionId"));
                sa.setSubstitutionRequestId(rs.getInt("substitutionRequestId"));
                sa.setTeacherID(rs.getInt("teacherId"));
                sa.setLeaveStatus(rs.getString("leaveStatus"));
                sa.setType(rs.getString("type"));
                sa.setReason(rs.getString("reason"));
                sa.setNotes(rs.getString("notes"));
                sa.setSubstitutionDate(rs.getDate("substitutionDate"));
                list.add(sa);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Integer> getLeavePeriod(Date substitutionDate, int teacherId) {
        List<Integer> list = new ArrayList<>();

        try {
            Connection con = Database.getConnection();
            String query
                    = "SELECT sch.schedulePeriod "
                    + "FROM substitution s "
                    + "JOIN `leave` l ON s.leaveId = l.leaveId "
                    + "JOIN schedule sch ON sch.teacherId = l.absentTeacherId "
                    + "WHERE s.substitutionDate = ? "
                    + "AND sch.scheduleDay = DAYNAME(s.substitutionDate) "
                    + "AND sch.scheduleSubject IS NOT NULL "
                    + "AND TRIM(sch.scheduleSubject) <> '' "
                    + "AND l.absentTeacherId = ?";

            PreparedStatement myPS = con.prepareStatement(query);

            myPS.setDate(1, new java.sql.Date(substitutionDate.getTime()));
            myPS.setInt(2, teacherId);

            ResultSet rs = myPS.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt(1));
            }

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public static int getAbsentTeacherBySubstitutionId(int substitutionId) {
        int teacherId = 0;
        try {
            Connection con = Database.getConnection();
            String query
                    = "SELECT \n"
                    + "    COALESCE(l.absentTeacherId, sr.requestTeacherId) AS absentTeacherId\n"
                    + "FROM substitution s\n"
                    + "LEFT JOIN `leave` l ON s.leaveId = l.leaveId\n"
                    + "LEFT JOIN substitutionRequest sr ON s.substitutionRequestId = sr.substitutionRequestId\n"
                    + "WHERE s.substitutionId = ?;";

            PreparedStatement myPS = con.prepareStatement(query);

            myPS.setInt(1, substitutionId);

            ResultSet rs = myPS.executeQuery();
            while (rs.next()) {
                teacherId = rs.getInt(1);
            }

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return teacherId;
    }
}
