<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<html>
    <head>
        <title>Procesar Comprar - UPOMMarket</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="/views/utils/includes.jsp"%>

        <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>
        <script src="../frameworks/jquery/jquery.min.js"></script>
        <script src="../frameworks/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script><!-- Para que se vean los logos -->
    </head>

    <body>

        <%@include file="../utils/header.jsp" %>
        <!-- Page Content -->
        <main class="container">
            <div class="divCarrito">
                <h3>Resumen de compra</h3>
                <hr>
                <s:if test="#session.carrito.size == 0">
                    <div class='alert alert-success'>El carrito está vacío.</div>
                </s:if>
                <s:elseif test="#session.carrito==null">
                    <div class='alert alert-success'>El carrito está vacío.</div>
                </s:elseif>
                <s:else>
                    <div class="table-responsive-sm">
                        <table id="tableProductos" class="table table-light">
                            <s:form method="post" action="finalizarCompra.php" id="finalizarCompra" theme="simple">
                                <input type="hidden" name="email" value="<?php echo base64_encode(encriptar($_SESSION['email'])); ?>"/>
                                <input type="hidden" name="direccion" value="<?php echo base64_encode(encriptar($_SESSION['direccion'])); ?>"/>
                                <thead>
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Descripción</th>
                                        <th class='text-center'>Precio(&euro;)</th>
                                        <th class='text-center'>Cantidad</th>
                                        <th class='text-center'>Subtotal(&euro;)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:set var="cont" value="0" />
                                    <s:set var="total" value="0"/>
                                    <s:iterator var="i" value="#session.carrito">
                                        <s:url var="productoId" action="eliminarCarrito">
                                            <s:param name="idProducto" value="idProducto"/>
                                            <s:param name="origin" value="'carrito'"/>
                                        </s:url>
                                        <tr class='producto'>
                                            <td>
                                                <a href=producto.php?idProducto='"> 
                                                    <s:property value="nombre"/>
                                                </a>
                                            </td>
                                            <td> 
                                                <s:property value="descripcion"/>
                                            </td>
                                            <td class='text-center'>
                                                <s:property value="precio"/>
                                            </td>
                                            <td class='text-center tdCantidad'>
                                                <s:property  value="cantidad.get(#cont)"/>
                                            </td>
                                            <td class='text-center tdSubtotal'>
                                                <s:property value="precio" />
                                            </td>

                                        </tr>
                                        <s:set var="total" value="%{#total+(precio*cantidad.get(#cont))}" />
                                        <s:set var="cont" value="%{#cont+1}" />
                                    </s:iterator>
                                    <%--
                                        <input type="hidden" name="producto<?php echo $i; ?>" value="<?php echo base64_encode(encriptar($producto['id'])); ?>"/>
                                        <input type="hidden" name="cantidad<?php echo $i; ?>" value="<?php echo base64_encode(encriptar($producto['cantidad'])); ?>"/>
                                    --%>
                                    <tr>
                                        <td colspan="4"><strong>Total:</strong></td>
                                        <td id="precioTotalCarrito" class='text-center'><s:property  value="#total"/>&euro;</td>
                                    </tr>
                                </tbody>
                                <button type="submit" name="submitButton" value="finalizarCompra" id="botonFinalizar" hidden></button>
                            </s:form>
                        </table>
                    </div>
                </div>
                <hr>
                

                <script src="https://www.paypal.com/sdk/js?client-id=Aag_BV9saCzCn3jZU7nRT-_qMd-sJuXnc9VKSeM5li-IXLAGDi2zUsiRtPpTu3Tvr46fIq9Ce6KSjkug&currency=EUR"></script>
                <hr>
                <div id="paypal-button-container"></div>

                <script>
                    $(document).ready(function () {
                        paypal.Buttons();
                    });
                </script>
                <script>
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


                            return actions.order.create(<?php echo json_encode(buildRequestBody(round($total, 2), $array_productos, $direccion)); ?>);
                },
                onApprove: function (data, actions) {

                                    return actions.order.capture().then(function (details) {

                                var formCompra = document.getElementById("finalizarCompra");
                                formCompra.submit();
                            });
                            }
                            }).render('#paypal-button-container');
                </script>

            </s:else>

        </div>
    </div>
    <!-- /.row -->

</main>
<!-- /.container -->
        <%@include file="../utils/footer.html" %>


</body>

</html>