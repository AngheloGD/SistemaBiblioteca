<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registro de Usuarios</title>
        <!-- Agrega los enlaces a Bootstrap CSS y JS desde un CDN -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
        <link href="css/Agregar.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <h1>Registro de Usuarios</h1>

        <form action="agregarUsu" method="post">

            <label for="ndniUsua">Dni:</label>
            <input type="text" id="ndniUsua" name="ndniUsua" required>

            <label for="nombUsua">Nombres:</label>
            <input type="text" id="nombUsua" name="nombUsua" required>

            <label for="apellUsua">Apellidos:</label>
            <input type="text" id="apellUsua" name="apellUsua" required>

            <label for="logiUsua">Usuario:</label>
            <input type="text" id="logiUsua" name="logiUsua" required>

            <label for="passUsua">Contraseña:</label>
            <input type="password" id="passUsua" name="passUsua" required>

            <input type="hidden" id="rolUsua" name="rolUsua" value="usuario">


            <input type="submit" value="Registrar" id="registrarBtn">
        </form>

        <div class="alert alert-success" role="alert" id="mensajeAlerta" style="display: none;">
            Registro exitoso
        </div>

        <script>
            document.querySelector("#registrarBtn").addEventListener("click", function (event) {
                event.preventDefault();

                // Obtener los datos del formulario
                const ndniUsua = document.querySelector("#ndniUsua").value;
                const nombUsua = document.querySelector("#nombUsua").value;
                const apellUsua = document.querySelector("#apellUsua").value;
                const logiUsua = document.querySelector("#logiUsua").value;
                const passUsua = document.querySelector("#passUsua").value;
                const rolUsua = document.querySelector("#rolUsua").value;

                // Realizar la solicitud POST al servidor
                fetch("agregarUsu", {
                    method: "POST",
                    body: new URLSearchParams({
                        ndniUsua: ndniUsua,
                        nombUsua: nombUsua,
                        apellUsua: apellUsua,
                        logiUsua: logiUsua,
                        passUsua: passUsua,
                        rolUsua: rolUsua,
                    }),
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    }
                })
                        .then(response => response.text())
                        .then(mensaje => {
                            if (mensaje === "Registro exitoso") {
                                // Mostrar la alerta con el mensaje de éxito
                                document.querySelector(".alert-success").style.display = "block";
                                document.querySelector("#mensajeAlerta").textContent = mensaje;

                                // Redirigir al usuario a la página de inicio después de 3 segundos
                                setTimeout(function () {
                                    window.location.href = "index.html";
                                }, 3000);
                            } else {
                                // Manejar mensajes de error si es necesario
                                console.error("Error:", mensaje);
                            }
                        })
                        .catch(error => {
                            // Manejar errores, por ejemplo, si la solicitud falla
                            console.error("Error:", error);
                        });
            });
        </script>
    </body>
</html>

