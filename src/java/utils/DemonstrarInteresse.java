package utils;

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
import iot.jcypher.query.factories.clause.CREATE;
import iot.jcypher.query.factories.clause.DO;
import iot.jcypher.query.factories.clause.MATCH;
import iot.jcypher.query.factories.clause.RETURN;
import iot.jcypher.query.values.JcNode;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
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
public class DemonstrarInteresse extends HttpServlet {

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
            out.println("<title>Servlet DemonstrarInteresse</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DemonstrarInteresse at " + request.getContextPath() + "</h1>");
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

        final String user = "neo4j";
        final String passwd = "dba";
        
        Properties props = new Properties();
        props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);

        IDBAccess remote = DBAccessFactory.createDBAccess(DBType.REMOTE, props, user, passwd);
        String nomePagina = request.getParameter("nomePagina");
        String username = ControleLogin.getUsernameLogado();
        JcNode pagina = new JcNode("Pagina");
        JcNode usuario = new JcNode("Usuario");
       
        
        JcQuery criacaoRelacionamento = new JcQuery(); 
        criacaoRelacionamento.setClauses(new IClause[]{
            MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
            MATCH.node(usuario).label("Usuario").property("username").value(username),
            CREATE.node(usuario).relation().out().type("Mostra_interesse").node(pagina)
        });
        JcQueryResult resultado = remote.execute(criacaoRelacionamento);
        if (resultado.hasErrors()) {
            System.out.println("Houve erro durante a criacao do relacionamento");
        }
        
        JcQuery descobertaPalavrasChave = new JcQuery(); 
        JcNode palavraChave = new JcNode("PalavraChave");
        descobertaPalavrasChave.setClauses(new IClause[] {
            MATCH.node().label("Pagina").property("nome").value(nomePagina).relation().out().type("PossuiPalavraChave").node(palavraChave),
            RETURN.value(palavraChave)
        });
        resultado = remote.execute(descobertaPalavrasChave);
        if (resultado.hasErrors()) {
            System.out.println("Houve erro durante a descoberta das palavras-chave");
        }
        List<GrNode> palavrasChave = resultado.resultOf(palavraChave); 
                
        JcQuery descobertaUsuario = new JcQuery(); 
        descobertaUsuario.setClauses(new IClause[] {
            MATCH.node(usuario).label("Usuario").property("username").value(username),
            RETURN.value(usuario)
        });
        resultado = remote.execute(descobertaUsuario);
        if (resultado.hasErrors()) {
            System.out.println("Houve erro durante a descoberta do usuario");
        }
        
        String interessesUsuario = resultado.resultOf(usuario).get(0).getProperty("interesses").getValue().toString();
        
        Iterator<GrNode> iterador = palavrasChave.iterator();
        while (iterador.hasNext()) {
            GrNode palavra = iterador.next();
            int indice = Integer.valueOf(palavra.getProperty("id").getValue().toString()) - 1;
            char[] interesseArray = interessesUsuario.toCharArray();
            interesseArray[indice] = '1';
            interessesUsuario = String.valueOf(interesseArray);            
        }
        JcQuery atualizacaoUsuario = new JcQuery();
        atualizacaoUsuario.setClauses(new IClause[] {
            MATCH.node(usuario).label("Usuario").property("username").value(username),
            DO.SET(usuario.property("interesses")).to(interessesUsuario)
        });
        resultado = remote.execute(atualizacaoUsuario);
        if (resultado.hasErrors()) {
            System.out.println("Houve erro durante a atualizacao dos interesses do usuario");
        }
        response.sendRedirect("pagina_generica.jsp?msg="+nomePagina);
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
