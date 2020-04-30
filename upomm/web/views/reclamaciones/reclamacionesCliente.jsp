<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="listaReclamaciones==null">
    <s:action executeResult="true" name="listarReclamaciones">
        <s:param name="operacion" value="listar"/>
    </s:action>
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
                    var table = $('#reclamaciones').DataTable({
                        "language": {
                            "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
                        },
                        "drawCallback": function () {
                            var table = $('#pedidos').DataTable();
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
                            <h4 class="text-center">Gestión de Compras</h4>
                            <ul class="list-unstyled">
                                <li><s:a href="../ventas/misCompras.jsp" cssClass="list-group-item">Mis Compras</s:a></li>
                                <li><s:a href="reclamacionesCliente.jsp" cssClass="list-group-item active">Mis Reclamaciones</s:a></li>
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
                                <s:iterator value="listaReclamaciones" var="lr">
                                    <tr>
                                        <td><s:property value="compras.idCompra"/></td>
                                    <td><s:property value="productos.nombre" /></td>
                                    <td><s:property value="productos.usuarios.nombre"/></td>
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

                        <div class='alert alert-success'>Aún no has realizado ninguna reclamación.</div>
                    </s:else>
                    <!-- /.col-lg-9 -->
                </div>
            </main>
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>