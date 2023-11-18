<%@page import="dto.Vprestamos"%>
<%@page import="dao.VprestamosJpaController"%>
<%@page import="java.util.List"%>
<%
 /*  String ope = request.getParameter("ope");
   if (ope != null) {
       VprestamosJpaController usu = new VprestamosJpaController();
       switch (ope) {
           case "1":
               List<Vprestamos> lista = usu.listar();
               for (Vprestamos u : lista) {
                  out.print("{\"data\":"+"\"codiPres\":\"" + u.getCodiPres() + "\",\"codiUsua\":\"" + u.getCodiUsua() + "\",\"codiLib\":\"" + u.getCodiLib() + "\",\"Estado\":\"" + u.getEstado() + "\"}");
               }
               break;
           // Otros casos...
       }
   } else {
      JOptionPane.showMessageDialog(null, "ERROR");
   }*/
  String ope = request.getParameter("ope");
  VprestamosJpaController usu=new VprestamosJpaController();
   switch (ope) {
      case "1":
            List<Vprestamos> lista= usu.listar();
        for (Vprestamos u : lista) {
            out.print("{\"data\":"+"\"codiPres\":\"" + u.getCodiPres() + "\",\"codiUsua\":\"" + u.getCodiUsua() + "\",\"codiLib\":\"" + u.getCodiLib() + "\",\"Estado\":\"" + u.getEstado() + "\"}");
             //out.print("{\"data\":"+u.getCodiPres()+" "+u.getCodiUsua()+" "+u.getCodiLib()+" "+u.getEstado()+ "}");
         }
           break;
         }
%>