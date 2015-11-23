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
import iot.jcypher.graph.GrRelation;
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
import java.util.List;
import java.util.Properties;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.neo4j.graphdb.Label;

/**
 *
 * @author Antonio Mateus
 */
@WebServlet(urlPatterns = {"/InicializacaoBancoDados"})
public class InicializacaoBancoDados extends HttpServlet {

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

    private enum TipoNo2 implements Label {

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

        JcNode palavraChave = new JcNode("PalavraChave");
        JcNode usuario = new JcNode("Usuario");
        final int NUM_PALAVRAS = 20;
        final int NUM_USUARIOS = 30;
        final int NUM_SOBRENOMES = 30;
        try {
            JcQueryResult result;
            List<JcError> errors = remote.clearDatabase();
            if (!errors.isEmpty()) {
                System.out.println("Houve erro ao excluir as palavras-chave");
            } else {
                ArrayList<String> interesses = new ArrayList<String>(NUM_PALAVRAS);
                interesses.addAll(Arrays.asList("esportes", "politica", "educacao", "meio_ambiente",
                        "informatica", "cinema", "teatro", "psicologia", "curiosidades", "humor",
                        "saude", "economia", "noticias", "marketing", "musicas", "games",
                        "viagem", "literatura", "animais", "series_televisao"));
                int i;
                for (i = 0; i < NUM_PALAVRAS; i++) {
                    JcQuery criacaoPalavras = new JcQuery();
                    criacaoPalavras.setClauses(new IClause[]{
                        CREATE.node(palavraChave).label("PalavraChave")
                        .property("id").value("" + (i + 1))
                        .property("nome").value(interesses.get(i))
                    });
                    result = remote.execute(criacaoPalavras);
                    if (result.hasErrors()) {
                        break;
                    }
                }
                if (i < NUM_PALAVRAS) {
                    System.out.println("Houve erro ao criar as palvras-chave");
                }

                ArrayList<String> nomes = new ArrayList<String>(NUM_USUARIOS);
                nomes.addAll(Arrays.asList("Le", "Ima", "Dortha", "Raina",
                        "Sharolyn", "Colby", "Janita", "Coleman", "Jeanelle", "Alicia",
                        "Valene", "Winston", "Rebbeca", "Sebrina", "Desirae", "Loura",
                        "Sherie", "Mallie", "Tomas", "Carolee", "Vincenza", "Tyesha",
                        "Rhiannon", "Joesph", "Tijuana", "Lashandra", "Gene", "Melynda",
                        "Shirly", "Ulrike"));
                ArrayList<String> sobrenomes = new ArrayList<String>(NUM_SOBRENOMES);
                sobrenomes.addAll(Arrays.asList("Williamson", "Walls", "Hammond",
                        "Zuniga", "Chen", "Greer", "Rocha", "Oliver", "Barton",
                        "Stevenson", "Gardner", "Curry", "Hodge", "Mayo", "Reilly",
                        "Mcfarland", "Cox", "Decker", "Duarte", "Ayers", "Barber",
                        "Leach", "Morrison", "Duffy", "Freeman", "Barajas", "Briggs",
                        "Olson", "Gamble", "Franklin"));
                ArrayList<String> genero = new ArrayList<String>(30);
                genero.add("masculino");
                genero.add("feminino");

                int j;
                for (j = 0; j < NUM_USUARIOS; j++) {
                    JcQuery query = new JcQuery();
                    query.setClauses(new IClause[]{
                        CREATE.node(usuario).label("Usuario")
                        .property("id").value(j)
                        .property("nome").value(nomes.get(j))
                        .property("sobrenome").value(sobrenomes.get(j % NUM_SOBRENOMES))
                        .property("username").value(nomes.get(j).toLowerCase() + "_" + sobrenomes.get(j % NUM_SOBRENOMES).toLowerCase())
                        .property("sexo").value(genero.get(j % 2))
                        .property("email").value(nomes.get(j).toLowerCase() + "." + sobrenomes.get(j % 30).toLowerCase() + "@email.com")
                        .property("senha").value("senha123")
                        .property("nascimento").value((j % 28) + "/" + (j % 12) + "/" + (j + 1980))
                        .property("sobre").value("Sou mais uma pessoa interessante! Fui a numero " + j + " a me cadastrar!")
                        .property("validado").value("sim")
                    });
                    result = remote.execute(query);
                    if (result.hasErrors()) {
                        break;
                    }
                }

                JcQuery query = new JcQuery();
                query.setClauses(new IClause[]{
                    MATCH.node(usuario).label("Usuario"),
                    RETURN.value(usuario)
                });
                result = remote.execute(query);
                List<GrNode> seguidores = result.resultOf(usuario);
                List<GrNode> seguidos = result.resultOf(usuario);

                Graph graph = result.getGraph();
                for (int h = 0; h < 15*NUM_USUARIOS; h++) {
                    Random rand = new Random();
                    int randomNum1 = rand.nextInt((NUM_USUARIOS - 1));
                    int randomNum2 = rand.nextInt((NUM_USUARIOS - 1));
                    while(randomNum1==randomNum2){
                        randomNum2 = rand.nextInt((NUM_USUARIOS - 1));
                    }
                    GrRelation rel = graph.createRelation("segue", seguidores.get(randomNum1), seguidos.get(randomNum2));
                    //rel.addProperty("role", "Neo");
                }

                errors = graph.store();

                if (j < NUM_USUARIOS) {
                    System.out.println("Houve erros durante a criacao dos usuarios");
                }
            }
            response.sendRedirect("redirect.jsp");
        } catch (NullPointerException n) {
            response.sendRedirect("redirect.jsp?msg=bancoVazio");
        } catch (Exception e) {
            response.sendRedirect("redirect.jsp?msg=exclusaoIncorreta");
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
