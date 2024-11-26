<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="dao.*, model.*" %>

<%

    String providerName = request.getParameter("providerName");
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String phoneNumber = request.getParameter("phoneNumber");


    Provider provider = new Provider();
    provider.setFullName(providerName);
    provider.setEmail(email);
    provider.setAddress(address);
    provider.setPhoneNumber(phoneNumber);

    ProviderDAO providerDAO = new ProviderDAO();
    boolean result = providerDAO.addProvider(provider);

    if (result) {
        session.setAttribute("newProvider", provider);
        response.sendRedirect("searchProvider.jsp?action=add");
    } else {
        response.sendRedirect("addProvider.jsp?err=fail");
    }
%>
