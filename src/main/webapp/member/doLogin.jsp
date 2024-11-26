<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,dao.*,model.*"%>

<%
System.out.println("111111");
    String username = (String)request.getParameter("username");
    String password = (String)request.getParameter("password");
    Member member = new Member();
    member.setUsername(username);
    member.setPassword(password);


    MemberDAO dao = new MemberDAO();
    boolean kq = dao.checkLogin(member);

    if(kq && (member.getRole().equalsIgnoreCase("manager"))){
        session.setAttribute("manager", member);
        response.sendRedirect("../manager/managerHome.jsp");
    }else if(kq &&(member.getRole().equalsIgnoreCase("staff"))){
        session.setAttribute("staff", member);
        response.sendRedirect("../staff/staffHome.jsp");
    }else{
        session.setAttribute("username", username);
        session.setAttribute("password", password);
        response.sendRedirect("login.jsp?err=fail");
    }


%>