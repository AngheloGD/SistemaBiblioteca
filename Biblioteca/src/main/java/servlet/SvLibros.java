/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.LibrosJpaController;
import dto.Libros;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author icris
 */
@WebServlet(name = "SvLibros", urlPatterns = {"/SvLibros"})
public class SvLibros extends HttpServlet {

    LibrosJpaController librosJPA = new LibrosJpaController();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idSeleccionado = request.getParameter("id");

        if (idSeleccionado.equals("Literario") || idSeleccionado.equals("Ingenieria")) {
            request.setAttribute("idSeleccionado", idSeleccionado);
            RequestDispatcher dispatcher = request.getRequestDispatcher("libros.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String cantidad = request.getParameter("cantidad");
        String codigoLibro = request.getParameter("codigoLibro");

        // Realizar las operaciones necesarias con la cantidad y el código del libro
        Libros libros = new Libros();
        libros = librosJPA.findLibros(Integer.parseInt(codigoLibro));
        int numCopiasDispo = libros.getNumCopiasDispo() - Integer.parseInt(cantidad);

        if (numCopiasDispo <= 0) {
            request.setAttribute("error", "No hay suficientes copias disponibles");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } else {
            libros.setNumCopiasDispo(libros.getNumCopiasDispo() - Integer.parseInt(cantidad));
            libros.setNumCopiasPres(libros.getNumCopiasPres() + Integer.parseInt(cantidad));

            try {
                librosJPA.edit(libros);
                response.sendRedirect("index.html");
            } catch (Exception ex) {
                Logger.getLogger(SvLibros.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
