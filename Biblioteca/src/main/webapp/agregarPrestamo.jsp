<%-- agregarPrestamo.jsp --%>
<%@ page import="dao.PrestamosJpaController" %>
<%@ page import="dto.Prestamos" %>
<%@ page import="dto.Usuario" %>
<%@ page import="dto.Libros" %>

<%
    // Recuperar los datos necesarios para agregar un pr�stamo
    int codiUsua = Integer.parseInt(request.getParameter("codiUsua")); // C�digo de usuario
    int codiLib = Integer.parseInt(request.getParameter("codiLib"));   // C�digo de libro
    String estado = "Prestado"; // Estado inicial del pr�stamo
    
    // Crear un nuevo objeto Prestamos con los datos
    Prestamos prestamo = new Prestamos();
    Usuario usuario = new Usuario();
    usuario.setCodiUsua(codiUsua);
    Libros libro = new Libros();
    libro.setCodiLib(codiLib);
    prestamo.setCodiUsua(usuario);
    prestamo.setCodiLib(libro);
    prestamo.setEstado(estado);

    // Realizar la operaci�n de agregado en la base de datos
    PrestamosJpaController prestamosDao = new PrestamosJpaController();
    prestamosDao.registrarPrestamo(codiUsua,codiLib,"Estado"); // Debes implementar este m�todo

    // Redirigir de nuevo a la p�gina principal o a donde desees
    response.sendRedirect("Prestamos.jsp"); // Cambia la URL seg�n tu estructura
%>
