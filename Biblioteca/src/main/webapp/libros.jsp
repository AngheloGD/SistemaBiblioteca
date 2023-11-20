<%@page import="dto.Libros"%>
<%@page import="java.util.List"%>
<%@page import="dao.LibrosJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel = "stylesheet" type = "text/css" href = "css/stylesLibrosjsp.css">
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    </head>
    <body>
        <%
            String idSeleccionado = request.getParameter("id");
            LibrosJpaController librosDao = new LibrosJpaController();
            List<Libros> lista = librosDao.findLibrosByGeneLib(idSeleccionado);
        %>
        <div id = "tablaLibros">
            <div id="divFormulario">
                <form id="formularioLibros" method="POST" action="SvLibros">
                    <label>Cantidad de copias que desea adquirir: </label>
                    <input type="text" name="cantidad">
                    <input type="hidden" id="codigoLibroSeleccionado" name="codigoLibro">
                    <button type="submit" onclick = "mostrarAlerta()">Separar</button>
                </form>
            </div>
            <br>
            <table>
                <tr>
                    <th>Codigo libro</th>
                    <th>Titulo libro</th>
                    <th>Autor libro</th>
                    <th>Numero copias disponibles</th>
                    <th>Numero de copias prestadas</th>
                </tr>

                <%
                    for (Libros libro : lista) {
                %>
                <tr class="filaTabla" data-id="<%= libro.getCodiLib()%>">
                    <td><%= libro.getCodiLib()%></td>
                    <td><%= libro.getTituLib()%></td>
                    <td><%= libro.getAutoLib()%></td>
                    <td><%= libro.getNumCopiasDispo()%></td>
                    <td><%= libro.getNumCopiasPres()%></td>
                </tr>
                <%}%>
            </table>
        </div>
        <script>
            $(document).ready(function () {
                $(".filaTabla").click(function () {
                    $(".filaTabla").removeClass("filaSeleccionada");

                    var codigoLibro = $(this).data("id");

                    $("#codigoLibroSeleccionado").val(codigoLibro);

                    $(this).addClass("filaSeleccionada");
                });
            });
        </script>
        <script type = "text/javascript" src = "js/functionsjsp.js"></script>
    </body>
</html>
