<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:if test="#session.usuario==null || #session.usuario.tipo!='vendedor'">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:elseif test="%{#parameters.idProducto!=null && producto==null}">
    <s:action name="seleccionarProducto" executeResult="true">
        <s:param name="origin" value="'crearProducto'" />
        <s:param name="idProducto" value="#parameters.idProducto" />
    </s:action>
</s:elseif>
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
            <title>Gestionar Producto - UPOMediaMarket</title>
            <%@include file="/views/utils/includes.jsp" %>
            <link href="/upomm/css/crearProducto.css" rel="stylesheet" type="text/css"/>
            <link href="/upomm/css/misProductos.css" rel="stylesheet" type="text/css"/>
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
                                    <input type='text' class='form-control' name='nombreCaracteristica' placeholder='Característica'>\
                                </div>\
                                <div class='col-md-5 mb-3'>\
                                    <input type='text' class='form-control' name='descripcionCaracteristica' placeholder='Descripción'>\
                                </div>\n\
                                <div class='col-md-1 mb-3'><a href='#' class='remover_campo btn btn-sm btn-outline-danger'>Eliminar</a></div>\n\
                            </div><hr/>");
                    });
                    // Remover div anterior
                    $('#caracteristicas').on("click", ".remover_campo", function (e) {
                        e.preventDefault();
                        var parent = $(this).parent('div').parent('.form-row');
                        var hr = $(parent).next("hr");
                        $(parent).remove();
                        $(hr).remove();

                    });
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
                            <h4 class="text-center">Menú de Vendedor</h4>
                            <ul class="list-unstyled">
                                <li class="list-group-item">
                                    <a href="/upomm/views/ventas/menuVentas.jsp" class="menu-link">Mis Ventas</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/reclamaciones/reclamacionesVendedor.jsp" class="menu-link">Mis Reclamaciones</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/productos/misProductos.jsp" class="menu-link">Mis Productos</a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/upomm/views/productos/crearProducto.jsp" class="menu-link active">Crear/Editar Producto</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-7 my-auto mx-auto border rounded-lg px-4 py-2">
                        <s:if test="%{producto!=null}">
                            <s:set var="accion" value="'modificarProducto'"/>
                        </s:if>
                        <s:else>
                            <s:set var="accion" value="'crearProducto'"/>
                        </s:else>
                        <s:form id="formProducto" action="%{#accion}" method="POST" enctype="multipart/form-data" theme="css_xhtml">   
                            <div class="form-group">
                                <label for="producto">Nombre del producto:</label>
                                <s:if test="%{producto!=null && nombre==null}">
                                    <s:textfield id="producto" name="nombre" cssClass="form-control" value="%{producto.nombre}"/> 
                                </s:if>
                                <s:else>
                                    <s:textfield id="producto" name="nombre" cssClass="form-control" value="%{nombre}"/>
                                </s:else>
                            </div>
                            <div class="form-group">
                                <label for="descripcion">Descripción:</label>
                                <s:if test="%{producto!=null && descripcion==null}">
                                    <s:textarea id="descripcion" name="descripcion" cssClass="form-control" value="%{producto.descripcion}"/>
                                </s:if>
                                <s:else>
                                    <s:textarea id="descripcion" name="descripcion" cssClass="form-control" value="%{descripcion}"/>
                                </s:else>
                            </div>
                            <div id="miSelect" class="form-group">
                                <label for="select-cat">Categorias:</label>
                                <s:if test="%{producto!=null && categoriasActuales==null}">
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
                                    <img class="img-fluid img-thumbnail rounded mt-2 mb-3 mx-auto d-block" src="<s:property value="%{producto.imagen}"/>" alt="Imagen producto"/>
                                </s:if>
                                <s:file id="imagen" name="imagen" accept="image/jpeg, image/png" cssClass="form-control form-control-file"/>
                            </div>
                            <div class="form-group">
                                <label for="precio">Precio:</label>
                                <s:if test="%{producto!=null && precio==null}">
                                    <s:textfield id="precio" name="precio" cssClass="form-control" value="%{producto.precio}"/>
                                </s:if>
                                <s:else>
                                    <s:textfield id="precio" name="precio" cssClass="form-control" value="%{precio}"/>
                                </s:else>
                            </div>
                            <br/>
                            <div id="caracteristicas">
                                <button type="button" id="add_field" class="btn btn-sm btn-outline-primary">Agregar</button>
                                <div class="form-row mt-2">
                                    <div class="col-md-5 mb-0">
                                        <s:fielderror fieldName="nombreCaracteristica" cssClass="list-unstyled errorMessage"/>
                                        <label>Característica:</label>
                                    </div>
                                    <div class="col-md-5 mb-0">
                                        <s:fielderror fieldName="descripcionCaracteristica" cssClass="list-unstyled errorMessage"/>
                                        <label>Descripción Característica:</label>
                                    </div>
                                </div>
                                <s:if test="%{producto!=null && nombreCaracteristica==null}">
                                    <s:set var="primero" value="true"/>
                                    <s:bean name="modelo.comparators.ComparadorCaracteristicasProductos" var="comparadorCars"/>
                                    <s:sort comparator="#comparadorCars" source="producto.caracteristicasProductoses">
                                        <s:iterator>
                                            <div class="form-row">
                                                <div class="col-md-5 mb-3">
                                                    <s:textfield name="nombreCaracteristica" cssClass="form-control" value="%{id.nombre}" placeholder="Característica" theme="simple"/>

                                                </div>
                                                <div class="col-md-5 mb-3">
                                                    <s:textfield name="descripcionCaracteristica" cssClass="form-control" value="%{valor}" placeholder="Descripción" theme="simple"/>
                                                </div>
                                                <s:if test="%{!#primero}">
                                                    <div class='col-md-1 mb-3'>
                                                        <a href='#' class='remover_campo btn btn-sm btn-outline-danger'>
                                                            Eliminar
                                                        </a>
                                                    </div>
                                                </s:if>
                                                <s:else>
                                                    <s:set var="primero" value="false"/>
                                                </s:else>
                                            </div>
                                            <hr/>
                                        </s:iterator>
                                    </s:sort>
                                </s:if>
                                <s:else>
                                    <s:if test="%{nombreCaracteristica==null || nombreCaracteristica.empty}">
                                        <div class="form-row">
                                            <div class="col-md-5 mb-3">
                                                <s:textfield name="nombreCaracteristica" cssClass="form-control" value="" placeholder="Característica" theme="simple"/>
                                            </div>
                                            <div class="col-md-5 mb-3">
                                                <s:textfield name="descripcionCaracteristica" cssClass="form-control" value="" placeholder="Descripción" theme="simple"/>
                                            </div>
                                        </div>
                                        <hr/>
                                    </s:if>
                                    <s:else>
                                        <s:iterator begin="0" end="%{nombreCaracteristica.size-1}" var="i">
                                            <s:set var="nc" value="%{nombreCaracteristica[#i]}"/>
                                            <s:set var="dc" value="%{descripcionCaracteristica[#i]}"/>
                                            <div class="form-row">
                                                <div class="col-md-5 mb-3">
                                                    <s:textfield name="nombreCaracteristica" cssClass="form-control" value="%{#nc}" placeholder="Característica" theme="simple"/>
                                                </div>
                                                <div class="col-md-5 mb-3">
                                                    <s:textfield name="descripcionCaracteristica" cssClass="form-control" value="%{#dc}" placeholder="Descripción" theme="simple"/>
                                                </div>
                                                <s:if test="%{#i>0}">
                                                    <div class='col-md-1 mb-3'>
                                                        <a href='#' class='remover_campo btn btn-sm btn-outline-danger'>
                                                            Eliminar
                                                        </a>
                                                    </div>
                                                </s:if>
                                            </div>
                                            <hr/>
                                        </s:iterator>
                                    </s:else>
                                </s:else>
                            </div>
                            <div class="form-group">
                                <label for="archivoVenta">Archivo a la venta:</label>
                                <br/>
                                <s:file id="archivoVenta" name="archivoVenta" accept="audio/aac, audio/webm, image/jpeg, image/png,image/gif, text/plain, text/csv, application/msword, application/vnd.ms-excel, application/epub+zip, application/zip, application/x-7z-compressed, application/pdf, application/x-rar-compressed, video/x-msvideo, video/mpeg, video/webm, " cssClass="form-control form-control-file"/>
                            </div>
                            <br/>
                            <div class="form-group">
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
                            </div>
                            <hr/>
                            <br/>
                            <div class="form-group">
                                <s:fielderror fieldName="terminos" cssClass="list-unstyled errorMessage"/>
                                <div class="custom-control custom-switch">
                                    <s:checkbox id="terminos" name="terminos" cssClass="custom-control-input" theme="simple" fieldValue="true"/>
                                    <label class="custom-control-label" for="terminos">
                                        <a href="http://www.google.com/search?q=estafa" target="_blank">
                                            Acepto los términos y condiciones
                                        </a>
                                    </label>
                                </div>
                            </div>
                            <s:if test="%{producto!=null}">
                                <s:hidden name="operacion" value="modificar"/>
                                <s:hidden name="idProducto" value="%{producto.idProducto}"/>
                                <s:submit name="btnCrearProducto" value="Modificar" cssClass=" pull-left btn btn-warning"/>
                            </s:if>
                            <s:else>
                                <s:hidden name="operacion" value="crear"/>
                                <s:submit name="btnCrearProducto" value="Crear" cssClass="pull-left btn btn-primary"/>
                            </s:else>
                        </s:form>

                    </div>
                </div>
            </main>
            <%@include file="../utils/footer.html" %>
        </body>
    </html>
</s:else>