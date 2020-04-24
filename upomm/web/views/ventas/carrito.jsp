<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Carrito XXX - UPOMarket</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="/views/utils/includes.jsp" %>
        <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>

        <script>
            $(document).ready(function () {
                $("#inputDireccion").change(function () {
                    var error = $("#error-direccion");
                    if (error != null) {
                        $(error).remove();
                    }
                });
                $("input.cantidad").change(function () {
                    console.log("Aqui estamos");
                    var inputsCantidad = $("input.cantidad");
                    var precios = $(".precio")
                    var total = 0;
                    for (var i = 0, max = inputsCantidad.length; i < max; i++) {
                        var input = $(inputsCantidad).get(i);
                        var precio = $($(precios).get(i)).text();
                        if (isNaN(input.value) || input.value <= 0) {
                            input.value = 1;
                        }
                            total += parseFloat(input.value) * parseFloat(precio);
                        


                    }
                    console.log(total);
                    $("#precioTotalCarrito").text(total.toFixed(2));

                });


                var inputsCantidad = $("input.cantidad");

                for (var i = 0, max = inputsCantidad.length; i < max; i++) {
                    var input = $(inputsCantidad).get(i);
                    input.value = 1;
                    $(input).change();
                }


            });
            function validaDireccion() {
                var direccion = $("#inputDireccion");
                var val = $("#inputDireccion option:selected").val();
                if (val == "") {
                    var a = document.getElementById("error-direccion");
                    if (a == null) {
                        direccion.parent().after($("<div id='error-direccion' class='alert alert-danger' role='alert'>Debe seleccionar una dirección para continuar con la compra</div>"));
                    }
                    return false;
                } else {
                    $("#formCarrito").submit();
                }
            }
        </script>



    </head>
    <body>
        <%--SCRIPT PAYPAL QUE NO SE QUE HACE
<script src="https://www.paypal.com/sdk/js?client-id=Aag_BV9saCzCn3jZU7nRT-_qMd-sJuXnc9VKSeM5li-IXLAGDi2zUsiRtPpTu3Tvr46fIq9Ce6KSjkug"></script>
        --%>
        <%@include file="../utils/header.jsp" %>

        <!-- Page Content -->
        <main class="container">

            <div class="divCarrito">

                <h3>Mi carrito</h3>
                <hr>
                <s:if test="#session.carrito.size == 0">
                    <div class='alert alert-success'>El carrito está vacío.</div>
                </s:if>
                <s:elseif test="#session.carrito==null">
                    <div class='alert alert-success'>El carrito está vacío.</div>
                </s:elseif>
                <s:else>
                    <s:form action="accionProcesarCarrito" method="post" theme="simple">
                        <div class='table-responsive-sm'>
                            <table id="tableProductos" class="table table-light">
                                <thead>
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Descripción</th>
                                        <th class='text-center'>Precio(&euro;)</th>
                                        <th class='text-center'>Cantidad</th>
                                        <th class='text-center'>Subtotal(&euro;)</th>
                                        <th class='text-center'>Eliminar </th>
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
                                                <span class="precio"><s:property value="precio"/></span>
                                            </td>
                                            <td class='text-center tdCantidad'>
                                                <s:textfield  cssClass="form-control cantidad" name="cantidad" type="number"/>
                                            </td>
                                            <td class='text-center tdSubtotal'>
                                                <s:property value="precio" />
                                            </td>
                                            <td class='text-center tdBtnEliminar'>
                                                <s:a href="%{productoId}" name='btnEliminarCarrito' cssClass='btn btn-sm btn-danger btnEliminar'  value="Eliminar" >Eliminar</s:a>

                                                </td>

                                            </tr>
                                        <s:set var="total" value="%{#total+precio}" />
                                        <s:set var="cont" value="%{#cont+1}" />
                                    </s:iterator>

                                    <tr>
                                        <td colspan="5">
                                            <strong>
                                                Total:
                                            </strong>
                                        </td>
                                        <td class="text-center">
                                            <span id="precioTotalCarrito"></span> €
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <hr>

                        <%-- <div class="divCarrito">
                             <div class="input-group mb-3">
                                 <div class="input-group-prepend">
                                     <label class="input-group-text" for='inputDireccion'><strong>Dirección de envio:</strong></label>
                                 </div>
                                 <select name="direccion" id="inputDireccion" class="custom-select">
                                     <option value="" disabled selected>--Seleccionar--</option>
                                     <?php
                                     foreach ($direcciones as $d) {
                                     echo "<option value='" . $d["id"] . "'>" . $d["nombre"] . "</option>";
                                     }
                                     ?>
                                 </select>
                             </div>
                             <a class="btn btn-sm btn-secondary" href="./aniadirDireccion.php" role="button">Añadir una dirección nueva</a>
                         </div>
                         <hr>--%>

                        <div class="divCarrito">
                            <input id="btnProcesarCompra" class="btn btn-md btn-primary btn-block text-uppercase form-control" type="submit" onclick="" value="Procesar Compra" name="procesarCompra">
                        </div>

                    </s:form>
                </s:else>
            </div>
        </main>
        <!-- /.container -->
        <%@include file="../utils/footer.html" %>
    </body>
</html>
