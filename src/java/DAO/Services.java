/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Beans.Question;
import Beans.User;
import Utils.HibernateUtil;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONObject;
import org.json.JSONArray;

/**
 *
 * @author Vishal
 */
public class Services {

    Session session = null;
    Transaction txn = null;

    public JSONObject checkLogIn(User user) {
        JSONObject response = new JSONObject();
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            response.put("status", false);
            Query query = session.createSQLQuery("select * from user where user_name =:name and password =:pass");
            query.setString("name", user.getUserName());
            query.setString("pass", user.getPassword());
            Object[] query_obj = (Object[]) query.uniqueResult();
            JSONObject obj = new JSONObject();
            obj.put("role_id", query_obj[1]);
//            List result = query.uniqueResult();
//            JSONArray arr=new JSONArray();
//            JSONObject obj=new JSONObject();
//            for(int i=0;i<result.size();i++) {
//                Object[] queryobj=(Object[])result.get(i);
//                obj.put("role_id",queryobj[1]);
////                arr.put(obj);
//            }
            response.put("data", obj);
            response.put("status", true);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }
        return response;
    }

    public JSONObject Question(Question user) {
        JSONObject response = new JSONObject();
       
        try {
//            user.setCreatedOn(new Date());
            response.put("status",false);
            session = HibernateUtil.getSessionFactory().openSession();
            txn = session.beginTransaction();
            session.save(user);
            txn.commit();
            response.put("status",true);
        } catch (Exception e) {
            txn.rollback();
            e.printStackTrace();
        }
        finally {
            if (session.isOpen()) {
                session.close();
            }
        }
        return response;
    }
    
     public JSONObject FetchQuestions() {
        JSONObject object = new JSONObject();
        try {
            object.put("status", false);
            session = HibernateUtil.getSessionFactory().openSession();
            Query query = session.createSQLQuery("select * from question");
            List result = query.list();
            JSONArray arr = new JSONArray();
            for (int i = 0; i < result.size(); i++) {
                Object[] queryobj=(Object[])result.get(i);
                JSONObject obj=new JSONObject();
                obj.put("q_id",queryobj[0]);
                obj.put("question",queryobj[1]);
                arr.put(obj);
            }
            object.put("question", arr);
            object.put("status", true);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        finally {
            if (session.isOpen()) {
                session.close();
            }
        }
        return object;
    }
    public static void main(String[] args) {

    }
}
