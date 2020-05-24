<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:if test="#session.usuario==null || #session.usuario.tipo!='vendedor'">
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
            <title>Ventas - UPOMediaMarket</title>
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/misProductos.css" rel="stylesheet">
            <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-rc.2/lazyload.js"></script>

            <script>
                //Creación del data Table
                $(document).ready(function () {
                    var table = $('#pedidos').DataTable({
                        "language": {
                            "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
                        },
                        "order": [[0, "desc"]],
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
                    $('[data-toggle="tooltip"]').tooltip();
                    $("img").on("error", function () {
                        $(this).attr("src", "/upomm/imagenes/defaultProfile.png");
                    });
                    $("img.lazyload").lazyload();
                });
            </script>
            <s:head />
        </head>
        <body>
            <%@include file="../utils/header.jsp" %>
            <main class="container-fluid mt-4">
                <div class="row">
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Menú de Vendedor</h4>
                            <ul class="list-unstyled">
                                <li class="list-group-item">
                                    <a href="/upomm/views/ventas/menuVentas.jsp" class="menu-link active">Mis Ventas</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/reclamaciones/reclamacionesVendedor.jsp" class="menu-link">Mis Reclamaciones</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/productos/misProductos.jsp" class="menu-link">Mis Productos</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/productos/crearProducto.jsp" class="menu-link">Crear/Editar Producto</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <!-- /.col-lg-3 -->
                    <div class="col-lg-9 table-responsive-sm my-auto mx-auto">
                        <s:if test="listaVentas.empty">
                            <div class='alert alert-info'>Aún no has realizado ninguna venta.</div>
                        </s:if>
                        <s:else>
                            <table id="pedidos" class="table table-striped table-bordered dataTable" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Nº Pedido</th>
                                        <th>Cliente</th>
                                        <th>Número de productos</th>
                                        <th>Total artículos</th>
                                        <th>Importe(&euro;)</th>
                                        <th>Fecha</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="listaVentas">
                                        <s:if test="%{usuarios.foto==''}">
                                            <s:set var="img" value="'default'"/>
                                        </s:if>
                                        <s:else>
                                            <s:set var="img" value="usuarios.foto"/>
                                        </s:else>
                                        <tr>
                                            <td><s:property value="idCompra"/></td>
                                            <td>
                                                <span data-toggle="tooltip" data-html="true" title="<ul><li><strong>Nombre:</strong> <s:property value="usuarios.nombre"/></li><li><strong>Email:</strong> <s:property value="usuarios.email"/></li></ul>">
                                                    <img style="max-width: 50px" class="img-fluid img-thumbnail lazyload rounded mx-auto d-block" data-src="<s:property value="%{#img}"/>"/>
                                                </span>
                                            </td>
                                            <td><s:property value="getNumeroProductos(#session.usuario)" /></td>
                                            <td><s:property value="getNumeroArticulos(#session.usuario)" /></td>
                                            <td><s:property value="getImporteParcial(#session.usuario)"/></td>
                                            <td><s:date name="fecha" format="dd/MM/yyyy"/></td>
                                        </tr>
                                    </s:iterator>
                                </tbody>
                            </table>
                        </s:else>
                    </div>
                    <!-- /.col-lg-9 -->
                </div>
            </main>
            <%@include file="../utils/footer.html" %>
            <s:form id="formPedido" action="venta.jsp" method="GET" hidden="true">
            </s:form>
        </body>
    </html>
</s:else>