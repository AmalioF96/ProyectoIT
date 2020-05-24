<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:if test="#session.usuario==null || #session.usuario.tipo!='admin'">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="categorias==null">
    <s:action executeResult="true" name="listarCategorias">
        <s:param name="origin" value="'crearCategoria'" />
    </s:action>
</s:elseif>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Gestionar Categorías - UPOMediaMarket</title>
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/misProductos.css" rel="stylesheet">

            <script>
                $(document).ready(function () {
                });
            </script>
            <s:head />
        </head>
        <body>
            <%@include file="../utils/header.jsp" %>
            <main class="container-fluid mt-4">
                <div class="row">
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Menú de Administrador</h4>
                            <ul class="list-unstyled">
                                <li class="list-group-item">
                                    <a href="/upomm/views/reclamaciones/disputasAdmin.jsp" class="menu-link">Disputas Abiertas</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/reclamaciones/resueltasAdmin.jsp" class="menu-link">Disputas Resueltas</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/productos/crearCategoria.jsp" class="menu-link active">Gestionar Categorías</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <!-- /.col-lg-3 -->
                    <div class="col-md-4 table-responsive-sm border-left my-auto mx-auto">
                        <h5 class="text-center mb-4" style="text-decoration: underline">Crear</h5>
                        <s:form action="crearCategoria" theme="css_xhtml" autocomplete="off">
                            <s:textfield name="nuevaCategoria" cssClass="form-control mb-4" placeholder="Introduce el nombre de la categoría"/>
                            <s:textfield name='operacion' value='crear' hidden="true"/>
                            <s:submit cssClass='btn btn-primary float-left' value='Crear'/>
                        </s:form>
                    </div>
                    <!-- /.col-lg-4 -->
                    <div class="col-md-4 table-responsive-sm border-left border-right my-auto mx-auto">
                        <h5 class="text-center mb-4" style="text-decoration: underline">Eliminar</h5>
                        <s:form action="eliminarCategoria" theme="css_xhtml" autocomplete="off">
                            <div id="miSelect" class="form-group mb-4">
                                <s:select name="categoria" list="categorias" listKey="nombre" listValue="nombre" cssClass="form-control custom-select" headerValue="--- Selecciona una categoría ---" headerKey=""/>
                            </div>
                            <s:textfield name='operacion' value='eliminar' hidden="true"/>
                            <s:submit cssClass='btn btn-danger float-left' value='Eliminar'/>
                        </s:form>
                    </div>
                    <!-- /.col-lg-4 -->
                </div>
                <s:if test="hasActionMessages()">
                    <s:actionmessage cssClass="alert alert-info list-unstyled"/>
                </s:if>
            </main>
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>