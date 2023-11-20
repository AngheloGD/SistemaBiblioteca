<%-- 
    Document   : SLibros
    Created on : 19 nov 2023, 18:18:13
    Author     : ANGHELO
--%>


<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Libros</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
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
                    <h1 class="all-tittles">Sistema bibliotecario <small>Administración De Libros</small></h1>
                </div>
            </div>
            <div class="conteiner-fluid">
                <ul class="nav nav-tabs nav-justified"  style="font-size: 17px;">


                    <li role="presentation" class="active"><a href="Estudiante.html">Libros</a></li>

                </ul>
            </div>
            <div class="container-fluid"  style="margin: 50px 0;">
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-3">
                        <img src="assets/img/leer.png" alt="user" class="img-responsive center-box" style="max-width: 110px;">
                    </div>
                    <div class="col-xs-12 col-sm-8 col-md-8 text-justify lead">
                        Bienvenido a la sección para separar tu Libro , para poder registrar deberás de llenar todos los campos del siguiente formulario
                    </div>
                </div>
            </div>

            <div class="container-fluid">
                <script>
                    function validarFormulario(event) {
                        var codiUsua = document.getElementById("codiUsua").value;
                        var codiLib = document.getElementById("codiLib").value;
                        var estado = document.getElementById("estado").value;

                        if (codiUsua === "" || codiLib === "" || estado === "") {
                            alert("Todos los campos son obligatorios. Por favor, complétalos.");
                            event.preventDefault(); // Evita que el formulario se envíe
                        } else {
                            alert("Registro Agregado con éxito");
                        }
                    }
                </script>
                <div class="container-flat-form">
                    <div class="title-flat-form title-flat-blue">Separar Libro</div>
                    <form autocomplete="off" action="prestamos" method="post" onsubmit="validarFormulario(event);">
                        <div class="row">
                            <div class="col-xs-12 col-sm-8 col-sm-offset-2">
                                <legend>Ingrese los Datos</legend>
                                <br><br>
                                <div class="group-material">
                                    <input type="text" class="material-control tooltips-general" id="codiUsua" name="codiUsua" required="" maxlength="20" data-toggle="tooltip" data-placement="top" title="NIE de estudiante">
                                    <span class="highlight"></span>
                                    <span class="bar"></span>
                                    <label for "codiUsua">Código de Usuario:</label>
                                </div>
                                <div class="group-material">
                                    <input type="text" class="material-control tooltips-general" id="codiLib" name="codiLib" placeholder="Escribe aquí el código del libro" required="" maxlength="20" data-toggle="tooltip" data-placement="top" title="Codigo del Libro">
                                    <span class="highlight"></span>
                                    <span class="bar"></span>
                                    <label for "codiLib">Codigo del Libro</label>
                                </div>
                                <div class="group-material">
                                    <input type="text" class="material-control tooltips-general" id="estado" name="estado" value="Prestado" readonly>
                                    <span class="highlight"></span>
                                    <span class="bar"></span>
                                    <label for="estado"></label>
                                </div>

                                <p class="text-center">
                                    <button type="reset" class="btn btn-info" style="margin-right: 20px;"><i class="zmdi zmdi-roller"></i> &nbsp;&nbsp; Limpiar</button>
                                    <button type="submit" class="btn btn-primary"><i class="zmdi zmdi-floppy"></i> &nbsp;&nbsp; Guardar</button>
                                </p>
                            </div>
                        </div>
                    </form>

                    <script>
                        function irAPrestamosJSP() {
                            window.location.href = "Prestamo.jsp"; // Redirige a la página Prestamos.jsp
                        }
                    </script>
                </div>

            </div>
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
