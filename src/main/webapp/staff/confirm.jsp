<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.text.DecimalFormat,dao.*,model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice Confirmation</title>
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

           .container {
               max-width: 800px;
               width: 100%;
               background-color: #fff;
               border-radius: 8px;
               box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
               padding: 3rem 2rem;
               margin-top: 100px;
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
           input[type="number"],
           input[type="date"],
           input[type="tel"],
           input[type="email"] {
               width: 100%;
               padding: 0.8rem;
               border: 1px solid #ddd;
               border-radius: 5px;
               font-size: 16px;
               color: #333;
               outline: none;
               transition: border-color 0.3s ease;
           }

           input:disabled {
               background-color: #f0f2f5;
               color: #888;
           }

           input:focus {
               border-color: #0575E6;
           }

           .section-title {
               color: #1a237e;
               font-size: 18px;
               margin: 2rem 0 1rem;
               padding-bottom: 0.5rem;
               border-bottom: 2px solid #0575E6;
           }

           table {
               width: 100%;
               border-collapse: collapse;
               margin: 1rem 0;
           }

           th, td {
               padding: 0.8rem;
               text-align: left;
               border-bottom: 1px solid #ddd;
           }

           th {
               background-color: #f0f2f5;
               color: #505965;
               font-weight: 600;
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

           .amount-field {
               display: flex;
               gap: 1rem;
           }

           .amount-field input {
               flex: 1;
           }

           .amount-field button {
               padding: 0.8rem 1.5rem;
               background: #0575E6;
               color: white;
               border: none;
               border-radius: 5px;
               cursor: pointer;
               font-weight: 600;
           }

           .amount-field button:hover {
               background: #021B79;
           }
       </style>
        <%
              Member staff = (Member)session.getAttribute("staff");
              if(staff==null){
                  response.sendRedirect("../member/login.jsp?err=timeout");
              }
             Invoice invoice = (Invoice)session.getAttribute("invoice");
             ArrayList<ImportedMaterial> listImportedMaterial = (ArrayList<ImportedMaterial>)session.getAttribute("listImportedMaterial");
               if(listImportedMaterial != null) {
                invoice.setImportedMaterials(listImportedMaterial);
               }

              Provider selectProvider = (Provider) session.getAttribute("provider");
              float totalCost = 0;
              float paidAmount = 0;

              if(listImportedMaterial != null){
              for(ImportedMaterial material: listImportedMaterial) {
                                  totalCost += material.getQuantity() * material.getPrice();
                            }
              }
              float remainingAmount = totalCost - paidAmount;
              DecimalFormat decimalFormat = new DecimalFormat("#.00");
              String formattedTotalCost = decimalFormat.format(totalCost);

         %>
</head>
<body>
    <header class="top-bar">
        <div class="logo-section">
            <h1>Confirmation</h1>
            <div class="welcome-text">
                Welcome back!
            </div>
        </div>
        <a href="searchMaterial.jsp?action=back" class="back-btn">
 <i class="fas fa-arrow-left"></i>
            Back
        </a>
    </header>

    <div class="container">
        <h2>Invoice Confirmation</h2>
        <form action="doConfirm.jsp" method="post">
            <div class="form-group">
                <label for="invoiceCode">Invoice Code</label>
                <input type="text" id="invoiceCode" name="invoiceCode" value="<%= invoice.getCode() %>" disabled>
            </div>

            <div class="form-group">
                <label for="invoiceDate">Invoice Date</label>
                <input type="date" id="invoiceDate" name="invoiceDate" value="<%= invoice.getDate() %>" disabled>
            </div>

            <h3 class="section-title">Staff Information</h3>
            <div class="form-group">
                <label for="staffID">Staff ID</label>
                <input type="text" id="staffID" name="staffID" value="<%= staff.getId() %>" disabled>
            </div>
            <div class="form-group">
                <label for="staffName">Staff Name</label>
                <input type="text" id="staffName" name="staffName" value="<%= staff.getFullName() %>" disabled>
            </div>

            <h3 class="section-title">Provider Information</h3>
            <div class="form-group">
                <label for="providerName">Provider Name</label>
                <input type="text" id="providerName" name="providerName" value="<%= selectProvider.getFullName() %>" disabled>
            </div>
            <div class="form-group">
                <label for="providerAddress">Provider Address</label>
                <input type="text" id="providerAddress" name="providerAddress" value="<%= selectProvider.getAddress() != null ? selectProvider.getAddress() : "" %>" disabled>
            </div>
            <div class="form-group">
                <label for="providerPhone">Phone Number</label>
                <input type="tel" id="providerPhone" name="providerPhone" value="<%= selectProvider.getPhoneNumber() %>" disabled>
            </div>
            <div class="form-group">
                <label for="providerEmail">Email</label>
                <input type="email" id="providerEmail" name="providerEmail" value="<%= selectProvider.getEmail() %>" disabled>
            </div>

            <h3 class="section-title">Selected Materials</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Quantity</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                                     if (listImportedMaterial != null && !listImportedMaterial.isEmpty()) {
                                         for (int i = 0; i < listImportedMaterial.size(); i++) {
                                 %>
                                     <tr onclick="">
                                         <td><%= i + 1 %></td>
                                         <td><%= listImportedMaterial.get(i).getMaterial().getName() %></td>
                                         <td><%= listImportedMaterial.get(i).getMaterial().getDescription() %></td>
                                         <td><%= listImportedMaterial.get(i).getQuantity() %></td>
                                         <td>$<%= String.format("%.2f", listImportedMaterial.get(i).getPrice()) %></td>

                                     </tr>
                                 <%
                                   }
                                     } else {
                                 %>
                                     <tr>
                                         <td colspan="6">No imported materials found</td>
                                     </tr>
                                 <%
                                     }
                                 %>
                </tbody>
            </table>

            <h3 class="section-title">Payment Summary</h3>
            <div class="form-group">
                <label for="totalCost">Total Cost</label>
                <input type="number" id="totalCost" name="totalCost" value="<%= totalCost %>" readonly>
            </div>
            <div class="form-group">
                <label for="paidAmount">Paid Amount</label>
                <input type="number" id="paidAmount" name="paidAmount" value="<%= paidAmount %>" required>
            </div>
            <div class="form-group">
                <label for="remainingAmount">Remaining Amount</label>
                <input type="number" id="remainingAmount" name="remainingAmount" value="<%= remainingAmount %>" readonly>
            </div>
            <div class="form-group amount-field">
                <input type="number" id="newPayment" name="newPayment" placeholder="Enter new payment amount">
                <button type="button" onclick="addPayment()">Add Payment</button>
            </div>

            <button type="submit" class="btn-save">Confirm Invoice</button>
        </form>
    </div>

    <script>
        function addPayment() {
            const newPayment = parseFloat(document.getElementById('newPayment').value || 0);
            const paidAmount = parseFloat(document.getElementById('paidAmount').value || 0);
            const totalCost = parseFloat(document.getElementById('totalCost').value || 0);

            if (newPayment <= 0) {
                alert('Please enter a valid payment amount');
                return;
            }
            if (newPayment > totalCost) {
                alert('Payment amount cannot exceed total cost');
                return;
            }

            document.getElementById('paidAmount').value = newPayment.toFixed(2);
            document.getElementById('remainingAmount').value = (totalCost - newPayment).toFixed(2);
            document.getElementById('newPayment').value = '';
        }
    </script>
</body>
</html>
