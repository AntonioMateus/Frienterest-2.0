/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import iot.jcypher.database.DBAccessFactory;
import iot.jcypher.database.DBProperties;
import iot.jcypher.database.DBType;
import iot.jcypher.database.IDBAccess;
import iot.jcypher.graph.GrNode;
import iot.jcypher.query.JcQuery;
import iot.jcypher.query.JcQueryResult;
import iot.jcypher.query.api.IClause;
import iot.jcypher.query.factories.clause.DO;
import iot.jcypher.query.factories.clause.MATCH;
import iot.jcypher.query.factories.clause.RETURN;
import iot.jcypher.query.values.JcNode;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Antonio Mateus
 */
public class VerificacaoEmail extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerificacaoEmail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerificacaoEmail at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        final String SERVER_ROOT_URI = "http://localhost:7474/";

        final String usernameDB = "neo4j";
        final String passwdDB = "dba";

        Properties props = new Properties();
        props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);

        IDBAccess remote
                = DBAccessFactory.createDBAccess(DBType.REMOTE, props, usernameDB, passwdDB);

        JcNode usuario = new JcNode("Usuario");
        String username = ControleLogin.getUsernameLogado();
        JcQuery query = new JcQuery();
        query.setClauses(new IClause[]{
            MATCH.node(usuario).label("Usuario")
            .property("username").value(username),
            RETURN.value(usuario)
        });
        JcQueryResult result = remote.execute(query);
        if (result.hasErrors()) {
            response.sendRedirect("criacao_conta.jsp?msg=falha");
            return;
        }
        List<GrNode> listaUsuarios = result.resultOf(usuario);
        String codigoEnviado = listaUsuarios.get(0).getProperty("codigo_enviado").getValue().toString();
        String codigoDigitado = request.getParameter("codigo");
        
        if (codigoEnviado.equals(codigoDigitado)) {
            JcQuery update = new JcQuery();
            update.setClauses(new IClause[]{
                MATCH.node(usuario).label("Usuario")
                .property("username").value(username),
                DO.SET(usuario.property("validado")).to("sim")
            });
            remote.execute(update);
            ControleLogin.setUsernameLogado(username);
            response.sendRedirect("pagina_inicial.jsp?msg=" + username);
        }
        else {
            response.sendRedirect("verificacao_email.jsp?msg=falha");
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