/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import iot.jcypher.database.DBAccessFactory;
import iot.jcypher.database.DBProperties;
import iot.jcypher.database.DBType;
import iot.jcypher.database.IDBAccess;
import iot.jcypher.query.JcQuery;
import iot.jcypher.query.api.IClause;
import iot.jcypher.query.factories.clause.CREATE;
import iot.jcypher.query.factories.clause.MATCH;
import iot.jcypher.query.values.JcNode;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

        IDBAccess remote
                = DBAccessFactory.createDBAccess(DBType.REMOTE, props, user, passwd);

        String nomePagina = request.getParameter("nome");
        String descricao = request.getParameter("sobre");
        
        JcNode pagina = new JcNode("Pagina");
        JcQuery criacaoPagina = new JcQuery();
        criacaoPagina.setClauses(new IClause[] {
            CREATE.node(pagina).label("Pagina")
            .property("nome").value(nomePagina)
            .property("descricao").value(descricao)
        });
        remote.execute(criacaoPagina);
        JcQuery relacionamentoPaginaPalavraChave;
        JcNode palavraChave = new JcNode("PalavraChave");
        if (request.getParameter("esportes") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("esportes"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("politica") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("politica"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("educacao") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("educacao"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("meio_ambiente") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("meio_ambiente"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("informatica") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("informatica"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("cinema") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("cinema"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("teatro") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("teatro"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("psicologia") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("psicologia"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("curiosidades") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("curiosidades"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("humor") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("humor"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("saude") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("saude"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("economia") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("economia"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("noticias") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("noticias"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("marketing") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("marketing"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("musica") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("musica"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("games") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("games"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("viagem") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("viagem"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("literatura") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("literatura"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("animais") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("animais"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        if (request.getParameter("series_televisao") != null) {
            relacionamentoPaginaPalavraChave = new JcQuery();
            relacionamentoPaginaPalavraChave.setClauses(new IClause[] {
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                MATCH.node(palavraChave).label("PalavraChave").property("nome").value("series_televisao"),
                CREATE.node(pagina).relation().out().type("PossuiPalavraChave").node(palavraChave)
            });
            remote.execute(relacionamentoPaginaPalavraChave);
        }
        String usernameCriador = ControleLogin.getUsernameLogado();
        JcQuery correspondenciaPaginaCriador = new JcQuery();
        JcNode criador = new JcNode("Usuario");
        correspondenciaPaginaCriador.setClauses(new IClause[]{
            MATCH.node(criador).label("Usuario").property("username").value(usernameCriador),
            MATCH.node(pagina).label("Pagina"),
            CREATE.node(criador).relation().out().type("CriaPagina").node(pagina)
        });
        response.sendRedirect("pagina_generica.jsp?msg="+nomePagina+"_"+descricao);
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
