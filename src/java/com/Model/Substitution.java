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
public class Substitution {

    private int substitutionId;
    private Date substitutionDate;
    private int leaveID;
    private int substitutionRequestId;

    //others
    private String notes;
    private String reason;
    private String type;
    private String leaveStatus;
    private int teacherId;

    public int getSubstitutionId() {
        return substitutionId;
    }

    public void setSubstitutionId(int substitutionId) {
        this.substitutionId = substitutionId;
    }

    public Date getSubstitutionDate() {
        return substitutionDate;
    }

    public void setSubstitutionDate(Date substitutionDate) {
        this.substitutionDate = substitutionDate;
    }

    public int getLeaveID() {
        return leaveID;
    }

    public void setLeaveID(int leaveID) {
        this.leaveID = leaveID;
    }

    public int getSubstitutionRequestId() {
        return substitutionRequestId;
    }

    public void setSubstitutionRequestId(int substitutionRequestId) {
        this.substitutionRequestId = substitutionRequestId;
    }

    public int getTeacherID() {
        return this.teacherId;
    }

    public void setTeacherID(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getReason() {
        return this.reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getNotes() {
        return this.notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    public String getLeaveStatus() {
        return this.leaveStatus;
    }

    public void setLeaveStatus(String leaveStatus) {
        this.leaveStatus = leaveStatus;
    }
}
