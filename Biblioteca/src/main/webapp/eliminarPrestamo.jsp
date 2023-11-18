<%-- eliminarPrestamo.jsp --%>
<%@ page import="dao.PrestamosJpaController" %>

<%
    // Recuperar el código de préstamo de la solicitud
    int codiPres = Integer.parseInt(request.getParameter("codiPres"));

    // Realizar la operación de eliminación en la base de datos
    PrestamosJpaController prestamosDao = new PrestamosJpaController();
    prestamosDao.eliminarPrestamo(codiPres); // Debes implementar este método

    // Redirigir de nuevo a la página principal o a donde desees
    response.sendRedirect("Prestamos.jsp"); // Cambia la URL según tu estructura
%>
