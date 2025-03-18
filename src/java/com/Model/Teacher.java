/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

/**
 *
 * @author ACER
 */
public class Teacher {

    private int teacherId;
    private String teacherName;
    private String teacherEmail;
    private String teacherContact;
    private String teacherRole;
    private String telegramID;
    
    public Teacher(){
        
    }

    public Teacher(String teacherName, String teacherEmail, String teacherContact,String teacherRole, String telegramID) {
        super();
        this.teacherName = teacherName;
        this.teacherEmail = teacherEmail;
        this.teacherContact = teacherContact;
        this.teacherRole = teacherRole;
        this.telegramID = telegramID;
    }
    
     public Teacher(int teacherId, String teacherName, String teacherEmail, String teacherContact,String teacherRole, String telegramID) {
        super();
        this.teacherId = teacherId;
        this.teacherName = teacherName;
        this.teacherEmail = teacherEmail;
        this.teacherContact = teacherContact;
        this.teacherRole = teacherRole;
        this.telegramID = telegramID;
    }

    public int getTeacherID() {
        return teacherId;
    }

    public void setTeacherID(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTeacherEmail() {
        return teacherEmail;
    }

    public void setTeacherEmail(String teacherEmail) {
        this.teacherEmail = teacherEmail;
    }

    public String getTeacherContact() {
        return teacherContact;
    }

    public void setTeacherContact(String teacherContact) {
        this.teacherContact = teacherContact;
    }

    public String getTeacherRole() {
        return teacherRole;
    }

    public void setTeacherRole(String teacherRole) {
        this.teacherRole = teacherRole;
    }

    public String getTelegramId() {
        return telegramID;
    }

    public void setTelegramId(String telegramID) {
        this.telegramID = telegramID;
    }
}
