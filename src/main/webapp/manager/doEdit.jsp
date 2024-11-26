<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="dao.MaterialDAO, model.Material" %>

<%

    int materialId = Integer.parseInt(request.getParameter("materialId"));
    String materialName = request.getParameter("materialName");
    String materialDescription = request.getParameter("materialDescription");
    float quantity = Float.parseFloat(request.getParameter("materialQuantity"));
    float price = Float.parseFloat(request.getParameter("materialPrice"));

    Material material = new Material(materialId,materialName,materialDescription,quantity,price);

    MaterialDAO materialDAO = new MaterialDAO();
    boolean updateResult = materialDAO.updateMaterial(material);

    if (updateResult) {
        session.setAttribute("editMaterial", material);
        response.sendRedirect("managerHome.jsp");
    } else {
        response.sendRedirect("editMaterial.jsp?err=fail");
    }
%>
