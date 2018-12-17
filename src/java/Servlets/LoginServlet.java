/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Beans.User;
import DAO.Services;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 *
 * @author ignite082
 */
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            JSONObject output_response = new JSONObject();
            User user = new User();
            user.setUserName(request.getParameter("user_name"));
            user.setPassword(request.getParameter("password"));
            PrintWriter out = response.getWriter();
            Services service = new Services();
            JSONObject result = service.checkLogIn(user);
            HttpSession session = request.getSession();
            if (result.getBoolean("status")) {
                session.setAttribute("user_name", user.getUserName());
                output_response.put("status", true);
                JSONObject data=result.getJSONObject("data");
                if (data.getInt("role_id") == 2) {
                    output_response.put("role", "User");
                } else if (data.getInt("role_id") == 1) {
                    output_response.put("role", "Admin");
                }
            } else {
                output_response.put("status", false);
            }
            System.out.println(output_response);
            out.print(output_response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
