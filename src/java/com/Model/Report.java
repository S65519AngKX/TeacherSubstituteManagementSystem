/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

/**
 *
 * @author Khe Xin
 */
public class Report {

    private int teacherId;
    private String teacherName;
    private int totalLeaves;
    private double approvedPercentage;
    private double rejectedPercentage;
    private double pendingPercentage;
    private int totalLeaveDays;
    private int totalLeaveDaysByAllTeacher;
    private int totalApprovedLeaveDays;
    private double leaveTypePercentage;
    private String leaveTypes;
    //substitution assignment
    private int substitutionTeaherId;
    private int numSubstitute;
    private int numApply;
    private int totalSubstitute;
    private double substitutionTypePercentage;
    private String substitutionTypes;

    public int getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public int getTotalLeaves() {
        return totalLeaves;
    }

    public void setTotalLeaves(int totalLeaves) {
        this.totalLeaves = totalLeaves;
    }

    public double getApprovedPercentage() {
        return approvedPercentage;
    }

    public void setApprovedPercentage(double approvedPercentage) {
        this.approvedPercentage = approvedPercentage;
    }

    public double getRejectedPercentage() {
        return rejectedPercentage;
    }

    public void setRejectedPercentage(double rejectedPercentage) {
        this.rejectedPercentage = rejectedPercentage;
    }

    public double getPendingPercentage() {
        return pendingPercentage;
    }

    public void setPendingPercentage(double pendingPercentage) {
        this.pendingPercentage = pendingPercentage;
    }

    public int getTotalApprovedLeaveDays() {
        return totalApprovedLeaveDays;
    }

    public void setTotalApprovedLeaveDays(int totalApprovedLeaveDays) {
        this.totalApprovedLeaveDays = totalApprovedLeaveDays;
    }

    public int getTotalLeaveDays() {
        return totalLeaveDays;
    }

    public void setTotalLeaveDays(int totalLeaveDays) {
        this.totalLeaveDays = totalLeaveDays;
    }

    public int getTotalLeavesByAllTeachers() {
        return totalLeaveDaysByAllTeacher;
    }

    public void setTotalLeavesByAllTeachers(int totalLeaveDaysByAllTeacher) {
        this.totalLeaveDaysByAllTeacher = totalLeaveDaysByAllTeacher;
    }

    public String getLeaveTypes() {
        return leaveTypes;
    }

    public void setLeaveTypes(String leaveTypes) {
        this.leaveTypes = leaveTypes;
    }

    public double getLeaveTypePercentage() {
        return leaveTypePercentage;
    }

    public void setLeaveTypePercentage(double leaveTypePercentage) {
        this.leaveTypePercentage = leaveTypePercentage;
    }

    //substitution assignment report
    public int getSubstitutionTeacherId() {
        return substitutionTeaherId;
    }

    public void setSubstitutionTeacherId(int substitutionTeaherId) {
        this.substitutionTeaherId = substitutionTeaherId;
    }

    public int getNumSubstitute() {//number of times being assigned to substitute class
        return numSubstitute;
    }

    public void setNumSubstitute(int numSubstitute) {
        this.numSubstitute = numSubstitute;
    }

    public int getNumApply() {//num of times class being substituted
        return numApply;
    }

    public void setNumApply(int numApply) {
        this.numApply = numApply;
    }

    public int getTotalSubstitute() {
        return totalSubstitute;
    }

    public void setTotalSubstitute(int totalSubstitute) {
        this.totalSubstitute = totalSubstitute;
    }

    public String getSubstitutionTypes() {
        return substitutionTypes;
    }

    public void setSubstitutionTypes(String substitutionTypes) {
        this.substitutionTypes = substitutionTypes;
    }

    public double getSubstitutionTypePercentage() {
        return substitutionTypePercentage;
    }

    public void setSubstitutionTypePercentage(double substitutionTypePercentage) {
        this.substitutionTypePercentage = substitutionTypePercentage;
    }
}
