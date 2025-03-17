/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.SubstitutionRequest;
import java.util.*;
import java.sql.*;
import util.Database;

public class SubstitutionRequestDao {

    public static int save(SubstitutionRequest request, Connection con) {
        int substitutionRequestId = 0;
        try (
                 PreparedStatement myPS = con.prepareStatement(
                        "INSERT INTO `substitutionRequest`(requestTeacherId,substitutionRequestDate,substitutionRequestReason, substitutionRequestNotes) "
                        + "VALUES(?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS)) {

            myPS.setInt(1, request.getRequestTeacherId());
            myPS.setDate(2, request.getSubstitutionRequestDate());
            myPS.setString(3, request.getSubstitutionRequestReason());
            myPS.setString(4, request.getSubstitutionRequestNotes());

            int rowsAffected = myPS.executeUpdate();

            if (rowsAffected > 0) {
                ResultSet rs = myPS.getGeneratedKeys();
                if (rs.next()) {
                    substitutionRequestId = rs.getInt(1);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return substitutionRequestId;
    }

    public static List<SubstitutionRequest> getSubstitutionRequestByTeacherId(int id) {
        List<SubstitutionRequest> list = new ArrayList<SubstitutionRequest>();

        try {
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from `substitutionRequest` where requestTeacherId=?");
            myPS.setInt(1, id);
            ResultSet rs = myPS.executeQuery();
            while (rs.next()) {
                SubstitutionRequest request = new SubstitutionRequest();
                request.setSubstitutionRequestId(rs.getInt(1));
                request.setRequestTeacherId(rs.getInt(2));
                request.setSubstitutionRequestDate(rs.getDate(3));
                request.setSubstitutionRequestReason(rs.getString(4));
                request.setSubstitutionRequestNotes(rs.getString(5));
                list.add(request);
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }
}
