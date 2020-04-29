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
        </head>
        <body>
            <%@include file="../utils/header.jsp" %>
            <!-- Page Content -->
            <main class="container">
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
                        <div class="col-9 contendor">
                            <div class="row">
                                <div class="col">
                                   <strong>Número de pedido:</strong>
                                <s:property value="compra.idCompra"/>
                                </div>
                                <div class="col">
                                   <strong>Fecha:</strong>
                                   <s:date name="compra.fecha" format="dd/MM/yyyy"/>
                                </div>
                            </div>
                                <br/>
                                <h3>Productos comprados</h3>
                                <s:form theme="simple">
                            <table class="table table-striped table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th>Vendedor</th>
                                        <th>Precio</th>
                                        <th>Cantidad</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                            <s:iterator value="compra.lineasDeCompras">
                                <tr>
                                    <td><s:property value="productos.nombre"/></td>
                                    <td><s:property value="productos.usuarios.nombre"/></td>
                                    <td><s:property value="productos.precio"/></td>
                                    <td><s:property value="cantidad"/></td>
                                    <td><s:submit cssClass="btn btn-danger" value="Reclamar"/></td>
                                </tr>
                            </s:iterator>
                            </table>
                                </s:form>
                        </div>
                    </div>
                    <!-- /.row -->
                </main>
                <!-- /.container -->
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>
