<%-- 
    Document   : pagina_generica
    Created on : 30/10/2015, 22:14:12
    Author     : Antonio Mateus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%  String[] nomeDescricao = request.getParameter("msg").split("_");
            String nomePagina = nomeDescricao[0];
            String descricao = nomeDescricao[1]; %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%out.print("Frienterest - "+nomePagina);%></title>
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

                        <h1><a href="pagina_inicial.jsp?msg=_">Frienterest &nbsp;</a></h1>

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
                <li><a href="criacao_pagina.jsp">Criar página</a></li>                
                
                <!-- <li class="has-dropdown">

                    <a href="#">Opções</a>

                    <ul class="dropdown">

                        <li><a href="pagina_inicial.jsp">Home</a></li>

                        <li><a href="redirect.jsp">Sair</a></li>                       

                    </ul>

                </li> -->
                
                <li><a href="redirect.jsp">Sair</a></li>

            </ul>


            <!-- Left Nav Section -->

            <ul class="left">


            </ul>

        </section>

    </nav>

    <!-- Busca - Fim -->
        <h1> <% out.println(nomePagina); %> </h1>
        <h3> <% out.println("Descrição: " +descricao);%> </h3>
        <br>
    </body>
</html>