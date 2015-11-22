<%-- 
    Document   : verificacao_email
    Created on : 24/10/2015, 19:26:25
    Author     : Antonio Mateus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verificação de email - Frienterest</title>
        <link href="css/foundation.css" rel="stylesheet" type="text/css"/>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css" rel="stylesheet">
        <style type="text/css">
            #titulo {
                color:#000000;
                text-align: left;
            }
            
            h1, h3 {
                color:#FFFFFF;
                text-align: center;
            }           
            
            #intro {
                background-color:#2980b9;
                height: 120px; 
                line-height: 100px;
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


        </style> 
        <link rel="shortcut icon" href="frienterest.ico">
    </head>
    <body>
        <% if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("falha")) {
        out.print ("<script>alert('O codigo enviado por nos eh diferente do digitado ! Por favor, tente novamente !')</script>"); }%>
        <div id="intro" class="row full-width">

            <div class="small-6 medium-1 large-2 columns auth-plain">

                <img id="logo" src="logo_frienterest.png" width="100" heigth="100" alt=""/>

            </div>


            <div class="small-30 medium-8 large-10 columns auth-plain">

                <h1>Frienterest</h1>
                <h3>A rede social que conecta pessoas interessantes.</h3>
            </div>

        </div>
        
        <div>
            <h3 id="titulo">Verificação de email</h3>
            <p>No espaço a seguir, digite o código que foi enviado para o email cadastrado.</p>
            <p><b>Observação: </b>Se o email que enviamos não estiver em sua caixa de entrada, verifique, por favor, sua caixa de spam.</p>
            <form method="post" action="VerificacaoEmail" >
                <div class="row collapse">
                    <div class="small-3 columns">
                        <input type="password" placeholder="digite o código de verificação" name="codigo">
                    </div>
                </div>                
                <input type="submit" value="Enviar código" class="button">                   
            </form>
        </div>        
    </body>
</html>
