<%-- 
    Document   : carrito
    Created on : 23-abr-2020, 17:34:47
    Author     : Amalio
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Carrito XXX - UPOMarket</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
        <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>
        <link href="/upomm/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="/upomm/css/footer.css" rel="stylesheet" type="text/css"/>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script><!-- Para que se vean los logos -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>

        <script>
            $(document).ready(function () {
                $("#inputDireccion").change(function () {
                    var error = $("#error-direccion");
                    if (error != null) {
                        $(error).remove();
                    }
                });

                var inputsCantidad = $("input.cantidad");
                var btnsEliminar = $("a.btnEliminar");
                var filas = $("tr.producto");
                var tdCantidad = $("td.tdCantidad");
                var tdBtnEliminar = $("td.tdBtnEliminar");

                for (var i = 0, max = filas.length; i < max; i++) {
                    var btn = $(btnsEliminar).get(i);
                    var tdc = $(tdCantidad).get(i);
                    var tdb = $(tdBtnEliminar).get(i);
                    var input = $(inputsCantidad).get(i);

                    $(input).appendTo(tdc);
                    $(btn).appendTo(tdb);

                }

                $("table").remove($("td.tdLabel").parent("tr"));


                $("input.cantidad").change(function () {
                    var cantidad = parseInt($(this).val());
                    if (isNaN(cantidad) || cantidad <= 0) {
                        cantidad = 1;
                        $(this).val(cantidad);
                    }
                    var id = $(this).attr("id");
                    var index = parseInt(id.split("-")[1]);
                    var rows = $("tr.producto");
                    var modificada = $(rows)[index];
                    var cells = $(modificada).children();
                    var precio = parseFloat($(cells[2]).text());
                    $(cells[4]).text(precio * cantidad);
                    var total = 0;
                    for (var i = 0; i < rows.length; i++) {
                        var cell = $(rows[i]).children()[4];
                        total += parseFloat($(cell).text());
                    }
                    $("#precioTotalCarrito").text(total.toFixed(2));

                });
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
        <h1>Hello World!</h1>
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
                    <s:form id="a" action="">
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
                                    <s:iterator var="i" value="#session.carrito">
                                        <s:url var="productoId" action="eliminarCarrito">
                                            <s:param name="id" value="idProducto"/>
                                            <s:param name="origin" value="carrito"/>
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

                                            </td>
                                            <td class='text-center tdSubtotal'>
                                                <s:property value="precio*3" />
                                            </td>
                                            <td class='text-center tdBtnEliminar'>

                                            </td>
                                            <s:textfield  cssClass="form-control cantidad" name="cantidad%{cont}" type="number" id="cantidad-%{cont}"/>
                                            <s:a href="%{productoId}" name='btnEliminarCarrito' cssClass='btn btn-sm btn-danger btnEliminar'  value="Eliminar" >Eliminar</s:a>

                                            </tr>
                                        <s:set var="cont" value="%{#cont+1}" />
                                    </s:iterator>

                                    <tr>
                                        <td colspan="5"><strong>Total:</strong></td>
                                        <td class="text-center"><span id="precioTotalCarrito"><?php echo number_format($total, 2); ?></span>€</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <hr>

                        <div class="divCarrito">
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
                        <hr>

                        <div class="divCarrito">
                            <input id="btnProcesarCompra" class="btn btn-md btn-primary btn-block text-uppercase form-control" type="submit" onclick="return validaDireccion()" value="Procesar Compra" name="procesarCompra">
                        </div>

                    </s:form>
                </s:else>
            </div>
        </main>
        <!-- /.container -->
        <%@include file="../utils/footer.html" %>
    </body>
</html>