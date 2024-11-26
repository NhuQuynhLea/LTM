<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*,java.text.ParseException,java.text.SimpleDateFormat,"%>
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

        .search-bar-container  {
            display: flex;
            align-items: center;
            gap: 1rem;
            max-width: 800px;
            margin: 0 auto 2rem;
            padding: 6rem 0rem 0rem;
        }

        form {
            flex-grow: 1;
            display: flex;
            align-items: center;
            flex-direction: row;
            gap: 1rem;
        }

        .search-bar-container form input {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .search-bar-container form button {
            padding: 0.8rem 1.5rem;
            background: #0575E6;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s ease;
        }

        .search-bar-container form button:hover {
            background: #021B79;
        }
        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: #0575E6;
            color: white;
        }

        .btn-secondary {
            background: #f0f2f5;
            color: #333;
        }

        .add-btn {
            padding: 0.8rem 1.5rem;
            background: #0575E6;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .add-btn:hover {
            background: #388E3C;
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
        Member staff = (Member)session.getAttribute("staff");
        if(staff==null){
           response.sendRedirect("../member/login.jsp?err=timeout");
        }
        String search= request.getParameter("searchTerm");
        String action= request.getParameter("back");
        ArrayList<Provider> listProvider = null;

        if(search == null && action == null) {

             Date now = new Date();
             SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
             String invoiceDate = dateFormat.format(now);

             Invoice invoice = new Invoice();
             invoice.setStaff(staff);
             invoice.setDate(parsedDate);
             session.setAttribute("invoice", invoice);
        }else if(search != null) {
             ProviderDAO providerDAO = new ProviderDAO();
             listProvider = new ArrayList<>();

             String searchQuery = search;
             if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                  listProvider = providerDAO.searchProvider(searchQuery);
                  session.setAttribute("listProvider", listProvider);
              }
        }

    %>

</head>
<body>

    <header class="top-bar">
        <div class="logo-section">
            <h1>Search Provider</h1>
            <div class="welcome-text">
                Welcome back!
            </div>
        </div>
        <a href="importMaterial.jsp" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            Back
        </a>
    </header>

    <div class="search-bar-container">
        <form action="searchProvider.jsp" method="get">
                             <input type="text" name="searchTerm" id="searchTerm" placeholder="Search by provider name..."
                                    value="<%= request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : "" %>" />
                             <button type="submit">Search</button>
         </form>
         <button type="button" class="btn btn-primary" onclick="event.stopPropagation();window.location.href='addProvider.jsp'">
                                </i> Add New
          </button>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Address</th>
                <th>Phone Number</th>
                <th>Email</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="materialTable">
         <%


                        if (listProvider != null && !listProvider.isEmpty()) {
                            for (Provider provider : listProvider) {
                    %>
                                <tr>
                                    <td><%= provider.getId() %></td>
                                    <td><%= provider.getFullName() %></td>
                                    <td><%= provider.getAddress() %></td>
                                    <td><%= provider.getPhoneNumber() %></td>
                                    <td><%= provider.getEmail() %></td>
                                    <td>
                                        <button class="view-btn"  onclick="event.stopPropagation(); window.location.href='searchMaterial.jsp?idProvider=<%= provider.getId() %>'">
                                            Select
                                        </button>
                                    </td>
                                </tr>
                    <%
                            }
                        } else {
                    %>
                            <tr>
                                <td>No provider found</td>
                            </tr>
                    <%
                        }
                    %>
    </table>

</body>
</html>
