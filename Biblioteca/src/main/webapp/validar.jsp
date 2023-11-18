<%@page import="dto.Usuario"%>
<%@page import="dao.UsuarioJpaController"%>
<%
    String logi = request.getParameter("logi");
    String Pass = request.getParameter("pass");
    String rol = request.getParameter("rol");
    UsuarioJpaController usuDao = new UsuarioJpaController();
    Usuario usu = usuDao.validar(logi, Pass, rol);

    if (usu == null) {
        out.println("NO ENCONTRADO");
    } else {
        out.print("ENCONTRADO");
    }


%>