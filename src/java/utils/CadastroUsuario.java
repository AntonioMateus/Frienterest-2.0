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
import iot.jcypher.query.factories.clause.MATCH;
import iot.jcypher.query.factories.clause.RETURN;
import iot.jcypher.query.values.JcNode;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//envio de email:
import java.util.Properties;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.neo4j.graphdb.Label;

/**
 *
 * @author Antonio Mateus
 */
public class CadastroUsuario extends HttpServlet {

    public static String emailUsuario;
    public static String codigoVerificacao;
    public static String usernameUsuario;

    public static String getUsernameUsuario() {
        return usernameUsuario;
    }

    public static String getEmailUsuario() {
        return emailUsuario;
    }

    public static String getCodigoVerificacao() {
        return codigoVerificacao;
    }

    public static void setUsernameUsuario(String username) {
        usernameUsuario = username;
    }

    public static void setEmailUsuario(String email) {
        emailUsuario = email;
    }

    public static void setCodigoVerificacao(String codigo) {
        codigoVerificacao = codigo;
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
            out.println("<title>Servlet CadastroUsuario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CadastroUsuario at " + request.getContextPath() + "</h1>");
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

// REFATORACAO CONEXAO SERVIDOR 3
        Properties props = new Properties();
        props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);

        IDBAccess remote
                = DBAccessFactory.createDBAccess(DBType.REMOTE, props, usernameDB, passwdDB);

        JcNode usuario = new JcNode("Usuario");
        JcQuery query = new JcQuery();

        try {
            String nome = request.getParameter("nome");
            String sobrenome = request.getParameter("sobrenome");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String senha = request.getParameter("senha");
            String copia_senha = request.getParameter("copia_senha");
            String dataNasc = request.getParameter("data_nascimento");
            String genero = request.getParameter("genero");
            String sobre = request.getParameter("sobre");
                
            if (copia_senha.equals(senha)) {
                setUsernameUsuario(username);
                setEmailUsuario(email);

                JcQuery preQuery = new JcQuery();
                preQuery.setClauses(new IClause[] {
                    MATCH.node(usuario).label("Usuario")
                    .property("username").value(username),
                    RETURN.value(usuario)
                });
                boolean existeUsuarioComUsername;
                try {
                    JcQueryResult r = remote.execute(preQuery);
                    List<GrNode> l = r.resultOf(usuario);
                    GrNode teste = l.get(0);
                    existeUsuarioComUsername = true;
                }
                catch (IndexOutOfBoundsException i) {
                    existeUsuarioComUsername = false; 
                }
                preQuery = new JcQuery();
                preQuery.setClauses(new IClause[] {
                    MATCH.node(usuario).label("Usuario")
                    .property("email").value(email),
                    RETURN.value(usuario)
                });
                boolean existeUsuarioComEmail;
                try {
                    JcQueryResult r = remote.execute(preQuery);
                    List<GrNode> l = r.resultOf(usuario);
                    GrNode teste = l.get(0);
                    existeUsuarioComEmail = true;
                }
                catch (IndexOutOfBoundsException i) {
                    existeUsuarioComEmail = false; 
                }

                if (!existeUsuarioComUsername && !existeUsuarioComEmail) {
                    String codigo = String.valueOf((int) (java.lang.Math.random() * 8999 + 1000));
                    setCodigoVerificacao(codigo);
                    query.setClauses(new IClause[]{
                        CREATE.node(usuario).label("Usuario")
                        .property("nome").value(nome)
                        .property("sobrenome").value(sobrenome)
                        .property("username").value(username)
                        .property("email").value(email)
                        .property("senha").value(senha)
                        .property("data_nascimento").value(dataNasc)
                        .property("genero").value(genero)
                        .property("sobre").value(sobre)
                        .property("validado").value("nao")
                        .property("codigo_enviado").value(codigo)
                    });
                    JcQueryResult result = remote.execute(query);
                    ControleLogin.setUsernameLogado(username);
                    if (result.hasErrors()) {
                        response.sendRedirect("criacao_conta.jsp?msg=falha");
                        return;
                    }
                    Properties eProps = new Properties();
                    eProps.put("mail.smtp.host", "smtp.gmail.com");
                    eProps.put("mail.smtp.socketFactory.port", "465");
                    eProps.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                    eProps.put("mail.smtp.auth", "true");
                    eProps.put("mail.smtp.port", "465");
                    Session session = Session.getInstance(eProps,
                            new javax.mail.Authenticator() {
                                @Override
                                protected PasswordAuthentication getPasswordAuthentication() {
                                    return new PasswordAuthentication("equipefrienterest@gmail.com", "frien27terest");
                                }
                            });
                    session.setDebug(true);
                    Message message = new MimeMessage(session);
                    message.setFrom(new InternetAddress("equipefrienterest@gmail.com"));
                    Address[] destinatarios = InternetAddress.parse(email);
                    message.setRecipients(Message.RecipientType.TO, destinatarios);
                    String artigo = (genero.equals("masculino") ? "o" : "a");
                    String assunto = "Bem vind" + artigo + " ao Frienterest";
                    message.setSubject(assunto);
                    String mensagem = "Olá " + nome + ", tudo bem?\nSeja bem vind" + artigo + " ao Frienterest: uma rede de pessoas interessantes. \nPor favor, use o código " + codigo + " quando for necessário.\nAtenciosamente.\nEquipe Frienterest";
                    message.setText(mensagem);
                    Transport.send(message);
                  
                    response.sendRedirect("verificacao_email.jsp?msg="+username);
                }            
                else if (existeUsuarioComUsername || existeUsuarioComEmail) {
                    response.sendRedirect("criacao_conta.jsp?msg=usuarioExistente");
                }
            }
            else {
                response.sendRedirect("criacao_conta.jsp?msg=falha");
            }
        } catch (MessagingException mex) {
            response.sendRedirect("criacao_conta.jsp?msg=emailInvalido");
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
