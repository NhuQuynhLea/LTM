<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Material Import</title>
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

        .material-form {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin: 6rem 0 2rem;
            display:flex;
            flex-direction: row;
            gap: 1.5rem;
        }

        .form-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f0f2f5;
        }

        .form-title {
            font-size: 1.25rem;
            color: #1a237e;
            font-weight: 600;
        }

        .form-content {

            display: flex;
            justify-content:center;
            gap: 1.5rem;
            align-items: end;

        }

        .form-group {

            display: flex;
            flex-direction: column;
            gap: 0.5rem;


        }
        .search-bar{
            flex:1;
            display: flex;
            align-items: end;
            gap: 1rem;
            max-width: 600px;
            margin: 0 auto ;
        }
        .search-bar input{
            flex: 1;
            padding: 0.8rem;
                        border: 1px solid #ddd;
                        border-radius: 8px;
                        font-size: 16px;
                        transition: border-color 0.3s ease;

        }
        .search-bar input:focus {
                    outline: none;
                    border-color: #0575E6;
                    box-shadow: 0 0 0 2px rgba(5, 117, 230, 0.1);
                }


        .form-group label {
            font-weight: 600;
            color: #333;
            font-size: 0.9rem;
        }

        .form-group input {
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;

        }

        .form-group input:focus {
            outline: none;
            border-color: #0575E6;
            box-shadow: 0 0 0 2px rgba(5, 117, 230, 0.1);
        }

        .button-group {
            display: flex;
            gap: 1rem;
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

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .table-container {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-top: 2rem;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .section-title {
            color: #1a237e;
            font-size: 1.2rem;
            font-weight: 600;
            margin: 0;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 1rem;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background: #f8f9fa;
            color: #333;
            font-weight: 600;
            font-size: 0.9rem;
        }

        th:first-child {
            border-top-left-radius: 8px;
        }

        th:last-child {
            border-top-right-radius: 8px;
        }

        tr:hover {
            background: rgba(5, 117, 230, 0.05);
            cursor: pointer;
        }

        .action-btn {
            background: #2196F3;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 14px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .action-btn.remove {
            background: #dc3545;
        }

        .action-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .save-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 1rem;
        }

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-badge.pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-badge.success {
            background: #d4edda;
            color: #155724;
        }
    </style>
    <%
        Member staff = (Member)session.getAttribute("staff");
             if(staff==null){
                response.sendRedirect("../member/login.jsp?err=timeout");
                }

         Provider selectProvider = (Provider) session.getAttribute("provider");
         Invoice invoice = (Invoice)session.getAttribute("invoice");
         ArrayList<Provider> listProvider = (ArrayList<Provider>)session.getAttribute("listProvider");
         String action= request.getParameter("action");
         if(action == null && selectProvider == null) {
            int idProvider = Integer.parseInt(request.getParameter("idProvider"));
                         if(listProvider != null)
                         for (Provider provider : listProvider) {
                             if(provider.getId() == idProvider) {
                                 selectProvider = provider;
                                 invoice.setProvider(selectProvider);
                                 session.setAttribute("provider",selectProvider);
                                 break;
                             }
                          }

         }
          String search= request.getParameter("searchTerm");
          String idSelect = request.getParameter("idSelect");
          String searchTerm = "";
          ArrayList<Material> listMaterial = null ;

          Material selectMaterial = new Material();

          ArrayList<ImportedMaterial> listImportedMaterial = (ArrayList<ImportedMaterial>)session.getAttribute("listImportedMaterial");

            if (search != null) {
                            MaterialDAO materialDAO = new MaterialDAO();
                             listMaterial = new ArrayList<>();
                            String searchQuery = search;
                            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                                 listMaterial = materialDAO.searchMaterial(searchQuery);
                                 session.setAttribute("listMaterial", listMaterial);
                            }
                      }
           else if(idSelect != null){
                           int idSelectMaterial = Integer.parseInt(request.getParameter("idSelect"));
                           listMaterial = (ArrayList<Material>)session.getAttribute("listMaterial");
                           if(listMaterial != null){
                            for(Material material:listMaterial){
                                if(material.getId() == idSelectMaterial){
                                 selectMaterial = material;
                                 break;
                                }
                               }
                                searchTerm = selectMaterial.getName();
                           }
                           session.setAttribute("selectMaterial", selectMaterial);

           }

              if (request.getParameter("quantity") != null && request.getParameter("price") != null) {
                                         listMaterial = (ArrayList<Material>)session.getAttribute("listMaterial");
                                         Material material= (Material)session.getAttribute("selectMaterial");

                                         float quantity = Float.parseFloat(request.getParameter("quantity"));
                                         float price = Float.parseFloat(request.getParameter("price"));
                                         ImportedMaterial importMaterial = new ImportedMaterial(material,quantity,price);
                                           if(listImportedMaterial == null) {
                                               listImportedMaterial = new ArrayList<>();
                                           }
                                         listImportedMaterial.add(importMaterial);
                                         session.setAttribute("listImportedMaterial", listImportedMaterial);
                                         System.out.println(importMaterial.getMaterial().getId());
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
        <a href="searchProvider.jsp?action=back" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            Back
        </a>
    </header>
    <div class="material-form" id="materialForm">
      <form class="search-bar"action="searchMaterial.jsp" method="get">

          <input type="text" name="searchTerm" id="searchTerm" placeholder="Search by material name..."
            value="<%= request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : searchTerm %>" />
         <button type="submit" class="btn btn-primary">Search</button>
      </form>
     <form action="searchMaterial.jsp" method="post"  >
            <div class="form-content">
                <div class="form-group">
                    <label for="quantity">Quantity</label>
                    <input type="number" id="quantity" name="quantity" placeholder="Enter quantity" min="0"  />
                </div>
                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="number" id="price" step="0.01" name="price" placeholder="Enter price" min="0"  />
                </div>
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                       </i> Import
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="event.stopPropagation();window.location.href='addMaterial.jsp'">
                       </i> Add New
                    </button>
                </div>
            </div>
        </form>
    </div>


    <div class="table-container">
        <div class="table-header">
            <h2 class="section-title">Search Results</h2>

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
            <tbody id="searchResults">
             <%

                            if (listMaterial != null && !listMaterial.isEmpty()) {
                                for (Material material : listMaterial) {
                        %>
                                    <tr >
                                        <td><%= material.getId() %></td>
                                        <td><%= material.getName() %></td>
                                        <td><%= material.getDescription() %></td>
                                        <td><%= material.getQuantity() %></td>
                                        <td>$<%= String.format("%.2f", material.getPrice()) %></td>
                                        <td>
                                            <button class="action-btn" onclick="event.stopPropagation();window.location.href='searchMaterial.jsp?idSelect=<%= material.getId() %>'">
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
            </tbody>
        </table>
    </div>

    <div class="table-container">
        <div class="table-header">
            <h2 class="section-title">Selected Materials</h2>

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
            <tbody id="selectedMaterials">
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
                     <td>
                         <button class="action-btn" onclick="event.stopPropagation(); removeImportedMaterial(this)">
                             Remove
                         </button>
                     </td>
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
        <div class="save-container">
            <button type="button" class="btn btn-primary" onclick="event.stopPropagation();window.location.href='confirm.jsp'">
         Save
            </button>
        </div>
    </div>

    <script>
        function removeImportedMaterial(btn) {
            const row = btn.closest('tr');
            row.remove();
        }


        function viewMaterial(id) {
            alert('Viewing details for Material ID: ' + id);
        }


        function addNewMaterial() {
            const materialName = document.getElementById('materialName').value;
            if (!materialName) {
                alert('Please enter a material name');
                return;
            }
            alert('Redirecting to add new material: ' + materialName);
        }

        document.getElementById('materialName').addEventListener('input', function() {
            const searchText = this.value.toLowerCase();
            const rows = document.getElementById('searchResults').getElementsByTagName('tr');

            for (let row of rows) {
                const name = row.cells[1].textContent.toLowerCase();
                row.style.display = name.includes(searchText) ? '' : 'none';
            }
        });
    </script>
</body>
</html>