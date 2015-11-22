<%--
Views should be stored under the WEB-INF folder so that
they are not accessible except through controller process.

This JSP is here to provide a redirect to the dispatcher
servlet but should be the only JSP outside of WEB-INF.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% if (request.getParameter("msg") == null) {
    response.sendRedirect("index.htm");
}
else if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("true")) {
    response.sendRedirect("index.htm?msg=true");
}
else if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("falha")) {
    response.sendRedirect("index.htm?msg=falha");
}
else if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("sucesso")) {
    response.sendRedirect("index.htm?msg=sucesso");
}
else if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("exclusaoIncorreta")) {
    response.sendRedirect("index.htm?msg=exclusaoIncorreta");
}
else {
    response.sendRedirect("index.htm?msg=false");
} %>
