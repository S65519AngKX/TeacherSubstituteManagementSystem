/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

import java.sql.Date;

/**
 *
 * @author Khe Xin
 */
public class SubstitutionAssignments {

    private int substitutionId;
    private int scheduleId;
    private int substitutionTeacherId;
    private String remarks;
    private String status;
    //additional variable
    private Date substitutionDate;
    private int absentTeacherId;
    private String reason;
    private String notes;
    private String className;
    private String scheduleSubject;
    private String scheduleDay;
    private int period;

    public SubstitutionAssignments() {
    }

    public SubstitutionAssignments(int substitutionId, int scheduleId, int substituteTeacherId, String remarks, String status) {
        super();
        this.substitutionId = substitutionId;
        this.scheduleId = scheduleId;
        this.substitutionTeacherId = substituteTeacherId;
        this.remarks = remarks;
        this.status = status;
    }

    public SubstitutionAssignments(int substitutionId, int scheduleId) {
        super();
        this.substitutionId = substitutionId;
        this.scheduleId = scheduleId;
    }

    public int getSubstitutionId() {
        return substitutionId;
    }

    public void setSubstitutionId(int substitutionId) {
        this.substitutionId = substitutionId;
    }

    public int getScheduleId() {
        return this.scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getSubstituteTeacherID() {
        return substitutionTeacherId;
    }

    public void setSubstituteTeacherID(int substitutionTeacherId) {
        this.substitutionTeacherId = substitutionTeacherId;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getRemarks() {
        return this.remarks;
    }

    //additional method
    public void setSubstitutionDate(Date substitutionDate) {
        this.substitutionDate = substitutionDate;
    }

    public Date getSubstitutionDate() {
        return this.substitutionDate;
    }

    public void setAbsentTeacherID(int absentTeacherId) {
        this.absentTeacherId = absentTeacherId;
    }

    public int getAbsentTeacherId() {
        return this.absentTeacherId;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getReason() {
        return this.reason;
    }

    public void setPeriod(int period) {
        this.period = period;
    }

    public int getPeriod() {
        return this.period;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getClassName() {
        return this.className;
    }

    public void setSubjectName(String scheduleSubject) {
        this.scheduleSubject = scheduleSubject;
    }

    public String getSubjectName() {
        return this.scheduleSubject;
    }
    
      public void setScheduleDay(String scheduleDay) {
        this.scheduleDay = scheduleDay;
    }

    public String getScheduleDay() {
        return this.scheduleDay;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getNotes() {
        return this.notes;
    }
}
