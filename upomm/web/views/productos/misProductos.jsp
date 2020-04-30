<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="listaProductos==null">
    <s:action executeResult="true" name="listarProductosDeUsuario"/>
</s:elseif>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <title>Mis Compras - UPOMediaMarket</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/misProductos.css" rel="stylesheet">
            <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
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
                                $("input").remove(); //Para que no se envie mas de un campo con el id al reenviar el form
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
        </head>
        <body>
            <%@include file="../utils/header.jsp" %>
            <!-- Page Content -->
            <main class="container-fluid">
                <div class="row">
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Menú de Vendedor</h4>
                            <ul class="list-unstyled">
                                <li><a href="/upomm/views/ventas/menuVentas.jsp" class="list-group-item ">Mis Ventas</a></li>
                                <li><a href="/upomm/views/productos/misProductos.jsp" class="list-group-item active">Mis Productos</a></li>
                                <li><a href="/upomm/views/productos/crearProducto.jsp" class="list-group-item">Crear Producto</a></li>
                            </ul>
                        </nav>
                    </div>
                    <!-- /.col-lg-3 -->
                    <s:if test="listaProductos.size > 0">
                        <div class="col-lg-9 table-responsive-sm">
                            <table id="pedidos" class="table table-striped table-bordered dataTable" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Descripción</th>
                                        <th>Precio(&euro;)</th>
                                        <th>Imagen</th>
                                        <th>Disponible</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="listaProductos">
                                        <tr>
                                            <td><s:property value="idProducto"/></td>
                                            <td><s:property value="nombre"/></td>
                                            <td><s:property value="descripcion"/></td>
                                            <td><s:property value="precio"/></td>
                                            <td><s:property value="imagen"/></td>
                                            <td><s:property value="disponible"/></td>
                                        </tr>
                                    </s:iterator>
                                </tbody>
                            </table>
                        </div>
                    </s:if>
                    <s:else>

                        <div class='alert alert-success'>Aún no has puesto a la venta ningún producto.</div>
                    </s:else>
                    <!-- /.col-lg-9 -->
                </div>
                <!-- /.row -->
            </main>
            <!-- /.container -->
            <%@include file="../utils/footer.html" %>
            <s:form id="formPedido" action="compra.jsp" method="GET" hidden="true">
            </s:form>
        </body>
    </html>
</s:else>