<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="listaCompras==null">
    <s:action executeResult="true" name="listarCompras"/>

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
            <form id="formPedido" action="compra.jsp" method="get" hidden>
            </form>
            <%@include file="../utils/header.jsp" %>
            <!-- Page Content -->
            <main class="container-fluid">
                <div class="row">
                    <div class="col-lg-3">
                        <!--<img id="logo_main" class="img-fluid" src="../img/upomarket.png" alt="upomarket">-->
                        <nav id="categorias" class="list-group">
                            <h4 class="text-center">Gestión de Compras</h4>
                            <ul class="list-unstyled">
                                <li><s:a href="misCompras.jsp" cssClass="list-group-item active">Mis Compras</s:a></li>
                                <li><s:a href="" cssClass="list-group-item">Mis Reclamaciones</s:a></li>
                            </ul>
                        </nav>
                    </div>
                    <!-- /.col-lg-3 -->
                    <div class="col-lg-8 table-responsive-sm">
                        <table id="pedidos" class="table table-striped table-bordered dataTable" style="width:100%">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Fecha</th>
                                    <th>Importe(&euro;)</th>
                                    <th>Numero de artículos</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="listaCompras">
                                    <tr>
                                        <td><s:property value="idCompra"/></td>
                                        <td><s:date name="fecha" format="dd/MM/yyyy"/></td>
                                        <td><s:property value="getImporte()"/></td>
                                        <td><s:property value="getNumeroArticulos()"/></td>
                                    </tr>
                                </s:iterator>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.col-lg-9 -->
                </div>
                <!-- /.row -->
            </main>
            <!-- /.container -->
            <%@include file="../utils/footer.html" %>
            <form id="formPedido" action="mostrarPedido.php" method="get" hidden>
            </form>
        </body>
    </html>
</s:else>