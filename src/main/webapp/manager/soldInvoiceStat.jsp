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

            .content-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 6rem 0rem 0rem;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                overflow: hidden;
                margin-top: 2rem;
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
                white-space: nowrap;
            }

            tbody tr {
                transition: all 0.3s ease;
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

            .price {
                font-family: monospace;
                font-size: 14px;
            }

            @media (max-width: 1200px) {
                .table-container {
                    overflow-x: auto;
                }

                table {
                    min-width: 1000px;
                }
            }

            @media (max-width: 768px) {
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
                            response.sendRedirect("/member/login.jsp?err=timeout");
                        }

                int idMaterialStat = 0;
                   try {
                       idMaterialStat = Integer.parseInt(request.getParameter("idMaterialStat"));
                   } catch (NumberFormatException e) {
                       response.sendRedirect("materialStat.jsp?error=fail");
                       return;
                   }
                 Date startDate = (Date) session.getAttribute("startDate");
                 Date endDate = (Date) session.getAttribute("endDate");

                 SoldInvoiceDAO soldInvoiceDAO = new SoldInvoiceDAO();
                 ArrayList<SoldInvoice> listInvoice = new ArrayList<>();
                 listInvoice = soldInvoiceDAO.getSoldInvoiceByMaterialStat(idMaterialStat,startDate,endDate);


            %>
</head>
<body>
     <header class="top-bar">
            <div class="logo-section">
                <h1>Invoice Statistics</h1>
                <div class="welcome-text">Welcome back!</div>
            </div>
            <a href="materialStat.jsp" class="logout-btn">
                <i class="fas fa-arrow-left"></i>
                Back
            </a>
        </header>

        <div class="content-container">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Staff Name</th>
                            <th>Client Name</th>
                            <th>Date</th>
                            <th>Quantity</th>
                            <th>Unit Price</th>
                            <th>Total Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                   for (SoldInvoice invoice : listInvoice) {
                               %>
                                   <tr>
                                       <td><%= invoice.getId() %></td>
                                       <td><%= invoice.getStaff().getFullName() %></td>
                                       <td><%= invoice.getCustomer().getFullName() %></td>
                                       <td><%= invoice.getDate() %></td>
                                       <td><%= invoice.getQuantity() %></td>
                                       <td class="price"><%= invoice.getUnitPrice() %></td>
                                       <td class="price"><%= invoice.getTotalPrice() %></td>
                                   </tr>
                               <% } %>

                    </tbody>
                </table>
            </div>
        </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date();
            const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);

            document.getElementById('startDate').value = formatDate(firstDay);
            document.getElementById('endDate').value = formatDate(today);
        });

        function formatDate(date) {
            return date.toISOString().split('T')[0];
        }

        function searchInvoices() {
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = new Date(document.getElementById('endDate').value);

            if (startDate > endDate) {
                alert('Start date cannot be later than end date');
                return;
            }

            // Add your search logic here
        }

        function viewInvoice(id) {
            alert(`Viewing invoice details for ID: ${id}`);
        }
    </script>
</body>
</html>