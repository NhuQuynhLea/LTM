<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Import Material</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            background-image:
                radial-gradient(at 40% 20%, rgba(5, 117, 230, 0.1) 0px, transparent 50%),
                radial-gradient(at 80% 0%, rgba(33, 150, 243, 0.1) 0px, transparent 50%),
                radial-gradient(at 0% 50%, rgba(5, 117, 230, 0.1) 0px, transparent 50%);
        }

        .top-bar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            padding: 1.2rem 3rem;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 2rem;
        }
         .welcome-text {
                    color: #505965;
                    font-size: 16px;
                    font-weight: 500;
                    background: linear-gradient(90deg, #0575E6, #021B79);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    padding: 0.5rem 1rem;
                    border-left: 2px solid #0575E6;
                }

        h1 {
            color: #1a237e;
            font-size: 26px;
            font-weight: 700;
            letter-spacing: 0.5px;
            position: relative;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 40%;
            height: 3px;
            background: linear-gradient(90deg, #0575E6, transparent);
            border-radius: 2px;
        }

        .back-btn {
            background-color: white;
            color: #0575E6;
            border: 2px solid #0575E6;
            padding: 0.6rem 1.8rem;
            border-radius: 50px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .back-btn:hover {
            background: linear-gradient(135deg, #0575E6, #021B79);
            color: white;
            border-color: transparent;
            box-shadow: 0 4px 15px rgba(5, 117, 230, 0.3);
            transform: translateY(-1px);
        }

        .main-content {
            padding: 8rem 3rem 3rem;
            max-width: 800px;
            margin: 0 auto;
        }

        .import-form {
            background: white;
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        }

        .form-title {
            color: #1a237e;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 2rem;
            text-align: center;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            color: #505965;
            font-size: 15px;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .form-input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 15px;
            color: #333;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: #0575E6;
            box-shadow: 0 0 0 3px rgba(5, 117, 230, 0.1);
        }

        .import-btn {
            width: 100%;
            padding: 1rem;
            border: none;
            border-radius: 8px;
            background: linear-gradient(135deg, #0575E6, #021B79);
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .import-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(5, 117, 230, 0.3);
        }

        .import-btn:active {
            transform: translateY(0);
        }

        @media (max-width: 768px) {
            .top-bar {
                padding: 1rem 1.5rem;
            }

            .main-content {
                padding: 8rem 1.5rem 2rem;
            }

            .import-form {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <%
        Member staff = (Member)session.getAttribute("staff");
        if(staff==null){
            response.sendRedirect("../member/login.jsp?err=timeout");
        }
        String invoiceCode = "";
        String invoiceDate = "2024-01-01";


    %>
    <header class="top-bar">
        <div class="logo-section">
                    <h1>Import Material</h1>
                    <div class="welcome-text">
                        Welcome back!
                    </div>
                </div>
        <a href="staffHome.jsp" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            Back
        </a>
    </header>

    <main class="main-content">
        <form class="import-form" action="searchProvider.jsp" method="post">
            <h2 class="form-title">Import Materials</h2>

            <div class="form-group">
                <label for="invoiceCode" class="form-label">Code</label>
                <input
                    type="text"
                    id="invoiceCode"
                    name="invoiceCode"
                    class="form-input"
                    placeholder="Enter the code"
                    value="<%= invoiceCode%>"
                    required
                >
            </div>

            <div class="form-group">
                <label for="invoiceDate" class="form-label">Date</label>
                <input
                    type="date"
                    id="invoiceDate"
                    name="invoiceDate"
                    class="form-input"value="<%= invoiceDate %>"

                    required

                >
            </div>

            <button type="submit" class="import-btn">
               Import

            </button>
        </form>
    </main>
</body>

</html>