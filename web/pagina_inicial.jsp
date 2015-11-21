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

            .node {
                stroke: #fff;
                stroke-width: 1.5px;
            }

            .link {
                stroke: #999;
                stroke-opacity: .6;
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
    <% String SERVER_ROOT_URI = "http://localhost:7474/";
        String usernameDB = "neo4j";
        String passwdDB = "dba";
        Properties props = new Properties();
        props.setProperty(DBProperties.SERVER_ROOT_URI, SERVER_ROOT_URI);
        IDBAccess remote = DBAccessFactory.createDBAccess(DBType.REMOTE, props, usernameDB, passwdDB);
        JcNode usuario = new JcNode("Usuario");
        JcQuery query = new JcQuery();
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
        if (genero.equals("null")) 
            artigo = "o";
        else if (genero.equals("masculino"))
            artigo = "o";
        else 
            artigo = "a";
        String mensagem = "Seja bem vind" +artigo +" " +nome;
//String[] nomeSexo = request.getParameter("msg").toString().split("_"); ARRUMAR ISSO!
//        String nome = ControleLogin.getEmailLogado();
//        String artigo;
//        if (nome==null) {
//            nome = CadastroUsuario.getNomeUsuario();
//        }
//        String sexo = CadastroUsuario.getSexoUsuario();
//        if (sexo==null) {
//            sexo = "masculino";
//        }
//         
//        if (sexo.equals("null")) 
//            artigo = "o";
//        else if (sexo.equals("masculino")) 
//            artigo = "o";
//        else 
//            artigo = "a";
//        String mensagem = "Seja bem vind" +artigo +" " +nome; %>
    <h1> <% out.println(mensagem); %> </h1>
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

    <div align="center" id="graph">
        <script type="text/javascript" src="js/d3.js" charset="utf-8"></script>
        <script type="text/javascript">
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

        </script>
    </div>

    <div id="graph3">
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
    </div>

</body>
</html>
