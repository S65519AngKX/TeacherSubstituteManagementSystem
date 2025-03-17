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
public class SubstitutionRequest {

    private int substitutionRequestId;
    private int requestTeacherId;
    private Date substitutionRequestDate;
    private String substitutionRequestReason;
    private String substitutionRequestNotes;
    
    public SubstitutionRequest(){
        
    }
    
    public SubstitutionRequest(int requestTeacherId, Date substitutionRequestDate, String substitutionRequestReason, String substitutionRequestNotes){
        super();
        this.requestTeacherId = requestTeacherId;
        this.substitutionRequestDate = substitutionRequestDate;
        this.substitutionRequestReason = substitutionRequestReason;
        this.substitutionRequestNotes = substitutionRequestNotes;
    }

    public int getSubstitutionRequestId() {
        return substitutionRequestId;
    }

    public void setSubstitutionRequestId(int substitutionRequestId) {
        this.substitutionRequestId = substitutionRequestId;
    }

    public int getRequestTeacherId() {
        return requestTeacherId;
    }

    public void setRequestTeacherId(int requestTeacherId) {
        this.requestTeacherId = requestTeacherId;
    }

    public Date getSubstitutionRequestDate() {
        return substitutionRequestDate;
    }

    public void setSubstitutionRequestDate(Date substitutionRequestDate) {
        this.substitutionRequestDate = substitutionRequestDate;
    }

    public String getSubstitutionRequestReason() {
        return substitutionRequestReason;
    }

    public void setSubstitutionRequestReason(String substitutionRequestReason) {
        this.substitutionRequestReason = substitutionRequestReason;
    }

    public String getSubstitutionRequestNotes() {
        return substitutionRequestNotes;
    }

    public void setSubstitutionRequestNotes(String substitutionRequestNotes) {
        this.substitutionRequestNotes = substitutionRequestNotes;
    }

}
