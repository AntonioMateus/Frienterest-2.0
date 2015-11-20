<%-- 
    Document   : criacao_pagina
    Created on : 30/10/2015, 16:40:06
    Author     : Antonio Mateus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Criação de páginas - Frienterest</title>
        <link href="css/foundation.css" rel="stylesheet" type="text/css"/>
        <style type="text/css">
            .signup-panel {

                border-radius: 5px;

                border: 1px solid #ccc;

                padding: 15px;

                margin-top: 30px;

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

                margin-left: 25%;

            }

            .signup-panel .button {

                margin-left: 35%;

            }
            
            #erro {
                color: red; 
                text-align: center;
            }
            
            #descricao {
                resize: none;
            }

        </style>
        <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script> 
        <script src="//cdn.jsdelivr.net/webshim/1.14.5/polyfiller.js"></script>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css" rel="stylesheet">
        <link rel="shortcut icon" href="frienterest.ico">
    </head>
    <body>
        <div class="row">

            <div class="large-6 columns">

                <div class="signup-panel">

                    <p class="welcome">Crie uma página para divulgar seu trabalho, homenagear um artista ou compartilhar seus interesses com a rede!</p>
                    
                    <form action="CadastroPagina" method="post" name="form2">

                        <div class="row collapse">

                            <div class="small-2  columns"><span class="prefix"></span></div>

                            <div class="small-10  columns">

                                <input type="text" placeholder="nome da página" name="nome">

                            </div>

                        </div>
                        <div class="row collapse">

                            <textarea name="sobre" rows="3" cols="12" placeholder="Escreva um pouco sobre a sua página ou comunidade..." id="descricao"></textarea>

                        </div>
                        <p style="text-align:left;font-size:20px;margin-left: 0;"><b>Escolha as palavras-chave que definirão a sua página: </b></p>
                        
                        <div class="row collapse">
                        <!-- Palavras-chave -->
                            <div class="small-6 columns">
                                <input type="radio" name="esportes" value="1">Esportes <br>
                                <input type="radio" name="politica" value="1">Política <br>
                                <input type="radio" name="educacao" value="1">Educação <br>
                                <input type="radio" name="meio_ambiente" value="1">Meio ambiente <br>
                                <input type="radio" name="informatica" value="1">Informática <br>
                                <input type="radio" name="cinema" value="1">Cinema <br>
                                <input type="radio" name="teatro" value="1">Teatro <br>
                                <input type="radio" name="psicologia" value="1">Psicologia <br>
                                <input type="radio" name="curiosidades" value="1">Curiosidades <br>
                                <input type="radio" name="humor" value="1">Humor
                            </div>
                            <div class="small-6 columns">
                                <input type="radio" name="saude" value="1">Saúde <br>
                                <input type="radio" name="economia" value="1">Economia <br>
                                <input type="radio" name="noticias" value="1">Notícias <br>
                                <input type="radio" name="marketing" value="1">Marketing <br>
                                <input type="radio" name="musica" value="1">Música <br>
                                <input type="radio" name="games" value="1">Games <br>
                                <input type="radio" name="viagem" value="1">Viagem <br>
                                <input type="radio" name="literatura" value="1">Literatura <br>
                                <input type="radio" name="animais" value="1">Animais <br>
                                <input type="radio" name="series_televisao" value="1">Séries e televisão
                            </div>
                        <!-- -------------- -->
                        </div>
                        <br>
                        <input type="submit" value="Criar página" class="button">

                    </form>

                </div>

            </div>

        </div>

    </body>
</html>