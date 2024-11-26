<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.text.SimpleDateFormat,java.text.ParseException,dao.*,model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Invoices</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            padding: 2rem;
            margin: 0;
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
            margin: 0;
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

        .search-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 6rem 0rem 0rem;
            width: 100%;
        }

        .search-bar form{
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            display: grid;
            grid-template-columns: 1fr 1fr auto;
            gap: 1.5rem;
            align-items: end;
            width: 100%;
        }

        .date-input-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;

        }

        .date-input-group label {
            font-size: 14px;
            font-weight: 600;
            color: #333;
        }

        .date-input-group input {
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: all 0.3s ease;

        }

        .date-input-group input:focus {
            outline: none;
            border-color: #0575E6;
            box-shadow: 0 0 0 2px rgba(5, 117, 230, 0.1);
        }

        .search-bar form button {
                    padding: 0.6rem 1.2rem;
                    background: #2196F3;
                    color: white;
                    border: none;
                    border-radius: 6px;
                    cursor: pointer;
                    font-size: 15px;
                    font-weight: 500;
                    transition: all 0.2s ease;
                    height: 40px;
                    white-space: nowrap;
                }

                .search-bar form button:hover {
                    background: #0369A1;
                    transform: translateY(-1px);
                    box-shadow: 0 2px 8px rgba(2, 132, 199, 0.25);
                }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
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

        tbody tr {
            transition: all 0.3s ease;
            cursor: pointer;
        }

        tbody tr:hover {
            background: rgba(5, 117, 230, 0.1);
        }

        .view-btn {
            background: #2196F3;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            border: none;
            transition: all 0.3s ease;
        }

        .view-btn:hover {
            background: #1976D2;
            transform: translateY(-1px);
        }

        @media (max-width: 768px) {
            .search-bar {
                grid-template-columns: 1fr;
            }

            .top-bar {
                padding: 1rem;
                flex-direction: column;
                gap: 1rem;
            }

            .logo-section {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }

            .welcome-text {
                border-left: none;
                padding: 0.5rem;
            }
        }
    </style>
    <%
                Member manager = (Member)session.getAttribute("manager");
                  if(manager==null){
                      response.sendRedirect("../member/login.jsp?err=timeout");
                  }

                Date startDate = (Date)session.getAttribute("startDate");
                Date endDate = (Date)session.getAttribute("endDate");
                ArrayList<MaterialStat> listMaterialStat = ( ArrayList<MaterialStat>) session.getAttribute("listMaterialStat");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");

                 if (startDateStr != null && !startDateStr.isEmpty() && endDateStr != null && !endDateStr.isEmpty()) {
                    MaterialStatDAO materialStatDAO = new MaterialStatDAO();

                     try {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                             startDate = sdf.parse(startDateStr);
                             endDate = sdf.parse(endDateStr);

                            session.setAttribute("startDate", startDate);
                            session.setAttribute("endDate", endDate);
                            listMaterialStat = new ArrayList<>();
                            listMaterialStat = materialStatDAO.getMaterialStat(startDate,endDate);
                             session.setAttribute("listMaterialStat", listMaterialStat);

                     } catch (ParseException e) {
                           out.println("<p>Error parsing the dates. Please ensure the date format is correct.</p>");
                            e.printStackTrace();
                         }
                     }
    %>
</head>
<body>
    <header class="top-bar">
        <div class="logo-section">
            <h1>Material Statistic</h1>
            <div class="welcome-text">Welcome back!</div>
        </div>
        <a href="statistic.jsp" class="logout-btn">
             <i class="fas fa-arrow-left"></i>
            Back
        </a>
    </header>

    <div class="search-container">
        <div class="search-bar">
              <form action="materialStat.jsp" method="get">
                    <div class="date-input-group">
                        <label for="startDate">Start Date</label>
                        <input type="date" id="startDate" name="startDate" value="<%= request.getParameter("startDate") != null ? request.getParameter("startDate") : "" %>" />
                    </div>

                    <div class="date-input-group">
                        <label for="endDate">End Date</label>
                        <input type="date" id="endDate" name="endDate" value="<%= request.getParameter("endDate") != null ? request.getParameter("endDate") : "" %>" />
                    </div>

                    <button type="submit">Search</button>
                </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Revenue</th>
                    <th>Actions</th>
                </tr>
            </thead>
           <tbody id="invoiceTable">
           <%


                        if (listMaterialStat != null && !listMaterialStat.isEmpty()) {
                            for (MaterialStat materialStat : listMaterialStat) {
                    %>
                                <tr onclick="window.location.href='soldInvoiceStat.jsp?idMaterialStat=<%= materialStat.getId() %>'">
                                    <td><%= materialStat.getId() %></td>
                                    <td><%= materialStat.getName() %></td>
                                    <td><%= materialStat.getTotalQuantity() %></td>
                                    <td>$<%= String.format("%.2f", materialStat.getRevenue()) %></td>
                                    <td>
                                        <button class="view-btn" onclick="event.stopPropagation(); window.location.href='soldInvoiceStat.jsp?idMaterialStat=<%= materialStat.getId() %>'">
                                            View
                                        </button>
                                    </td>
                                </tr>
                    <%
                            }
                        } else {

                              out.println("<p>No material statistic found for the selected date range.</p>");

                        }
                    %>
           </tbody>
        </table>
    </div>

</body>
</html>