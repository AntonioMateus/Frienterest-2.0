<%-- 
    Document   : busca_pessoas
    Created on : 30/09/2015, 23:35:03
    Author     : andrew
--%>

<%@page import="java.util.LinkedList"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
                <title>Frienterest</title>

                <link href="css/foundation.css" rel="stylesheet" type="text/css"/>
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

                    /* Styles for search results */

                    .results {

                        margin-top: 50px;

                    }

                    .results .search-results {

                        margin-top: 40px;

                        margin-bottom: 20px;

                    }

                    .results img {

                        margin-left: auto;

                        margin-right: auto;

                        margin-bottom: 10px;

                    }

                    .top-bar{
                        background: #2980b9
                    }

                </style>
                <link rel="shortcut icon" href="frienterest.ico">
                </head>

                <body>
                    <!-- Busca -->
                    <% String termoBusca = request.getParameter("msg");
                    String SERVER_ROOT_URI = "http://localhost:7474/";
                    String usernameDB = "neo4j";
                    String passwdDB = "dba";
                    Properties props = new Properties();
                    props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);
                    IDBAccess remote = DBAccessFactory.createDBAccess(DBType.REMOTE, props, usernameDB, passwdDB);
                    JcNode usuario = new JcNode("Usuario");
                    JcNode pagina = new JcNode("Pagina");
                    JcNode palavraChave = new JcNode("PalavraChave"); 
                    JcQuery buscaUsuarios = new JcQuery();
                    buscaUsuarios.setClauses(new IClause[] {
                        MATCH.node(usuario).label("Usuario").property("nome").value(termoBusca),
                        RETURN.value(usuario)
                    });
                    JcQueryResult resultado = remote.execute(buscaUsuarios); 
                    if (resultado.hasErrors()) {
                        out.print("<script>alert('Erro na busca de usuarios')</script>");
                    }
                    List<GrNode> usuariosResultantes = resultado.resultOf(usuario);
                    JcQuery buscaPaginas = new JcQuery();
                    buscaPaginas.setClauses(new IClause[] {
                        MATCH.node(pagina).label("Pagina").property("nome").value(termoBusca),
                        RETURN.value(pagina)
                    });
                    resultado = remote.execute(buscaPaginas); 
                    if (resultado.hasErrors()) {
                        out.print("<script>alert('Erro na busca de paginas')</script>");
                    }
                    List<GrNode> paginasResultantes1 = resultado.resultOf(pagina);
                    buscaPaginas = new JcQuery();
                    buscaPaginas.setClauses(new IClause[] {
                        MATCH.node(pagina).label("Pagina").relation().out().type("PossuiPalavraChave").node(palavraChave).label("PalavraChave").property("nome").value("termoBusca"),
                        RETURN.value(pagina)
                    });
                    resultado = remote.execute(buscaPaginas);
                    if (resultado.hasErrors()) {
                        out.print("<script>alert('Erro na busca de paginas')</script>");
                    }
                    List<GrNode> paginasResultantes2 = resultado.resultOf(pagina); %>
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

                                <li><a href="redirect.jsp">Sair</a></li>

                                <li class="has-dropdown">

                                    <a href="#">Opções</a>

                                    <ul class="dropdown">

                                        <li><a href="pagina_inicial.jsp">Home</a></li>

                                        <li><a href="redirect.jsp">Conta</a></li>

                                    </ul>

                                </li>

                            </ul>


                            <!-- Left Nav Section -->

                            <ul class="left">


                            </ul>

                        </section>

                    </nav>

                    <!-- Busca - Fim -->

                    <h2 align="center">Pessoas Interessantes</h2>

                    <!-- Exibicao da busca -->
                    <div class="row results">

                        <div class="large-12 columns ">

                            <div class="row">

                                <div class="large-9 columns">

                                    <h3> Resultado da busca: </h3>

                                </div>

                            </div>

                            <div class="search-results">
                                
                                <%  if (usuariosResultantes.size() == 0) {
                                       %><h3><% out.print("Nao foi encontrado nenhum usuario com o nome " +termoBusca); %></h3><%
                                    }
                                    else {
                                        for (GrNode usuarioEncontrado:usuariosResultantes) {
                                            String nome = usuarioEncontrado.getProperty("nome").getValue().toString();
                                            String sobrenome = usuarioEncontrado.getProperty("sobrenome").getValue().toString(); 
                                            String username = usuarioEncontrado.getProperty("username").getValue().toString();
                                            %><a href='pagina_usuario.jsp?msg=<%=username%>'><%=(nome + " " +sobrenome)%></a><%
                                        }    
                                    }
                                
                                    if (paginasResultantes1.size() == 0 && paginasResultantes2.size() == 0) {
                                        %><h3><% out.print("Nao foi encontrado nenhuma pagina com o nome " +termoBusca); %></h3><%
                                    }
                                    else {
                                        List<GrNode> paginasEncontradas = new LinkedList<>();
                                        for (GrNode paginaEncontrada:paginasResultantes1) {
                                            paginasEncontradas.add(paginaEncontrada);
                                        }
                                        for (GrNode paginaEncontrada:paginasResultantes2) {
                                            if (!paginasEncontradas.contains(paginaEncontrada))
                                                paginasEncontradas.add(paginaEncontrada);
                                        }
                                        for (GrNode paginaEncontrada:paginasEncontradas) {
                                            String nomePagina = paginaEncontrada.getProperty("nome").getValue().toString();
                                            %><a href='pagina_generica.jsp?msg=<%=nomePagina%>'><%=nomePagina%></a><%
                                        }    
                                    }%>

                                <!--<div class="row ">

                                    <div class="large-2 columns">

                                        <a href="#"> <span> </span><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Gnome-stock_person.svg/2000px-Gnome-stock_person.svg.png" alt="book cover" class=" thumbnail"></a>

                                    </div>

                                    <div class="large-10 columns">

                                        <div class="row">

                                            <div class=" large-9 columns">

                                                <h5><></h5>

                                                <p><a href="#"> Página </a> | <a href="#"> Interesses </a></p>

                                            </div>

                                            <div class=" large-3 columns">

                                                <a href="#"  class="button  expand medium"><span>Enviar mensagem</span> </a>

                                                <a href="#"  class="button  expand medium"><span>Adicionar como amigo(a)</span></a> 

                                            </div>

                                            <div class="row">

                                                <div class=" large-12 columns">

                                                    <ul class="large-block-grid-2">

                                                        <li>

                                                            <ul>

                                                                <li><strong>Nome: </strong> <> </li>

                                                                <li><strong>Sobrenome:</strong>  </li>

                                                                <li><strong>Interesses em comum: </strong> Nenhum </li>

                                                                <li><strong>Amizades em comum:</strong> Nenhuma </li>

                                                            </ul>

                                                        </li>


                                                    </ul>

                                                </div> -->

                                            </div>

                                        </div>

                                    </div>

                                    <hr>

                               <!-- </div>         

                            </div>
                                                }

                           

                            %>

                            <h4 align="center">
                                Nenhum resultado encontrado.
                            </h4>

                                       <!--
                                        <a href="#" class="button right"> show more results &raquo;</a>
                            
                        </div>

                    </div>-->
                    <!-- Exibicao da busca - Fim -->

                </body>
            </html>
