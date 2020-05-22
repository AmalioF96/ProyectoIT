<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null || #session.usuario.tipo!='vendedor'">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="listaProductos==null">
    <s:action executeResult="true" name="listarProductosDeUsuario"/>
</s:elseif>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <title>Mis Productos - UPOMediaMarket</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/misProductos.css" rel="stylesheet">
            <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-rc.2/lazyload.js"></script>
            <script>
                //Creación del data Table
                $(document).ready(function () {
                    var table = $('#productos').DataTable({
                        "language": {
                            "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
                        }
                    });
                    $("img").on("error", function () {
                        $(this).attr("src", "/upomm/imagenes/productDefaultImage.jpg");
                    });
                    $("img.lazyload").lazyload();
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
                                <li class="list-group-item">
                                    <a href="/upomm/views/ventas/menuVentas.jsp" class="menu-link">Mis Ventas</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/reclamaciones/reclamacionesVendedor.jsp" class="menu-link">Mis Reclamaciones</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/productos/misProductos.jsp" class="menu-link active">Mis Productos</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/productos/crearProducto.jsp" class="menu-link">Crear/Editar Producto</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <!-- /.col-lg-3 -->
                    <div class="col-lg-9 table-responsive-sm my-auto mx-auto">
                        <s:if test="listaProductos.empty">
                            <div class='alert alert-success'>Aún no has puesto a la venta ningún producto.</div>
                        </s:if>
                        <s:else>
                            <table id="productos" class="table table-striped table-bordered dataTable" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Precio(&euro;)</th>
                                        <th>Imagen</th>
                                        <th>Disponible</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="listaProductos">
                                        <s:url var="editarProductoUrl" value="/views/productos/crearProducto.jsp">
                                            <s:param name="idProducto" value="idProducto"/>
                                        </s:url>
                                        <s:url var="idProductoUrl" value="/views/productos/producto.jsp">
                                            <s:param name="idProducto" value="idProducto"/>
                                        </s:url>
                                        <s:if test="%{imagen==''}">
                                            <s:set var="img" value="'default'"/>
                                        </s:if>
                                        <s:else>
                                            <s:set var="img" value="imagen"/>
                                        </s:else>
                                        <tr>
                                            <td><s:property value="idProducto"/></td>
                                            <td><s:a href="%{idProductoUrl}"><s:property value="nombre"/></s:a></td>
                                            <td><s:property value="precio"/></td>
                                            <td>                                                    
                                                <img style="max-width: 60px" class="img-fluid img-thumbnail lazyload rounded mx-auto d-block" data-src="<s:property value="%{#img}"/>"/>
                                            </td>
                                            <td>                                        
                                                <s:if test="disponible">
                                                    &#10004;
                                                </s:if>
                                                <s:else>
                                                    &#10060;
                                                </s:else>
                                            </td>
                                            <td>
                                                <s:a href="%{editarProductoUrl}" cssClass="btn btn-warning btn-md">Editar</s:a>
                                                </td>
                                            </tr>
                                    </s:iterator>
                                </tbody>
                            </table>
                        </s:else>
                    </div>
                    <!-- /.col-lg-9 -->
                </div>
                <!-- /.row -->
            </main>
            <!-- /.container -->
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>