<%-- agregarPrestamo.jsp --%>
<%@ page import="dao.PrestamosJpaController" %>
<%@ page import="dto.Prestamos" %>
<%@ page import="dto.Usuario" %>
<%@ page import="dto.Libros" %>

<%
    // Recuperar los datos necesarios para agregar un préstamo
    int codiUsua = Integer.parseInt(request.getParameter("codiUsua")); // Código de usuario
    int codiLib = Integer.parseInt(request.getParameter("codiLib"));   // Código de libro
    String estado = "Prestado"; // Estado inicial del préstamo
    
    // Crear un nuevo objeto Prestamos con los datos
    Prestamos prestamo = new Prestamos();
    Usuario usuario = new Usuario();
    usuario.setCodiUsua(codiUsua);
    Libros libro = new Libros();
    libro.setCodiLib(codiLib);
    prestamo.setCodiUsua(usuario);
    prestamo.setCodiLib(libro);
    prestamo.setEstado(estado);

    // Realizar la operación de agregado en la base de datos
    PrestamosJpaController prestamosDao = new PrestamosJpaController();
    prestamosDao.registrarPrestamo(codiUsua,codiLib,"Estado"); // Debes implementar este método

    // Redirigir de nuevo a la página principal o a donde desees
    response.sendRedirect("Prestamos.jsp"); // Cambia la URL según tu estructura
%>
