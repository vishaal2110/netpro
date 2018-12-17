<%-- 
    Document   : user
    Created on : 16 Dec, 2018, 7:18:20 PM
    Author     : Vishal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%><%--
<%@page import="Beans.User"%>
<%@page import="DAO.Services"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    HttpSession session1 = request.getSession();
    if (session1 == null) {
        response.sendRedirect("login.jsp");
    }
%>--%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Quizbox - Welcome User</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
        <link href="Assets/CSS/style_1.css" rel="stylesheet" type="text/css"/>
        <link href="Assets/CSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="Assets/JS/jquery.min.js" type="text/javascript"></script>
    </head>
    <body onload="showmsg()">
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#" style="font-size:28px;color:white; font-family:Lucida Console;margin-left:2%;padding-top:18px"><b>QuizBox</b></a>
                </div>
                <ul class="nav navbar-nav" style="font-size:18.5px;padding-top:3.5px">
                    <li style="margin-left:15px" onclick="welcome()"><a href="#">Home</a></li>
                    <li onclick="quiz()"><a href="#" >Quiz</a></li>
                </ul>
                <button id="logout" class="btn  navbar-btn" style="margin-left:65%;font-size:18px;border-radius:7%;color:white" ><a href="/LogoutServlet"><span class="glyphicon glyphicon-log-in">&nbsp;</span>Logout</a></button>
            </div>
        </nav>
        <div id="wel">
            <label id="l1">Hey There,</label><br>
            <label id="l2">Ready for the quiz?</label><br>
            <label id="l3">All questions must be answered.<br> The quiz will be submitted at the end.</label><br><br>
            <label id="l4"><b>Good Luck!</b></label><br>
            <button id="continue" onclick="quiz()">Continue</button>
        </div>
        <div class="container">

            <div class="page-header" id="h2" style="font-family:Comic Sans MS cursive  sans-serif;width:25%;margin-top:3%">
                <h1 style="font-size:34px;color:white;text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Quiz</h1>
            </div>
            <div class="panel panel-default" id="pan2" style="width:60%;height:440px;margin-left:20%;margin-top:3%">
                <div class="panel-heading" style='background-image:linear-gradient(to right,#2b5876 , #4e4376);color:white;height:10%;font-size:20px'>
                    <!--                    <div class="progress">
                                            <div class="progress-bar progress-bar-info progress-bar-striped" role="progressbar"
                                                 aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width:100%" id="progressbar">
                                                100%+
                                            </div>
                                      </  </div>-->
                    <b><center>Questions</center></b>
                </div>
                <br>
                <div class="card-body">
                    <form onsubmit="return false;">
                        <div class="panel-body" id="block" >

                        </div>
                    </form>

                </div>
            </div>
        </div>
        <script>
            $.ajax({
                url: "UserServlet",
                method: "POST",
                dataType: "JSON",
                async: false,
                success: function (data) {
//                    console.log(data);
                    if (data.status) {
                        if (data.redirect_url !== undefined) {
                            window.location.href = data.redirect_url;
                        }
                    }
                }, error: function (data) {
//                    console.log(data);
                }
            });
            function showmsg()
            {
                $("#wel").slideDown(1200);
            }
//            $(document).ready(function () {
//                $.ajax({
//                   url:"UserServlet",
//                   method:"POST",
//                   dataType:"JSON",
//                   async:false,
//                   success:function(data){
//                       console.log(data);
//                       start();
//                   },error:function(data){
//                       console.log(data);
//                   }
//                });
            $("#wel").hide();
            $('.container').hide();
            function welcome()
            {
                $("#wel").slideDown();
                $('.container').slideUp();
            }
            function quiz()
            {
                $("#wel").slideUp(800);
                $("#pan2").slideDown(800);
                $('.container').slideDown(800);
                $("#img").slideDown(800);
            }
            var counter = 0;
            var answer_json = {};
            var questions = [];
//            var totalques=0
            function add_questions(counter) {
                $("#block").empty();
                for (var i = 0; i < 4; i++) {
                    if ((counter + i) < questions.length) {
                        var div_data = "Question " + (i + counter + 1) + ": " + questions[i + counter] + "<br><input type='text' style='width:80%' id='question_" + (i + counter) + "' onchange='update_question(question_" + (i + counter) + ")'><br><br>";
                        $("#block").append(div_data);
//                        totalques++;
                    }
                }
                counter += 4;
                if (counter < questions.length) {
                    var button = "<button onclick='add_questions(" + counter + ")'>NEXT</button>";
                    $("#block").append(button);
                } else {
                    var button = "<button onclick='getAnswer()'>SUBMIT</button>";
                    $("#block").append(button);
                }
//                var current_progress = 0;
//                var interval = setInterval(function () {
//                    current_progress += ((4 * 100) / totalques);
//                    $("#progressbar")
//                            .css("width", current_progress + "%")
//                            .attr("aria-valuenow", current_progress)
//                            .text(current_progress + "% Complete");
//                    if (current_progress >= 100)
//                        clearInterval(interval);
//                }, 1000);
            }
            function getAnswer() {

//                    console.log(answer_json);
                $.ajax({
                    url: "InsertAnswer",
                    method: "POST",
                    dataType: "JSON",
                    data: {
                        answer: JSON.stringify(answer_json),
                        action: "save_answer"
                    },
                    success: function (data) {
//                        console.log(data);
                        alert("Success");
                    },
                    error: function (error) {
                        alert("Error");
                    }
                });
            }
            function update_question(q_id) {
                var question_id = (q_id.id).split("_")[1];
                var question_name = questions[question_id];
//                    console.log(question_name);
                answer_json[question_name] = q_id.value;
            }
            function start() {
                $.ajax({
                    url: 'FetchQuestion',
                    type: 'POST',
                    dataType: "JSON",
                    data: {
                        action: "getQuestion"
                    },
                    success: function (data) {
                        for (var i = 0; i < data.question.length; i++) {
                            questions.push(data.question[i].question);
                        }
                        add_questions(0);

                    },
                    error: function (error) {
//                        console.log(error);
                        alert("Fail");
                    }
                });
            }
            start();

            $("#logout").click(function () {
                $.ajax({
                    url: "LogoutServlet",
                    type: 'POST',
                    data: {
                        logout: true
                    },
                    success: function (result) {
//                        console.log(result);
                        if (result === "true") {
                            location.href = "login.jsp";
                        }
                    },
                    error: function (err) {
                        alert("Error in connecting");
//                        console.log(err);
                    }
                });
            });
//            });
        </script>
    </body>
</html>