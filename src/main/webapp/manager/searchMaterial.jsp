<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Material</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Basic styling */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            padding: 2rem;
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


        .search-bar {
            max-width: 600px;
            margin: 0 auto 2rem;
            padding: 6rem 0rem 0rem;
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 1rem;
        }

        .search-bar form input {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .search-bar form button {
            padding: 0.8rem 1.5rem;
            background: #0575E6;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s ease;
        }

        .search-bar form button:hover {
            background: #021B79;
        }
        .search-bar form {
            display: flex;
            flex-direction: row;
            gap: 1rem;
            width: 100%;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            margin-top: 1rem;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #f4f6f8;
            color: #333;
            font-weight: 600;
        }

        tr:hover {
            background: rgba(5, 117, 230, 0.1);
            cursor: pointer;
        }

        .view-btn {
            background: #2196F3;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            border: none;
            transition: background 0.3s ease;
        }

        .view-btn:hover {
            background: #1976D2;
        }
    </style>
    <%
                Member manager = (Member)session.getAttribute("manager");
                  if(manager==null){
                      response.sendRedirect("../member/login.jsp?err=timeout");
                  }

                String search = request.getParameter("searchTerm");
                ArrayList<Material> listMaterial = null;
                if(search != null) {
                     MaterialDAO materialDAO = new MaterialDAO();

                      String searchQuery = search;
                     if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                          listMaterial = new ArrayList<>();
                          listMaterial = materialDAO.searchMaterial(searchQuery);
                          session.setAttribute("listMaterial", listMaterial);
                     }
                }

    %>
</head>
<body>

    <header class="top-bar">
        <div class="logo-section">
            <h1>Search Material</h1>
            <div class="welcome-text">
                Welcome back!
            </div>
        </div>
        <a href="manageMaterial.jsp" class="logout-btn">
           <i class="fas fa-arrow-left"></i>
            Back
        </a>
    </header>
    <div class="search-bar">
         <form action="searchMaterial.jsp" method="get">
                     <input type="text" name="searchTerm" id="searchInput" placeholder="Search by material name..."
                            value="<%= request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : "" %>" />
                     <button type="submit">Search</button>
                  </form>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="materialTable">
        <%


                if (listMaterial != null && !listMaterial.isEmpty()) {
                    for (Material material : listMaterial) {
            %>
                        <tr onclick="window.location.href='editMaterial.jsp?idEdit=<%= material.getId() %>'">
                            <td><%= material.getId() %></td>
                            <td><%= material.getName() %></td>
                            <td><%= material.getDescription() %></td>
                            <td><%= material.getQuantity() %></td>
                            <td>$<%= String.format("%.2f", material.getPrice()) %></td>
                            <td>
                                <button class="view-btn" onclick="event.stopPropagation(); window.location.href='editMaterial.jsp?idEdit=<%= material.getId() %>'">
                                    Select
                                </button>
                            </td>
                        </tr>
            <%
                    }
                } else {
            %>
                    <tr>
                        <td>No materials found</td>
                    </tr>
            <%
                }
            %>
    </table>

</body>
</html>
