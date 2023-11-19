<%-- 
    Document   : Prestamo
    Created on : 18 nov 2023, 13:42:52
    Author     : ANGHELO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.Libros"%>
<%@ page import="java.util.List" %>
<%@ page import="dto.Prestamos" %>
<%@ page import="dao.PrestamosJpaController" %>
<%@ page import="dto.Usuario" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Prestamos</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="Shortcut Icon" type="image/x-icon" href="assets/icons/book.ico" />
        <script src="js/sweet-alert.min.js"></script>
        <link rel="stylesheet" href="css/sweet-alert.css">
        <link rel="stylesheet" href="css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/jquery.mCustomScrollbar.css">
        <link rel="stylesheet" href="css/style.css">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/jquery-1.11.2.min.js"><\/script>')</script>
        <script src="js/modernizr.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/main.js"></script>
    </head>
    <body>
        <div class="navbar-lateral full-reset">
            <div class="visible-xs font-movile-menu mobile-menu-button"></div>
            <div class="full-reset container-menu-movile custom-scroll-containers">
                <div class="logo full-reset all-tittles">
                    <i class="visible-xs zmdi zmdi-close pull-left mobile-menu-button" style="line-height: 55px; cursor: pointer; padding: 0 10px; margin-left: 7px;"></i>
                    sistema bibliotecario
                </div>
                <div class="full-reset" style="background-color:#2B3D51; padding: 10px 0; color:#fff;">
                    <figure>
                        <img src="assets/img/hacker.png" alt="Biblioteca" class="img-responsive center-box" style="width:55%;">
                    </figure>
                    <p class="text-center" style="padding-top: 15px;">Sistema Bibliotecario</p>
                </div>
                <div class="full-reset nav-lateral-list-menu">
                    <ul class="list-unstyled">
                        <li><a href="Principal.html"><i class="zmdi zmdi-home zmdi-hc-fw"></i>&nbsp;&nbsp; Inicio</a></li>
                        <li>
                            <div class="dropdown-menu-button"><i class="zmdi zmdi-account-add zmdi-hc-fw"></i>&nbsp;&nbsp; Registro de usuarios <i class="zmdi zmdi-chevron-down pull-right zmdi-hc-fw"></i></div>
                            <ul class="list-unstyled">
                                <li><a href="Estudiante.html"><i class="zmdi zmdi-accounts zmdi-hc-fw"></i>&nbsp;&nbsp; Nuevo estudiante</a></li>
                            </ul>
                        </li>
                        <li>
                            <div class="dropdown-menu-button"><i class="zmdi zmdi-assignment-o zmdi-hc-fw"></i>&nbsp;&nbsp; Libros <i class="zmdi zmdi-chevron-down pull-right zmdi-hc-fw"></i></div>
                            <ul class="list-unstyled">
                                <li><a href="Libros.html"><i class="zmdi zmdi-book zmdi-hc-fw"></i>&nbsp;&nbsp; Nuevo libro</a></li>
                            </ul>
                        </li>
                        <li>
                            <div class="dropdown-menu-button"><i class="zmdi zmdi-alarm zmdi-hc-fw"></i>&nbsp;&nbsp; Préstamos y reservaciones <i class="zmdi zmdi-chevron-down pull-right zmdi-hc-fw"></i></div>
                            <ul class="list-unstyled">
                                <li><a href="Prestamo.jsp"><i class="zmdi zmdi-calendar zmdi-hc-fw"></i>&nbsp;&nbsp; Todos los préstamos</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="content-page-container full-reset custom-scroll-containers">
            <nav class="navbar-user-top full-reset">
                <ul class="list-unstyled full-reset">
                    <figure>
                        <img src="assets/img/ingeniero-de-software.png" alt="user-picture" class="img-responsive img-circle center-box">
                    </figure>
                    <li style="color:#fff; cursor:default;">
                        <span class="all-tittles" id="nombreUsuario"></span>
                    </li>
                    <script>
            var nombreUsuario = localStorage.getItem('username');
            if (nombreUsuario) {
                document.getElementById('nombreUsuario').textContent = nombreUsuario;
            }
                    </script>
                    <li class="tooltips-general exit-system-button" id="logoutButton" data-placement="bottom" title="Salir del sistema">
                        <i class="zmdi zmdi-power"></i>
                    </li>


                    <li class="tooltips-general search-book-button" data-href="searchbook.html" data-placement="bottom" title="Buscar libro">
                        <i class="zmdi zmdi-search"></i>
                    </li>
                    <li class="mobile-menu-button visible-xs" style="float: left !important;">
                        <i class="zmdi zmdi-menu"></i>
                    </li>
                </ul>
            </nav>
            <div class="container">
                <div class="page-header">
                    <h1 class="all-tittles">Sistema bibliotecario <small>préstamos y reservaciones</small></h1>
                </div>
            </div>
            <div class="conteiner-fluid">
                <ul class="nav nav-tabs nav-justified"  style="font-size: 17px;">
                    <li class="active"><a href="Prestamos.html">Todos los préstamos</a></li>
                </ul>
            </div>
            <div class="container-fluid"  style="margin: 50px 0;">
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-3">
                        <img src="assets/img/calendar_book.png" alt="calendar" class="img-responsive center-box" style="max-width: 110px;">
                    </div>
                    <div class="col-xs-12 col-sm-8 col-md-8 text-justify lead">
                        Bienvenido a esta sección, aquí se muestran todos los préstamos de libros realizados hasta la fecha y que ya se entregaron satisfactoriamente
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <h2 class="text-center all-tittles">Listado de préstamos</h2>
                <div class="table-responsive">
                    <div class="div-table" style="margin:0 !important;">
                        <div class="div-table-row div-table-row-list" style="background-color:#DFF0D8; font-weight:bold;">
                            <div class="div-table-cell" style="width: 6%;">Codigo de Prestamos</div>
                            <div class="div-table-cell" style="width: 22%;">Codigo Usuario</div>
                            <div class="div-table-cell" style="width: 22%;">Codigo del Libro</div>
                            <div class="div-table-cell" style="width: 10%;">Estado</div>
                            <div class="div-table-cell" style="width: 10%;">Opciones</div>
                        </div>
                        <%
                            PrestamosJpaController prestamosDao = new PrestamosJpaController();
                            List<Prestamos> prestamosList = prestamosDao.mostrarprestamos();

                            for (Prestamos prestamo : prestamosList) {
                                Usuario usuario = prestamo.getCodiUsua();
                                Libros libro = prestamo.getCodiLib();
                        %>
                        <div class="div-table-row div-table-row-list">
                            <div class="div-table-cell" style="width: 6%;"><%= prestamo.getCodiPres()%></div>
                            <div class="div-table-cell" style="width: 22%;"><%= usuario.getCodiUsua()%></div>
                            <div class="div-table-cell" style="width: 22%;"><%= libro.getCodiLib()%></div>
                            <div class="div-table-cell" style="width: 10%;"><%= prestamo.getEstado()%></div>
                            <div class="div-table-cell" style="width: 8%;">
                                <form id="eliminarForm" method="post" action="eliminarPrestamo.jsp" style="display: inline-block;">
                                    <input type="hidden" name="codiPres" value="<%= prestamo.getCodiPres()%>">
                                    <button class="btn btn-danger" onclick="confirmarEliminar(event)"><i class="zmdi zmdi-delete"></i></button>
                                </form>

                                <form method="post" action="#" onsubmit="openEditarForm('<%= prestamo.getCodiPres()%>');
                                        return false;" Style="display: inline-block;">

                                    <input type="hidden" name="codiPres" value="<%= prestamo.getCodiPres()%>">
                                    <button class="btn btn-info"><i class="zmdi zmdi-file-text"></i></button>
                                </form>
                            </div>

                        </div>
                        <% }%>
                    </div>
                </div>
            </div>
            <script>
                function confirmarEliminar(event) {
                    event.preventDefault(); // Prevenir la acción por defecto del botón (enviar el formulario)

                    var confirmacion = confirm("¿Está seguro de que desea eliminar este préstamo?");

                    if (confirmacion) {
                        document.getElementById('eliminarForm').submit(); // Enviar el formulario si se hace clic en Aceptar
                    }
// Si se hace clic en Cancelar, no se hará nada
                }
            </script>
            <script>
                function openEditarForm(codiPres) {
                    // Abre la ventana emergente con el formulario de editar.jsp
                    window.open('editar.jsp?codiPres=' + codiPres, 'Editar Préstamo', 'width=600,height=400');
                }
            </script>
            <div class="modal fade" tabindex="-1" role="dialog" id="ModalHelp">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title text-center all-tittles">ayuda del sistema</h4>
                        </div>
                        <div class="modal-body">
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore dignissimos qui molestias ipsum officiis unde aliquid consequatur, accusamus delectus asperiores sunt. Quibusdam veniam ipsa accusamus error. Animi mollitia corporis iusto.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="zmdi zmdi-thumb-up"></i> &nbsp; De acuerdo</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- <footer class="footer full-reset">
                 <div class="container-fluid">
                     <div class="row">
                         <div class="col-xs-12 col-sm-6">
                             <h4 class="all-tittles">Acerca de Nosotros</h4>
                             <p>
                                 Bueno somos un grupito solido, muy estudiosos, Eh, espero que sea de su agrado este proyecto y aprovechenlo :)
                             </p>
                         </div>
                         <div class="col-xs-12 col-sm-6">
                             <h4 class="all-tittles">Desarrollados </h4>
                             <ul class="list-unstyled">
                                 <li><i class="zmdi zmdi-check zmdi-hc-fw"></i>&nbsp; Anghelo Guerrero<i class="zmdi zmdi-facebook zmdi-hc-fw footer-social"></i><i class="zmdi zmdi-twitter zmdi-hc-fw footer-social"></i></li>
                                 <li><i class="zmdi zmdi-check zmdi-hc-fw"></i>&nbsp; Fiorella Durand<i class="zmdi zmdi-facebook zmdi-hc-fw footer-social"></i><i class="zmdi zmdi-twitter zmdi-hc-fw footer-social"></i></li>
 
                             </ul>
                         </div>
                     </div>
                 </div>
                 <div class="footer-copyright full-reset all-tittles">© 2023 INGENIERIA</div>
             </footer>-->
        </div>
        <!--Para el cierre de sesion-->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Verificar si hay una sesión activa al cargar la página
                var username = localStorage.getItem('username');
                if (!username) {
                    // Si no hay una sesión activa, redirigir a la página de inicio de sesión
                    window.location.replace('/Biblioteca/');
                } else {
                    // Mostrar el nombre de usuario u otras acciones que desees realizar cuando haya una sesión activa
                    document.getElementById('nombreUsuario').textContent = username;

                    // Agregar un evento para controlar los cambios en el historial solo si hay una sesión activa
                    window.addEventListener('popstate', function (event) {
                        history.pushState(null, null, '/Biblioteca/');
                    });
                }

                // Evento para el botón de cierre de sesión
                document.getElementById('logoutButton').addEventListener('click', function () {
                    // Mostrar el cuadro de confirmación
                    var confirmLogout = confirm("¿Está seguro de que desea salir del sistema?");
                    if (confirmLogout) {
                        // Realizar una solicitud AJAX para cerrar la sesión en el servidor
                        $.ajax({
                            type: "POST",
                            url: "cerrarSesion", // Reemplazar con la URL real de tu servlet de cierre de sesión
                            success: function () {
                                // Limpiar el localStorage y sessionStorage
                                localStorage.removeItem('username');
                                sessionStorage.removeItem('username');

                                // Redirigir a la página de inicio de la aplicación
                                window.location.replace('/Biblioteca/');
                            },
                            error: function () {
                                alert("Error al cerrar sesión");
                            }
                        });
                    }
                });

                // Agregar un evento para detectar cambios en el almacenamiento local (puede indicar cierre de sesión desde otra pestaña)
                window.addEventListener('storage', function (event) {
                    if (event.key === 'username' && !event.newValue) {
                        // Si el valor de 'username' en el almacenamiento local se ha eliminado (cierre de sesión),
                        // redirigir a la página de inicio de sesión
                        window.location.replace('/Biblioteca/');
                    }
                });
            });
        </script>
    </body>
</html>