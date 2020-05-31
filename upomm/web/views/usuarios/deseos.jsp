<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Lista de Deseos - UPOMediaMarket</title>
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>
            <link href="/upomm/css/perfil.css" rel="stylesheet" type="text/css"/>
            <link href="/upomm/css/misProductos.css" rel="stylesheet">
            <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>

            <script>
                //Creación del data Table
                $(document).ready(function () {
                    var table = $('#deseos').DataTable({
                        "language": {
                            "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
                        }
                    });
                });
            </script>
        </head>
        <body>
            <%@include file="../utils/header.jsp" %>

            <!-- Page Content -->
            <main class="container-fluid mt-4">
                <div class="row">
                    <!-- LISTA DE CATEGORÍAS -->
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Perfil De Usuario</h4>
                            <ul class="list-unstyled">
                                <li class="list-group-item">
                                    <a href="/upomm/views/usuarios/perfil.jsp" class="menu-link">Ver Perfil</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/usuarios/deseos.jsp" class="menu-link active">Lista de Deseos</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-9 my-auto mx-auto table-responsive-sm">
                        <s:if test="%{#session.usuario.productoses_1==null || #session.usuario.productoses_1.empty}">
                            <div class='alert alert-info'>Aún no has añadido ningún producto a tu lista de deseos.</div>
                        </s:if>
                        <s:else>
                            <table id="deseos" class="table table-striped table-bordered dataTable" style="width:100%">
                                <thead>
                                    <tr>
                                        <th class="text-left">Producto</th>
                                        <th class="text-left">Descripción</th>
                                        <th>Precio(&euro;)</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="#session.usuario.getProductoses_1()" var="producto">
                                        <s:url var="idProductoUrl" value="/views/productos/producto.jsp">
                                            <s:param name="idProducto" value="%{#producto.idProducto}"/>
                                        </s:url>
                                        <tr>
                                            <td class="text-left">
                                                <s:a href = "%{idProductoUrl}">
                                                    <s:property value="nombre"/>
                                                </s:a>
                                            </td>
                                            <td class="text-left"><s:property value="descripcion"/></td>
                                            <td><s:property value="precio"/></td>
                                            <td>
                                                <s:if test="%{!#session.carrito.contains(#producto)}">
                                                    <s:form action="agregarCarrito" theme="simple">
                                                        <s:textfield name="idProducto" value="%{#producto.idProducto}" hidden="true"/>
                                                        <s:textfield name="origin" value="deseos" hidden="true"/>
                                                        <s:submit cssClass="btn btn-sm btn-primary" name="btnAgregarCarrito" value="Agregar al carrito" />
                                                    </s:form>
                                                </s:if>
                                                <s:else>
                                                    <s:form action="eliminarCarrito" theme="simple">
                                                        <s:textfield name="idProducto" value="%{#producto.idProducto}" hidden="true"/>
                                                        <s:textfield name="origin" value="deseos" hidden="true"/>
                                                        <s:submit cssClass="btn btn-sm btn-secondary" name="btnEliminarCarrito" value="Eliminar del carrito" />
                                                    </s:form>
                                                </s:else>
                                                <s:form action="eliminarDeseo" theme="simple">
                                                    <s:textfield name="idProducto" value="%{#producto.idProducto}" hidden="true"/>
                                                    <s:submit cssClass="btn btn-sm btn-warning mt-2" name="btnEliminarCarrito" value="Eliminar de la lista" />
                                                </s:form>
                                            </td>
                                        </tr>
                                    </s:iterator>
                                </tbody>
                            </table>
                        </s:else>
                    </div>
                </div>
            </main>
            <!-- /.container -->
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>