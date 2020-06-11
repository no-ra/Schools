<%
    session.removeAttribute("name");
    session.invalidate();
    response.sendRedirect("index.jsp");
%>