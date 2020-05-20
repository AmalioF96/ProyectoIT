<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="listaReclamaciones==null">
    <s:action executeResult="true" name="listarReclamacionesCliente">
        <s:param name="operacion" value="listar"/>
    </s:action>
</s:elseif>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Compras - UMM</title>
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/misProductos.css" rel="stylesheet">
            <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-rc.2/lazyload.js"></script>

            <script>
                //Creación del data Table
                $(document).ready(function () {
                    var table = $('#reclamaciones').DataTable({
                        "language": {
                            "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
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
            <main class="container-fluid">
                <div class="row">
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Gestión de Compras</h4>
                            <ul class="list-unstyled">
                                <li class="list-group-item">
                                    <s:a href="../ventas/misCompras.jsp" cssClass="menu-link">Mis Compras</s:a>
                                    </li>
                                    <li class="list-group-item">
                                    <s:a href="reclamacionesCliente.jsp" cssClass="menu-link active">Mis Reclamaciones</s:a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <!-- /.col-lg-3 -->
                    <s:if test="listaReclamaciones.size > 0">
                        <div class="col-lg-9 table-responsive-sm">
                            <table id="reclamaciones" class="table table-striped table-bordered dataTable" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Nº Pedido</th>
                                        <th>Producto</th>
                                        <th>Vendedor</th>
                                        <th>Descripción</th>
                                        <th>Estado</th>
                                        <th>Fecha</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="listaReclamaciones">
                                        <s:url var="idProductoUrl" value="/views/productos/producto.jsp">
                                            <s:param name="idProducto" value="productos.idProducto"/>
                                        </s:url>
                                        <s:if test="%{productos.usuarios.foto==''}">
                                            <s:set var="img" value="'default'"/>
                                        </s:if>
                                        <s:else>
                                            <s:set var="img" value="productos.usuarios.foto"/>
                                        </s:else>
                                        <tr>
                                            <td><s:property value="compras.idCompra"/></td>
                                            <td>                                                    
                                                <s:a href = "%{idProductoUrl}">
                                                    <s:property value="productos.nombre"/>
                                                </s:a></td>
                                            <td>                                              
                                                <span data-toggle="tooltip" data-html="true" title="<ul><li><strong>Nombre:</strong> <s:property value="productos.usuarios.nombre"/></li><li><strong>Email:</strong> <s:property value="productos.usuarios.email"/></li></ul>">
                                                    <img style="max-width: 60px" class="img-fluid img-thumbnail lazyload rounded mx-auto d-block" data-src="<s:property value="%{#img}"/>"/>
                                                </span>
                                            </td>
                                            <td><s:property value="descripcion"/></td>
                                            <td><s:property value="estado" /></td>
                                            <td><s:date name="fecha" format="dd/MM/yyyy"/></td>
                                        </tr>
                                    </s:iterator>
                                </tbody>
                            </table>
                        </div>
                    </s:if>
                    <s:else>
                        <div class='alert alert-info'>Aún no has realizado ninguna reclamación.</div>
                    </s:else>
                    <!-- /.col-lg-9 -->
                </div>
            </main>
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>