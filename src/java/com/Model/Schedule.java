/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

/**
 *
 * @author Khe Xin
 */
public class Schedule {

    private int scheduleId;
    private String scheduleDay;
    private int schedulePeriod;
    private String scheduleSubject;
    private String className;
    private int teacherId;

    public Schedule() {
    }

    public Schedule(String scheduleDay, int schedulePeriod, String scheduleSubject, String className, int teacherId) {
        super();
        this.scheduleDay = scheduleDay;
        this.schedulePeriod = schedulePeriod;
        this.scheduleSubject = scheduleSubject;
        this.className = className;
        this.teacherId = teacherId;
    }

    public Schedule(int scheduleId, String scheduleDay, int schedulePeriod, String scheduleSubject, String className, int teacherId) {
        super();
        this.scheduleId = scheduleId;
        this.scheduleDay = scheduleDay;
        this.schedulePeriod = schedulePeriod;
        this.scheduleSubject = scheduleSubject;
        this.className = className;
        this.teacherId = teacherId;
    }

    public int getScheduleId() {
        return this.scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public String getScheduleDay() {
        return this.scheduleDay;
    }

    public void setScheduleDay(String scheduleDay) {
        this.scheduleDay = scheduleDay;
    }

    public int getSchedulePeriod() {
        return this.schedulePeriod;
    }

    public void setSchedulePeriod(int schedulePeriod) {
        this.schedulePeriod = schedulePeriod;
    }

    public String getScheduleSubject() {
        return this.scheduleSubject;
    }

    public void setScheduleSubject(String scheduleSubject) {
        this.scheduleSubject = scheduleSubject;
    }

    public String getClassName() {
        return this.className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public int getTeacherId() {
        return this.teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

}
