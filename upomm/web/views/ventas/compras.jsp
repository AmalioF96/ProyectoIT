<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="listaCompras==null">
    <s:action executeResult="true" name="seleccionarCompras">
        <%--<s:param name="idProducto" value="#parameters.idProducto"/>--%>
    </s:action>
</s:elseif>
<s:else>
    <html>
        <head>
            <title>Carrito XXX - UPOMarket</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/misProductos.css" rel="stylesheet">
            <link href="/upomm/css/misReclamaciones.css" rel="stylesheet">
            <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
            <script>
                //Creación del data Table
                $(document).ready(function () {
                    var data = "";
                    $('#pedidos').DataTable({
                        "language": {
                            "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"
                        },
                        "data": data,
                        "paging": true,
                        "order": [[1, "desc"]],
                        "ordering": true,
                        "columns": [
                            {"data": "idPedido"},
                            {"data": "fecha"},
                            {"data": "precio"}
                        ],
                        "drawCallback": function () {
                            var table = $('#pedidos').DataTable();

                            $('#pedidos tbody').on('click', 'tr', function () {
                                var id = table.row(this).data().idPedido;
                                var input = $("<input type='text' name='idPedido'/>");
                                $(input).val(id);
                                $("#formPedido").append(input);
                                $("#formPedido").submit();
                            });
                        }
                    });
                });
                function reemplazarImg(img) {
                    $(img).attr("src", "../img/productDefaultImage.jpg");
                }
            </script>
        </head>
        <body>
            <form id="formPedido" action="mostrarPedido.php" method="get" hidden>
            </form>
            <%@include file="../utils/header.jsp" %>
            <!-- Page Content -->
            <main class="container-fluid">
                <div class="row">
                    <div class="col-lg-3">
                        <img id="logo_main" class="img-fluid" src="../img/upomarket.png" alt="upomarket">
                        <nav class="list-group">
                            <h4 class="text-center">Gestión de Compras</h4>
                            <ul class="list-unstyled">
                                <li><a href="misPedidos.php" class="list-group-item active">Mis Compras</a></li>
                                <li><a href="reclamacionesRealizadas.php" class="list-group-item">Mis Reclamaciones</a></li>
                            </ul>
                        </nav>
                    </div>
                    <!-- /.col-lg-3 -->
                    <div class="col-lg-9 table-responsive-sm">
                        <table id="pedidos" class="table table-striped table-bordered dataTable" style="width:100%">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Fecha</th>
                                    <th>Importe(&euro;)</th>
                                </tr>
                            </thead>
                        </table>
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