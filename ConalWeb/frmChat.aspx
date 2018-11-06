﻿<%@ Page Language="C#"AutoEventWireup="true" CodeBehind="frmChat.aspx.cs" Inherits="ConalWeb.Views.frmChat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Sala de Chat</title>
    
    <style type="text/css">
        
        
    </style>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="~/Content/Site.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="~/Scripts/modernizr-2.6.2.js"></script>
</head>
<body style="background-color:gainsboro;">
    
    <div class="container">
        <div class="row">
            <div class="col-md-offset-2 col-md-8 col-md-offset-2">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <asp:Label ID="Label3" runat="server" Text="Sala de chat" Font-Bold="True" Font-Size="X-Large" ForeColor="#006600"></asp:Label>
                    </div>
                    <div class="panel-body">
                        <asp:Label ID="Label2" runat="server" Text="Bienvenido(a)!" Font-Bold="True"></asp:Label>
                        <div id="mostrar_nombre"></div>
                        <input type="hidden" id="nombreUsuario" runat="server" />
                        <br />
                        <asp:Label ID="Label1" runat="server" Text="Comunidad: " Font-Bold="True"></asp:Label>
                        <div id="mostrar_comunidad"></div>
                        <input type="hidden" id="nombreComunidad" runat="server" />
                        <br />
                        <textarea id="miMensaje" class="form-control" style="min-height:200px;" name="message"></textarea>
                        <br />
                        <input type="button" id="btnEnviarMsg" value="Enviar" class="btn btn-success"  />
                        <br />
                        <div class="panel panel-default" style="margin-top:10px;">
                            <div class="panel-body">
                                <ul id="cajaMensajes"></ul>
                            </div>
                        </div>
                   
                    </div>
                </div>
            </div>

        </div>
    </div>
    
    <!--Script references. -->
    <!--Reference the jQuery library. -->
    <script src="Scripts/jquery-3.3.1.min.js" "></script>
    <!--Reference the SignalR library. -->
    <script src="/Scripts/jquery.signalR-2.3.0.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="/signalr/hubs"></script>
    <!--Add script to update the page and send messages.-->
    <script type="text/javascript">

        // TODO: Lo de "chat.server" son los metodos de ChatHub.cs, "chat.client" ya es otra cosa de jquery

        $(function () {
            // Declare a proxy to reference the hub.
            var chat = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.

            chat.client.receive = function (name, conId, msge) {
                $('#cajaMensajes').append("<li>" + name + " : " + msge + "</li>");

            }

            // Get the user name and store it to prepend to messages.
            //$('#nombreUsuario').val(prompt('Enter your name:', ''));
            // Set initial focus to message input box.
            $('#miMensaje').focus();
            // Start the connection.
            $.connection.hub.start().done(function () {

                // unirse al grupo
                chat.server.join($('#nombreComunidad').val());
                $('#mostrar_nombre').text($('#nombreUsuario').val());
                $('#mostrar_comunidad').text($('#nombreComunidad').val());

                $('#btnEnviarMsg').click(function () {
                    // Call the Send method on the hub.
                    //chat.server.send($('#nombreUsuario').val(), $('#message').val());
                    chat.server.sendMessage($('#nombreUsuario').val(), $('#miMensaje').val(), $('#nombreComunidad').val());
                    // Clear text box and reset focus for next comment.
                    $('#miMensaje').val('').focus();
                });

                $("#miMensaje").keypress(function (e) {
                if (e.which == 13) {
                    $('#btnEnviarMsg').click();
                }
            });
            });
        });
    </script>
        


    <script src="~/Scripts/bootstrap.min.js"></script>
</body>
</html>
