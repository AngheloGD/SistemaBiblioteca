/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.PrestamosJpaController;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ANGHELO
 */
@WebServlet(name = "Prestamos", urlPatterns = {"/prestamos"})
public class Prestamos extends HttpServlet {

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
        response.setContentType("application/json");
        // Recupera los parámetros del formulario (código de usuario, código de libro y estado)
        int codiUsua = Integer.parseInt(request.getParameter("codiUsua"));
        int codiLib = Integer.parseInt(request.getParameter("codiLib"));
        String estado = request.getParameter("estado");

        // Crea una instancia del controlador JPA de Prestamos
        PrestamosJpaController prestamoDao = new PrestamosJpaController();

        // Registra el préstamo
        prestamoDao.registrarPrestamo(codiUsua, codiLib, estado);

        // Muestra el mensaje de éxito como un alert()
        response.getWriter().write("<script>alert('Registro Agregado con éxito');</script>");

        // Evita que se realice la redirección a la página `/prestamos`
        response.setHeader("Location", request.getContextPath() + "/Principal.html");
        response.setStatus(HttpServletResponse.SC_SEE_OTHER);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
