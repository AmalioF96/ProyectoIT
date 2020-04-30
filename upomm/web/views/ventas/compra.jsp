<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="#parameters.idCompra==null">
    <s:action executeResult="true" name="listarCompras"/>
</s:elseif>
<s:elseif test="compra==null">
    <s:action executeResult="true" name="seleccionarCompra"/>
</s:elseif>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <title>Compra - UPOMediaMarket</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/compra.css" rel="stylesheet">
            <script>
                $(document).ready(function () {
                    var seleccionado = null;
                    $(".reclamar").click(function () {
                        $("#descripcion").show();
                        $('#modalReclamaciones').modal('show');
                        seleccionado = $(this).parent();
                    });
                    $("#send").click(function () {
                        var descripcion = $("#descripcion");
                        $(descripcion).hide();
                        $(seleccionado).append(descripcion);
                        $(seleccionado).submit();
                    });
                });
            </script>
        </head>
        <body>
            <!-- Modal -->
            <div class="modal fade" id="modalReclamaciones" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Reclamación</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <textarea id="descripcion" name="descripcion" class="form-control" placeholder="Describe brevemente el motivo de la reclamación*"></textarea>
                            <small><strong>*Este campo es obligatorio</strong></small>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <button id="send" class="btn btn-primary">Enviar</button>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="../utils/header.jsp" %>
            <!-- Page Content -->
            <main class="container-fluid">
                <div class="row">
                    <s:if test="#request.error!=null && !#request.error">
                        <div class="alert alert-success" role="alert">Se ha creado la reclamación.</div> 
                    </s:if>
                    <s:elseif test="#request.error">
                        <div class="alert alert-danger" role="alert">ERROR: no se pudo crear la reclamación.</div> 
                    </s:elseif>
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group">
                            <h4 class="text-center">Gestión de Compras</h4>
                            <ul class="list-unstyled">
                                <li>
                                    <s:a href="misCompras.jsp" cssClass="list-group-item active">Mis Compras</s:a>
                                    </li>
                                    <li>
                                    <s:a href="" cssClass="list-group-item">Mis Reclamaciones</s:a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <div class="col-lg-9 contendor table-responsive-sm">
                            <div class="row">
                                <div class="col-sm">
                                    <table>
                                        <tr>
                                            <td><strong>Número de pedido:</strong></td>
                                            <td class="text-left"><s:property value="compra.idCompra"/></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Número de productos:</strong></td>
                                        <td class="text-left"><s:property value="compra.lineasDeCompras.size"/></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-sm text-right">
                                <table class="pull-right">
                                    <tr>
                                        <td class="text-left"><strong>Fecha:</strong></td>
                                        <td><s:date name="compra.fecha" format="dd/MM/yyyy"/></td>
                                    </tr>
                                    <tr>
                                        <td class="text-left"><strong>Importe:</strong></td>
                                        <td><s:property value="compra.getImporte()"/>&euro;</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col" style="margin-top:1%">
                                <h3>Productos comprados</h3>
                                <table class="table table-striped table-bordered" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>Producto</th>
                                            <th>Vendedor</th>
                                            <th>Precio</th>
                                            <th>Cantidad</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <s:iterator value="compra.lineasDeCompras">
                                            <s:iterator value="compra.reclamacioneses">
                                                <s:if test="id.idCompra==compra.idCompra && id.idProducto==productos.idProducto">
                                                    <s:set var="reclamado" value="true"/>                                        
                                                </s:if>
                                            </s:iterator>
                                            <s:url var="idProductoUrl" value="/views/productos/producto.jsp">
                                                <s:param name="idProducto" value="productos.idProducto"/>
                                            </s:url>
                                            <tr>
                                                <td>
                                                    <s:a href = "%{idProductoUrl}">
                                                        <s:property value="productos.nombre"/>
                                                    </s:a>
                                                </td>
                                                <td><s:property value="productos.usuarios.nombre"/></td>
                                                <td><s:property value="productos.precio"/></td>
                                                <td><s:property value="cantidad"/></td>
                                                <td>
                                                    <s:form action="crearReclamacion" cssClass="formReclamacion" theme="simple">
                                                        <s:textfield name="idProducto" value="%{productos.idProducto}" hidden="true"/>
                                                        <s:textfield name="idCompra" value="%{idCompra}" hidden="true"/>
                                                        <s:if test="#reclamado!=null">
                                                            <s:textfield type="button" cssClass="btn btn-danger reclamar" value="Reclamar" disabled="true"/>
                                                        </s:if>
                                                        <s:else>
                                                            <s:textfield type="button" cssClass="btn btn-danger reclamar" value="Reclamar"/>  
                                                        </s:else>
                                                    </s:form>
                                                </td>
                                            </tr>
                                        </s:iterator>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </main>
            <!-- /.container -->
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>
