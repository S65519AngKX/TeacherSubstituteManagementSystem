/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Dao;

import com.Model.SubstitutionRequestPeriod;
import java.util.*;
import java.sql.*;
import util.Database;

public class SubstitutionRequestPeriodDao {

    public static int save(SubstitutionRequestPeriod request, Connection con) {
        int status = 0;
        try {
            PreparedStatement myPS = con.prepareStatement(
                    "INSERT INTO `substitutionRequestPeriod`(substitutionRequestId,substitutionRequestPeriod) "
                    + "VALUES(?, ?)");

            myPS.setInt(1, request.getSubstitutionRequestId());
            myPS.setInt(2, request.getSubstitutionRequestPeriod());

            status = myPS.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return status;
    }

    public static List<SubstitutionRequestPeriod> getSubstitutionRequestPeriod(int id) {
        List<SubstitutionRequestPeriod> list = new ArrayList<SubstitutionRequestPeriod>();

        try {
            Connection con = Database.getConnection();
            PreparedStatement myPS = con.prepareStatement("select * from `substitutionRequestPeriod` where substitutionRequestId=?");
            myPS.setInt(1, id);
            ResultSet rs = myPS.executeQuery();
            while (rs.next()) {
                SubstitutionRequestPeriod request = new SubstitutionRequestPeriod();
                request.setSubstitutionRequestPeriodId(rs.getInt(1));
                request.setSubstitutionRequestId(rs.getInt(2));
                request.setSubstitutionRequestPeriod(rs.getInt(3));

                list.add(request);
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    static List<Integer> getPeriodsBySubstitutionRequestId(int substitutionRequestId, Connection con) {
        List<Integer> list = new ArrayList<Integer>();
        int period;

        try {
            PreparedStatement myPS = con.prepareStatement("select substitutionRequestPeriod from `substitutionRequestPeriod` where substitutionRequestId=?");
            myPS.setInt(1, substitutionRequestId);
            ResultSet rs = myPS.executeQuery();
            while (rs.next()) {
                period=rs.getInt(1);
                list.add(period);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

}

