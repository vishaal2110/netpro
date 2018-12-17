<%-- 
    Document   : index
    Created on : 16 Dec, 2018, 7:05:58 PM
    Author     : Vishal
--%>
<%@page import="Beans.User"%>
<%@page import="DAO.Services"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    HttpSession session1 = request.getSession();
    if (session1== null) {
        response.sendRedirect("login.jsp");
        
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Login</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="Assets/JS/jquery.min.js" type="text/javascript"></script>
        <script src="Assets/JS/javascript.js" type="text/javascript"></script>
        <link href="Assets/CSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="Assets/CSS/style.css" rel="stylesheet" type="text/css"/>
        <link href="Assets/CSS/style_1.css" rel="stylesheet" type="text/css"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <body onload="show()">
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#" style="font-size:28px;color:white; font-family:Lucida Console;margin-left:370%;padding-top:18px"><b>QuizBox</b></a>
                </div>
            </div>
        </nav>
        <div class="container cn">
            <div class="col-lg-4">
                <div class="page-header">
                    <h2><b>Log In</b></h2>

                </div>

                <div class="form-group">
                    <label for="username">UserName:&nbsp;<sup style="color:red;font-size:18px">*</sup></label>
                    <input  type="text"  id="user_name"  name="username" style=" border-top:none;border-left:none;border-right:none; margin-top:3%;margin-left:8%;width:81%;border-bottom:1px solid black">
                    <label for="pwd">Password:&nbsp;<sup style="color:red;font-size:18px">*</sup></label>
                    <input  type="password"  id="password"  name="password" style=" border-top:none;border-left:none;border-right:none; margin-top:3%;margin-left:8%;width:81%;border-bottom:1px solid black">
                    <div id="frgt">
                        Have you forgotten your
                        <a><b>username</b> </a>or <a><b>password?</b></a>
                    </div>
                    <button id="submit" onclick="validate()">
                        Continue
                    </button>
                    <div id="bottom">
                        Do you wish to register 
                        for <a><b>a new account</b> </a>
                    </div>
                </div>
            </div>
        </div>
        <script>
                        $(".cn").hide();
                        function show()
                        {
                            $(".cn").fadeIn(1500);
                        }
                        $(document).ready(function () {
                            $("#submit").click(function () {
                                var user_name = $("#user_name").val();
                                var password = $("#password").val();
                                $.ajax({
                                    url: "LoginServlet",
                                    type: 'POST',
                                    dataType: "JSON",
                                    data: {
                                        user_name: user_name,
                                        password: password
                                    },
                                    success: function (result) {
//                                        console.log(result);
                                        if (result.status) {
                                            var role = result.role;
                                            if (role === "Admin")
                                                window.location.href = "admin.jsp";
                                            else if (role === "User")
                                                window.location.href = "user.jsp";
                                            else
                                                window.location.href = "login.jsp";
                                        } else
                                            alert("No record found");

                                    },
                                    error: function (err) {
                                        alert("Enter valid Id and password");
//                                        console.log(err);
                                    }
                                });
                            });
                        });
                        
                        function validate()
                        {
                            var e=$("#user_name").val();
                            var p=$("#password").val();
                            if(e==="")
                            {
                                alert("Invalid")
                            }
                        }
        </script>
    </body>
</html>
