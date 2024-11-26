<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
     body{
         background: #f0f2f5;
                    background-image:
                        radial-gradient(at 40% 20%, rgba(5, 117, 230, 0.1) 0px, transparent 50%),
                        radial-gradient(at 80% 0%, rgba(33, 150, 243, 0.1) 0px, transparent 50%),
                        radial-gradient(at 0% 50%, rgba(5, 117, 230, 0.1) 0px, transparent 50%);
        height: 100vh;
         margin: 0;
          display:flex;
          justify-content:center;
          align-items: center;
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
     .login-container {
          background-color: white;
          box-shadow: 0 10px 30px rgba(0,0,0,0.1);
          border-radius: 20px;
          padding: 3rem 2rem;
          text-align: center;
          width: 100%;
          max-width: 450px;
     }
      h1 {
           color: #0575E6;
           margin-bottom: 2rem;
           font-size: 28px;
           font-weight: 600;
           text-transform: uppercase;
           letter-spacing: 1px;
       }
       .form-input {
             margin-bottom: 1.5rem;
        }
      input {
           width: 100%;
           padding: 1rem;
           margin-bottom: 1rem;
           border: 2px solid #eee;
           border-radius: 12px;
           box-sizing: border-box;
           font-size: 16px;
           transition: all 0.3s ease;
           background: white;
      }
      input:focus {
           outline: none;
           border-color:#0575E6;
           box-shadow: 0 0 15px rgba(5, 117, 230, 0.2);
           }
      input::placeholder {
           color: #999;
           }
      button {
           background: linear-gradient(45deg, #0575E6 0%, #021B79 100%);
           color: white;
           padding: 1rem;
           border: none;
           border-radius: 12px;
           cursor: pointer;
           font-size: 16px;
           font-weight: 600;
           width: 100%;
           transition: all 0.3s ease;
           text-transform: uppercase;
           letter-spacing: 1px;
          }
      button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
            background: linear-gradient(45deg, #021B79 0%, #0575E6 100%);
              }
      @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                 opacity: 1;
                 transform: translateY(0);
                 }
              }

        .login-container {
             animation: fadeIn 0.6s ease-out;
        }
    </style>

</head>
<body>
   <div class="login-container">
   <h1>Welcome Back</h1>
             <%
                    String username = "";
                    String password = "";
                   if(request.getParameter("err") !=null && request.getParameter("err").equalsIgnoreCase("timeout")){
                       %> <h4>Login again!</h4><%
                   }else if(request.getParameter("err") !=null && request.getParameter("err").equalsIgnoreCase("fail")){
                     username = (String) session.getAttribute("username");
                     password = (String) session.getAttribute("password");
                       %> <h4 style="color: red;">Invalid username/password!</h4><%

                   }
                   %>
           <form action="/tomcat/member/doLogin.jsp" method="post">
                <div class="form-input">
                    <input type="text" name="username" placeholder="Username" required value="<%= username != null ? username : "" %>">
                    <input type="password" name="password" placeholder="Password" required value="<%= password != null ? password : "" %>">
                </div>
                <button type="submit">Login</button>
            </form>
   </div>
</body>
</html>
