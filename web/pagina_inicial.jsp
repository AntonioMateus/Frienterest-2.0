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
<%@page import="utils.ControleLogin"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Frienterest</title>

        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" href="css/alchemy-white.css">

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

            .top-bar-section{
                background: #2980b9
            }

            .node circle {
                stroke: white;
                stroke-width: 1.5px;
                opacity: 1.0;
            }

            line {
                stroke: black;
                stroke-width: 1.5px;
                stroke-opacity: 1.0;
            }

        </style>
        <link rel="shortcut icon" href="frienterest.ico">

        <script src="js/jquery-2.1.4.min.js"></script>
        <script src="http://d3js.org/d3.v3.js"></script>

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
        <% String SERVER_ROOT_URI = "http://localhost:7474/";
            String usernameDB = "neo4j";
            String passwdDB = "dba";
            Properties props = new Properties();
            props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);
            IDBAccess remote = DBAccessFactory.createDBAccess(DBType.REMOTE, props, usernameDB, passwdDB);
            JcNode usuario = new JcNode("Usuario");
            JcQuery query = new JcQuery();
            String mensagem;
            try {
                String nomeUsuario = request.getParameter("msg").toString();
                query.setClauses(new IClause[]{
                    MATCH.node(usuario).label("Usuario").property("username").value(nomeUsuario),
                    RETURN.value(usuario)
                });
                JcQueryResult resultado = remote.execute(query);
                if (resultado.hasErrors()) { %>
        <h1><%out.println("Deu ruim");%></h1>
        <% }

                List<GrNode> usuarios = resultado.resultOf(usuario);
                String nome = (String) usuarios.get(0).getProperty("nome").getValue();
                String genero = (String) usuarios.get(0).getProperty("genero").getValue();
                String artigo;
                if (genero.equals("null")) {
                    artigo = "o";
                } else if (genero.equals("masculino")) {
                    artigo = "o";
                } else {
                    artigo = "a";
                }
                mensagem = "Seja bem vind" + artigo + " " + nome;
            } catch (NullPointerException e) {
                mensagem = "Seja bem vindo";
            } %>
        <h1> <% out.println(mensagem);%> </h1>
        <br>
        <!--<img src="http://dev.assets.neo4j.com.s3.amazonaws.com/wp-content/uploads/2012/09/Screen-Shot-2012-09-13-at-12.57.35-PM.png"/>-->
        <!--</div> -->

        <script>
            <%String usuarioLogado = ControleLogin.getUsernameLogado();%>
            var usuarioLogado = "<%=usuarioLogado%>";
            console.log(usuarioLogado);

            // The query
            var query = {"statements": [{"statement": "MATCH (n)-[r]-() WHERE n.username ='" + usuarioLogado + "' RETURN n, r" /*"MATCH p=(n)-->(m)<--(k),(n)--(k) RETURN p Limit 100"*/,
                        "resultDataContents": ["graph", "row"]}]};

//the helper function provided by neo4j documents
            function idIndex(a, id) {
                for (var i = 0; i < a.length; i++) {
                    if (a[i].id === id)
                        return i;
                }
                return null;
            }
// jQuery ajax call
            var token = "neo4j:dba";
            var hash = btoa(token);
            var authHeader = 'Basic ' + hash;
            var request = $.ajax({
                type: "POST",
                url: "http://localhost:7474/db/data/transaction/commit",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', authHeader);
                },
                accepts: {json: "application/json"},
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(query),
                //now pass a callback to success to do something with the data
                success: function (data) {
                    var nodes = [], links = [];

                    data.results[0].data.forEach(function (row) {

                        row.graph.nodes.forEach(function (n) {

                            if (idIndex(nodes, n.id) == null)
                                nodes.push({id: n.id, label: n.labels[0], username: n.properties.username});

                        });

                        links = links.concat(row.graph.relationships.map(function (r) {

                            return {source: idIndex(nodes, r.startNode), target: idIndex(nodes, r.endNode), type: r.type};

                        }));

                    });

                    viz = {nodes: nodes, links: links};
                    //console.log(JSON.stringify(viz));
                    // Now do something awesome with the graph!

                    var mouseOverFunction = function (d) {
                        var circle = d3.select(this);

                        node
                                .transition(500)
                                .style("opacity", function (o) {
                                    return isConnected(o, d) ? 1.0 : 0.2;
                                })
                                .style("fill", function (o) {
                                    if (isConnectedAsTarget(o, d) && isConnectedAsSource(o, d)) {
                                        fillcolor = 'green';
                                    } else if (isConnectedAsSource(o, d)) {
                                        fillcolor = 'red';
                                    } else if (isConnectedAsTarget(o, d)) {
                                        fillcolor = 'blue';
                                    } else if (isEqual(o, d)) {
                                        fillcolor = "hotpink";
                                    } else {
                                        fillcolor = '#000';
                                    }
                                    return fillcolor;
                                });

                        link
                                .transition(500)
                                .style("stroke-opacity", function (o) {
                                    return o.source === d || o.target === d ? 1 : 0.2;
                                })
                                .transition(500)
                                .attr("marker-end", function (o) {
                                    return o.source === d || o.target === d ? "url(#arrowhead)" : "url()";
                                });

                        circle
                                .transition(500)
                                .attr("r", function () {
                                    return 1.4 * node_radius(d)
                                });
                    }

                    var mouseOutFunction = function () {
                        var circle = d3.select(this);

                        node
                                .transition(500);

                        link
                                .transition(500);

                        circle
                                .transition(500)
                                .attr("r", node_radius);
                    }

                    function isConnected(a, b) {
                        return isConnectedAsTarget(a, b) || isConnectedAsSource(a, b) || a.index == b.index;
                    }

                    function isConnectedAsSource(a, b) {
                        return linkedByIndex[a.index + "," + b.index];
                    }

                    function isConnectedAsTarget(a, b) {
                        return linkedByIndex[b.index + "," + a.index];
                    }

                    function isEqual(a, b) {
                        return a.index == b.index;
                    }

                    function tick() {
                        link
                                .attr("x1", function (d) {
                                    return d.source.x;
                                })
                                .attr("y1", function (d) {
                                    return d.source.y;
                                })
                                .attr("x2", function (d) {
                                    return d.target.x;
                                })
                                .attr("y2", function (d) {
                                    return d.target.y;
                                });

                        node
                                .attr("transform", function (d) {
                                    return "translate(" + d.x + "," + d.y + ")";
                                });

                        text.attr("transform", function (d) {
                            return "translate(" + d.x + "," + d.y + ")";
                        });
                    }

                    function node_radius(d) {
                        return Math.pow(40.0 * 130/*d.size*/, 1 / 3);
                    }

                    var width = 1000;
                    var height = 500;

                    var nodes = viz.nodes;
                    var links = viz.links;
                    console.log(JSON.stringify(viz, null, 2));

                    var force = d3.layout.force()
                            .nodes(nodes)
                            .links(links)
                            .charge(-3000)
                            .friction(0.6)
                            .gravity(0.6)
                            .size([width, height])
                            .linkDistance(120)
                            .start();

                    var linkedByIndex = {};
                    links.forEach(function (d) {
                        linkedByIndex[d.source.index + "," + d.target.index] = true;
                    });

                    var svg = d3.select("body").append("svg")
                            .attr("width", width)
                            .attr("height", height);

                    var link = svg.selectAll("line")
                            .data(links)
                            .enter().append("line")

                    var node = svg.selectAll(".node")
                            .data(nodes)
                            .enter().append("g")
                            .attr("class", "node")
                            .call(force.drag);

                    node
                            .append("circle")
                            .attr("r", node_radius)
                            .on("mouseover", mouseOverFunction)
                            .on("mouseout", mouseOutFunction);
                    var text = svg.append("svg:g").selectAll("g")
                            .data(force.nodes())
                            .enter().append("svg:g");


                    text.append("svg:text")
                            .attr('y', '0.7em')
                            .attr('class', 'name')
                            .text(function (d) {
                                return d.username;
                            });

                    svg
                            .append("marker")
                            .attr("id", "arrowhead")
                            .attr("refX", 12 + 14) // Controls the shift of the arrow head along the path
                            .attr("refY", 2)
                            .attr("markerWidth", 24)
                            .attr("markerHeight", 16)
                            .attr("orient", "auto")
                            .append("path")
                            .attr("d", "M 0,0 V 4 L6,2 Z");

                    link
                            .attr("marker-end", "url()");

                    force
                            .on("tick", tick);

                },
                error: function (xhr, err, msg) {
                    console.log(xhr);
                    console.log(err);
                    console.log(msg);
                }

            });
//            console.log(graph.links[0].toString());
        </script>
    </body>
</html>
