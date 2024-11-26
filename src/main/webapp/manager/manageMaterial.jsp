<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Material</title>
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

        .page-title {
            text-align: center;
            margin-bottom: 3rem;
            color: #1a237e;
            font-size: 32px;
            font-weight: 700;
            position: relative;
            display: inline-block;
            left: 50%;
            transform: translateX(-50%);
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, transparent, #0575E6, transparent);
            border-radius: 2px;
        }

        .material-grid {

            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2.5rem;
            padding: 2rem 0;
        }

        .material-card {
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

        .material-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(5, 117, 230, 0.2);
        }

        .card-icon {
            font-size: 48px;
            margin-bottom: 1.5rem;
            transition: all 0.4s ease;
        }

        .card-title {
            font-size: 22px;
            font-weight: 600;
            letter-spacing: 1px;
            margin-bottom: 1rem;
        }

        .card-description {
            color: #666;
            font-size: 15px;
            line-height: 1.6;
        }

        .create-card {
            background: linear-gradient(135deg, #00c853, #009624);
            color: white;
        }

        .update-card {
            background: linear-gradient(135deg, #2196F3, #1976D2);
            color: white;
        }

        .delete-card {
            background: linear-gradient(135deg, #f44336, #c62828);
            color: white;
        }

        .view-card {
            background: linear-gradient(135deg, #9c27b0, #6a1b9a);
            color: white;
        }

        .material-card .card-description {
            color: rgba(255, 255, 255, 0.9);
        }

        @media (max-width: 768px) {
            .top-bar {
                padding: 1rem 1.5rem;
            }

            .main-content {
                padding: 8rem 1.5rem 2rem;
            }

            .material-grid {
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .page-title {
                font-size: 28px;
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
            <h1>Material Management</h1>
            <div class="welcome-text">
               Welcome back!
            </div>
        </div>

        <a href="managerHome.jsp" class="logout-btn">
                     <i class="fas fa-arrow-left"></i>
                    Back
                </a>
    </header>

    <main class="main-content">
        <div class="material-grid">
            <a href="createMaterial.jsp" class="material-card create-card">
                <i class="fas fa-plus-circle card-icon"></i>
                <div class="card-title">Create Material</div>
                <div class="card-description">
                    Add new materials to the inventory system
                </div>
            </a>

            <a href="searchMaterial.jsp" class="material-card update-card">
                <i class="fas fa-edit card-icon"></i>
                <div class="card-title">Update Material</div>
                <div class="card-description">
                    Modify existing material information
                </div>
            </a>

            <a href="deleteMaterial.jsp" class="material-card delete-card">
                <i class="fas fa-trash-alt card-icon"></i>
                <div class="card-title">Delete Material</div>
                <div class="card-description">
                    Remove materials from the system
                </div>
            </a>


        </div>
    </main>
</body>
</html>