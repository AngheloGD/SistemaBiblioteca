<%-- eliminarPrestamo.jsp --%>
<%@ page import="dao.PrestamosJpaController" %>

<%
    // Recuperar el c�digo de pr�stamo de la solicitud
    int codiPres = Integer.parseInt(request.getParameter("codiPres"));

    // Realizar la operaci�n de eliminaci�n en la base de datos
    PrestamosJpaController prestamosDao = new PrestamosJpaController();
    prestamosDao.eliminarPrestamo(codiPres); // Debes implementar este m�todo

    // Redirigir de nuevo a la p�gina principal o a donde desees
    response.sendRedirect("Prestamos.jsp"); // Cambia la URL seg�n tu estructura
%>
