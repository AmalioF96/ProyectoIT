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
                                $("input").remove();
                                var id = table.row(this).data()[0];
                                var input = $("<input type='text' name='idVenta'/>");
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
            <main class="container-fluid">
                <div class="row">
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Menú de Vendedor</h4>
                            <ul class="list-unstyled">
                                <li>
                                    <a href="/upomm/views/ventas/menuVentas.jsp" class="list-group-item active">Mis Ventas</a>
                                </li>
                                <li>
                                    <a href="/upomm/views/productos/misProductos.jsp" class="list-group-item">Mis Productos</a>
                                </li>
                                <li>
                                    <a href="/upomm/views/productos/crearProducto.jsp" class="list-group-item">Crear/Editar Producto</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <!-- /.col-lg-3 -->
                    <s:if test="listaVentas.size > 0">
                        <div class="col-lg-9 table-responsive-sm">
                            <table id="pedidos" class="table table-striped table-bordered dataTable" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Numero de Venta</th>
                                        <th>Email Cliente</th>
                                        <th>Cantidad de productos</th>
                                        <th>Total artículos</th>
                                        <th>Importe(&euro;)</th>
                                        <th>Fecha</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="listaVentas">
                                        <tr>
                                            <td><s:property value="idCompra"/></td>
                                            <td><s:property value="usuarios.email"/></td>
                                            <td><s:property value="getNumeroProductos(#session.usuario)" /></td>
                                            <td><s:property value="getNumeroArticulos(#session.usuario)" /></td>
                                            <td><s:property value="getImporteParcial(#session.usuario)"/></td>
                                            <td><s:date name="fecha" format="dd/MM/yyyy"/></td>
                                        </tr>
                                    </s:iterator>
                                </tbody>
                            </table>
                        </div>
                    </s:if>
                    <s:else>

                        <div class='alert alert-success'>Aún no has realizado ninguna venta.</div>
                    </s:else>
                    <!-- /.col-lg-9 -->
                </div>
            </main>
            <%@include file="../utils/footer.html" %>
            <s:form id="formPedido" action="venta.jsp" method="GET" hidden="true">
            </s:form>
        </body>
    </html>
</s:else>