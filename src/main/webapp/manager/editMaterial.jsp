<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Material</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
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

        .container {
            max-width: 600px; /* Increased max-width */
            width: 100%;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 3rem 2rem; /* Adjusted padding */
            margin-top: 100px; /* Spacing from top bar */
        }

        h2 {
            text-align: center;
            color: #1a237e;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        label {
            font-weight: 600;
            color: #505965;
            margin-bottom: 0.5rem;
            display: block;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            color: #333;
            outline: none;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:disabled {
            background-color: #f0f2f5;
            color: #888;
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            border-color: #0575E6;
        }

        .btn-save {
            width: 100%;
            padding: 0.8rem;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background: linear-gradient(135deg, #0575E6, #021B79);
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 1.5rem;
        }

        .btn-save:hover {
            background: linear-gradient(135deg, #021B79, #0575E6);
            box-shadow: 0 4px 15px rgba(5, 117, 230, 0.3);
        }
    </style>

    <%

      Member manager = (Member)session.getAttribute("manager");
      if(manager==null){
          response.sendRedirect("../member/login.jsp?err=timeout");
      }
      int idEdit = 0;
      Material editMaterial = (Material)session.setAttribute("editMaterial");
      if(request.getParameter("err") !=null && request.getParameter("err").equalsIgnoreCase("fail")){
         editMaterial = (Material) session.getAttribute("editMaterial");
      }else{

                 try {
                     idEdit = Integer.parseInt(request.getParameter("idEdit"));

                 } catch (NumberFormatException e) {
                     response.sendRedirect("searchMaterial.jsp?error=fail");
                     return;
                 }
              ArrayList<Material> listMaterial = (ArrayList<Material>)session.getAttribute("listMaterial");


              if(listMaterial != null)
              for (Material material : listMaterial) {
                  if(material.getId() == idEdit) {
                      editMaterial = material;
                      session.setAttribute("editMaterial",editMaterial);
                      break;
                  }
               }
      }



    %>
</head>
<body>
    <header class="top-bar">
        <div class="logo-section">
            <h1>Update Material</h1>
            <div class="welcome-text">
                Welcome back!
            </div>
        </div>
        <a href="searchMaterial.jsp" class="logout-btn">
            <i class="fas fa-arrow-left"></i>
            Back
        </a>
    </header>

    <div class="container">
        <h2>Edit Material</h2>
        <form action="doEdit.jsp" method="post">
            <div class="form-group">
                <label for="materialId">Material ID</label>
                <input type="text" id="materialId" name="materialId"  value="<%= editMaterial.getId() %>"  readonly>
            </div>
            <div class="form-group">
                <label for="materialName">Name</label>
                <input type="text" id="materialName" name="materialName" value="<%= editMaterial.getName() %>">
            </div>
            <div class="form-group">
                 <label for="materialDescription">Description</label>
                 <input type="text" id="materialDescription" name="materialDescription" value="<%= editMaterial.getDescription() %>">
            </div>
            <div class="form-group">
                <label for="materialQuantity">Quantity</label>
                <input type="number" id="materialQuantity" name="materialQuantity" value="<%= editMaterial.getQuantity() %>"step="0.01>
            </div>
            <div class="form-group">
                <label for="materialPrice">Price</label>
                <input type="number" id="materialPrice" name="materialPrice" value="<%= editMaterial.getPrice() %>" step="0.01">
            </div>
            <button type="submit" class="btn-save">Save</button>
        </form>
    </div>
</body>
</html>
