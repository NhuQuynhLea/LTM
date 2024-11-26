<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard</title>
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

        .logout-btn {
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

        .logout-btn:hover {
            background: linear-gradient(135deg, #0575E6, #021B79);
            color: white;
            border-color: transparent;
            box-shadow: 0 4px 15px rgba(5, 117, 230, 0.3);
            transform: translateY(-1px);
        }

        .main-content {
            padding: 8rem 3rem 3rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2.5rem;
            padding: 2rem 0;
        }

        .dashboard-card {
            background: white;
            border-radius: 20px;
            padding: 2.5rem;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            transition: all 0.4s ease;
            cursor: pointer;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 250px;
            position: relative;
            overflow: hidden;
        }

        .dashboard-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(5, 117, 230, 0.95), rgba(2, 27, 121, 0.95));
            opacity: 0;
            transition: all 0.4s ease;
            z-index: 1;
        }

        .dashboard-card:hover::before {
            opacity: 1;
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(5, 117, 230, 0.2);
        }

        .card-content {
            position: relative;
            z-index: 2;
            transition: all 0.4s ease;
        }

        .card-icon {
            font-size: 48px;
            color: #0575E6;
            margin-bottom: 1.5rem;
            transition: all 0.4s ease;
        }

        .card-title {
            color: #1a237e;
            font-size: 22px;
            font-weight: 600;
            letter-spacing: 1px;
            transition: all 0.4s ease;
        }

        .card-description {
            color: #666;
            margin-top: 1rem;
            font-size: 15px;
            transition: all 0.4s ease;
            opacity: 0.9;
        }

        .dashboard-card:hover .card-icon,
        .dashboard-card:hover .card-title,
        .dashboard-card:hover .card-description {
            color: white;
        }

        @media (max-width: 768px) {
            .top-bar {
                padding: 1rem 1.5rem;
                flex-direction: column;
                gap: 1rem;
            }

            .logo-section {
                flex-direction: column;
                gap: 0.5rem;
                text-align: center;
            }

            h1::after {
                left: 30%;
                width: 40%;
            }

            .welcome-text {
                border-left: none;
                padding: 0.5rem 0;
            }

            .main-content {
                padding: 12rem 1.5rem 2rem;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: 2rem;
            }
        }
    </style>
    <%
                Member manager = (Member)session.getAttribute("manager");
                  if(manager==null){
                      response.sendRedirect("../member/login.jsp?err=timeout");
                  }
    %>
</head>
<body>

    <header class="top-bar">
        <div class="logo-section">
            <h1>Manager Home</h1>
            <div class="welcome-text">
                Welcome back!
            </div>
        </div>
        <a href="../member/login.jsp" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </header>

    <main class="main-content">
        <div class="dashboard-grid">
            <a href="manageMaterial.jsp" class="dashboard-card">
                <div class="card-content">
                    <i class="fas fa-box-open card-icon"></i>
                    <div class="card-title">Manage Material</div>

                </div>
            </a>
            <a href="statistic.jsp" class="dashboard-card">
                <div class="card-content">
                    <i class="fas fa-chart-line card-icon"></i>
                    <div class="card-title">View Statistics</div>

                </div>
            </a>
        </div>
    </main>
</body>
</html>