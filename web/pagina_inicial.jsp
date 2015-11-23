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

                        <h1><a href="pagina_inicial.jsp">Frienterest &nbsp;</a></h1>

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
                </ul>
            </form>
            <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->

            <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>



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
        <!--        <div id="alchemy" class="alchemy" align="center">
                    <script type="text/javascript" src="js/vendor/vendor.js"></script>
                    <script type="text/javascript" src="js/alchemy.min.js"></script>
                    
                    <script type="text/javascript">
                    var some_data = 
                        {
                          "nodes": [
                            {
                              id: 1,
                              name: "name"
                            },
                            {
                              id: 2,
                              name: "name"
                            },
                            {
                              id: 3,
                              name: "name"
                            }
                          ],
                          "edges": [
                            {
                              source: 1,
                              target: 2
                            },
                            {
                              source: 1,
                              target: 3,
                            }
                          ]
                        };
        
                        var some_data2 = 
                                {
                                    "nodes":
                                    [
                                        {name:"Peter",label:"Person",id:1},
                                        {name:"Michael",label:"Person",id:2}, 
                                        {name:"Neo4j",label:"Database",id:3}
                                    ], 
                                    "edges":
                                            [
                                        {source:1, target:2, type:"KNOWS", since:2010},
                                        {source:1, target:3, type:"FOUNDED"}, 
                                        {source:2, target:3, type:"WORKS_ON"}
                                    ]
                                }
          
                        alchemy.begin({"dataSource": some_data2, "nodeCaption": name, "nodeMouseOver": name})                
                            
        
                    </script>-->


        <!--<img src="http://dev.assets.neo4j.com.s3.amazonaws.com/wp-content/uploads/2012/09/Screen-Shot-2012-09-13-at-12.57.35-PM.png"/>-->
        <!--</div> -->


        <!--d3.js - STATUS: FUNCIONANDO-->
        <!--        <div align="center" id="graph">
                    <script type="text/javascript" src="js/d3.js" charset="utf-8"></script>
                    <script type="text/javascript">
        
                        var request = $.ajax({
                            type: "POST",
                            url: "http://localhost:7474/db/data/cypher",
                            accepts: {json: "application/json"},
                            dataType: "json",
                            contentType: "application/json",
                            data: JSON.stringify({"query": "MATCH n RETURN n LIMIT 1", "params": {}})
                        });
        
                        var width = 800, height = 800;
        
                        // force layout setup
        
                        var force = d3.layout.force()
        
                                .charge(-200).linkDistance(30).size([width, height]);
        
        
        
                        // setup svg div
        
                        var svg = d3.select("#graph").append("svg")
        
                                .attr("width", 800).attr("height", 800)
        
                                .attr("pointer-events", "all");
        
                        // load graph (nodes,links) json from /graph endpoint
        
                        d3.json("miserables.json", function (error, graph) {
        
                            if (error) {
                                window.alert("Erro");
                                return;
                            }
        
        
        
                            force.nodes(graph.nodes).links(graph.links).start();
        
        
        
                            // render relationships as lines
        
                            var link = svg.selectAll(".link")
        
                                    .data(graph.links).enter()
        
                                    .append("line").attr("class", "link");
        
        
        
                            // render nodes as circles, css-class from label
        
                            var node = svg.selectAll(".node")
        
                                    .data(graph.nodes).enter()
        
                                    .append("circle")
        
                                    .attr("class", function (d) {
                                        return "node " + d.label
                                    })
        
                                    .attr("r", 10)
        
                                    .call(force.drag);
        
        
        
                            // html title attribute for title node-attribute
        
                            node.append("title")
        
                                    .text(function (d) {
                                        return d.title;
                                    })
        
        
        
                            // force feed algo ticks for coordinate computation
        
                            force.on("tick", function () {
        
                                link.attr("x1", function (d) {
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
        
        
        
                                node.attr("cx", function (d) {
                                    return d.x;
                                })
        
                                        .attr("cy", function (d) {
                                            return d.y;
                                        });
        
                            });
        
                        });
        
                        var res =
                                {"results": [
                                        {
                                            "columns": ["path"],
                                            "data": [{
                                                    "graph": {
                                                        "nodes": [
                                                            {"id": "1", "labels": ["Person"], "properties": {"name": "Peter"}},
                                                            {"id": "2", "labels": ["Person"], "properties": {"name": "Michael"}}
        
                                                        ],
                                                        "relationships": [
                                                            {"id": "0", "type": "KNOWS", "startNode": "1", "endNode": "2", "properties": {}}
        
                                                        ]
        
                                                    } // , {"graph": ...}, ...
        
                                                }]}
        
                                    ], "errors": []
        
                                }
        
                        function idIndex(a, id) {
        
                            for (var i = 0; i < a.length; i++) {
        
                                if (a[i].id == id)
                                    return i;
                            }
        
                            return null;
        
                        }
        
                        var nodes = [], links = [];
        
                        res.results[0].data.forEach(function (row) {
        
                            row.graph.nodes.forEach(function (n) {
        
                                if (idIndex(nodes, n.id) == null)
                                    nodes.push({id: n.id, label: n.labels[0], title: n.properties.name});
        
                            });
        
                            links = links.concat(row.graph.relationships.map(function (r) {
        
                                return {start: idIndex(nodes, r.startNode), end: idIndex(nodes, r.endNode), type: r.type};
        
                            }));
        
                        });
        
                        var some_data2 =
                                {
                                    "nodes":
                                            [
                                                {name: "Peter", label: "Person", id: 1},
                                                {name: "Michael", label: "Person", id: 2},
                                                {name: "Neo4j", label: "Database", id: 3}
                                            ],
                                    "edges":
                                            [
                                                {source: 1, target: 2, type: "KNOWS", since: 2010},
                                                {source: 1, target: 3, type: "FOUNDED"},
                                                {source: 2, target: 3, type: "WORKS_ON"}
                                            ]
                                }
        
                    </script>
                </div>-->

        <script>
            var buscaUsuario = <%ControleLogin.getUsernameLogado();%>;


            // The query
            var query = {"statements": [{"statement": "MATCH p=(n)-->(m)<--(k),(n)--(k) RETURN p Limit 100",
                        "resultDataContents": ["graph", "row"]}]};

//the helper function provided by neo4j documents
            function idIndex(a, id) {
                for (var i = 0; i < a.length; i++) {
                    if (a[i].id == id)
                        return i;
                }
                return null;
            }
// jQuery ajax call
            var request = $.ajax({
                type: "POST",
                url: "http://localhost:7474/db/data/transaction/commit",
                accepts: {json: "application/json"},
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify(query),
                //now pass a callback to success to do something with the data
                success: function (data) {
                    // parsing the output of neo4j rest api
                    data.results[0].data.forEach(function (row) {
                        row.graph.nodes.forEach(function (n) {
                            if (idIndex(nodes, n.id) == null) {
                                nodes.push({id: n.id, label: n.labels[0], title: n.properties.name});
                            }
                        });
                        links = links.concat(row.graph.relationships.map(function (r) {
                            // the neo4j documents has an error : replace start with source and end with target
                            return {source: idIndex(nodes, r.startNode), target: idIndex(nodes, r.endNode), type: r.type};
                        }));
                    });
                    window.graph = {nodes: nodes, links: links};
                    log.console(graph);
                    // Now do something awesome with the graph!

                }

            });
        </script>
        
        <script>
            data = {
                nodes: [
                    {size: 10},
                    {size: 5},
                    {size: 2},
                    {size: 3},
                    {size: 30},
                    {size: 40}
                ],
                links: [
                    {source: 0, target: 1},
                    {source: 0, target: 2},
                    {source: 1, target: 0},
                    {source: 3, target: 0},
                    {source: 4, target: 1}
                ]
            }

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
            }

            function node_radius(d) {
                return Math.pow(40.0 * d.size, 1 / 3);
            }

            var width = 1000;
            var height = 500;

            var nodes = data.nodes
            var links = data.links

            var force = d3.layout.force()
                    .nodes(nodes)
                    .links(links)
                    .charge(-3000)
                    .friction(0.6)
                    .gravity(0.6)
                    .size([width, height])
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

            svg
                    .append("marker")
                    .attr("id", "arrowhead")
                    .attr("refX", 6 + 7) // Controls the shift of the arrow head along the path
                    .attr("refY", 2)
                    .attr("markerWidth", 6)
                    .attr("markerHeight", 4)
                    .attr("orient", "auto")
                    .append("path")
                    .attr("d", "M 0,0 V 4 L6,2 Z");

            link
                    .attr("marker-end", "url()");

            force
                    .on("tick", tick);

        </script>
        <!--    <div id="graph3">
                <script src="//d3js.org/d3.v3.min.js"></script>
                <script>
        
                    var width = 960,
                            height = 500;
        
                    var color = d3.scale.category20();
        
                    var force = d3.layout.force()
                            .charge(-120)
                            .linkDistance(30)
                            .size([width, height]);
        
                    var svg = d3.select("graph3").append("svg")
                            .attr("width", width)
                            .attr("height", height);
        
                    d3.json("miserables.json", function (error, graph) {
                        if (error)
                            throw error;
        
                        force
                                .nodes(graph.nodes)
                                .links(graph.links)
                                .start();
        
                        var link = svg.selectAll(".link")
                                .data(graph.links)
                                .enter().append("line")
                                .attr("class", "link")
                                .style("stroke-width", function (d) {
                                    return Math.sqrt(d.value);
                                });
        
                        var node = svg.selectAll(".node")
                                .data(graph.nodes)
                                .enter().append("circle")
                                .attr("class", "node")
                                .attr("r", 5)
                                .style("fill", function (d) {
                                    return color(d.group);
                                })
                                .call(force.drag);
        
                        node.append("title")
                                .text(function (d) {
                                    return d.name;
                                });
        
                        force.on("tick", function () {
                            link.attr("x1", function (d) {
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
        
                            node.attr("cx", function (d) {
                                return d.x;
                            })
                                    .attr("cy", function (d) {
                                        return d.y;
                                    });
                        });
                    });
                    var some_data2 =
                            {
                                "nodes":
                                        [
                                            {name: "Peter", label: "Person", id: 1},
                                            {name: "Michael", label: "Person", id: 2},
                                            {name: "Neo4j", label: "Database", id: 3}
                                        ],
                                "edges":
                                        [
                                            {source: 1, target: 2, type: "KNOWS", since: 2010},
                                            {source: 1, target: 3, type: "FOUNDED"},
                                            {source: 2, target: 3, type: "WORKS_ON"}
                                        ]
                            }
                </script>
            </div>-->

    </body>
</html>
