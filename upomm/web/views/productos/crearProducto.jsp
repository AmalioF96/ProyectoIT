<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:if test="categorias==null">
    <s:action name="listarCategorias" executeResult="true">
        <s:param name="origin" value="'crearProducto'" />
    </s:action>
</s:if>
<s:else>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Crear Producto - UMM</title>
            <%@include file="/views/utils/includes.jsp" %>
            <script>
                $(document).ready(function () {
                    $('#add_field').click(function (e) {
                        e.preventDefault(); //prevenir nnuevos clicks

                        $('#caracteristicas').append(
                                "<div class='form-row'>\n\
                                <div class='col-md-4 mb-3'>\
                                    <input type='text' class='form-control' name='nombreCaracteristica'>\
                                </div>\
                                <div class='col-md-4 mb-3'>\
                                    <input type='text' class='form-control' name='descripcionCaracteristica'>\
                                </div><a href='#' class='remover_campo'>Remover</a>\n\
                            </div>");
                    });
                    // Remover o div anterior
                    $('#caracteristicas').on("click", ".remover_campo", function (e) {
                        e.preventDefault();
                        $(this).parent('div').remove();

                    });
                });
            </script>
            <s:head />
        </head>
        <body>



            <%@include file="../utils/header.jsp" %>
            <main class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <nav id="categorias" class="list-group make-me-sticky">
                            <h4 class="text-center">Menú de Vendedor</h4>
                            <ul class="list-unstyled">
                                <li><a href="/upomm/views/ventas/menuVentas.jsp" class="list-group-item">Mis Ventas</a></li>
                                <li><a href="/upomm/views/productos/misProductos.jsp" class="list-group-item">Mis Productos</a></li>
                                <li><a href="/upomm/views/productos/crearProducto.jsp" class="list-group-item active">Crear Producto</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-1"></div>
                    <div class="col-lg-7">
                        <s:form action="crearProducto" method="post" enctype="multipart/form-data" theme="css_xhtml">
                            <div class="form-group">
                                <label for="producto">Nombre del producto:</label>
                                <s:textfield name="nombre" cssClass="form-control" ></s:textfield>
                                    <label for="descripcion">Descripción:</label>
                                <s:textfield name="descripcion" cssClass="form-control" ></s:textfield>
                                </div>
                                <div id="miSelect" class="form-row">
                                    <label>Categorias:</label>
                                <s:select id="select" name="categorias" headerValue="Categorias" list="categorias" listKey="nombre" listValue="nombre" multiple="true" cssClass="form-control chosen-select" tabindex="-1" />
                            </div>
                            <br/>
                            <div class="form-group">
                                <label>Añade una imagen:</label>
                                <br/>
                                <s:file name="imagen" accept="image/jpeg, image/png"></s:file>
                                </div>
                                <div class="form-group">
                                    <label>Precio:</label>
                                <s:textfield name="precio" cssClass="form-control"></s:textfield>
                                </div>
                                <br/>
                                <div id="caracteristicas">
                                    <button type="button" id="add_field" class="btn btn-sm btn-outline-primary">Agregar</button>
                                    <div class="form-row">
                                        <div class="col-md-4 mb-3">
                                            <label>Característica:</label>
                                        <s:textfield name="nombreCaracteristica" cssClass="form-control"></s:textfield>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label>Descripción Característica:</label>
                                        <s:textfield name="descripcionCaracteristica" cssClass="form-control"></s:textfield>
                                        </div>
                                    </div>
                                </div>
                                <label>Archivo a la venta:</label>
                                <br/>
                            <s:file name="archivoVenta" accept="image/jpeg, image/png"></s:file>
                                <br/>
                                <br/>
                            <s:checkbox name="terminos"></s:checkbox>
                                <label class="">&nbsp;
                                    <a href="">Acepto los términos y condiciones</a>
                                </label>
                                <br/>
                            <s:submit name="btnCrearProducto" value="Crear" cssClass="btn btn-primary"></s:submit>
                        </s:form>

                    </div>
                </div>
            </main>
            <%@include file="../utils/footer.html" %>



        </body>
    </html>

</s:else>