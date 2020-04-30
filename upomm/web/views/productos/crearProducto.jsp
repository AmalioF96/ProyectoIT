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
            <link href="/upomm/css/carrito.css" rel="stylesheet" type="text/css"/>
            <link href="/upomm/css/header.css" rel="stylesheet" type="text/css"/>
            <link href="/upomm/css/footer.css" rel="stylesheet" type="text/css"/>
            <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
            <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js" integrity="sha384-6khuMg9gaYr5AxOqhkVIODVIvm9ynTT5J4V1cfthmT+emCG6yVmEZsRHdxlotUnm" crossorigin="anonymous"></script>
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
            <script src="https://kit.fontawesome.com/a076d05399.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
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
                <div class="row m-5">
                    <div class="col-lg-2">

                    </div>
                    <div class="col-lg-8">
                        <s:form action="crearProducto" method="post" enctype="multipart/form-data" theme="css_xhtml">
                            <div class="form-group">
                                <label for="producto">Nombre del producto</label>
                                <s:textfield name="nombre" cssClass="form-control" ></s:textfield>
                                    <label for="descripcion">Descripción</label>
                                <s:textfield name="descripcion" cssClass="form-control" ></s:textfield>
                                </div>
                                <div id="miSelect" class="form-row">
                                    <label>Categorias</label>
                                <s:select id="select" name="categorias" headerValue="Categorias" list="categorias" listKey="nombre" listValue="nombre" multiple="true" cssClass="form-control chosen-select" tabindex="-1" />
                            </div>
                            <br/>
                            <div class="form-group">
                                <label>Añade una imagen</label>
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
                                            <label>Característica</label>
                                        <s:textfield name="nombreCaracteristica" cssClass="form-control"></s:textfield>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label>Descripción Característica</label>
                                        <s:textfield name="descripcionCaracteristica" cssClass="form-control"></s:textfield>
                                        </div>
                                    </div>
                                </div>
                                <label>Archivo a la venta</label>
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