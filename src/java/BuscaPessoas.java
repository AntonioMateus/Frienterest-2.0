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
import iot.jcypher.query.factories.clause.MATCH;
import iot.jcypher.query.factories.clause.RETURN;
import iot.jcypher.query.values.JcNode;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.Properties;
import java.util.regex.PatternSyntaxException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.neo4j.graphdb.Label;

/**
 *
 * @author andrew
 */
public class BuscaPessoas extends HttpServlet {

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
            out.println("<title>Servlet BuscaPessoas</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuscaPessoas at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
    }

    //Se for a primeira vez que você está executando esse projeto, descomente as linhas a seguir
    public enum TipoNo implements Label {

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

        String pessoa = request.getParameter("pessoa");
        List pessoasEncontradas = new ArrayList();

        try {
            String[] nomeSobrenome = pessoa.split("\\s+");

            if (nomeSobrenome.length == 1) {
                query.setClauses(new IClause[]{
                    MATCH.node(usuario).label("Usuario")
                    .property("nome").value(nomeSobrenome[0]),
                    RETURN.value(usuario)
                });
            } else if (nomeSobrenome.length == 2) {
                query.setClauses(new IClause[]{
                    MATCH.node(usuario).label("Usuario")
                    .property("nome").value(nomeSobrenome[0])
                    .property("sobrenome").value(nomeSobrenome[1]),
                    RETURN.value(usuario)
                });
            }

            JcQueryResult result = remote.execute(query);

            if (result.hasErrors()) {
                response.sendRedirect("criacao_conta.jsp?msg=falha");
            }

            List<GrNode> pessoas = result.resultOf(usuario);
            ListIterator<GrNode> itPessoas = pessoas.listIterator();
            
            while (itPessoas.hasNext()) {
                GrNode user = itPessoas.next();
                List encontrou = new ArrayList();
                String nome = (String) user.getProperty("nome").getValue().toString();
                String sobrenome = (String) user.getProperty("sobrenome").getValue().toString();
                String sobre = (String) user.getProperty("sobre").getValue().toString();
                encontrou.add(nome);
                encontrou.add(sobrenome);
                encontrou.add(sobre);
                pessoasEncontradas.add(encontrou);
            }

            request.setAttribute("pessoasEncontradas", pessoasEncontradas);
            RequestDispatcher rd = request.getRequestDispatcher("busca_pessoas.jsp");
            rd.forward(request, response);
            
        } catch (PatternSyntaxException ex) {
            response.sendRedirect("pagina_inicial.jsp");
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
