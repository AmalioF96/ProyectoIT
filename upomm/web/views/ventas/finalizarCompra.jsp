<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="%{#session.carrito==null || #session.carrito.empty}">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<html>
    <head>
        <title>Procesar Comprar - UPOMMarket</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="/views/utils/includes.jsp"%>
        <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>
        <script src="https://www.paypal.com/sdk/js?client-id=sb&currency=EUR"></script>

        <script>
            $(document).ready(function () {
                paypal.Buttons();
            });
        </script>
        <s:head/>
    </head>

    <body>
        <%@include file="../utils/header.jsp" %>
        <!-- Page Content -->
        <main class="container">
            <div class="m-3">
                <h3>Resumen de compra</h3>
                <hr>
                <div class="table-responsive-sm">
                    <s:form method="post" action="accionFinalizarCompra" id="finalizarCompra" theme="css_xhtml">
                        <table id="tableProductos" class="table table-light text-center">
                            <input type="hidden" name="email" value="<?php echo base64_encode(encriptar($_SESSION['email'])); ?>"/>
                            <input type="hidden" name="direccion" value="<?php echo base64_encode(encriptar($_SESSION['direccion'])); ?>"/>
                            <thead>
                                <tr>
                                    <th class="text-left">Nombre</th>
                                    <th class="text-left">Descripción</th>
                                    <th>Precio(&euro;)</th>
                                    <th>Cantidad</th>
                                    <th>Subtotal(&euro;)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:set var="cont" value="0" />
                                <s:set var="total" value="0"/>
                                <s:iterator var="i" value="#session.carrito">
                                    <s:url var="productoId" value="/views/productos/producto.jsp">
                                        <s:param name="idProducto" value="idProducto"/>
                                    </s:url>
                                    <tr class='producto'>
                                        <td class="text-left">
                                            <s:a href="%{productoId}"> 
                                                <s:property value="nombre"/>
                                            </s:a>
                                        </td>
                                        <td class="text-left"> 
                                            <s:property value="descripcion"/>
                                        </td>
                                        <td >
                                            <s:property value="precio"/>
                                        </td>
                                        <td class='tdCantidad'>
                                            <s:property  value="#session.cantidad.get(#cont)"/>
                                        </td>
                                        <td class='tdSubtotal'>
                                            <s:property value="%{precio*#session.cantidad.get(#cont)}" />
                                        </td>

                                    </tr>
                                    <s:set var="total" value="%{#total+(precio*#session.cantidad.get(#cont))}" />
                                    <s:set var="cont" value="%{#cont+1}" />
                                </s:iterator>
                                <tr>
                                    <td colspan="3"></td>
                                    <td><strong>Total:</strong></td>
                                    <td id="precioTotalCarrito" class='text-center font-weight-bold'>
                                        <s:property  value="#total"/>&euro;
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <hr>
                    <div class="custom-control custom-switch wwgrp row mx-auto my-4">
                        <s:checkbox id="terminosYCondiciones" name="terminosYCondiciones" cssClass="custom-control-input wwctrl" theme="simple" fieldValue="true"/>
                        <label class="custom-control-label wwlbl" for="terminosYCondiciones">
                            <a href="http://www.google.com/search?q=estafa" target="_blank">
                                Acepto los términos y condiciones
                            </a>
                        </label>
                    </div>
                    <div class="row mx-auto my-4">
                        <div id="paypal-button-container"></div>
                    </div>
                </s:form>
                <script>
                    function toJson() {
                        var a = {intent: "CAPTURE",
                            purchase_units: new Array(
                                    {
                                        amount: {
                                            currency_code: "EUR",
                                            value: 0
                                        }
                                    }
                            )
                        };
                        var json = JSON.stringify(a);
                        return json;
                    }
                    /*
                     * 
                     *Aquí cargamos los datos necesarios para interactuar con la API de paypal
                     */
                    paypal.Buttons({
                        style: {
                            size: 'small',
                            color: 'gold',
                            shape: 'pill'
                        },
                        createOrder: function (data, actions) {
                            return actions.order.create(toJson());
                        },
                        onApprove: function (data, actions) {

                            return actions.order.capture().then(function (details) {
                                $("#formCompra").submit();
                            });
                        }
                    }).render('#paypal-button-container');
                </script>
            </div>
        </main>
        <!-- /.container -->
        <%@include file="../utils/footer.html" %>
    </body>
</html>