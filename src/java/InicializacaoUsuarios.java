/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.neo4j.cypher.javacompat.ExecutionEngine;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Label;
import org.neo4j.graphdb.Node;
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
        GraphDatabaseService graphDb = new GraphDatabaseFactory().newEmbeddedDatabase("graph.db");
        ExecutionEngine engine = new ExecutionEngine(graphDb);
        try (Transaction tx = graphDb.beginTx()) {
            engine.execute("optional match (n:Usuario) optional match (n)-[r]->() delete n,r");
//          engine.execute("optional match (n:Usuario) optional match (n)<-[r]-() delete n,r");
//          engine.execute("optional match (n:Pagina) optional match (n)-[r]-() delete n,r");
            ArrayList<String> nomes = new ArrayList<String>(30);
            nomes.addAll(Arrays.asList("Melynda","Ima","Dortha","Raina",
                    "Sharolyn","Colby","Janita","Coleman","Jeanelle","Alicia",
                    "Valene","Winston","Rebbeca","Sebrina","Desirae","Loura",
                    "Sherie","Mallie","Tomas","Carolee","Vincenza","Tyesha",
                    "Rhiannon","Joesph","Tijuana","Lashandra","Gene","Le",
                    "Shirly","Ulrike"));
            ArrayList<String> sobrenomes = new ArrayList<String>(30);
            
            ArrayList<String> genero = new ArrayList<String>(30);
            genero.add("masculino");
            genero.add("feminino");
            
            for (int i = 0; i < nomes.size(); i++) {
                Node usuario = graphDb.createNode(InicializacaoUsuarios.TipoNo.Usuario);
                usuario.setProperty("id", i);
                usuario.setProperty("nome", nomes.get(i));
                usuario.setProperty("sobrenome", "da Silva");              
                usuario.setProperty("sexo", genero.get(i%2));
                usuario.setProperty("email", nomes.get(i).toLowerCase()+"@email.com");
                usuario.setProperty("senha", "senha123");
                usuario.setProperty("nascimento", "1/1/1");
                usuario.setProperty("sobre", "Uma pessoa interessante" + i);
                usuario.setProperty("validado", "sim");
            }
            tx.success();
            System.out.println("Rede reiniciada! Todas as pessoas foram inseridas!");
            response.sendRedirect("redirect.jsp");
        }
        finally {
            graphDb.shutdown();
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
