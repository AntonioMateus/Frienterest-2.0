<%-- 
    Document   : pagina_usuario
    Created on : 23/11/2015, 12:52:31
    Author     : Antonio Mateus
--%>

<%@page import="utils.SugestaoPessoasASeguir"%>
<%@page import="utils.SugestaoPaginas"%>
<%@page import="utils.ControleLogin"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Properties"%>
<%@page import="iot.jcypher.graph.GrNode"%>
<%@page import="iot.jcypher.database.DBType"%>
<%@page import="iot.jcypher.database.DBProperties"%>
<%@page import="iot.jcypher.database.DBAccessFactory"%>
<%@page import="iot.jcypher.database.IDBAccess"%>
<%@page import="iot.jcypher.query.JcQuery"%>
<%@page import="iot.jcypher.query.JcQueryResult"%>
<%@page import="iot.jcypher.query.factories.clause.RETURN"%>
<%@page import="iot.jcypher.query.values.JcNode"%>
<%@page import="iot.jcypher.query.api.IClause"%>
<%@page import="iot.jcypher.query.factories.clause.MATCH"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%  String usernameLogado = ControleLogin.getUsernameLogado();
            String usernameDonoPagina = request.getParameter("msg");
            String SERVER_ROOT_URI = "http://localhost:7474/";
            String usernameDB = "neo4j";
            String passwdDB = "dba";
            Properties props = new Properties();
            props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);
            IDBAccess remote = DBAccessFactory.createDBAccess(DBType.REMOTE, props, usernameDB, passwdDB);
            JcNode usuario = new JcNode("Usuario");
            JcQuery query = new JcQuery();
            query.setClauses(new IClause[] {
                MATCH.node(usuario).label("Usuario").property("username").value(usernameDonoPagina),
                RETURN.value(usuario)
            });
            JcQueryResult resultado = remote.execute(query);
            if (resultado.hasErrors()) {
                %><h1><%out.println("Deu ruim");%></h1><%
            }
            List<GrNode> usuarios = resultado.resultOf(usuario);
            String nome = usuarios.get(0).getProperty("nome").getValue().toString();
            String sobrenome = usuarios.get(0).getProperty("sobrenome").getValue().toString();
            String email = usuarios.get(0).getProperty("email").getValue().toString(); 
            String descricao = usuarios.get(0).getProperty("sobre").getValue().toString();
            String interesses = usuarios.get(0).getProperty("interesses").getValue().toString();
            String dataNascimento = usuarios.get(0).getProperty("data_nascimento").getValue().toString();
            String genero = usuarios.get(0).getProperty("genero").getValue().toString();            
            %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%out.print("Frienterest - "+usernameDonoPagina);%></title>
        <link href="css/foundation.css" rel="stylesheet" type="text/css"/>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css" rel="stylesheet">
        <style type="text/css">
            .has-form {

                position: absolute;

                top: 0;

                left: 6rem;

                min-width: 14rem; }

            @media only screen and (max-width: 40em) {

                .has-form {

                    min-width: 10rem;

                    top: 0.5rem; }

                .has-form .button {

                    height: 1.85rem; } }
            
            .top-bar{
            background: #2980b9
            }
            
            .imgClass {
                background-image: url(http://i.imgur.com/A1ucAzP.png?1);
                background-position: 0px 0px; 
                background-repeat: no-repeat;
                width: 124px;
                height: 122px;
                border: 0px;
                cursor: pointer;
                outline: 0;
            }
            
                </style>
            <link rel="shortcut icon" href="frienterest.ico">
            </head>
            <body>
                <!-- Busca -->

        <nav class="top-bar" data-topbar role="navigation">
            <form method="POST" action="BuscaPessoas">
                <ul class="title-area">

                    <li class="name">

                        <h1><a href="pagina_inicial.jsp?msg=<%=ControleLogin.getUsernameLogado()%>">Frienterest &nbsp;</a></h1>

                    </li>

                    <li class="has-form">

                        <div class="row collapse">

                            <div class="large-8 small-9 columns">

                                <input type="text" name="pessoa" placeholder="Encontre Pessoas">

                            </div>

                            <div class="large-4 small-3 columns">

                                <input type="submit" class="alert button expand" value="Pesquisar"></input>

                            </div>

                        </div>

                    </li>

            </form>
            <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->

            <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>

        </ul>

        <section class="top-bar-section">

            <!-- Right Nav Section -->
            <ul class="right">
                <li><form method="post" action="ExcluirConta"><input type="submit" value="Excluir conta" class="button"></form></li>
                <li><a href="pagina_usuario.jsp?msg=<%=usernameLogado%>">Minha página</a></li>
                <li><a href="criacao_pagina.jsp">Criar página</a></li>                
                              
                <li><a href="redirect.jsp">Sair</a></li>

            </ul>


            <!-- Left Nav Section -->

            <ul class="left">


            </ul>

        </section>

    </nav>

    <!-- Busca - Fim -->
    
    <div class="row">
        <div class="large-9 columns auth-plain">
            <h2><%out.print(nome+" "+sobrenome);%></h2>
            <h3><b>Gênero:</b><%out.print(genero);%></h3>
            <h3><b>Email para contato:</b><%out.print(email);%></h3>
            <h3><b>Data de nascimento:</b><%out.print(dataNascimento);%></h3>
            <h3><b>Descrição:</b><%out.print(descricao);%></h3>
            <h3><b>Interesses:</b></h3> 
            <br>
            <%  char[] vetorInteresses = interesses.toCharArray();
                for (int i = 0; i < vetorInteresses.length; i++) {
                    char caractere = vetorInteresses[i];
                    if (caractere == '1') {
                        JcNode palavraChave = new JcNode("PalavraChave");
                        JcQuery achaPalavra = new JcQuery(); 
                        achaPalavra.setClauses(new IClause[] {
                            MATCH.node(palavraChave).label("PalavraChave").property("id").value("" +(i+1)),
                            RETURN.value(palavraChave)
                        });
                        String nomeInteresse = remote.execute(achaPalavra).resultOf(palavraChave).get(0).getProperty("nome").getValue().toString();
                        %><h3><%out.print(nomeInteresse);%></h3>
                          <br><%
                    } 
                }%>            
        </div>
        <div class="large-3 columns auth-plain">
            <% if (usernameLogado.equals(usernameDonoPagina)) { %>
                <h4>Talvez estas páginas sejam de seu interesse...</h4>
                <%  List<GrNode> listaPaginasInteressantes = SugestaoPaginas.retornaPaginasMaisSemelhantes(5);
                for (GrNode paginaInteressante: listaPaginasInteressantes) {
                    String nomePaginaPossivelmenteInteressante = paginaInteressante.getProperty("nome").getValue().toString();
                    %><a href="pagina_generica.jsp?msg=<%=nomePaginaPossivelmenteInteressante%>"><%=nomePaginaPossivelmenteInteressante%></a><% 
                } %>
                <h4>Talvez seja legal conhecer estas pessoas...</h4> 
            <%  List<GrNode> listaPessoasInteressantes = SugestaoPessoasASeguir.retornaPessoasMaisSemelhantes(5);
                for (GrNode pessoaInteressante: listaPessoasInteressantes) {
                    String nomePessoaPossivelmenteInteressante = pessoaInteressante.getProperty("nome").getValue().toString();
                    String usernamePessoaPossivelmenteInteressante = pessoaInteressante.getProperty("username").getValue().toString();
                    String sobrenomePessoaPossivelmenteInteressante = pessoaInteressante.getProperty("sobrenome").getValue().toString();
                    %><a href="pagina_usuario.jsp?msg=<%=usernamePessoaPossivelmenteInteressante%>"><%=nomePessoaPossivelmenteInteressante +" " +sobrenomePessoaPossivelmenteInteressante%></a><%
                }  
            }    
            else { 
                JcNode amigo = new JcNode ("Usuario");
                JcQuery descobertaAmigos = new JcQuery();
                descobertaAmigos.setClauses(new IClause[] {
                    MATCH.node(usuario).label("Usuario").relation().out().type("Segue").node(amigo).label("Usuario"),
                    RETURN.value(amigo)
                });
                List<GrNode> pessoasSeguidas = remote.execute(descobertaAmigos).resultOf(amigo);
                boolean usuarioJahSeguido = false;
                for (GrNode pessoa:pessoasSeguidas) {
                    if (pessoa.getProperty("username").getValue().toString().equals(usernameDonoPagina)) {
                        usuarioJahSeguido = true;
                    }
                }
                if (!usuarioJahSeguido) {%>
                    <form action="Seguir" method="post">
                        <input name="nomeUsuario" value="<%=usernameDonoPagina%>" hidden="true" readonly="true">
                        <input type="submit" value=""  class="imgClass">

                        <p style="text-align: left"> Adicionar amigo </p>
                    </form> 
            <%  }
            }%>
        </div>
    </div>
    </body>
</html>