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
import iot.jcypher.graph.Graph;
import iot.jcypher.query.JcQuery;
import iot.jcypher.query.JcQueryResult;
import iot.jcypher.query.api.IClause;
import iot.jcypher.query.factories.clause.CREATE;
import iot.jcypher.query.factories.clause.MATCH;
import iot.jcypher.query.factories.clause.RETURN;
import iot.jcypher.query.result.JcError;
import iot.jcypher.query.values.JcNode;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.neo4j.cypher.javacompat.ExecutionEngine;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Label;
import org.neo4j.graphdb.Transaction;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;

/**
 *
 * @author andrew
 */
@WebServlet(urlPatterns = {"/InicializacaoUsuarios"})
public class InicializacaoUsuarios extends HttpServlet {

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
            out.println("<title>Servlet InicializacaoUsuarios</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InicializacaoUsuarios at " + request.getContextPath() + "</h1>");
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

        final String SERVER_ROOT_URI = "http://localhost:7474/";
        final String usernameDB = "neo4j";
        final String passwdDB = "dba";

        Properties props = new Properties();
        props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);

        IDBAccess remote
                = DBAccessFactory.createDBAccess(DBType.REMOTE, props, usernameDB, passwdDB);

        JcNode usuario = new JcNode("Usuario");
        JcQuery query = new JcQuery();

        final int NUM_USUARIOS = 30;
        try {
            query.setClauses(new IClause[]{
                MATCH.node(usuario).label("Usuario"),
                RETURN.value(usuario)
            });
            JcQueryResult result = remote.execute(query);
            List<GrNode> usuarios = result.resultOf(usuario);
            for (Iterator<GrNode> iterator = usuarios.iterator(); iterator.hasNext();) {
                GrNode next = iterator.next();
                next.remove();
            }
            Graph graph = result.getGraph();
            List<JcError> errors = graph.store();

            if (result.hasErrors()) {
                response.sendRedirect("criacao_conta.jsp?msg=falha");
            }

            ArrayList<String> nomes = new ArrayList<String>(NUM_USUARIOS);
            nomes.addAll(Arrays.asList("Le", "Ima", "Dortha", "Raina",
                    "Sharolyn", "Colby", "Janita", "Coleman", "Jeanelle", "Alicia",
                    "Valene", "Winston", "Rebbeca", "Sebrina", "Desirae", "Loura",
                    "Sherie", "Mallie", "Tomas", "Carolee", "Vincenza", "Tyesha",
                    "Rhiannon", "Joesph", "Tijuana", "Lashandra", "Gene", "Melynda",
                    "Shirly", "Ulrike"));
            ArrayList<String> sobrenomes = new ArrayList<String>(30);

            ArrayList<String> genero = new ArrayList<String>(30);
            genero.add("masculino");
            genero.add("feminino");

            for (int i = 0; i < NUM_USUARIOS; i++) {
                query.setClauses(new IClause[]{
                    CREATE.node(usuario).label("Usuario")
                    .property("id").value(i)
                    .property("nome").value(nomes.get(i))
                    .property("sobrenome").value("da Silva")
                    .property("username").value(nomes.get(i).toLowerCase() + "_frienterestUser" + i)
                    .property("sexo").value(genero.get(i % 2))
                    .property("email").value(nomes.get(i).toLowerCase() + "@email.com")
                    .property("senha").value("senha123")
                    .property("nascimento").value("1/1/1")
                    .property("sobre").value("Uma pessoa interessante" + i)
                    .property("validado").value("sim")
                });
                result = remote.execute(query);
            }

            if (result.hasErrors()) {
                response.sendRedirect("criacao_conta.jsp?msg=falha");
            }
        } catch (Exception e) {
            response.sendRedirect("criacao_conta.jsp?msg=falha");
        }
        response.sendRedirect("busca_pessoas.jsp");
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
