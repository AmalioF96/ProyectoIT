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
            <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" type="text/css"/>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
            <script>
                $(document).ready(function () {
                    $(".chosen-select").chosen();
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
                                <s:textfield id="producto" name="nombre" cssClass="form-control" value="%{producto.nombre}"/>
                                <label for="descripcion">Descripción:</label>
                                <s:textarea id="descripcion" name="descripcion" cssClass="form-control" value="%{producto.descripcion}"/>
                            </div>
                            <div id="miSelect" class="form-group">
                                <label for="select-cat">Categorias:</label>
                                <s:if test="%{producto!=null}">
                                    <s:set var="asignadas" value="%{producto.getCategoriasProducto().{nombre}}"/>
                                </s:if>
                                <s:else>
                                    <s:set var="asignadas" value="%{categoriasActuales.{nombre}}"/>
                                </s:else>
                                <s:select id="select-cat" name="categoriasProducto" headerValue="Categorias" list="categorias" listKey="nombre" listValue="nombre" multiple="true" value="%{#asignadas}" cssClass="form-control chosen-select" data-placeholder="Selecciona una o varias"/>
                            </div>
                            <br/>
                            <div class="form-group">
                                <label for="imagen">Añade una imagen:</label>
                                <br/>
                                <s:if test="%{producto!=null && producto.imagen!=''}">
                                    <img src="<s:property value="%{producto.imagen}"/>" alt="Imagen producto"/>
                                </s:if>
                                <s:file id="imagen" name="imagen" accept="image/jpeg, image/png" cssClass="form-control form-control-file"/>
                            </div>
                            <div class="form-group">
                                <label for="precio">Precio:</label>
                                <s:textfield id="precio" name="precio" cssClass="form-control" value="%{producto.precio}"/>
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
                                    <s:set var="primero" value="true"/>
                                    <s:iterator value="producto.caracteristicasProductoses">
                                        <div class="form-row">
                                            <div class="col-md-5 mb-3">
                                                <s:textfield name="nombreCaracteristica" cssClass="form-control" value="%{id.nombre}" errorPosition="bottom"/>

                                            </div>
                                            <div class="col-md-5 mb-3">
                                                <s:textfield name="descripcionCaracteristica" cssClass="form-control" value="%{valor}" errorPosition="bottom"/>
                                            </div>
                                            <s:if test="%{!#primero}">
                                                <div class='col-md-1 mb-3'>
                                                    <a href='#' class='remover_campo'>
                                                        <i class='fas fa-window-close'></i>
                                                    </a>
                                                </div>
                                            </s:if>
                                            <s:else>
                                                <s:set var="primero" value="false"/>
                                            </s:else>
                                        </div>
                                    </s:iterator>
                                </s:if>
                                <s:else>
                                    <s:if test="%{nombreCaracteristica==null || nombreCaracteristica.empty}">
                                        <div class="form-row">
                                            <div class="col-md-5 mb-3">
                                                <s:textfield name="nombreCaracteristica" cssClass="form-control" value="" errorPosition="bottom"/>
                                            </div>
                                            <div class="col-md-5 mb-3">
                                                <s:textfield name="descripcionCaracteristica" cssClass="form-control" value="" errorPosition="bottom"/>
                                            </div>
                                        </div>
                                    </s:if>
                                    <s:else>
                                        <s:iterator begin="0" end="%{nombreCaracteristica.size-1}" var="i">
                                            <s:set var="nc" value="%{nombreCaracteristica[#i]}"/>
                                            <s:set var="dc" value="%{descripcionCaracteristica[#i]}"/>
                                            <div class="form-row">
                                                <div class="col-md-5 mb-3">
                                                    <s:textfield name="nombreCaracteristica" cssClass="form-control" value="%{#nc}" errorPosition="bottom"/>
                                                </div>
                                                <div class="col-md-5 mb-3">
                                                    <s:textfield name="descripcionCaracteristica" cssClass="form-control" value="%{#dc}" errorPosition="bottom"/>
                                                </div>
                                                <s:if test="%{#i>0}">
                                                    <div class='col-md-1 mb-3'>
                                                        <a href='#' class='remover_campo'>
                                                            <i class='fas fa-window-close'></i>
                                                        </a>
                                                    </div>
                                                </s:if>
                                            </div>
                                        </s:iterator>
                                    </s:else>
                                </s:else>
                            </div>
                            <label for="archivoVenta">Archivo a la venta:</label>
                            <br/>
                            <s:file id="archivoVenta" name="archivoVenta" accept="image/jpeg, image/png" cssClass="form-control form-control-file"/>
                            <br/>
                            <br/>
                            <s:if test="%{producto.disponible}">
                                <div class="custom-control custom-switch">
                                    <s:checkbox id="disponible" name="disponible" cssClass="custom-control-input" theme="simple" fieldValue="true" checked="true"/>
                                    <label class="custom-control-label" for="disponible">Disponible a la venta</label>
                                </div>
                            </s:if>
                            <s:else>
                                <div class="custom-control custom-switch">
                                    <s:checkbox id="disponible" name="disponible" cssClass="custom-control-input" theme="simple" fieldValue="true"/>
                                    <label class="custom-control-label" for="disponible">Disponible a la venta</label>
                                </div>     
                            </s:else>
                            <br/>
                            <s:if test="%{#request.errorTerminos}">
                                <div class="errorMessage" errorfor="terminos">Debe aceptar los términos y condiciones</div>
                            </s:if>
                            <div class="custom-control custom-switch">
                                <s:checkbox id="terminos" name="terminos" cssClass="custom-control-input" theme="simple" fieldValue="true"/>
                                <label class="custom-control-label" for="terminos">
                                    <a href="http://www.google.com/search?q=estafa" target="_blank">Acepto los términos y condiciones</a>
                                </label>
                            </div>
                            <br/>
                            <s:if test="%{producto!=null}">
                                <s:hidden name="operacion" value="modificar"/>
                                <s:hidden name="idProducto" value="%{producto.idProducto}"/>
                                <s:submit name="btnCrearProducto" value="Modificar" cssClass="btn btn-warning"/>
                            </s:if>
                            <s:else>
                                <s:hidden name="operacion" value="crear"/>
                                <s:submit name="btnCrearProducto" value="Crear" cssClass="btn btn-primary"/>
                            </s:else>
                        </s:form>

                    </div>
                </div>
            </main>
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>