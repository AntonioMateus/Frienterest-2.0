<%-- 
    Document   : criacao_conta
    Created on : 27/09/2015, 11:17:39
    Author     : Antonio Mateus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro - Frienterest</title>
        <link href="css/foundation.css" rel="stylesheet" type="text/css"/>
        <script language="JavaScript" type="text/javascript">
            function mascaraData (campoData, e) {
                if (document.all) 
                    var tecla = event.keyCode;
                else
                    var tecla = e.which;
                
                if (tecla >= 47 && tecla < 58) {
                    var data = campoData.value;
                }
                if (data.length === 2 || data.length === 5) {
                    data += '/';
                    campoData.value = data;
                }
                else if (tecla === 8 || tecla === 0) {
                    return true;
                }
                else {
                    return false;
                }
            }
        </script>
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
        <script>
            webshims.setOptions('forms-ext', {types: 'date'});
            webshims.polyfill('forms forms-ext');
            $.webshims.formcfg = {
                en: {
                    dFormat: '/',
                    dateSigns: '/',
                    patterns: {
                        d: "dd/mm/yy"
                    }
                }
            };
        </script>
        <link href="http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.css" rel="stylesheet">
        <link rel="shortcut icon" href="frienterest.ico">
    </head>
    <body>
        <% if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("falha")) {
                out.print("<script>alert('Senhas não correspondem. Por favor, refaça o cadastro.')</script>");
            } else if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("emailInvalido")) {
                out.print("<script>alert('O email digitado é inválido!')</script>");
            } else if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("falhaEnvio")) {
                out.print("<script>alert('Houve um erro ao enviar o email de verificação. Desculpe-nos pelo transtorno mas refaça o cadastro.')</script>");
            } else if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("usuarioExistente")) {
                out.print("<script>alert('Ja existe algum usuario com esse email ou nome de usuario.')</script>");
            }
            else if (request.getParameter("msg") != null && request.getParameter("msg").toString().equals("dataInvalida")) {
                out.print("<script>alert('A data de nascimento inserida eh invalida')</script>");
            }%>
        <div class="row">

            <div class="large-6 columns">

                <div class="signup-panel">

                    <p class="welcome">Seja bem-vindo(a) ao Frienterest!</p>

                    <form action="CadastroUsuario" method="post" name="form2">

                        <div class="row collapse">

                            <div class="small-2  columns">

                                <span class="prefix"><i class="fi-torso"></i></span>

                            </div>

                            <div class="small-10  columns">

                                <input type="text" placeholder="nome" name="nome">

                            </div>

                        </div>
                        <div class="row collapse">

                            <div class="small-2  columns">
                                <span class="prefix"></span>
                            </div>

                            <div class="small-10  columns">

                                <input type="text" placeholder="sobrenome" name="sobrenome">

                            </div>

                        </div>

                        <div class="row collapse">

                            <div class="small-2 columns ">

                                <span class="prefix"><i class="fi-torso-business"></i></span>

                            </div>

                            <div class="small-10 columns ">

                                <input type="username" placeholder="nome de usuario" name="username">

                            </div>

                        </div>

                        <div class="row collapse">

                            <div class="small-2 columns">

                                <span class="prefix"><i class="fi-mail"></i></span>

                            </div>

                            <div class="small-10  columns">

                                <input type="text" placeholder="email" name="email">

                            </div>

                        </div>

                        <div class="row collapse">

                            <div class="small-2 columns ">

                                <span class="prefix"><i class="fi-lock"></i></span>

                            </div>

                            <div class="small-10 columns ">

                                <input type="password" placeholder="senha" name="senha">

                            </div>

                        </div>

                        <div class="row collapse">

                            <div class="small-2 columns ">

                                <span class="prefix"></i></span>

                            </div>

                            <div class="small-10 columns ">

                                <input type="password" placeholder="repetir senha" name="copia_senha">

                            </div>

                        </div>                        
                        <div class="row collapse">

                            <div class="small-2 columns ">

                                <span class="prefix"><i class="fi-calendar"></i></span>

                            </div>

                            <div class="small-10 columns ">

                                <input type="text" placeholder="data de nascimento" name="data_nascimento" onkeyup="mascaraData(this,event);" maxlength="10">

                            </div>

                        </div>

                        <div class="row collapse">

                            <div class="small-2  columns">
                                <span class="prefix"></span>
                            </div>

                            <div class="small-10  columns">

                                <select name="genero">
                                    <option value="masculino">masculino</option>
                                    <option value="feminino">feminino</option>
                                </select>

                            </div>

                        </div>   

                        <div class="row collapse">

                            <textarea name="sobre" rows="3" cols="12" placeholder="Escreva um pouco sobre você..." id="descricao"></textarea>

                        </div>
                        <input type="submit" value="Cadastrar-se" class="button">

                    </form>
                    <p>Já tem uma conta? Entre <a href="redirect.jsp">aqui &raquo</a></p>

                </div>

            </div>

        </div>

    </body>
</html>
