
<%@page import="dto.Usuario"%>
<%@page import="dao.UsuarioJpaController"%>
<%
    
    String logi =request.getParameter("txtLogi");
    String Pass=request.getParameter("txtPass");
    String roles=request.getParameter("cboRoles");

   UsuarioJpaController usuDao= new UsuarioJpaController();
   Usuario usuario = usuDao.validar(logi, Pass, roles);
    
    if(usuario == null )
    out.println("No se encontro el usuario");
    else
    out.print("Usuario: " + usuario.getCodiUsua() + usuario.getRoles());
    
%>