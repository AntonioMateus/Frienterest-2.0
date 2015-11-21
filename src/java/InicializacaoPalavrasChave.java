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
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Label;
import org.neo4j.graphdb.Node;
import org.neo4j.graphdb.Transaction;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;
import org.neo4j.cypher.javacompat.ExecutionEngine;

/**
 *
 * @author Antonio Mateus
 */
public class InicializacaoPalavrasChave extends HttpServlet {

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
            out.println("<title>Servlet InicializacaoPalavrasChave</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InicializacaoPalavrasChave at " + request.getContextPath() + "</h1>");
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
        PalavraChave;
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
//          engine.execute("optional match (n:Usuario) optional match (n)-[r]->() delete n,r");
            engine.execute("optional match (n:PalavraChave) optional match (n)<-[r]-() delete n,r");
            engine.execute("optional match (n:Pagina) optional match (n)-[r]-() delete n,r");
            Node palavra1 = graphDb.createNode(TipoNo.PalavraChave);
            palavra1.setProperty("id", "1");
            palavra1.setProperty("nome", "esportes");
            Node palavra2 = graphDb.createNode(TipoNo.PalavraChave);
            palavra2.setProperty("id", "2");
            palavra2.setProperty("nome", "politica");
            Node palavra3 = graphDb.createNode(TipoNo.PalavraChave);
            palavra3.setProperty("id", "3");
            palavra3.setProperty("nome", "educacao");
            Node palavra4 = graphDb.createNode(TipoNo.PalavraChave);
            palavra4.setProperty("id", "4");
            palavra4.setProperty("nome", "meio_ambiente");
            Node palavra5 = graphDb.createNode(TipoNo.PalavraChave);
            palavra5.setProperty("id", "5");
            palavra5.setProperty("nome", "informatica");
            Node palavra6 = graphDb.createNode(TipoNo.PalavraChave);
            palavra6.setProperty("id", "6");
            palavra6.setProperty("nome", "cinema");
            Node palavra7 = graphDb.createNode(TipoNo.PalavraChave);
            palavra7.setProperty("id", "7");
            palavra7.setProperty("nome", "teatro");
            Node palavra8 = graphDb.createNode(TipoNo.PalavraChave);
            palavra8.setProperty("id", "8");
            palavra8.setProperty("nome", "psicologia");
            Node palavra9 = graphDb.createNode(TipoNo.PalavraChave);
            palavra9.setProperty("id", "9");
            palavra9.setProperty("nome", "curiosidades");
            Node palavra10 = graphDb.createNode(TipoNo.PalavraChave);
            palavra10.setProperty("id", "10");
            palavra10.setProperty("nome", "humor");
            Node palavra11 = graphDb.createNode(TipoNo.PalavraChave);
            palavra11.setProperty("id", "11");
            palavra11.setProperty("nome", "saude");
            Node palavra12 = graphDb.createNode(TipoNo.PalavraChave);
            palavra12.setProperty("id", "12");
            palavra12.setProperty("nome", "economia");
            Node palavra13 = graphDb.createNode(TipoNo.PalavraChave);
            palavra13.setProperty("id", "13");
            palavra13.setProperty("nome", "noticias");
            Node palavra14 = graphDb.createNode(TipoNo.PalavraChave);
            palavra14.setProperty("id", "14");
            palavra14.setProperty("nome", "marketing");
            Node palavra15 = graphDb.createNode(TipoNo.PalavraChave);
            palavra15.setProperty("id", "15");
            palavra15.setProperty("nome", "musica");
            Node palavra16 = graphDb.createNode(TipoNo.PalavraChave);
            palavra16.setProperty("id", "16");
            palavra16.setProperty("nome", "games");
            Node palavra17 = graphDb.createNode(TipoNo.PalavraChave);
            palavra17.setProperty("id", "17");
            palavra17.setProperty("nome", "viagem");
            Node palavra18 = graphDb.createNode(TipoNo.PalavraChave);
            palavra18.setProperty("id", "18");
            palavra18.setProperty("nome", "literatura");
            Node palavra19 = graphDb.createNode(TipoNo.PalavraChave);
            palavra19.setProperty("id", "19");
            palavra19.setProperty("nome", "animais");
            Node palavra20 = graphDb.createNode(TipoNo.PalavraChave);
            palavra20.setProperty("id", "20");
            palavra20.setProperty("nome", "series_televisao");
            tx.success();
            System.out.println("Rede reiniciada! Todas as palavras-chave foram inseridas!");
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
