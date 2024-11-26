<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="dao.MaterialDAO, model.Material" %>

<%

    String materialName = request.getParameter("materialName");
    String materialDescription = request.getParameter("materialDescription");

    Material material = new Material();
    material.setName(materialName);
    material.setDescription(materialDescription);

    MaterialDAO materialDAO = new MaterialDAO();
    boolean result = materialDAO.addMaterial(material);

    if (result) {
        session.setAttribute("newMaterial", material);
        response.sendRedirect("searchMaterial.jsp?action=add");
    } else {
        response.sendRedirect("addMaterial.jsp?err=fail");
    }
%>
