/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Properties;
import org.neo4j.graphdb.Label;

import iot.jcypher.database.DBAccessFactory;
import iot.jcypher.database.DBProperties;
import iot.jcypher.database.DBType;
import iot.jcypher.database.IDBAccess;
import iot.jcypher.graph.GrNode;
import iot.jcypher.query.JcQuery;
import iot.jcypher.query.JcQueryResult;
import iot.jcypher.query.api.IClause;
import iot.jcypher.query.factories.clause.MATCH;
import iot.jcypher.query.factories.clause.RETURN;
import iot.jcypher.query.values.JcNode;

/**
 *
 * @author Antonio Mateus
 */
public class ControleLogin extends HttpServlet {

    public static String emailLogado;

    public static String getEmailLogado() {
        return emailLogado;
    }

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
            out.println("<title>Servlet ControleLogin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControleLogin at " + request.getContextPath() + "</h1>");
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

    //Se for a primeira vez que você está executando esse projeto, descomente as linhas a seguir
    private enum TipoNo implements Label {

        Usuario;
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

        String email = request.getParameter("email");
        emailLogado = email;
        String senha_digitada = request.getParameter("senha");

        final String SERVER_ROOT_URI = "http://localhost:7474/";

        final String username = "neo4j";
        final String passwd = "dba";
        
// REFATORACAO CONEXAO SERVIDOR 3
        Properties props = new Properties();
        props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);

        IDBAccess remote
                = DBAccessFactory.createDBAccess(DBType.REMOTE, props, username, passwd);

        JcNode usuario = new JcNode("Usuario");
        JcQuery query = new JcQuery();
        query.setClauses(new IClause[]{
            MATCH.node(usuario).label("Usuario").property("email").value(email),
            RETURN.value(usuario)
        });
        JcQueryResult result = remote.execute(query);
        List<GrNode> usuarios = result.resultOf(usuario);

        GrNode usuarioLogin = usuarios.get(0);
        String senhaUsuario = usuarioLogin.getProperty("senha").getValue().toString();
        String validacaoUsuario = usuarioLogin.getProperty("validado").getValue().toString();
        String nomeUsuario = usuarioLogin.getProperty("nome").getValue().toString();
        
        if (senha_digitada.equals(senhaUsuario)) {
            if(validacaoUsuario.equals("sim")){
                response.sendRedirect("pagina_inicial.jsp?msg=" + nomeUsuario);   
            }
        } else if (senha_digitada.equals(senhaUsuario)) {
            if(validacaoUsuario.equals("nao")){
                response.sendRedirect("verificacao_email.jsp");   
            }
        } else {
            response.sendRedirect("redirect.jsp?msg=true");
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
