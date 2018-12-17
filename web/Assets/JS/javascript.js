/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validate() {
    
   

    var username = document.getElementById("user_name").value;
    var password = document.getElementById("password").value;
    if(username==="" && password===""){
        alert("Enter Username and password");
    }
   else if(username==="")
    {
        alert("Enter username");
    }
   else if(password==="")
    {
        alert("Enter Password");
    }
//    if (username === "admin" && password === "admin") {
//        alert("Welcome Admin");
//        window.location = "admin.html";
//        return false;
//    } if (username === "user")
//    {
//        alert("Welcome User");
//        window.location = "user.html";
//        return false;
//    }
}
