<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:if test="#session.usuario==null || #session.usuario.tipo!='admin'">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="listaReclamaciones==null">
    <s:action executeResult="true" name="listarDisputasAbiertas">
        <s:param name="operacion" value="listar"/>
    </s:action>
</s:elseif>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Disputas Abiertas - UPOMediaMarket</title>
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/misProductos.css" rel="stylesheet">
            <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/lazyload@2.0.0-rc.2/lazyload.js"></script>

            <script>
                //Creación del data Table
                $(document).ready(function () {
                    var seleccionado = null;
                    $(".gestionar").click(function () {
                        var descripcion = $(this).parents("td").find(".descripcion").text();
                        $("#descripcion").text(descripcion);
                        $("#descripcion").show();
                        $('#modalReclamaciones').modal('show');
                        seleccionado = $(this).parent();
                    });
                    $("#cliente").click(function () {
                        $(seleccionado).find("input[name='operacion']").val("cliente");
                        if (confirm("Se cerrará la disputa a favor del cliente, ¿desea continuar?")) {
                            $(seleccionado).submit();
                        }
                    });
                    $("#vendedor").click(function () {
                        $(seleccionado).find("input[name='operacion']").val("vendedor");
                        if (confirm("Se cerrará la disputa a favor del vendedor, ¿desea continuar?")) {
                            $(seleccionado).submit();
                        }
                    });
                    var table = $('#reclamaciones').DataTable({
                        "language": {
                            "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
                        },
                        "order": [[0, "desc" ]]
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
            <!-- Modal -->
            <div class="modal fade" id="modalReclamaciones" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Disputa</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <textarea id="descripcion" name="descripcion" class="form-control"readonly="true"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button id="cliente" class="btn btn-primary">Cliente</button>
                            <button id="vendedor" class="btn btn-secondary">Vendedor</button>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="../utils/header.jsp" %>
            <main class="container-fluid mt-4">
                <div class="row">
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Menú de Administrador</h4>                            <ul class="list-unstyled">
                                <li class="list-group-item">
                                    <a href="/upomm/views/reclamaciones/disputasAdmin.jsp" class="menu-link active">Disputas Abiertas</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/reclamaciones/resueltasAdmin.jsp" class="menu-link">Disputas Resueltas</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/productos/crearCategoria.jsp" class="menu-link">Gestionar Categorías</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <!-- /.col-lg-3 -->
                    <div class="col-lg-9 table-responsive-sm my-auto mx-auto">
                        <s:if test="listaReclamaciones.empty">
                            <div class='alert alert-info'>No hay disputas abiertas.</div>
                        </s:if>
                        <s:else>
                            <table id="reclamaciones" class="table table-striped table-bordered dataTable" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Nº Pedido</th>
                                        <th>Producto</th>
                                        <th>Cliente</th>
                                        <th>Vendedor</th>
                                        <th>Fecha</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="listaReclamaciones">
                                        <s:url var="idProductoUrl" value="/views/productos/producto.jsp">
                                            <s:param name="idProducto" value="productos.idProducto"/>
                                        </s:url>
                                        <s:if test="%{compras.usuarios.foto==''}">
                                            <s:set var="img_cli" value="'default'"/>
                                        </s:if>
                                        <s:else>
                                            <s:set var="img_cli" value="compras.usuarios.foto"/>
                                        </s:else>
                                        <s:if test="%{productos.usuarios.foto==''}">
                                            <s:set var="img_ven" value="'default'"/>
                                        </s:if>
                                        <s:else>
                                            <s:set var="img_ven" value="productos.usuarios.foto"/>
                                        </s:else>
                                        <tr>
                                            <td><s:property value="compras.idCompra"/></td>
                                            <td>                                                    
                                                <s:a href = "%{idProductoUrl}">
                                                    <s:property value="productos.nombre"/>
                                                </s:a>
                                            </td>
                                            <td>                                              
                                                <span data-toggle="tooltip" data-html="true" title="<ul><li><strong>Nombre:</strong> <s:property value="compras.usuarios.nombre"/></li><li><strong>Email:</strong> <s:property value="compras.usuarios.email"/></li></ul>">
                                                    <img style="max-width: 60px" class="img-fluid img-thumbnail lazyload rounded mx-auto d-block" data-src="<s:property value="%{#img_cli}"/>"/>
                                                </span>
                                            </td>
                                            <td>                                              
                                                <span data-toggle="tooltip" data-html="true" title="<ul><li><strong>Nombre:</strong> <s:property value="productos.usuarios.nombre"/></li><li><strong>Email:</strong> <s:property value="productos.usuarios.email"/></li></ul>">
                                                    <img style="max-width: 60px" class="img-fluid img-thumbnail lazyload rounded mx-auto d-block" data-src="<s:property value="%{#img_ven}"/>"/>
                                                </span>
                                            </td>
                                            <td><s:date name="fecha" format="dd/MM/yyyy"/></td>
                                            <td>
                                                <span class="descripcion" style="display:none"><s:property value="descripcion"/></span>
                                                <s:form action="modificarReclamacion" theme="simple">
                                                    <s:textfield name="operacion" value="" hidden="true"/>
                                                    <s:textfield name="idProducto" value="%{productos.idProducto}" hidden="true"/>
                                                    <s:textfield name="idCompra" value="%{compras.idCompra}" hidden="true"/>
                                                    <s:textfield type="button" cssClass="btn btn-warning gestionar" value="Gestionar"/>                                                </s:form>
                                                </td>
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
        </body>
    </html>
</s:else>