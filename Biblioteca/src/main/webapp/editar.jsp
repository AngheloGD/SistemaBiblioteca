<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="dto.Prestamos"%>
<%@page import="dao.PrestamosJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.List"%>

<%
    String codigo = request.getParameter("codiPres");
    if (codigo != null) {
        int codigoPres = Integer.parseInt(codigo);
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("com.mycompany_Biblioteca_war_1.0-SNAPSHOTPU");

        PrestamosJpaController prestamosDao = new PrestamosJpaController();
        Prestamos prestamo = prestamosDao.findPrestamos(codigoPres);

        if (prestamo != null) {
            String estado = request.getParameter("Estado");
            if (estado != null) {
                prestamo.setEstado(estado);

                try {
                    prestamosDao.edit(prestamo);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Préstamo</title>
        <style>
            body {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
                margin: 0;
            }
            form {
                text-align: center;
            }
        </style>
        <script>
            // Cierra la ventana emergente después de la edición
            window.opener.location.reload();
            window.close();
        </script>
    </head>
    <body>
        <h1>Editar Préstamo</h1>
        <p>Préstamo editado correctamente.</p>
    </body>
</html>
<%
} catch (Exception e) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Préstamo</title>
    </head>
    <body>
        <h1>Editar Préstamo</h1>
        <p>Error al editar el préstamo.</p>
    </body>
</html>
<%
    }
} else {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/editar.css" rel="stylesheet" type="text/css"/>
        <title>Editar Préstamo</title>
    </head>
    <body>
        <form method="post" action="editar.jsp">
            <h1>Editar Préstamo</h1>
            Código de Préstamo: <%= prestamo.getCodiPres()%><br>
            Código de Usuario: <%= prestamo.getCodiUsua().getCodiUsua()%><br>
            Código de Libro: <%= prestamo.getCodiLib().getCodiLib()%><br>
            Estado:
            <select name="Estado">
                <option value="entregado" <% if (prestamo.getEstado().equals("entregado")) {
                        out.print("selected");
                    } %>>Entregado</option>
                <option value="vencido" <% if (prestamo.getEstado().equals("vencido")) {
                        out.print("selected");
                    } %>>Vencido</option>
                <option value="prestado" <% if (prestamo.getEstado().equals("prestado"))
                                        out.print("selected");%>>Prestado</option>
                <!-- Puedes agregar más opciones si es necesario -->
            </select>
            <input type="hidden" name="codiPres" value="<%= prestamo.getCodiPres()%>">
            <input type="submit" value="Guardar">
        </form>
    </body>
</html>
<%
    }
} else {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Préstamo</title>
    </head>
    <body>
        <p>El código del préstamo no fue encontrado.</p>
    </body>
</html>
<%
    }
} else {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Préstamo</title>
    </head>
    <body>
        <p>El código del préstamo no se proporcionó.</p>
    </body>
</html>
<%
    }
%>