/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.Leave;
import com.Model.SubstitutionAssignments;
import com.Model.Report;
import java.util.*;
import java.sql.*;
import java.sql.Date;
import util.Database;

public class ReportDao {
    //leave report
     public static List<Report> getLeaveReport(Date startDate, Date endDate) {
        List<Report> list = new ArrayList<Report>();

        try {
            Connection con = Database.getConnection();
            String sql = "SELECT t.teacherName, "
                    + "COUNT(l.leaveId) AS totalLeaves, "
                    + " COALESCE(SUM(CASE WHEN l.leaveStatus = 'Approved' THEN DATEDIFF(l.leaveEndDate, l.leaveStartDate) + 1 ELSE 0 END) * 100.0 \n"
                    + "             / NULLIF(SUM(DATEDIFF(l.leaveEndDate, l.leaveStartDate) + 1), 0), 0) AS approvedPercentage,\n"
                    + "    COALESCE(SUM(CASE WHEN l.leaveStatus = 'Rejected' THEN DATEDIFF(l.leaveEndDate, l.leaveStartDate) + 1 ELSE 0 END) * 100.0 \n"
                    + "             / NULLIF(SUM(DATEDIFF(l.leaveEndDate, l.leaveStartDate) + 1), 0), 0) AS rejectedPercentage,\n"
                    + "    COALESCE(SUM(CASE WHEN l.leaveStatus = 'Pending' THEN DATEDIFF(l.leaveEndDate, l.leaveStartDate) + 1 ELSE 0 END) * 100.0 \n"
                    + "             / NULLIF(SUM(DATEDIFF(l.leaveEndDate, l.leaveStartDate) + 1), 0), 0) AS pendingPercentage,"
                    + "COALESCE(SUM(DATEDIFF(l.leaveEndDate, l.leaveStartDate) + 1), 0) AS totalLeaveDays, "
                    + "COALESCE(SUM(CASE WHEN l.leaveStatus = 'Approved' THEN DATEDIFF(l.leaveEndDate, l.leaveStartDate) + 1 ELSE 0 END), 0) AS totalApprovedLeaveDays "
                    + "FROM teacher t "
                    + "LEFT JOIN `leave` l ON t.teacherId = l.absentTeacherId ";
            if (startDate != null && endDate != null) {
                sql += "AND (l.leaveStartDate BETWEEN ? AND ? OR l.leaveEndDate BETWEEN ? AND ?) ";
            }
            sql += "GROUP BY t.teacherId, t.teacherName ORDER BY t.teacherName ASC";

            PreparedStatement ps = con.prepareStatement(sql);
            if (startDate != null && endDate != null) {
                ps.setDate(1, startDate);
                ps.setDate(2, endDate);
                ps.setDate(3, startDate);
                ps.setDate(4, endDate);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Report report = new Report();
                report.setTeacherName(rs.getString("teacherName"));
                report.setTotalLeaves(rs.getInt("totalLeaves"));
                report.setApprovedPercentage(rs.getDouble("approvedPercentage"));
                report.setRejectedPercentage(rs.getDouble("rejectedPercentage"));
                report.setPendingPercentage(rs.getDouble("pendingPercentage"));
                report.setTotalLeaveDays(rs.getInt("totalLeaveDays"));
                report.setTotalApprovedLeaveDays(rs.getInt("totalApprovedLeaveDays"));
                list.add(report);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Report> getLeaveRanking(Date startDate, Date endDate) {
        List<Report> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "SELECT t.teacherId, \n"
                    + "  COALESCE(SUM(DATEDIFF(l.leaveEndDate, l.leaveStartDate) + 1), 0) AS totalLeaveDays,\n"
                    + "  (SELECT COALESCE(SUM(DATEDIFF(l2.leaveEndDate, l2.leaveStartDate) + 1), 0) \n"
                    + "   FROM `leave` l2 \n"
                    + "   WHERE 1=1";

            if (startDate != null && endDate != null) {
                sql += " AND (l2.leaveStartDate BETWEEN ? AND ? OR l2.leaveEndDate BETWEEN ? AND ?)";
            }

            sql += ") AS totalRecords \n"
                    + "FROM teacher t \n"
                    + "LEFT JOIN `leave` l ON t.teacherId = l.absentTeacherId AND l.leaveStatus ='Approved'";

            if (startDate != null && endDate != null) {
                sql += " AND (l.leaveStartDate BETWEEN ? AND ? OR l.leaveEndDate BETWEEN ? AND ?) ";
            }

            sql += "GROUP BY t.teacherId\n"
                    + "ORDER BY totalLeaveDays DESC\n"
                    + "LIMIT 3";
            PreparedStatement ps = con.prepareStatement(sql);

            if (startDate != null && endDate != null) {
                ps.setDate(1, startDate);
                ps.setDate(2, endDate);
                ps.setDate(3, startDate);
                ps.setDate(4, endDate);
                ps.setDate(5, startDate);
                ps.setDate(6, endDate);
                ps.setDate(7, startDate);
                ps.setDate(8, endDate);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Report sa = new Report();
                sa.setTeacherId(rs.getInt("teacherId"));
                sa.setTotalLeaveDays(rs.getInt("totalLeaveDays"));
                sa.setTotalLeavesByAllTeachers(rs.getInt("totalRecords"));
                list.add(sa);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<Report> getLeaveTypePercentage(Date startDate, Date endDate) {
        List<Report> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "SELECT l.leaveReason, \n"
                    + "COALESCE(COUNT(*) * 100.0 / NULLIF((SELECT COUNT(*) from `leave` WHERE 1=1\n";
            if (startDate != null && endDate != null) {
                sql += " AND (leaveStartDate BETWEEN ? AND ? OR leaveEndDate BETWEEN ? AND ?)";
            }

            sql += "), 0), 0) AS percentage\n"
                    + "FROM `leave` l\n"
                    + "WHERE 1=1\n";

            if (startDate != null && endDate != null) {
                sql += " AND (l.leaveStartDate BETWEEN ? AND ? OR l.leaveEndDate BETWEEN ? AND ?)\n";
            }

            sql += "GROUP BY l.leaveReason";

            PreparedStatement ps = con.prepareStatement(sql);

            if (startDate != null && endDate != null) {
                ps.setDate(1, startDate);
                ps.setDate(2, endDate);
                ps.setDate(3, startDate);
                ps.setDate(4, endDate);
                ps.setDate(5, startDate);
                ps.setDate(6, endDate);
                ps.setDate(7, startDate);
                ps.setDate(8, endDate);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Report sa = new Report();
                sa.setLeaveTypes(rs.getString("leaveReason"));
                sa.setLeaveTypePercentage(rs.getDouble("percentage"));
                list.add(sa);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //substitution assignment report
     public static List<Report> getSubstitutionAssignmentReport(Date startDate, Date endDate) {
        List<Report> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "SELECT \n"
                    + "    t.teacherId,\n"
                    + "    COALESCE(absent_counts.numClassesSubstituted, 0) AS numClassesSubstituted,\n"
                    + "    COALESCE(substitute_counts.numArrangedForSubstitution, 0) AS numArrangedForSubstitution\n"
                    + "FROM teacher t\n"
                    + "LEFT JOIN (\n"
                    + "    SELECT \n"
                    + "        COALESCE(l.absentTeacherId, sr.requestTeacherId) AS teacherId,\n"
                    + "        COUNT(DISTINCT CONCAT(sa.substitutionId, '-', sa.scheduleId)) AS numClassesSubstituted\n"
                    + "    FROM substitutionAssignments sa\n"
                    + "    JOIN substitution s ON sa.substitutionId = s.substitutionId\n"
                    + "    LEFT JOIN `leave` l ON s.leaveId = l.leaveId\n"
                    + "    LEFT JOIN substitutionRequest sr ON s.substitutionRequestId = sr.substitutionRequestId\n"
                    + "    WHERE sa.status = 'CONFIRMED'\n";

            if (startDate != null && endDate != null) {
                sql += "    AND s.substitutionDate BETWEEN ? AND ?\n";
            }

            sql += "    GROUP BY COALESCE(l.absentTeacherId, sr.requestTeacherId)\n"
                    + ") absent_counts ON absent_counts.teacherId = t.teacherId\n"
                    + "LEFT JOIN (\n"
                    + "    SELECT \n"
                    + "        sa.substituteTeacherId AS teacherId,\n"
                    + "        COUNT(DISTINCT CONCAT(sa.substitutionId, '-', sa.scheduleId)) AS numArrangedForSubstitution\n"
                    + "    FROM substitutionAssignments sa\n"
                    + "    JOIN substitution s ON sa.substitutionId = s.substitutionId\n"
                    + "    WHERE sa.status = 'CONFIRMED'\n";

            if (startDate != null && endDate != null) {
                sql += "    AND s.substitutionDate BETWEEN ? AND ?\n";
            }

            sql += "    GROUP BY sa.substituteTeacherId\n" // Explicitly specify table alias
                    + ") substitute_counts ON substitute_counts.teacherId = t.teacherId\n"
                    + "ORDER BY t.teacherName;";
            PreparedStatement ps = con.prepareStatement(sql);

            if (startDate != null && endDate != null) {
                ps.setDate(1, startDate);
                ps.setDate(2, endDate);
                ps.setDate(3, startDate);
                ps.setDate(4, endDate);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Report sa = new Report();
                sa.setTeacherId(rs.getInt("teacherId"));
                sa.setNumSubstitute(rs.getInt("numArrangedForSubstitution"));
                sa.setNumApply(rs.getInt("numClassesSubstituted"));
                list.add(sa);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<Report> getSubstitutionAssignmentRanking(Date startDate, Date endDate) {
        List<Report> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "SELECT \n"
                    + "    sa.substituteTeacherId, \n"
                    + "    COUNT(*) AS numArrangedForSubstitution, \n"
                    + "    (SELECT COUNT(*) \n"
                    + "     FROM substitutionassignments sa2 \n"
                    + "     INNER JOIN substitution s2 ON sa2.substitutionId = s2.substitutionId \n"
                    + "     WHERE sa2.status = 'CONFIRMED' \n";

            if (startDate != null && endDate != null) {
                sql += "     AND s2.substitutionDate BETWEEN ? AND ? \n";
            }

            sql += "    ) AS totalRecords \n"
                    + "FROM substitutionassignments sa \n"
                    + "INNER JOIN substitution s ON sa.substitutionId = s.substitutionId \n"
                    + "INNER JOIN teacher t ON sa.substituteTeacherId = t.teacherId \n"
                    + "WHERE sa.status = 'CONFIRMED' \n";

            if (startDate != null && endDate != null) {
                sql += "AND s.substitutionDate BETWEEN ? AND ? \n";
            }

            sql += "GROUP BY sa.substituteTeacherId \n"
                    + "ORDER BY numArrangedForSubstitution DESC \n"
                    + "LIMIT 3";
            PreparedStatement ps = con.prepareStatement(sql);

            if (startDate != null && endDate != null) {
                ps.setDate(1, startDate);
                ps.setDate(2, endDate);
                ps.setDate(3, startDate);
                ps.setDate(4, endDate);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Report sa = new Report();
                sa.setSubstitutionTeacherId(rs.getInt("substituteTeacherId"));
                sa.setNumSubstitute(rs.getInt("numArrangedForSubstitution"));
                sa.setTotalSubstitute(rs.getInt("totalRecords"));
                list.add(sa);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<Report> getSubstitutionTypePercentage(Date startDate, Date endDate) {
        List<Report> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "SELECT \n"
                    + "    COALESCE(NULLIF(sa.remarks, ''), 'Substituted') AS remarks,\n"
                    + "    COUNT(*) * 100.0 / NULLIF(total.total_count, 0) AS percentage\n"
                    + "FROM \n"
                    + "    substitutionassignments sa\n"
                    + "INNER JOIN \n"
                    + "    substitution s ON sa.substitutionId = s.substitutionId\n"
                    + "CROSS JOIN (\n"
                    + "    SELECT COUNT(*) AS total_count\n"
                    + "    FROM substitutionassignments sa2\n"
                    + "    INNER JOIN substitution s2 ON sa2.substitutionId = s2.substitutionId\n"
                    + "    WHERE sa2.status = 'Confirmed' \n";
            if (startDate != null && endDate != null) {
                sql += " AND s2.substitutionDate BETWEEN ? AND ?\n";
            }
            sql += ") AS total\n"
                    + "WHERE \n"
                    + "    sa.status = 'Confirmed'\n";

            if (startDate != null && endDate != null) {
                sql += " AND s.substitutionDate BETWEEN ? AND ?\n";
            }
            sql += "GROUP BY sa.remarks,total.total_count\n"
                    + "ORDER BY \n"
                    + "    percentage DESC;";

            PreparedStatement ps = con.prepareStatement(sql);

            if (startDate != null && endDate != null) {
                ps.setDate(1, startDate);
                ps.setDate(2, endDate);
                ps.setDate(3, startDate);
                ps.setDate(4, endDate);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Report sa = new Report();
                sa.setSubstitutionTypes(rs.getString("remarks"));
                sa.setSubstitutionTypePercentage(rs.getDouble("percentage"));
                list.add(sa);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
