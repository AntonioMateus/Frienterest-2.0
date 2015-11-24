<%-- 
    Document   : busca_pessoas
    Created on : 30/09/2015, 23:35:03
    Author     : andrew
--%>

<%@page import="utils.ControleLogin"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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

                                    <%
                                        List pessoasEncontradas = new ArrayList();

                                        pessoasEncontradas = (ArrayList) request.getAttribute("pessoasEncontradas");

                                        if (pessoasEncontradas != null && pessoasEncontradas.size() > 0) {

                                            for (int i = 0; i < pessoasEncontradas.size(); i++) {

                                                List pessoas = (List) pessoasEncontradas.get(i);

                                    %>

                                    <div class="row ">

                                        <div class="large-2 columns">

                                            <a href="#"> <span> </span><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Gnome-stock_person.svg/2000px-Gnome-stock_person.svg.png" alt="book cover" class=" thumbnail"></a>

                                        </div>

                                        <div class="large-10 columns">

                                            <div class="row">

                                                <div class=" large-9 columns">

                                                    <h5><%= pessoas.get(2)%></h5>

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

                                                                    <li><strong>Nome: </strong> <%= pessoas.get(0)%> </li>

                                                                    <li><strong>Sobrenome:</strong> <%= pessoas.get(1)%> </li>

                                                                    <li><strong>Interesses em comum: </strong> Nenhum </li>

                                                                    <li><strong>Amizades em comum:</strong> Nenhuma </li>

                                                                </ul>

                                                            </li>


                                                        </ul>

                                                    </div>

                                                </div>

                                            </div>

                                        </div>

                                        <hr>

                                    </div>         

                                </div>
                                <%                    }

                                } else {

                                %>

                                <h4 align="center">
                                    Nenhum resultado encontrado.
                                </h4>

                                <%}%>
                                <!--
                                            <a href="#" class="button right"> show more results &raquo;</a>
                                -->
                            </div>

                        </div>
                        <!-- Exibicao da busca - Fim -->

                    </body>
            </html>
