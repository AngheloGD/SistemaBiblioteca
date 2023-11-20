document.addEventListener('DOMContentLoaded', function () {
    var categorias = document.querySelectorAll('.divCategoriaLibro');
    
    categorias.forEach(function (categoria) {
        categoria.addEventListener('click', function () {
            var idSeleccionado = categoria.id;

            window.location.href = 'SvLibros?id=' + idSeleccionado;
        });
    });
});