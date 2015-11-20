/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.neo4j.cypher.javacompat.ExecutionEngine;
import org.neo4j.cypher.javacompat.ExecutionResult;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Label;
import org.neo4j.graphdb.Node;
import org.neo4j.graphdb.Transaction;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;

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
        GraphDatabaseService graphDb = new GraphDatabaseFactory().newEmbeddedDatabase("graph.db");
        ExecutionEngine engine = new ExecutionEngine(graphDb);
        ExecutionResult result;
        String pessoa = request.getParameter("pessoa");
        List pessoasEncontradas = new ArrayList();

        try (Transaction tx = graphDb.beginTx()) {
            result = engine.execute("match (n:Usuario) where n.nome='" + pessoa + "' return n");
            Iterator<Node> pessoas = result.columnAs("n");
            while (pessoas.hasNext()) {
                Node user = pessoas.next();
                List encontrou = new ArrayList();
                String nome = (String) user.getProperty("nome");
                String sobrenome = (String) user.getProperty("sobrenome");
                String sobre = (String) user.getProperty("sobre");
                encontrou.add(nome);
                encontrou.add(sobrenome);
                encontrou.add(sobre);
                pessoasEncontradas.add(encontrou);
            }
            
            request.setAttribute("pessoasEncontradas", pessoasEncontradas);
            RequestDispatcher rd = request.getRequestDispatcher("busca_pessoas.jsp");
            rd.forward(request, response);
            tx.success();
            
        } catch (NullPointerException n) {
            response.sendRedirect("pagina_inicial.jsp");
        } finally {
            graphDb.shutdown();
            response.sendRedirect("pagina_inicial.jsp");
        }

        //processRequest(request, response);
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
