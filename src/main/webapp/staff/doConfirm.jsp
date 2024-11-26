<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.text.DecimalFormat,dao.*,model.*"%>

<%

    Invoice invoice = (Invoice)session.getAttribute("invoice");

    InvoiceDAO invoiceDAO = new InvoiceDAO();
    boolean result = invoiceDAO.setInvoice(invoice);

    if (result) {
    %>
        <script type="text/javascript">
            alert("save successfully!");
        </script>
    <%
        response.sendRedirect("staffHome.jsp");
    } else {
    %>
            <script type="text/javascript">
                alert("error!");
            </script>
    <%
        response.sendRedirect("confirm.jsp?err=fail");
    }
%>