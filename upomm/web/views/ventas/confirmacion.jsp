<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="%{#session.usuario==null || (#parameters.id==null && compra==null)}">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Confirmación de Compra - UPOMediaMarket</title>
        <%@include file="/views/utils/includes.jsp"%>
        <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>

        <script>
            $(document).ready(function () {
                var id = atob("<s:property value="#parameters.id"/>");
                if (id !== null && id.length > 0) {
                    $('#modalValidacion').modal({
                        show: true,
                        backdrop: 'static',
                        keyboard: false
                    });
                    var data = "grant_type=client_credentials";

                    var xhr = new XMLHttpRequest();

                    xhr.addEventListener("readystatechange", function () {
                        if (this.readyState === 4 && this.status == 200) {
                            var myArr = JSON.parse(this.responseText);
                            var token = myArr["access_token"];
                            confirma(id, token);
                        }
                    });

                    xhr.open("POST", "https://api.sandbox.paypal.com/v1/oauth2/token");
                    xhr.setRequestHeader("Authorization", "Basic QWIzRVhGcHdqTlVKSGVNRHRvWjZBTGhPZlg4c1NYN1NKckNpNGI0MWdoUnFJLTRhSVJvd2JCMkdId1hSYmhBaWFPc1d2NjZPMnk1VmtYRWw6RUFUdWlyZkgyZ0FvNVA1N3hQNGpWYTZZcHZVYzV1MFNYQ1ZoQnpyZ0RPRWpVN1hSNHpTZktqcHdac05fWllGcHZsWmpfMENfcW1NTy1NUmQ=");
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.withCredentials = false;

                    xhr.send(data);
                } else {
                    var d = new Date();
                    var links = $(".enlaces");
                    for (var i = 0; i < links.length; i++) {
                        var url = $(links[i]).attr("href");
                        $(links[i]).attr("href", url + "&time=" + d.getTime());
                    }
                }
            });

            function confirma(id, token) {
                var xhr = new XMLHttpRequest();
                xhr.withCredentials = true;

                xhr.addEventListener("readystatechange", function () {
                    if (this.readyState === 4 && this.status == 200) {
                        valida(JSON.parse(this.responseText));
                    }
                });

                xhr.open("GET", "https://api.sandbox.paypal.com/v2/checkout/orders/" + id.toString());
                xhr.setRequestHeader("Content-Type", "application/json");
                xhr.setRequestHeader("Authorization", "Bearer " + token.toString());
                xhr.withCredentials = false;

                xhr.send();
            }

            function valida(respuesta) {
                if (respuesta["status"] == "COMPLETED") {
                    window.location = "/upomm/views/ventas/accionFinalizarCompra";
                } else {
                    $("#modalValidacion").modal('hide');
                    $("#error").show();
                }
            }
        </script>
        <s:head/>
    </head>

    <body>
        <!-- Modal -->
        <div class="modal fade" id="modalValidacion" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered cascading-modal" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Validando..</h5>
                    </div>
                    <div class="modal-body m-2">
                        <div class="spinner-border text-primary mx-auto d-block"></div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../utils/header.jsp" %>
        <!-- Page Content -->
        <main class="container-fluid my-auto mx-auto">
            <div class="mt-3">
                <div id="error" class='alert alert-danger' style="display: none">ERROR: no se ha podido validar la operación.
                </div>
                <s:if test="hasActionErrors()">
                    <div class='alert alert-danger'>
                        <s:actionerror cssClass="list-unstyled m-0"/>
                    </div>
                </s:if>
                <s:elseif test="compra!=null">
                    <div class='alert alert-success'>
                        &iexcl;La compra se ha registrado con éxito! Haz click en los enlaces* para descargar tus archivos:
                        <ul class="mt-4">
                            <s:iterator value="compra">
                                <s:url var="idProductoUrl" action="descargarArchivo">
                                    <s:param name="idProducto" value="idProducto"/>
                                </s:url>
                                <li>
                                    <a class="enlaces" href="<s:property value="#idProductoUrl"/>" target="_blank">
                                        <s:property value="nombre"/>
                                    </a>
                                </li>
                            </s:iterator>
                        </ul>
                        <small><strong>*Los enlaces serán válidos durante 30 minutos.</strong></small>
                    </div>
                    <ul>

                    </ul>
                </s:elseif>
            </div>
        </main>
        <!-- /.container -->
        <%@include file="../utils/footer.html" %>
    </body>
</html>