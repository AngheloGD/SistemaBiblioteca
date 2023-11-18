<%-- 
    Document: Prestamos
    Created on: 6 nov 2023, 5:25:58
    Author: ANGHELO
--%>

<%@page import="dto.Libros"%>
<%@ page import="java.util.List" %>
<%@ page import="dto.Prestamos" %>
<%@ page import="dao.PrestamosJpaController" %>
<%@ page import="dto.Usuario" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Lista de Préstamos</title>

        <link href="css/tabla.css" rel="stylesheet" type="text/css"/>

    </head>
    <body>
        <h1>Lista de Préstamos</h1>
        <input type="button" value="Agregar" onclick="location.href = 'Agregar.jsp'"><br><br>

        <table>

            <tr>
                <th>Código de Préstamo</th>
                <th>Código de Usuario</th>
                <th>Código de Libro</th>
                <th>Estado del Préstamo</th>
                <th>Acciones</th>
            </tr>
            <%
                PrestamosJpaController prestamosDao = new PrestamosJpaController();
                List<Prestamos> prestamosList = prestamosDao.mostrarprestamos();

                for (Prestamos prestamo : prestamosList) {
                    Usuario usuario = prestamo.getCodiUsua();
                    Libros libro = prestamo.getCodiLib();
            %>
            <tr>
                <td><%= prestamo.getCodiPres()%></td>
                <td><%= usuario.getCodiUsua()%></td>
                <td><%= libro.getCodiLib()%></td>
                <td><%= prestamo.getEstado()%></td>
                <td>
                    <form method="post" action="editar.jsp">
                        <input type="hidden" name="codiPres" value="<%= prestamo.getCodiPres()%>">
                        <input type="submit" value="Editar">
                    </form>
                    <form method="post" action="eliminarPrestamo.jsp">
                        <input type="hidden" name="codiPres" value="<%= prestamo.getCodiPres()%>">
                        <input type="submit" value="Eliminar">
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </body>
</html>