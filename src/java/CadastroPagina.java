/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.neo4j.cypher.javacompat.ExecutionEngine;
import org.neo4j.cypher.javacompat.ExecutionResult;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Label;
import org.neo4j.graphdb.Node;
import org.neo4j.graphdb.RelationshipType;
import org.neo4j.graphdb.Transaction;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;

/**
 *
 * @author Antonio Mateus
 */
public class CadastroPagina extends HttpServlet {

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
            out.println("<title>Servlet CadastroPagina</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CadastroPagina at " + request.getContextPath() + "</h1>");
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
        Pagina;
    }
    
    private enum TipoRelacionamento implements RelationshipType {
        PossuiPalavraChave, CriaPagina;
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
        try (Transaction tx = graphDb.beginTx()) {
            String nomePagina = request.getParameter("nome");
            String descricao = request.getParameter("sobre"); 
            Node pagina = graphDb.createNode(TipoNo.Pagina);
            pagina.setProperty("nome", nomePagina);
            pagina.setProperty("descricao",descricao);
            if (request.getParameter("esportes") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'esportes'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("politica") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'politica'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("educacao") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'educacao'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("meio_ambiente") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'meio_ambiente'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("informatica") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'informatica'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("cinema") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'cinema'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("teatro") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'teatro'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("psicologia") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'psicologia'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("curiosidades") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'curiosidades'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("humor") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'humor'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("saude") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'saude'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("economia") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'economia'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("economia") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'economia'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("noticias") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'noticias'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("marketing") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'marketing'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("musica") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'musica'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("games") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'games'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("viagem") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'viagem'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("literatura") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'literatura'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("animais") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'animais'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            if (request.getParameter("series_televisao") != null) {
                result = engine.execute("match (int:PalavraChave {nome:'series_televisao'}) return int");
                Iterator<Node> colunas = result.columnAs("int");
                Node interesse = colunas.next();
                pagina.createRelationshipTo(interesse, TipoRelacionamento.PossuiPalavraChave);
            }
            String emailCriador = ControleLogin.getUsernameLogado();
            if (emailCriador == null) {
                emailCriador = CadastroUsuario.getEmailUsuario(); 
            }
            String consulta = "match (criador:Usuario {email: '" +emailCriador +"'}) return criador";
            result = engine.execute(consulta);
            Iterator<Node> colunas = result.columnAs("criador");
            Node criador = colunas.next();
            criador.createRelationshipTo(pagina, TipoRelacionamento.CriaPagina);
            tx.success();
            response.sendRedirect("pagina_generica.jsp?msg="+nomePagina+"_"+descricao);
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
