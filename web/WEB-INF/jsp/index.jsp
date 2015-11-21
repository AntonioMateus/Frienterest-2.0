<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Frienterest - A sua rede social de interesses</title>
        <link href="css/foundation.css" rel="stylesheet" type="text/css"/>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css" rel="stylesheet">

        <style type="text/css">
            h1, h3 {
                color:#FFFFFF;
                text-align: center;
            }           
            
            #intro {
                background-color:#2980b9;
                height: 120px; 
                line-height: 100px;
            }
            #erro1, #erro2 {
                color: red;
                text-align: center;
            }


            .auth-plain {

                padding-right: 0px;

                padding-left: 0px;

                padding-top: 0px;

            }



            .left-solid {

                margin-top: 0px;

                margin-bottom: 0px;

            }



            .signup-panel {

                border-radius: 5px;

                padding: 15px;

                margin-top: 30px;

                margin-bottom: 30px;

                background: #fff;

            }



            .signup-panel a{

                color: #fff;

            }



            .signup-panel i {

                font-size: 30px;

                line-height: 50px;

                color: #999;

            }

            .signup-panel form input, .signup-panel form span {

                height: 50px;

            }

            .signup-panel .welcome {

                font-size: 26px;

                text-align: center;

                margin-left: 0;

            }

            .signup-panel p {

                font-size: 13px;

                font-weight: 200;

                text-align: center;

            }

            .signup-panel .button {

                margin-left: 35%;

            }



            .newusers {

                background: #fff;

            }
            
            .imgClass {
                background-image: url(http://i.imgur.com/sFE359B.jpg?1);
                background-position: 0px 0px; 
                background-repeat: no-repeat;
                width: 106px;
                height: 95px;
                border: 0px;
                cursor: pointer;
                outline: 0;                
            }

        </style> 
        <link rel="shortcut icon" href="frienterest.ico">
    </head>
    <body>
        <% if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("true")) {
        out.print ("<script>alert('Senha incorreta ! Por favor, tente novamente !')</script>"); }
        else if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("false")) {
        out.print ("<script>alert('Usuário não cadastrado ! Inscreva-se agora mesmo !')</script>"); }%>        
        <div id="intro" class="row full-width">

            <div class="small-6 medium-1 large-2 columns auth-plain">

                <img id="logo" src="logo_frienterest.png" width="100" heigth="100" alt=""/>

            </div>


            <div class="small-30 medium-8 large-10 columns auth-plain">

                <h1>Bem-vindo(a) ao Frienterest</h1>
                <h3>A rede social que conecta pessoas interessantes.</h3>
            </div>

        </div> 
        <br>
        <br>
        <div class="row">

            <div class="large-6 columns auth-plain">

                <div class="signup-panel left-solid">

                    <p class="welcome">Usuário Registrado</p>

                    <form id="formulario" action="ControleLogin" method="post" name="form1">

                        <div class="row collapse">

                            <div class="small-2  columns">

                                <span class="prefix"><i class="fi-torso-female"></i></span>

                            </div>

                            <div class="small-10  columns">

                                <input type="text" name="email" size="40" placeholder="Email">

                            </div>

                        </div>

                        <div class="row collapse">

                            <div class="small-2 columns ">

                                <span class="prefix"><i class="fi-lock"></i></span>

                            </div>

                            <div class="small-10 columns ">
                                <input type="password" name="senha" size="40" maxlength="15" placeholder="Senha">
                            </div>                               
                        </div>
                        <input type="submit" value="Entrar" class="button">                        
                    </form>


                </div>

            </div>


            <div class="large-6 columns auth-plain">

                <div class="signup-panel newusers">

                    <p class="welcome"> Novo usuário?</p>

                    <p>Crie uma conta já e conheça diversas pessoas com base em seus interesses! É fácil e rápido!</p><br>


                    <a href="criacao_conta.jsp" class="button" >Cadastro</a></br>

                </div>

            </div>

        </div> 

        <!-- Footer -->

    <footer class="footer">

        <div class="row full-width">

            <div class="small-12 medium-3 large-4 columns">
                <i class="fi-laptop"></i>        
                <!-- <form action="InicializacaoPalavrasChave" method="post">
                    <!-- <i class="fi-laptop"></i> 
                    <input type="submit" value="" class="imgClass">
                </form> -->

                <p>Inicialmente, a rede social Frienterest está disponível apenas para web. Trata-se de uma rede que usa uma nova tecnologia para armazenar dados de pessoas, bem como relacionamentos entre elas! Ficou curioso(a)? Inscreva-se hoje mesmo! </p>

            </div>

            <div class="small-12 medium-3 large-4 columns">
                <i class="fi-torso-business"></i>
                <!--<form action="InicializacaoUsuarios" method="post">
                    <!-- <i class="fi-torso-business"></i> 
                    <input type="submit" value="" class="imgClass">
                </form> -->

                <p>Os desenvolvedores desse projeto são Antonio Carlos Mateus da Silva e André Thomaz Gandolpho de Mello, ambos estudantes de Sistemas de Informação da EACH-USP.</p>

            </div>

            
            <div class="small-12 medium-3 large-4 columns">

                <h4>Outras redes</h4>

                    <ul class="footer-links">

                        <li><a href="https://github.com/AntonioMateus/Frienterest">GitHub do projeto</a></li>

                        <li><a href="https://www.facebook.com/atgmello">Facebook (André Mello)</a></li>

                        <li><a href="https://www.facebook.com/antonio.mateus.37">Facebook (Antonio Mateus)</a></li>

                        <ul>

                            </div>

                            </div>

                            </footer>

                                <script src="js/vendor/jquery.js"></script>
                                <script src="js/foundation.min.js"></script>
                                <script>
                                $(document).foundation();
                                </script>
                           

    </body>
</html>
