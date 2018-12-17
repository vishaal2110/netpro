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
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            PrintWriter out = response.getWriter();
            String logout = request.getParameter("logout");
            HttpSession session = request.getSession(false);
            session.invalidate();
//            if (logout.equals("true")) {
//                session.removeAttribute("user_name");
            out.print("true");
//            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//        JSONObject logout_status=new JSONObject();
//        PrintWriter out = response.getWriter();
//        try {
//            String logout = request.getParameter("logout");
//            HttpSession session = request.getSession(false);
//            if(session!=null) {
//                session.invalidate();
//                logout_status.put("status",true);
//            }
//        } catch (Exception e) {
//            try{
//            logout_status.put("status",false);
//            }catch(Exception ex) {
//                ex.printStackTrace();
//            }
//        }
//        out.print(logout_status);
//    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
