<%-- 
    Document   : admin
    Created on : 16 Dec, 2018, 7:18:03 PM
    Author     : Vishal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>QuizBox - Welcome Admin</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <!--<link href="Assets/CSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>-->
        <link href="Assets/CSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="Assets/JS/jquery.min.js" type="text/javascript"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="Assets/JS/jquery.dataTables.minn.js" type="text/javascript"></script>
        <link href="Assets/CSS/jquery.dataTables.min_1.css" rel="stylesheet" type="text/css"/>
        <link href="Assets/CSS/admin_css.css" rel="stylesheet" type="text/css"/>
        <script src="Assets/JS/nicEdit.js" type="text/javascript"></script>
        <script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
        <script type="text/javascript">bkLib.onDomLoaded(nicEditors.allTextAreas);</script>
        <style>
            #mychart_answeredQuestion
            {
                margin-left:15%;
                margin-top:3%;
            }
        </style>

    </head>

    <body  onload="startTime()">

        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#" style="font-size:28px;color:white; font-family:Lucida Console;margin-left:2%;padding-top:18px"><b>QuizBox</b></a>
                    <div id="txt" style="color:white;margin-left:700%;margin-top:15px;font-size:21px"></div>
                </div>
                <ul class="nav navbar-nav" style="font-size:18.5px;padding-top:3.5px">
                    <li style="margin-left:15px" onclick="home()"><a href="#">Home</a></li>
                    <li onclick="function1()"><a href="#" >Show Response</a></li>
                    <li onclick="function4()"><a href="#">Defaulters List</a></li>
                    <li onclick="charts()"><a href="#">Charts</a></li>

                </ul>
                <button id="logout" class="btn navbar-btn" style="margin-left:40%;;color:white;font-size:18px;border-radius:7%" ><a href="/LogoutServlet"><span class="glyphicon glyphicon-log-in">&nbsp;</span>Logout</a></button>
            </div>
        </nav>
        <div class="page-header" id="h1" style="font-family:Comic Sans MS cursive  sans-serif;width:30%;margin-top:4.5%">
            <h1 id="h1" style="font-size:34px;color:white;text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Add Questions</h1>
        </div>
        <div class="panel panel-primary" id="pan" style="width:40%;margin-left:28%;margin-top:5.5%;border-radius:3%">
            <div class="panel-heading" style="background-image:linear-gradient(to right,#2b5876 , #4e4376)"><b>Add Questions</b></div>
            <div class="panel-body" >
                <div id="div">

                    <textarea placeholder="Enter Question" rows="1" cols="50" id="txt1"  style="width:100%">

                    </textarea><br>
                    <label id='l1'>What type of question?</label>
                    &nbsp; &nbsp;&nbsp;&nbsp;
                    <div id="radioptn" >
                        <input type="radio" id="subj" name="rtb_question" value="Subjective" onclick="function2()">Subjective  &nbsp; &nbsp;&nbsp;&nbsp;
                        <input type="radio" id="subj" name="rtb_question" value="Objective" onclick="function2()" >Objective<br><br>
                        <input type="text" id="add-options" placeholder="Add options" style="width:25%">
                        <button id="btn7" style="width:15%; border-radius:3% ">Add</button>
                    </div>
                </div>
                <div id="sub">
                    <button id="btn5" style="margin-left: 65%; margin-top:7%; border-radius:5%" ><b>Submit</b></button>
                    <button id="btn6" style="border-radius:5%" onclick="reset()"><b>Reset</b></button>
                </div>
            </div>
        </div>

        <div class="page-header" id="h2" style="font-family:Comic Sans MS cursive  sans-serif;width:30%;margin-top:4.5%">
            <h1 style="font-size:34px;color:white;text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Show Response</h1>
        </div>
        <div id="response-table">
            <table id="myTable" style="margin-top:6%">
                <thead  style='background-image:linear-gradient(to right,#2b5876 , #4e4376);color:white'>
                    <tr>
                        <th>User Name</th> 
                        <th>Question</th> 
                        <th>Answer</th></tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div class="page-header" id="h3" style="font-family:Comic Sans MS cursive  sans-serif;width:30%;margin-top:4.5%">
            <h1 style="font-size:34px;color:white;text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Defaulters List</h1>
        </div>
        <div id="defaulter-table" >
            <a href="DownloadServlet" class="btn btn-link" id="download" style="font-size:16px;color:white;background-color:black;width:16%;margin-left:22%;margin-top:-196px">Download</a>
            <table id="myTable1" style="margin-top:6%">
                <thead style='background-image:linear-gradient(to right,#2b5876 , #4e4376);color:white'>
                    <tr>
                        <th>User Name</th>
                        <th style="width:200px">Defaulter Percentage</th></tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
        <div class="page-header" id="charthead" style="font-family:Comic Sans MS cursive  sans-serif;width:30%;margin-top:4.5%">
            <h1 style="font-size:34px;color:white;text-shadow: 1px 1px 2px black, 0 0 25px blue, 0 0 5px darkblue;">Charts</h1>
        </div>
        <canvas id="mychart_answeredQuestion" width="400" height="400" style="background-color:white"></canvas>
        <canvas id="mychart_defaulterpercentage" width="400" height="400" style="background-color:white"></canvas>
        <script src="Assets/JS/Chart.js" type="text/javascript"></script>
        <div id="chartContainer" style="height: 360px; width: 100%;"></div>

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
                        $("#response-table").hide();
                        $("#h2").hide();
                        $("#add-options").hide();
                        $("#btn7").hide();
                        $("#btn5").hide();
                        $("#btn6").hide();
                        $("#defaulter-table").hide();
                        $("#h3").hide();
                        $("#l1").slideDown(1200);
                        $("#subm").hide();
                        $("#mychart_answeredQuestion").hide();
                        $("#mychart_defaulterpercentage").hide();
                        $("#charthead").hide();
                        $("#chartContainer").hide();

                        function def()
                        {
                            $("#h2").hide();
                            $("#add-options").hide();
                            $("#btn7").hide();
                            $("#btn5").hide();
                            $("#btn6").hide();
                            $('.nicEdit-main').slideDown(1200);
                            $("#l1").slideDown(1200);
                            $("#radioptn").slideDown(1200);
                            $("#master").hide();
                            $("#delete").hide();
                            $(".main").hide();
                            $("#mychart_answeredQuestion").hide();
                            $("#mychart_defaulterpercentage").hide();
                            $("#charthead").hide();
                        }
                        function function2()
                        {
                            var b = $('.nicEdit-main').text();

                            if (b === "" || b === null)
                            {
                                window.alert("Question field is empty");
                                return false;
                            } else if (b.trim() === "" || b === null)
                            {
                                window.alert("Question field is empty");
                                return false;
                            } else {
                                var ques_type = $('input[name=rtb_question]:checked').val();
                                console.log(ques_type);
                                if (ques_type === "Subjective")
                                {
                                    showsub();
                                    return true;
                                } else if (ques_type === "Objective")
                                {
                                    showobj();
                                    return true;
                                }
                            }
                        }
                        function showsub()
                        {
                            $("#btn5").show();
                            $("#btn6").show();
                            $("#btn7").slideUp("fast");
                            $("#add-options").slideUp("fast");
                            $('.main').slideUp("fast");
                        }
                        function showobj()
                        {
                            $("#add-options").show();
                            $("#btn7").show();
                            $("#btn5").show();
                            $("#btn6").show();
                            document.getElementById("add-options").value = "";
                        }

                        $("#btn7").on("click", function () {
                            var value = $("#add-options").val();
                            if ($("#add-options").val().length === 0)
                            {
                                window.alert("Field is blank");
                                return false;
                            }
                            if (value.trim() === "") {
                                window.alert("Enter valid value");
                                return false;
                            }
                            var row = '<div class="main"><input type="radio" id="options" name="ques-options" >' + $("#add-options").val() + '&nbsp;&nbsp;<button id="delete" class="deloptions">delete</div>';
                            $("#div").append(row);
                            $('#add-options').val('');
                        });
                        $("body").delegate(".deloptions", "click", function () {
                            $($(this).parent()).remove();
                        });
                        function reset()
                        {
                            $(".nicEdit-main").empty();
                            $("#add_options").empty();
                            $(".main").hide();
                            def();
                        }

                        function function1()
                        {
                            $("#defaulter-table").hide();
                            $("#pan").slideUp(1200);
                            $("#h2").show();
                            $("#h1").slideUp(1200);
                            $("#h3").hide();
                            $("#response-table").slideDown(1200);
                            var table = $('#myTable').DataTable();
                            $("#response-table").show();
                            $("#mychart_answeredQuestion").hide();
                            $("#mychart_defaulterpercentage").hide();
                            $("#charthead").hide();
                        }

                        function home()
                        {
                            $("#response-table").slideUp(1200);
                            $("#h2").slideUp(1200);
                            $("#add-options").slideUp(1200);
                            $("#btn7").slideUp(1200);
                            $("#btn5").slideUp(1200);
                            $("#btn6").slideUp(1200);
                            $("#pan").slideDown(1200);
                            $("#h1").slideDown(1200);
                            $("#myTable1").slideUp(1200);
                            $("#h3").slideUp(1200);
                            $("#defaulter-table").hide(1200);
                            $("#mychart_answeredQuestion").hide();
                            $("#mychart_defaulterpercentage").hide();
                            $("#charthead").hide();
                        }

                        function function4()
                        {
                            $("#myTable1").slideDown(1200);
                            $("#response-table").hide();
                            $("#h2").hide();
                            $("#add-options").hide();
                            $("#btn7").hide();
                            $("#btn5").hide();
                            $("#btn6").hide();
                            $("#pan").hide();
                            $("#h1").hide();
                            $("#h3").slideDown(1200);
                            $("#defaulter-table").show();
                            var table = $('#myTable1').DataTable();
                            $("#defaulter-table").show();
                            $("#mychart_answeredQuestion").hide();
                            $("#mychart_defaulterpercentage").hide();
                            $("#charthead").hide();
                        }
                        function startTime() {
                            var today = new Date();
                            var h = today.getHours();
                            var m = today.getMinutes();
                            var s = today.getSeconds();
                            m = checkTime(m);
                            s = checkTime(s);
                            document.getElementById('txt').innerHTML =
                                    h + ":" + m + ":" + s;
                            var t = setTimeout(startTime, 500);
                        }
                        function checkTime(i) {
                            if (i < 10) {
                                i = "0" + i;
                            }
                            return i;
                        }
                        $(function () {
                            $("#btn5").click(function () {
                                var ques_type = $('input[name=question]:checked').val();
                                if (ques_type === "Objective")
                                {
//                                    var opt = $(".main").val();
//                                    console.log(opt);
//                                    if (opt === "")
//                                    {
//                                        window.alert("Please provide options");
//                                        return false;
//                                    }
                                    if ($(".main").val() === "")
                                    {
                                        window.alert("please provide options");
                                        return false;
                                    }
                                    var ques_box1 = $('.nicEdit-main').text();

                                    if (ques_box1 === "" || ques_box1 === null)
                                    {
                                        window.alert("Question field is blank");
                                        return false;
                                    }
                                    if (ques_box1 !== null)
                                    {

                                        if (ques_box1.trim() === "")
                                        {
                                            window.alert("Enter valid question");
                                            return false;
                                        }
                                    }

                                }
                                if (ques_type === "Subjective")
                                {
                                    var ques_box = $('.nicEdit-main').text();

                                    if (ques_box === "")
                                    {
                                        window.alert("Question field is blank");
                                        return false;
                                    } else if (ques_box.trim() === "")
                                    {
                                        window.alert("Enter valid question");
                                        return false;
                                    }
                                }
                                $.ajax({
                                    url: "InsertQuestion",
                                    method: "POST",
                                    dataType: "json",
                                    data: {
                                        question: $(".nicEdit-main").text(),
                                        q_type: $("input[name='rtb_question']:checked").val()
                                    }, success: function (response) {
                                        if (response.status === true) {
                                            alert("Data Saved");
                                        } else {
                                            alert("Data Not Saved");
                                        }
                                    }, error: function (error) {
//                                        alert("error");
//                                        console.log(error);
                                    }
                                });
                                return false;
                            });
                        });
                        $(function () {
                            $.ajax({
                                url: "fetchDefaulterPercentage",
                                method: "POST",
                                dataType: "json",
                                success: function (response) {
//                                    console.log(response);
                                    if (response.status === true) {
                                        for (var i = 0; i < response.fetchDefaulterPercentage.length; i++) {
                                            var temp = "<tr>";
                                            temp += "<td>";
                                            temp += response.fetchDefaulterPercentage[i].user_name;
                                            temp += "</td>";
                                            temp += "<td>";
                                            temp += response.fetchDefaulterPercentage[i].count_answer + "%";
                                            temp += "</td>";
                                            temp += "</tr>";
                                            $("#myTable1").append(temp);
                                        }
                                    } else {
                                        alert("error");
                                    }
                                }, error: function (error) {
//                                    alert("error");
//                                    console.log(error);
                                }
                            });
                        });
                        $(function () {
                            $.ajax({
                                url: "response",
                                method: "Post",
                                dataType: "json",
                                success: function (response) {
//                                    console.log(response);
                                    if (response.status === true) {
                                        for (var i = 0; i < response.response.length; i++) {
                                            var temp = "<tr>";
                                            temp += "<td>";
                                            temp += response.response[i].user_name;
                                            temp += "</td>";
                                            temp += "<td>";
                                            temp += response.response[i].question;
                                            temp += "</td>";
                                            temp += "<td>";
                                            temp += response.response[i].answer;
                                            temp += "</td>";
                                            temp += "</tr>";
                                            $("#myTable").append(temp);
                                        }
                                    } else {
//                                        alert("error");
                                    }
                                }, error: function (error) {
//                                    alert("error");
//                                    console.log(error);
                                }
                            });
                        });
                        $("#logout").click(function () {
                            $.ajax({
                                url: "LogoutServlet",
                                type: 'POST',
                                data: {
                                    logout: true
                                },
                                success: function (result) {
                                    if (result === "true") {
                                        location.href = "login.jsp";
                                    }
                                },
                                error: function (err) {
                                    alert("Error in connecting");
//                                    console.log(err);
                                }
                            });
                        });
                        var data;
                        $(function () {
                            $.ajax({
                                url: "fetchMostAnsweredQuestion",
                                method: "Post",
                                dataType: "json",
                                success: function (response) {
//                                    console.log(response);
                                    data = response;
//                                    console.log(data);
                                    var ctx = document.getElementById("mychart_answeredQuestion");
                                    var labels_array = [];
                                    var data_array = [];
                                    if (data.status) {
                                        for (var index = 0; index < data.fetchMostAnsweredQuestion.length; index++) {
//                                            console.log(data.fetchMostAnsweredQuestion[index].answer_count);
                                            if (!(index === 10))
                                            {
                                                labels_array.push(data.fetchMostAnsweredQuestion[index].question);
                                                data_array.push(data.fetchMostAnsweredQuestion[index].answer_count);
                                            } else
                                            {
                                                break;
                                            }
                                        }
                                        var myChart = new Chart(ctx, {
                                            type: 'bar',
                                            data: {
                                                labels: labels_array,
                                                datasets: [{
                                                        label: 'Most answered questions',
                                                        data: data_array,
                                                        backgroundColor: [
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3'
                                                        ],
                                                        borderColor: [
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black'
                                                        ],
                                                        borderWidth: 1
                                                    }]
                                            }, options: {
                                                responsive: false,
                                                scales: {
                                                    xAxes: [{
                                                            ticks: {
                                                                maxRotation: 90,
                                                                minRotation: 80
                                                            }
                                                        }],
                                                    yAxes: [{
                                                            ticks: {
                                                                beginAtZero: true
                                                            }
                                                        }]
                                                }
                                            }
                                        });
                                    }
                                }, error: function (error) {
//                                    alert("error");
//                                    console.log(error);
                                }
                            });
                        });
                        var data;
                        $(function () {
                            $.ajax({
                                url: "fetchDefaulterPercentage",
                                method: "POST",
                                dataType: "json",
                                success: function (response) {
//                                    console.log(response);
                                    data = response;
//                                    console.log(data);
                                    var ctx = document.getElementById("mychart_defaulterpercentage");
                                    var labels_array = [];
                                    var data_array = [];
                                    if (data.status) {
                                        for (var index = 0; index < data.fetchDefaulterPercentage.length; index++) {
                                            labels_array.push(data.fetchDefaulterPercentage[index].user_name);
                                            data_array.push(data.fetchDefaulterPercentage[index].count_answer);
//                                          
                                        }
                                        var myChart = new Chart(ctx, {
                                            type: 'bar',
                                            data: {
                                                labels: labels_array,
                                                datasets: [{
                                                        label: 'Defaulters',
                                                        data: data_array,
                                                        backgroundColor: [
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3',
                                                            '#5F68C3'
                                                        ],
                                                        borderColor: [
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black',
                                                            'black'
                                                        ],
                                                        borderWidth: 1
                                                    }]
                                            }, options: {
                                                responsive: false,
                                                scales: {
                                                    xAxes: [{
                                                            ticks: {
                                                                maxRotation: 90,
                                                                minRotation: 80
                                                            }
                                                        }],
                                                    yAxes: [{
                                                            ticks: {
                                                                beginAtZero: true
                                                            }
                                                        }]
                                                }
                                            }
                                        });
                                    }
                                }, error: function (error) {
//                                    alert("error");
//                                    console.log(error);
                                }
                            });
                        });

                        function charts()
                        {
                            $("#charthead").slideDown(1200);
                            $("#mychart_answeredQuestion").slideDown(1200);
                            $("#mychart_defaulterpercentage").slideDown(1200);
                            $("#defaulter-table").hide();
                            $("#h3").hide();
                            $("#l1").show();
                            $("#subm").hide();
                            $("#response-table").hide();
                            $("#h2").hide();
                            $("#add-options").hide();
                            $("#btn7").hide();
                            $("#btn5").hide();
                            $("#btn6").hide();
                            $("#pan").hide();
                            $("#h1").hide();

                        }
        </script>
    </body>
</html>