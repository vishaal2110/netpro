/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

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
public class UserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        JSONObject obj = new JSONObject();
        try {
            obj.put("status", false);
            HttpSession session = request.getSession(false);
            System.out.println(session.getAttribute("user_name"));
            if (session.getAttribute("user_name") == null) {
//            if (session == null) {
                obj.put("redirect_url", "login.jsp");
            }
            obj.put("status", true);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        out.print(obj);
    }

}
