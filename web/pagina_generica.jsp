<%-- 
    Document   : pagina_generica
    Created on : 30/10/2015, 22:14:12
    Author     : Antonio Mateus
--%>

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
        <%  String nomePagina = request.getParameter("msg");
            String descricao = null;
            String SERVER_ROOT_URI = "http://localhost:7474/";
            String usernameDB = "neo4j";
            String passwdDB = "dba";
            Properties props = new Properties();
            props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);
            IDBAccess remote = DBAccessFactory.createDBAccess(DBType.REMOTE, props, usernameDB, passwdDB);
            JcNode pagina = new JcNode("Pagina");
            JcQuery query = new JcQuery();
            query.setClauses(new IClause[]{
                MATCH.node(pagina).label("Pagina").property("nome").value(nomePagina),
                RETURN.value(pagina)
            });
            JcQueryResult resultado = remote.execute(query);
            if (resultado.hasErrors()) {
        %><h1><%out.println("Deu ruim");%></h1><%
                    }
                    List<GrNode> paginas = resultado.resultOf(pagina);
                    descricao = paginas.get(0).getProperty("descricao").getValue().toString();
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><%out.print("Frienterest - " + nomePagina);%></title>
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

        .imgClass {
            background-image: url(http://i.imgur.com/MXofX9A.png?1);
            background-position: 0px 0px; 
            background-repeat: no-repeat;
            width: 136px;
            height: 124px;
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

    <!-- Busca - Fim -->

    <div class="row">
        <div class="large-9 columns auth-plain">
            <h1> <% out.println(nomePagina); %> </h1>
            <h3> <% out.println("Descrição: " + descricao);%> </h3>
            <br>
        </div>
        <div class="large-3 columns auth-plain">
            <form action="DemonstrarInteresse" method="post">
                <input name="nomePagina" value="<%=nomePagina%>" hidden="true" readonly="true">
                <input type="submit" value=""  class="imgClass">

                <p style="text-align: left"> Demonstrar interesse </p>
            </form>
        </div>
    </div>
</body>
</html>