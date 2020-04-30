<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="listaVentas==null">
    <s:action executeResult="true" name="listarVentas"/>
</s:elseif>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Ventas - UMM</title>
            <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>
            <link href="/upomm/css/header.css" rel="stylesheet" type="text/css"/>
            <link href="/upomm/css/footer.css" rel="stylesheet" type="text/css"/>
            <link href="/upomm/css/misProductos.css" rel="stylesheet">
            <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
            <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js" integrity="sha384-6khuMg9gaYr5AxOqhkVIODVIvm9ynTT5J4V1cfthmT+emCG6yVmEZsRHdxlotUnm" crossorigin="anonymous"></script>
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
            <script src="https://kit.fontawesome.com/a076d05399.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>

            <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
            <script>
                //Creación del data Table
                $(document).ready(function () {
                    var table = $('#pedidos').DataTable({
                        "language": {
                            "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
                        },
                        "drawCallback": function () {
                            var table = $('#pedidos').DataTable();

                            $('#pedidos tbody').on('click', 'tr', function () {
                                var id = table.row(this).data()[0];
                                var input = $("<input type='text' name='idCompra'/>");
                                $(input).val(id);
                                $("#formPedido").append(input);
                                $("#formPedido").submit();
                            });
                        }
                    });
                });
            </script>
            <s:head />
        </head>
        <body>



            <%@include file="../utils/header.jsp" %>
            <main class="container">
                <div class="row m-5">
                    <div class="col-lg-1"> 
                    </div>

                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Menú de Vendedor</h4>
                            <ul class="list-unstyled">
                                <li><a href="/upomm/views/ventas/menuVentas.jsp" class="list-group-item active">Mis Ventas</a></li>
                                <li><a href="#" class="list-group-item active">Mis Productos</a></li>
                                <li><a href="/upomm/views/productos/crearProducto.jsp" class="list-group-item">Crear Producto</a></li>
                            </ul>
                        </nav>
                    </div>
                    <!-- /.col-lg-3 -->
                    <div class="col-lg-8 table-responsive-sm">
                        <table id="pedidos" class="table table-striped table-bordered dataTable" style="width:100%">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Email Cliente</th>
                                    <th>Producto</th>
                                    <th>Cantidad de productos</th>
                                    <th>Importe(&euro;)</th>
                                    <th>Fecha</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="listaVentas" var="lv">
                                    <tr>
                                        <td><s:property value="#lv[0]"/></td>
                                        <td><s:property value="#lv[1]" /></td>
                                        <td><s:property value="#lv[2]"/></td>
                                        <td><s:property value="#lv[3]"/></td>
                                        <td><s:property value="#lv[4]" /></td>
                                        <td><s:date name="#lv[5]" format="dd/MM/yyyy"/></td>
                                    </tr>
                                </s:iterator>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.col-lg-9 -->
                </div>
            </main>
            <%@include file="../utils/footer.html" %>


        </body>
    </html>
</s:else>