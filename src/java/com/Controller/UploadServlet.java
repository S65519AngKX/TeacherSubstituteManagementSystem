package com.Controller;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet(name = "UploadServlet", urlPatterns = {"/UploadServlet"})
public class UploadServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String jdbcUrl = "jdbc:mysql://localhost:3306/substitutemanagement";
        String username = "root";
        String password = "admin";

        PrintWriter out = response.getWriter();

        // Retrieve uploaded CSV file
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();

        // Validate file 
        if (fileName == null || fileName.isEmpty() || !fileName.toLowerCase().endsWith(".csv")) {
            out.println("<script>alert('Invalid file! Please upload a CSV file.');</script>");
            request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
            return;
        }

        // Save the uploaded file
        File fileLocation = new File("C:\\Users\\ACER\\Desktop\\KX\\UMT\\sem5\\assignment\\fyp\\S65519_TeacherSubstituteManagementSystem\\web\\csv");
        if (!fileLocation.exists()) {
            fileLocation.mkdirs();
        }

        File uploadedFile = new File(fileLocation, fileName);
        try ( InputStream fileContent = filePart.getInputStream();  FileOutputStream outputStream = new FileOutputStream(uploadedFile)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }

        // Read and process CSV file
        try ( BufferedReader lineReader = new BufferedReader(new FileReader(uploadedFile));  Connection connection = DriverManager.getConnection(jdbcUrl, username, password)) {

            connection.setAutoCommit(false); // Disable auto-commit for batch processing

            String sql = "INSERT INTO schedule(scheduleDay,schedulePeriod,scheduleSubject,className,teacherId)VALUES(?,?,?,?,?)";
            try ( PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

                String lineText;
                int count = 0;

                lineReader.readLine(); // Skip header line

                while ((lineText = lineReader.readLine()) != null) {
                    String[] data = lineText.split(",");

                    if (data.length < 5) {
                        continue; //skip uneccesary content
                    }

                    preparedStatement.setString(1, data[0]); 
                    preparedStatement.setInt(2, Integer.parseInt(data[1])); 
                    preparedStatement.setString(3, data[2]); 
                    preparedStatement.setString(4, data[3]); 
                    preparedStatement.setInt(5, Integer.parseInt(data[4])); 

                    preparedStatement.addBatch(); // Add to batch
                    count++;

                    // Execute batch every 500 records to avoid memory overflow
                    if (count % 500 == 0) {
                        preparedStatement.executeBatch();
                    }
                }

                // Execute remaining batch
                preparedStatement.executeBatch();
                connection.commit(); // Commit all changes

                out.print("<script>alert('" + count + " records saved successfully');</script>");
                request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("<script>alert('Sorry! Unable to save schedule record.');</script>");
            request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
        /**
         * Handles the HTTP <code>GET</code> method.
         *
         * @param request servlet request
         * @param response servlet response
         * @throws ServletException if a servlet-specific error occurs
         * @throws IOException if an I/O error occurs
         */
        @Override
        protected void doGet
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Handles the HTTP <code>POST</code> method.
         *
         * @param request servlet request
         * @param response servlet response
         * @throws ServletException if a servlet-specific error occurs
         * @throws IOException if an I/O error occurs
         */
        @Override
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
