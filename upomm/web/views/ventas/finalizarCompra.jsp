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
        <script src="https://www.paypal.com/sdk/js?client-id=Ab3EXFpwjNUJHeMDtoZ6ALhOfX8sSX7SJrCi4b41ghRqI-4aIRowbB2GHwXRbhAiaOsWv66O2y5VkXEl&currency=EUR"></script>

        <script>
            $(document).ready(function () {
                $("#terminosYCondiciones").prop( "checked", false);
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
                <s:form method="post" action="accionFinalizarCompra" id="finalizarCompra" theme="css_xhtml">
                    <div class="table-responsive-sm">
                        <table id="tableProductos" class="table table-light text-center">
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
                                <s:set var="total" value="0"/>
                                <s:iterator value="#session.carrito">
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
                                            <s:number name="precio" maximumFractionDigits="2" minimumFractionDigits="2" />
                                        </td>
                                        <td class='tdCantidad'>
                                            <s:property  value="#session.cantidad[idProducto]"/>
                                        </td>
                                        <td class='tdSubtotal'>
                                            <s:number name="precio*#session.cantidad[idProducto]" maximumFractionDigits="2" minimumFractionDigits="2" />
                                        </td>

                                    </tr>
                                    <s:set var="total" value="%{#total+(precio*#session.cantidad[idProducto])}" />
                                </s:iterator>
                                <tr>
                                    <td colspan="3"></td>
                                    <td><strong>Total:</strong></td>
                                    <td id="precioTotalCarrito" class='text-center font-weight-bold'>
                                        <s:number name="#total" maximumFractionDigits="2" minimumFractionDigits="2" />&euro;
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <hr>
                    <s:fielderror fieldName="terminosYCondiciones" cssClass="list-unstyled errorMessage"/>
                    <p id="error" class="errorMessage" style="display: none">Debe acepatar los términos y condiciones</p>
                    <div class="custom-control custom-switch wwgrp row mx-auto my-4">
                        <s:checkbox id="terminosYCondiciones" name="terminosYCondiciones" cssClass="custom-control-input wwctrl" theme="simple" fieldValue="true" required="true"/>
                        <label class="custom-control-label wwlbl" for="terminosYCondiciones">
                            <a href="http://www.google.com/search?q=estafa" target="_blank">
                                Acepto los términos y condiciones
                            </a>
                        </label>
                    </div>
                    <%--<s:submit cssClass="btn btn-warning pull-left" value="COMPRAR"/>--%>
                </s:form>
                <div class="row mx-auto mt-4">
                    <div id="paypal-button-container" class="col-sm-4 px-0"></div>
                </div>
                <script>
                    /*
                     * 
                     *Aquí cargamos los datos necesarios para interactuar con la API de paypal
                     */
                    paypal.Buttons({
                        locale: 'es_ES',
                        style: {
                            size: 'responsive',
                            color: 'gold',
                            shape: 'pill',
                            label: 'pay',
                            tagline: 'true',
                            layout: 'horizontal'
                        },
                        createOrder: function (data, actions) {
                            return actions.order.create({
                                intent: "CAPTURE",
                                application_context: {
                                    brand_name: 'UPOMediaMarket',
                                    locale: 'es-ES',
                                    landing_page: 'BILLING',
                                    user_action: 'PAY_NOW'
                                },
                                purchase_units: [{
                                        amount: {
                                            currency_code: 'EUR',
                                            value: <s:property value="#total"/>,
                                            breakdown: {
                                                item_total: {
                                                    currency_code: 'EUR',
                                                    value: <s:property value="#total"/>
                                                }
                                            }
                                        },
                                        items: <s:property value="items"/>
                                    }]
                            }
                            );
                        },
                        onApprove: function (data, actions) {
                            return actions.order.capture().then(function (details) {
                                $("#finalizarCompra").submit();
                            });
                        },
                        onInit: function (data, actions) {

                            // Disable the buttons
                            actions.disable();

                            // Listen for changes to the checkbox
                            $("#terminosYCondiciones")
                                    .change(function (event) {
                                        $("#error").hide();
                                        // Enable or disable the button when it is checked or unchecked
                                        if (event.target.checked) {
                                            actions.enable();
                                        } else {
                                            actions.disable();
                                        }
                                    });
                        },
                        onClick: function () {
                            // Show a validation error if the checkbox is not checked
                            if (!document.querySelector("#terminosYCondiciones").checked) {
                                $("#error").show();
                            }
                        }
                    }).render("#paypal-button-container");
                </script>
            </div>
        </main>
        <!-- /.container -->
        <%@include file="../utils/footer.html" %>
    </body>
</html>