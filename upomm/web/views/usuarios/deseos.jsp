<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <title>Carrito XXX - UPOMarket</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>

            <script>

            </script>
        </head>
        <body>
            <%@include file="../utils/header.jsp" %>

            <!-- Page Content -->
            <main class="container">

                <div class="divCarrito">

                    <h3>Mis deseos</h3>
                    <hr>
                    <s:if test="deseos==#session.usuario.getProductoses_1()">
                        <div class='alert alert-success'>Aún no has añadido ningún producto a tu lista de deseos está vacío.</div>
                    </s:if>
                    <s:elseif test="#session.usuario.getProductoses_1().size()<1">
                        <div class='alert alert-success'>Aún no has añadido ningún producto a tu lista de deseos está vacío.</div>
                    </s:elseif>
                    <s:else>

                        <div class='table-responsive-sm'>
                            <table class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th>Descripción</th>
                                        <th>Precio</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="#session.usuario.getProductoses_1()" var="producto">
                                        <s:url var="idProductoUrl" value="/views/productos/producto.jsp">
                                            <s:param name="idProducto" value="productos.idProducto"/>
                                        </s:url>
                                        <tr>
                                            <td>
                                                <s:a href = "%{idProductoUrl}">
                                                    <s:property value="nombre"/>
                                                </s:a>
                                            </td>
                                            <td><s:property value="descripcion"/></td>
                                            <td><s:property value="precio"/></td>
                                            <td>
                                                <s:if test="%{!#session.carrito.contains(#producto)}">
                                                    <s:form action="agregarCarrito" theme="simple">
                                                        <s:textfield name="idProducto" value="%{#producto.idProducto}" hidden="true"/>
                                                        <s:submit cssClass="btn btn-success" name="btnAgregarCarrito" value="Agregar al carrito" />
                                                    </s:form>
                                                </s:if>
                                                <s:else>
                                                    <s:form action="eliminarCarrito" theme="simple">
                                                        <s:textfield name="idProducto" value="%{#producto.idProducto}" hidden="true"/>
                                                        <s:submit cssClass="btn btn-warning" name="btnEliminarCarrito" value="Eliminar del carrito" />
                                                    </s:form>
                                                </s:else>
                                                <s:form action="eliminarDeseo" theme="simple">
                                                    <s:textfield name="idProducto" value="%{#producto.idProducto}" hidden="true"/>
                                                    <s:submit cssClass="btn btn-danger" name="btnEliminarCarrito" value="Eliminar de la lista" />
                                                </s:form>
                                            </td>
                                        </tr>
                                    </s:iterator>
                                </tbody>
                            </table>
                        </div>
                        <hr>


                    </s:else>
                </div>
            </main>
            <!-- /.container -->
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>