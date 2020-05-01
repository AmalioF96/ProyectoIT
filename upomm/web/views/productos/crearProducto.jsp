<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:if test="%{#parameters.idProducto!=null && producto==null}">
    <s:action name="seleccionarProducto" executeResult="true">
        <s:param name="origin" value="'crearProducto'" />
        <s:param name="idProducto" value="#parameters.idProducto" />
    </s:action>
</s:if>
<s:elseif test="categorias==null">
    <s:action name="listarCategorias" executeResult="true">
        <s:param name="origin" value="'crearProducto'" />
    </s:action>
</s:elseif>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Crear Producto - UMM</title>
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/crearProducto.css" rel="stylesheet" type="text/css"/>
            <script>
                $(document).ready(function () {
                    $('#add_field').click(function (e) {
                        e.preventDefault(); //prevenir nuevos clicks

                        $('#caracteristicas').append(
                                "<div class='form-row'>\n\
                                <div class='col-md-5 mb-3'>\
                                    <input type='text' class='form-control' name='nombreCaracteristica'>\
                                </div>\
                                <div class='col-md-5 mb-3'>\
                                    <input type='text' class='form-control' name='descripcionCaracteristica'>\
                                </div>\n\
                                <div class='col-md-1 mb-3'><a href='#' class='remover_campo'><i class='fas fa-window-close'></i></a></div>\n\
                            </div>");
                    });
                    // Remover o div anterior
                    $('#caracteristicas').on("click", ".remover_campo", function (e) {
                        e.preventDefault();
                        $(this).parent('div').parent('div').remove();

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
                            <h4 class="text-center">Menú de Vendedor</h4>
                            <ul class="list-unstyled">
                                <li
                                    <a href="/upomm/views/ventas/menuVentas.jsp" class="list-group-item">Mis Ventas</a>
                                </li>
                                <li>
                                    <a href="/upomm/views/productos/misProductos.jsp" class="list-group-item">Mis Productos</a>
                                </li>
                                <li>
                                    <a href="/upomm/views/productos/crearProducto.jsp" class="list-group-item active">Crear/Editar Producto</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-1"></div>
                    <div class="col-lg-7">
                        <s:if test="%{producto!=null}">
                            <s:set var="accion" value="'modificarProducto'"/>
                        </s:if>
                        <s:else>
                            <s:set var="accion" value="'crearProducto'"/>
                        </s:else>
                        <s:form id="formProducto" action="%{#accion}" method="post" enctype="multipart/form-data" theme="css_xhtml">   
                            <div class="form-group">
                                <label for="producto">Nombre del producto:</label>
                                <s:textfield name="nombre" cssClass="form-control" value="%{producto.nombre}"/>
                                <label for="descripcion">Descripción:</label>
                                <s:textarea name="descripcion" cssClass="form-control" value="%{producto.descripcion}"/>
                            </div>
                            <div id="miSelect" class="form-row">
                                <label>Categorias:</label>
                                <select id="select" name="categorias" class="form-control" multiple="true">
                                    <s:iterator value="categorias" var="i">
                                        <s:set value="false" var="asignada"/>
                                        <s:iterator value="producto.categoriasProductoses">
                                            <s:if test="%{#i.nombre==id.nombre}">
                                                <s:set value="true" var="asignada"/>
                                            </s:if>
                                        </s:iterator>
                                        <s:if test="%{#asignada==true}">
                                            <option selected="true" value="<s:property value="nombre"/>">
                                            </s:if>
                                            <s:else>
                                            <option value="<s:property value="nombre"/>">
                                            </s:else>
                                            <s:property value="nombre"/>
                                        </option>
                                    </s:iterator>
                                </select>
                                <%--<s:select id="select" name="categorias" headerValue="Categorias" list="categorias" listKey="nombre" listValue="nombre" multiple="true" cssClass="form-control" tabindex="-1" theme="simple"/--%>
                            </div>
                            <br/>
                            <div class="form-group">
                                <label>Añade una imagen:</label>
                                <br/>
                                <s:if test="%{producto!=null && producto.imagen!=''}">
                                    <img src="<s:property value="%{producto.imagen}"/>" alt="Imagen producto"/>
                                </s:if>
                                <s:file name="imagen" accept="image/jpeg, image/png" cssClass="form-control form-control-file"/>
                            </div>
                            <div class="form-group">
                                <label>Precio:</label>
                                <s:textfield name="precio" cssClass="form-control" value="%{producto.precio}"/>
                            </div>
                            <br/>
                            <div id="caracteristicas">
                                <button type="button" id="add_field" class="btn btn-sm btn-outline-primary">Agregar</button>
                                <div class="form-row mt-2">
                                    <div class="col-md-5 mb-0">
                                        <label>Característica:</label>
                                    </div>
                                    <div class="col-md-5 mb-0">
                                        <label>Descripción Característica:</label>
                                    </div>
                                </div>
                                <s:if test="producto!=null">
                                    <s:iterator value="producto.caracteristicasProductoses">
                                        <div class="form-row">
                                            <div class="col-md-5 mb-3">
                                                <s:textfield name="nombreCaracteristica" cssClass="form-control" value="%{id.nombre}"/>

                                            </div>
                                            <div class="col-md-5 mb-3">
                                                <s:textfield name="descripcionCaracteristica" cssClass="form-control" value="%{valor}"/>
                                            </div>
                                            <div class='col-md-1 mb-3'>
                                                <a href='#' class='remover_campo'>
                                                    <i class='fas fa-window-close'></i></a>
                                            </div>
                                        </div>
                                    </s:iterator>
                                </s:if>
                                <s:else>
                                    <div class="form-row mt-2">
                                        <div class="col-md-5 mb-3">
                                            <s:textfield name="nombreCaracteristica" cssClass="form-control"/>
                                        </div>
                                        <div class="col-md-5 mb-3">
                                            <s:textfield name="descripcionCaracteristica" cssClass="form-control"/>
                                        </div>
                                    </div>
                                </s:else>
                            </div>
                            <label>Archivo a la venta:</label>
                            <br/>
                            <s:file name="archivoVenta" accept="image/jpeg, image/png" cssClass="form-control form-control-file"/>
                            <br/>
                            <s:if test="%{producto!=null}">
                                <div class="custom-control custom-switch">
                                    <s:textfield id="disponible" type="checkbox" name="disponible" cssClass="custom-control-input" checked="%{producto.disponible}" theme="simple"/>
                                    <label class="custom-control-label" for="disponible">Disponible a la venta</label>
                                </div>
                            </s:if>
                            <s:else>
                                <div class="custom-control custom-switch">
                                    <s:textfield id="disponible" type="checkbox" name="disponible" cssClass="custom-control-input" theme="simple"/>
                                    <label class="custom-control-label" for="disponible">Disponible a la venta</label>
                                </div>     
                            </s:else>
                            <br/>
                            <br/>
                            <div class="custom-control custom-switch">
                                <s:textfield id="terminos" type="checkbox" name="terminos" cssClass="custom-control-input" theme="simple"/>
                                <label class="custom-control-label" for="terminos">
                                    <a href="http://www.google.com/search?q=estafa" target="_blank">Acepto los términos y condiciones</a>
                                </label>
                            </div>
                            <br/>
                            <s:if test="%{producto!=null}">
                                <s:submit name="btnCrearProducto" value="Modificar" cssClass="btn btn-warning"></s:submit>
                            </s:if>
                            <s:else>
                                <s:submit name="btnCrearProducto" value="Crear" cssClass="btn btn-primary"></s:submit>
                            </s:else>
                        </s:form>

                    </div>
                </div>
            </main>
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>