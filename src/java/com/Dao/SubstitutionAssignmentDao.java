/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.Report;
import com.Model.Schedule;
import com.Model.SubstitutionAssignments;
import com.Model.Teacher;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import util.Database;

/**
 *
 * @author Khe Xin
 */
public class SubstitutionAssignmentDao {

    public static void createSubstitutionAssignmentsForSubstitutionRequest(int substitutionRequestId, int requestTeacherId, Date substitutionDate, int substitutionId, Connection con) throws SQLException {

        List<Integer> requestedPeriods = SubstitutionRequestPeriodDao.getPeriodsBySubstitutionRequestId(substitutionRequestId, con);

        for (int period : requestedPeriods) {
            Schedule schedule = ScheduleDao.getScheduleByTeacherAndPeriod(requestTeacherId, period, substitutionDate, con);

            if (schedule != null) {
                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO substitutionAssignments (substitutionId, scheduleId, substituteTeacherId, remarks, status) VALUES (?, ?, NULL, NULL, 'PENDING')"
                );
                ps.setInt(1, substitutionId);
                ps.setInt(2, schedule.getScheduleId());
                ps.executeUpdate();
                ps.close();
            }
        }
    }

    public static void createSubstitutionAssignmentsForLeave(int substitutionId, int absentTeacherId, Date substitutionDate, Connection con) throws SQLException {
        String getScheduleQuery = "SELECT scheduleId FROM schedule WHERE teacherId = ? AND scheduleDay = ? AND scheduleSubject IS NOT NULL AND TRIM(scheduleSubject) <> '';";
        String insertAssignmentQuery = "INSERT INTO substitutionAssignments (substitutionId, scheduleId, substituteTeacherId, remarks, status) VALUES (?, ?, NULL , NULL, 'PENDING')";
        try ( PreparedStatement ps = con.prepareStatement(getScheduleQuery);  PreparedStatement insertPs = con.prepareStatement(insertAssignmentQuery)) {

            Calendar calendar = Calendar.getInstance();

            // Loop through each date in the leave range
            String scheduleDay = new SimpleDateFormat("EEEE").format(substitutionDate); // Get the day name

            // Find schedule periods for this teacher on this day
            System.out.println("Checking schedule for absentTeacherId: " + absentTeacherId + " on " + scheduleDay);

            ps.setInt(1, absentTeacherId);
            ps.setString(2, scheduleDay);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int scheduleId = rs.getInt("scheduleId");
                System.out.println("Found scheduleId: " + scheduleId);

                // Insert into substitutionAssignments
                insertPs.setInt(1, substitutionId);
                insertPs.setInt(2, scheduleId);
                insertPs.executeUpdate();

            }

        }
    }

    public static int update(Connection con, SubstitutionAssignments assignment) {
        int status = 0;
        try {
            PreparedStatement myPS = con.prepareStatement(
                    "UPDATE substitutionAssignments SET substituteTeacherId=?, remarks=?, status=? WHERE substitutionId=? AND scheduleId=?"
            );

            if (assignment.getSubstituteTeacherID() == 0) {  // Assuming 0 means no teacher assigned
                myPS.setNull(1, java.sql.Types.INTEGER);
            } else {
                myPS.setInt(1, assignment.getSubstituteTeacherID());
            }
            if (assignment.getRemarks() == null || assignment.getRemarks().trim().isEmpty()) {
                myPS.setNull(2, java.sql.Types.VARCHAR);
            } else {
                myPS.setString(2, assignment.getRemarks());
            }
            myPS.setString(3, assignment.getStatus());
            myPS.setInt(4, assignment.getSubstitutionId());
            myPS.setInt(5, assignment.getScheduleId());
            status = myPS.executeUpdate();

            myPS.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static int confirm(SubstitutionAssignments assignment) {
        int status = 0;
        try {
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement(
                    "UPDATE substitutionAssignments SET status='CONFIRMED' WHERE substitutionId=? AND scheduleId=?"
            );
            myPS.setInt(1, assignment.getSubstitutionId());
            myPS.setInt(2, assignment.getScheduleId());
            status = myPS.executeUpdate();

            myPS.close();
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static int delete(int substitutionId, int scheduleId) {
        int status = 0;
        try {
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("delete from `substitutionAssignments` where substitutionId=? AND scheduleId=?");
            myPS.setInt(1, substitutionId);
            myPS.setInt(2, scheduleId);

            status = myPS.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static List<SubstitutionAssignments> getAllTodaySubstitutionAssignment() {//to arrange today substitution
        List<SubstitutionAssignments> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "SELECT \n"
                    + "    sa.substitutionId, \n"
                    + "    sa.scheduleId, sa.status, sa.remarks, sch.scheduleDay, s.substitutionDate,\n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.absentTeacherId, sr.requestTeacherId) \n"
                    + "        ELSE '' \n"
                    + "    END AS absentTeacherId, \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.leaveReason, sr.substitutionRequestReason) \n"
                    + "        ELSE '' \n"
                    + "    END AS reason, \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.leaveNotes, sr.substitutionRequestNotes) \n"
                    + "        ELSE '' \n"
                    + "    END AS notes, \n"
                    + "    sch.schedulePeriod, \n"
                    + "    sch.className, \n"
                    + "    sch.scheduleSubject,  \n"
                    + "    sa.substituteTeacherId \n"
                    + "FROM substitutionAssignments sa \n"
                    + "INNER JOIN substitution s ON sa.substitutionId = s.substitutionId \n"
                    + "LEFT JOIN `leave` l ON s.leaveId = l.leaveId \n"
                    + "LEFT JOIN substitutionRequest sr ON s.substitutionRequestId = sr.substitutionRequestId \n"
                    + "LEFT JOIN schedule sch ON sa.scheduleId = sch.scheduleId \n"
                    + "WHERE s.substitutionDate = CURDATE() \n"
                    + "ORDER BY sa.substitutionId, sch.schedulePeriod;";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            int rowCount = 0;
            while (rs.next()) {
                rowCount++;
                SubstitutionAssignments sa = new SubstitutionAssignments();
                sa.setSubstitutionId(rs.getInt("substitutionId"));
                sa.setScheduleId(rs.getInt("scheduleId"));
                sa.setSubstitutionDate(rs.getDate("substitutionDate"));
                sa.setAbsentTeacherID(rs.getInt("absentTeacherId"));
                sa.setReason(rs.getString("reason"));
                sa.setNotes(rs.getString("notes"));
                sa.setRemarks(rs.getString("remarks"));
                sa.setStatus(rs.getString("status"));
                sa.setPeriod(rs.getInt("schedulePeriod"));
                sa.setClassName(rs.getString("className"));
                sa.setSubjectName(rs.getString("scheduleSubject"));
                sa.setScheduleDay(rs.getString("scheduleDay"));
                sa.setSubstituteTeacherID(rs.getInt("substituteTeacherId"));
                list.add(sa);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<SubstitutionAssignments> displayTodaySubstitutionAssignment() {//to display today assigned substitution(confirmed)
        List<SubstitutionAssignments> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "SELECT \n"
                    + "    sa.substitutionId, \n"
                    + "    sa.scheduleId, sa.status, sa.remarks, sch.scheduleDay, \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.absentTeacherId, sr.requestTeacherId) \n"
                    + "        ELSE '' \n"
                    + "    END AS absentTeacherId, \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.leaveReason, sr.substitutionRequestReason) \n"
                    + "        ELSE '' \n"
                    + "    END AS reason, \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.leaveNotes, sr.substitutionRequestNotes) \n"
                    + "        ELSE '' \n"
                    + "    END AS notes, \n"
                    + "    sch.schedulePeriod, \n"
                    + "    sch.className, \n"
                    + "    sch.scheduleSubject,  \n"
                    + "    sa.substituteTeacherId \n"
                    + "FROM substitutionAssignments sa \n"
                    + "INNER JOIN substitution s ON sa.substitutionId = s.substitutionId \n"
                    + "LEFT JOIN `leave` l ON s.leaveId = l.leaveId \n"
                    + "LEFT JOIN substitutionRequest sr ON s.substitutionRequestId = sr.substitutionRequestId \n"
                    + "LEFT JOIN schedule sch ON sa.scheduleId = sch.scheduleId \n"
                    + "WHERE s.substitutionDate = CURDATE() AND sa.status='CONFIRMED'\n"
                    + "ORDER BY sa.substitutionId, sch.schedulePeriod;";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            int rowCount = 0;
            while (rs.next()) {
                rowCount++;

                SubstitutionAssignments sa = new SubstitutionAssignments();
                sa.setSubstitutionId(rs.getInt("substitutionId"));
                sa.setScheduleId(rs.getInt("scheduleId"));
                sa.setStatus(rs.getString("status"));
                sa.setRemarks(rs.getString("remarks"));
                sa.setAbsentTeacherID(rs.getInt("absentTeacherId"));
                sa.setReason(rs.getString("reason"));
                sa.setNotes(rs.getString("notes"));
                sa.setPeriod(rs.getInt("schedulePeriod"));
                sa.setClassName(rs.getString("className"));
                sa.setSubjectName(rs.getString("scheduleSubject"));
                sa.setScheduleDay(rs.getString("scheduleDay"));
                sa.setSubstituteTeacherID(rs.getInt("substituteTeacherId"));
                list.add(sa);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<SubstitutionAssignments> getAllSubstitutionAssignment() {//to arrange all substitution(pending)
        List<SubstitutionAssignments> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "SELECT \n"
                    + "    sa.substitutionId, \n"
                    + "    sa.scheduleId, sa.status, sa.remarks, sch.scheduleDay, s.substitutionDate, \n"
                    + "    s.substitutionDate,  \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.absentTeacherId, sr.requestTeacherId) \n"
                    + "        ELSE '' \n"
                    + "    END AS absentTeacherId, \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.leaveReason, sr.substitutionRequestReason) \n"
                    + "        ELSE '' \n"
                    + "    END AS reason, \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.leaveNotes, sr.substitutionRequestNotes) \n"
                    + "        ELSE '' \n"
                    + "    END AS notes, \n"
                    + "    sch.schedulePeriod, \n"
                    + "    sch.className, \n"
                    + "    sch.scheduleSubject,  \n"
                    + "    sa.substituteTeacherId \n"
                    + "FROM substitutionAssignments sa \n"
                    + "LEFT JOIN substitution s ON sa.substitutionId = s.substitutionId  \n"
                    + "LEFT JOIN `leave` l ON s.leaveId = l.leaveId \n"
                    + "LEFT JOIN substitutionRequest sr ON s.substitutionRequestId = sr.substitutionRequestId \n"
                    + "LEFT JOIN schedule sch ON sa.scheduleId = sch.scheduleId \n"
                    + "WHERE sa.status = 'PENDING'\n"
                    + "ORDER BY s.substitutionDate DESC, sa.substitutionId, sch.schedulePeriod;";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            int rowCount = 0;
            while (rs.next()) {
                rowCount++;

                SubstitutionAssignments sa = new SubstitutionAssignments();
                sa.setSubstitutionId(rs.getInt("substitutionId"));
                sa.setScheduleId(rs.getInt("scheduleId"));
                sa.setSubstitutionDate(rs.getDate("substitutionDate"));
                sa.setStatus(rs.getString("status"));
                sa.setRemarks(rs.getString("remarks"));
                sa.setAbsentTeacherID(rs.getInt("absentTeacherId"));
                sa.setReason(rs.getString("reason"));
                sa.setNotes(rs.getString("notes"));
                sa.setPeriod(rs.getInt("schedulePeriod"));
                sa.setClassName(rs.getString("className"));
                sa.setSubjectName(rs.getString("scheduleSubject"));
                sa.setScheduleDay(rs.getString("scheduleDay"));
                sa.setSubstituteTeacherID(rs.getInt("substituteTeacherId"));
                sa.setSubstitutionDate(rs.getDate("substitutionDate"));
                list.add(sa);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static List<Teacher> getSuggestedSubstitute(Date substitutionDate, int schedulePeriod, String scheduleDay, String className, String scheduleSubject) {//to display all suggested substitute teacher
        List<Teacher> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "WITH MonthlySubCount AS ( " //get frequency of teacher being assigned for substitution in a month
                    + "    SELECT sa.substituteTeacherId, COUNT(*) AS totalAssignments "
                    + "    FROM substitutionAssignments sa "
                    + "    JOIN substitution s ON sa.substitutionId = s.substitutionId "
                    + "    WHERE MONTH(s.substitutionDate) = MONTH(CURRENT_DATE()) "
                    + "        AND YEAR(s.substitutionDate) = YEAR(CURRENT_DATE()) "
                    + "    GROUP BY sa.substituteTeacherId "
                    + "), "
                    + "BlockedTeachers AS ( " //get unsuitable teacher
                    + "    SELECT DISTINCT teacherId FROM ( " //get teacher who request for substitution on the same date
                    + "        SELECT sr.requestTeacherId AS teacherId "
                    + "        FROM substitutionRequest sr "
                    + "        JOIN substitution s ON sr.substitutionRequestId = s.substitutionRequestId "
                    + "        WHERE s.substitutionDate = ? "
                    + "        UNION "
                    + "        SELECT l.absentTeacherId AS teacherId " //get teacher who apply for leave on the same date
                    + "        FROM `leave` l "
                    + "        JOIN substitution s ON l.leaveId = s.leaveId "
                    + "        WHERE s.substitutionDate = ? AND l.leaveStatus='Approved'"
                    + "        UNION "
                    + "        SELECT sch.teacherId AS teacherId " //block unavailable teacher
                    + "        FROM schedule sch "
                    + "        WHERE sch.scheduleDay = ? "
                    + "            AND sch.schedulePeriod = ? "
                    + "            AND (sch.className IS NOT NULL AND sch.className <> ' ') "
                    + "    ) AS blocked "
                    + "), "
                    + "AvailableTeachers AS ( "
                    + "    SELECT t.teacherId, t.teacherName, "
                    + "        COALESCE(MAX(ms.totalAssignments), 0) AS totalAssignments, "
                    + "        MAX(CASE WHEN s.className = ? THEN 1 ELSE 0 END) AS classMatch, "
                    + "        MAX(CASE WHEN s.scheduleSubject = ? THEN 1 ELSE 0 END) AS subjectMatch, "
                    + "        MAX(CASE WHEN t.teacherRole = 'Part Time' THEN 1 ELSE 0 END) AS isPartTime "
                    + "    FROM teacher t "
                    + "    LEFT JOIN schedule s ON s.teacherId = t.teacherId "
                    + "    LEFT JOIN MonthlySubCount ms ON t.teacherId = ms.substituteTeacherId "
                    + "    WHERE t.teacherId NOT IN (SELECT teacherId FROM BlockedTeachers WHERE teacherId IS NOT NULL) "
                    + "    GROUP BY t.teacherId, t.teacherName "
                    + ") "
                    + "SELECT * FROM AvailableTeachers "
                    + "ORDER BY classMatch DESC, isPartTime DESC, totalAssignments ASC, subjectMatch DESC, RAND();";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, substitutionDate);
            ps.setDate(2, substitutionDate);
            ps.setString(3, scheduleDay);
            ps.setInt(4, schedulePeriod);
            ps.setString(5, className);
            ps.setString(6, scheduleSubject);

            ResultSet rs = ps.executeQuery();
            String finalQuery = sql;
            finalQuery = finalQuery.replaceFirst("\\?", "'" + substitutionDate.toString() + "'");
            finalQuery = finalQuery.replaceFirst("\\?", "'" + substitutionDate.toString() + "'");
            finalQuery = finalQuery.replaceFirst("\\?", "'" + scheduleDay + "'");
            finalQuery = finalQuery.replaceFirst("\\?", String.valueOf(schedulePeriod));
            finalQuery = finalQuery.replaceFirst("\\?", "'" + className + "'");
            finalQuery = finalQuery.replaceFirst("\\?", "'" + scheduleSubject + "'");

            System.out.println("Executed SQL: " + finalQuery +"\n");

            while (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setTeacherID(rs.getInt(1));
                teacher.setTeacherName(rs.getString(2));
                teacher.setClassMatch(rs.getInt(4));
                teacher.setPartTime(rs.getInt(6));
                teacher.setSubjectMatch(rs.getInt(5));
                list.add(teacher);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //get period if teacher is being assigned for susbtitution for more than one class at the same time
    public static Set<Integer> getAssignedPeriodsForTeacher(int substituteTeacherId, Date substitutionDate) {
        Set<Integer> assignedPeriods = new HashSet<>();

        String sql = "SELECT sch.schedulePeriod, COUNT(*)\n"
                + "FROM substitutionAssignments sa \n"
                + "JOIN substitution s ON sa.substitutionId = s.substitutionId \n"
                + "JOIN schedule sch ON sa.scheduleId = sch.scheduleId \n"
                + "WHERE sa.substituteTeacherId = ? AND s.substitutionDate = ?\n"
                + "GROUP BY sch.schedulePeriod\n"
                + "HAVING COUNT(*) > 1;";

        try ( Connection conn = Database.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, substituteTeacherId);
            ps.setDate(2, substitutionDate);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    assignedPeriods.add(rs.getInt("schedulePeriod"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return assignedPeriods;
    }

    public static SubstitutionAssignments getSubstitutionAssigmentDetailsBySubstitutionIdAndScheduleId(int substitutionId, int scheduleId) {//for telegram notification
        SubstitutionAssignments assgn = new SubstitutionAssignments();

        try {
            Connection con = Database.getConnection();
            String query = "SELECT \n"
                    + "    sa.remarks, sch.scheduleDay, \n"
                    + "    s.substitutionDate,  \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.absentTeacherId, sr.requestTeacherId) \n"
                    + "        ELSE '' \n"
                    + "    END AS absentTeacherId, \n"
                    + "    sch.schedulePeriod, \n"
                    + "    sch.className, \n"
                    + "    sch.scheduleSubject,  \n"
                    + "    sa.substituteTeacherId \n"
                    + "FROM substitutionAssignments sa \n"
                    + "LEFT JOIN substitution s ON sa.substitutionId = s.substitutionId  \n"
                    + "LEFT JOIN `leave` l ON s.leaveId = l.leaveId \n"
                    + "LEFT JOIN substitutionRequest sr ON s.substitutionRequestId = sr.substitutionRequestId \n"
                    + "LEFT JOIN schedule sch ON sa.scheduleId = sch.scheduleId "
                    + "WHERE sa.substitutionId=? AND sa.scheduleId=?;";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, substitutionId);
            ps.setInt(2, scheduleId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                assgn.setRemarks(rs.getString("remarks"));
                assgn.setScheduleDay(rs.getString("scheduleDay"));
                assgn.setSubstitutionDate(rs.getDate("substitutionDate"));
                assgn.setAbsentTeacherID(rs.getInt("absentTeacherId"));
                assgn.setPeriod(rs.getInt("schedulePeriod"));
                assgn.setClassName(rs.getString("className"));
                assgn.setSubjectName(rs.getString("scheduleSubject"));
                assgn.setSubstituteTeacherID(rs.getInt("substituteTeacherId"));
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return assgn;
    }

    public static List<SubstitutionAssignments> getSubstitutionAssignmentRecord(Date startDate, Date endDate) {
        List<SubstitutionAssignments> list = new ArrayList<>();
        try {
            Connection con = Database.getConnection();
            String sql = "SELECT \n"
                    + "    sa.substitutionId, \n"
                    + "    sa.scheduleId, sa.status, sa.remarks, sch.scheduleDay, \n"
                    + "    s.substitutionDate,  \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.absentTeacherId, sr.requestTeacherId) \n"
                    + "        ELSE '' \n"
                    + "    END AS absentTeacherId, \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.leaveReason, sr.substitutionRequestReason) \n"
                    + "        ELSE '' \n"
                    + "    END AS reason, \n"
                    + "    CASE \n"
                    + "        WHEN ROW_NUMBER() OVER (PARTITION BY sa.substitutionId ORDER BY sch.schedulePeriod) = 1 \n"
                    + "        THEN COALESCE(l.leaveNotes, sr.substitutionRequestNotes) \n"
                    + "        ELSE '' \n"
                    + "    END AS notes, \n"
                    + "    sch.schedulePeriod, \n"
                    + "    sch.className, \n"
                    + "    sch.scheduleSubject,  \n"
                    + "    sa.substituteTeacherId \n"
                    + "FROM substitutionAssignments sa \n"
                    + "LEFT JOIN substitution s ON sa.substitutionId = s.substitutionId  \n"
                    + "LEFT JOIN `leave` l ON s.leaveId = l.leaveId \n"
                    + "LEFT JOIN substitutionRequest sr ON s.substitutionRequestId = sr.substitutionRequestId \n"
                    + "LEFT JOIN schedule sch ON sa.scheduleId = sch.scheduleId \n"
                    + "WHERE sa.status = 'CONFIRMED' ";

            if (startDate != null && endDate != null) {
                sql += "AND (s.substitutionDate BETWEEN ? AND ? OR s.substitutionDate IS NULL) ";
            } else {
                sql += "AND (s.substitutionDate IS NULL OR s.substitutionDate IS NOT NULL) "; // Returns all records
            }

            sql += "ORDER BY s.substitutionDate DESC, sa.substitutionId, sch.schedulePeriod;";

            PreparedStatement ps = con.prepareStatement(sql);

            if (startDate != null && endDate != null) {
                ps.setDate(1, startDate);
                ps.setDate(2, endDate);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SubstitutionAssignments sa = new SubstitutionAssignments();
                sa.setSubstitutionId(rs.getInt("substitutionId"));
                sa.setScheduleId(rs.getInt("scheduleId"));
                sa.setStatus(rs.getString("status"));
                sa.setRemarks(rs.getString("remarks"));
                sa.setAbsentTeacherID(rs.getInt("absentTeacherId"));
                sa.setReason(rs.getString("reason"));
                sa.setNotes(rs.getString("notes"));
                sa.setPeriod(rs.getInt("schedulePeriod"));
                sa.setClassName(rs.getString("className"));
                sa.setSubjectName(rs.getString("scheduleSubject"));
                sa.setScheduleDay(rs.getString("scheduleDay"));
                sa.setSubstituteTeacherID(rs.getInt("substituteTeacherId"));
                sa.setSubstitutionDate(rs.getDate("substitutionDate"));
                list.add(sa);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
