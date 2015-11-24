<%-- 
    Document   : busca_pessoas
    Created on : 24/11/2015, 00:34:39
    Author     : Antonio Mateus
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
                        
                        <nav class="top-bar" data-topbar role="navigation">
                            <form method="POST" action="BuscaPessoas">
                                <ul class="title-area">

                                    <li class="name">

                                        <h1><a href="pagina_inicial.jsp">Frienterest &nbsp;</a></h1>

                                    </li>

                                    <li class="has-form">

                                        <div class="large-7 small-8 columns">

                                            <input type="text" name="pessoa" placeholder="Pessoas">

                                        </div>

                                        <div class="large-5 small-4 columns">

                                            <input type="submit" class="button" value="Pesquisar"></input>

                                        </div>

                                    </li>
                                </ul>
                            </form>

                            <section class="top-bar-section">

                                <!-- Right Nav Section -->
                                <%String username = ControleLogin.getUsernameLogado();%>
                                <ul class="right">
                                    <li><a href="pagina_usuario.jsp?msg=<%=username%>">Minha página</a></li>
                                    <li><a href="criacao_pagina.jsp">Criar página</a></li>                

                                    <li class="has-dropdown">

                                        <a href="#">Opções</a>

                                        <ul class="dropdown">
                                            <li>
                                                <form method="post" action="ExcluirConta">
                                                    <input type="submit" value="Excluir conta" class="alert button">
                                                </form>
                                            </li>
                                        </ul>

                                    </li>

                                    <li><a href="redirect.jsp">Sair</a></li>

                                </ul>


                                <!-- Left Nav Section -->

                                <ul class="left">


                                </ul>

                            </section>

                        </nav>
                        <%  
                            String SERVER_ROOT_URI = "http://localhost:7474/";
                            String usernameDB = "neo4j";
                            String passwdDB = "dba";
                            String termoBusca = request.getParameter("msg");
                            Properties props = new Properties();
                            props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);
                            IDBAccess remote = DBAccessFactory.createDBAccess(DBType.REMOTE, props, usernameDB, passwdDB);
                            JcNode usuario = new JcNode("Usuario");
                            JcNode palavraChave = new JcNode("PalavraChave");
                            JcNode pagina = new JcNode("Pagina");
                            
                            JcQuery buscaUsuarios = new JcQuery(); 
                            buscaUsuarios.setClauses(new IClause[] {
                                MATCH.node(usuario).label("Usuario").property("nome").value(termoBusca),
                                RETURN.value(usuario)
                            });
                            JcQueryResult resultado = remote.execute(buscaUsuarios);
                            if (resultado.hasErrors()) {
                                out.print("<script>alert('Houve problemas durante a busca de usuarios')</script>");
                            }
                            List<GrNode> usuariosEncontrados = resultado.resultOf(usuario);
                            List<GrNode> paginasEncontradas = new LinkedList<>(); 
                            JcQuery buscaPaginas = new JcQuery(); 
                            buscaPaginas.setClauses(new IClause[] {
                                MATCH.node(pagina).label("Pagina").property("nome").value(termoBusca),
                                RETURN.value(pagina)
                            });
                            resultado = remote.execute(buscaPaginas);
                            if (resultado.hasErrors()) {
                                out.print("<script>alert('Houve problemas durante a primeira busca de paginas')</script>");
                            }
                            List<GrNode> parte1 = resultado.resultOf(pagina);
                            for (GrNode paginaEncontrada:parte1) {
                                paginasEncontradas.add(paginaEncontrada);
                            }    
                            buscaPaginas = new JcQuery();
                            buscaPaginas.setClauses(new IClause[] {
                                MATCH.node(pagina).label("Pagina").relation().out().type("PossuiPalavraChave").node(palavraChave).label("PalavraChave").property("nome").value(termoBusca),
                                RETURN.value(pagina)
                            });
                            resultado = remote.execute(buscaPaginas);
                            if (resultado.hasErrors()) {
                                out.print("<script>alert('Houve problemas durante a segunda busca de paginas')</script>");
                            }
                            List<GrNode> parte2 = resultado.resultOf(pagina);
                            for (GrNode paginaEncontrada:parte2) {
                                if (!paginasEncontradas.contains(paginaEncontrada))
                                    paginasEncontradas.add(paginaEncontrada);
                            }                            
                        %>
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

                                    <%  if (usuariosEncontrados.size() == 0) {
                                        %><h3><%out.print("Nao foram encontrados usuarios com o nome pesquisado.");%></h3><%
                                        } 
                                        else {
                                            for (GrNode usuarioEncontrado: usuariosEncontrados) {
                                                String nome = usuarioEncontrado.getProperty("nome").getValue().toString();
                                                String sobrenome = usuarioEncontrado.getProperty("sobrenome").getValue().toString();
                                                String usernameEncontrado = usuarioEncontrado.getProperty("username").getValue().toString();
                                                %><a href='pagina_usuario.jsp?msg=<%=usernameEncontrado%>'><%=(nome +" " +sobrenome)%></a><%
                                            }    
                                        }
                                    
                                        if (paginasEncontradas.size() == 0) {
                                            %><h3><%out.print("Nao foram encontradas paginas com o nome pesquisado (ou palavra-chave pesquisada)");%></h3><%
                                        }
                                        else {
                                            for (GrNode paginaEncontrada : paginasEncontradas) {
                                                String nomePagina = paginaEncontrada.getProperty("nome").getValue().toString();
                                                %><a href='pagina_generica.jsp?msg=<%=nomePagina%>'><%=nomePagina%></a><%
                                            }    
                                        }    
                                        
                                    %>

                                    

                                    <hr>

                                </div>         

                                </div>
                                
                                
                            </div>

                           <!-- Exibicao da busca - Fim -->

                    </body>
            </html>