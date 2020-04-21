<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<!DOCTYPE html>
<%--<s:if test="%{producto==null}">
    <s:/>
</s:if>
<s:else>--%><
<html>
    <head>
        <title>Producto XXX - UPOMarket</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="/upomm/css/login.css" rel="stylesheet" type="text/css"/>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="icon" type="image/png" href="/upomm/imagenes/icono.png">


        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="/upomm/css/header.css" rel="stylesheet">
        <link href="/upomm/css/footer.css" rel="stylesheet">
        <link href="/upomm/css/producto.css" rel="stylesheet" type="text/css"/>

        <script src="https://kit.fontawesome.com/a076d05399.js"></script><!-- Para que se vean los logos -->
        <script>
            $(document).ready(function () {
            animaEstrellas();
            obtenerValoracion();
            var puntuacion = parseFloat(<?php echo number_format($puntuacion, 2) ?>);
        var k =                0;
        for (k = 0; k < puntuacion; k++) {
                    var text = $("#productRating").text();
            if (k < puntuacion && k + 1 > puntuacion)
                    $("#productRating").append($("<i class='fas fa-star-half-alt'></i>"));
            else
                    $("#productRating").append($("<i class='fas fa-star'><                /i>"));
        }
        for (var j = k; j < 5; j++) {
                    $("#productRating").append($("<i class='far fa                -star'></i                >"));
        }
        $("#btnEliminar").click(function () {
                    var idProducto = $("<input name='idProducto' type='number' hidden>");
            $(idProducto).val(<?php echo $                _GET["idProducto"] ?>);
        $("#formEliminarValor                acion").append(idProducto);
        $("#elimin                arSubmit").c                lick();
            });
            });
            /*
            * Obt            enemos la                      valoración actual de un producto
            */
            function obtenerValor            acion() {
                    $("#formValoracionProducto").submit(function () {
            var estrellas = $("#formValoracionProducto .fa-star");
            var cont = 0;
            for (var i = 0; i < estrellas.length; i++) {
            if ($(estrellas                [i]).hasClass("checked                ")) {
            cont                ++;
                    }
                    }
        $("#                puntuaci            on").val(cont);
                    if (cont > 0) {
                    return true;
                    } else {
                    alert("Debe puntuar el producto");
            retu            rn false;
                    }
                    
            });
            }
            /*            Animación de            la valoració                n*/
        function animaEstrellas(                    ) {
                    $(".fa-s            tar").click(functi            on () {
            var id = $(this).attr('id');
            var puntuacion = parseInt(id.substring(id.length - 1, id.length));
            var estrellas = $(".review");
            for (var i = 0; i < estrellas.length; i++) {
            if (i < puntuacion) {
            $(estrellas[i]).addClass("checked");
            $(estrellas[i]).removeClass("unchecked");
            } else {
                    $(estrellas[i]).removeClass("checked");
            $(estrellas[i]).addClass("unchecked");
            }
            }
            });
                    }
                    /*            Controlar la e            dici                    ón de la valor            ación*/
                    func            tion mostrarEditab            le() {
                    $("#miValorac            ion").hide();
            var desc            ripcion = $("#miValoracion p").text();
            var puntuacion = $("#miValoracion span").text().l            ength;
            var form = $("<form id='formValoracionProducto' method='get'></form>");
            var text = $("<textarea class='form-control' name='valoracion'></textarea>");
            $(text).css("width", "100%");
            $(text).val(descripcion);
            $(form).append(text);
            for (var i = 1; i <= 5; i++) {
            var valora = $("<span class='review fa fa-star unchecked'></span>");
            $(valora).attr("id", "puntuacion-" + i);
            $(form).append(valora);
            }
            var btn = $("<input type='submit' class='btn btn-sm btn-success' value='Guarda            r' name='editarVal            oracion'>");
            $(btn).css("margin", "10px 10px 10px 0");
                    $(form).append        ($("<br>"));        
                    $(form).appe            nd(btn)          ;
                    btn = $("<bu        tto        n type='bu        tton' class='btn btn-sm           btn-warning'>Canc        elar        </button>");
            $(form).append(btn);
            $(form).        append($("<input id='puntuacion' type=             'number' nam        e        ='puntuacion' hid        den>"          ));
            var idP        roducto = $("<input na        me='idProducto' type='number' hidden>");
            $(        idProducto).        val(<?php echo $_GET        ["idProducto"] ?>)        ;
            $(form).append(idP        rodu        cto);
            $("#miValoracion")        .after(form);
            animaEst        rell        as();
            obtenerValoracion(        );
            $(btn).click(function () {
                    $("#formValo        racionProduc        to        ").remove();
            $("#m         iValoracion").show();
            });
            }
            </s        cript>
            
            <script src="https://code.jquery.com/jqu        ery-3.4.1.min.js" integrity="sha25        6-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo        =" crossorigin="anonymous"></script>
            <s:head/>
            <s:if test="#session.usuario!=null">
                <jsp:forward page="/views/principal.jsp"/>
            </s:if>
            </head>

            <body>
                <?php
                $categorias = listarCategorias();
                include './header.php';
                ?>
                <!-- Page Content -->
                <main class="container">
                    <div class="row">

                        <!-- LISTA DE CATEGORÍAS -->
                        <div class="col-lg-3">
                            <img id="logo_main" class="img-fluid" src="../img/upomarket.png" alt="upomarket">
                            <nav id='categorias' class="list-group">
                                <ul class="list-unstyled">
                                    <h4 class="text-center">Categorías</h4>
                                    <ul>
                                        <s:iterator var="i" value="producto.categoriasProductoses" step="1">

                                            <li><s:property value="nombre" /></li>

                                        </s:iterator>

                                        <li><a href="./categoria.php?categoria=' . $c[0] . '" class="list-group-item">' . $c[0] . '</a></li>';


                                    </ul>
                            </nav>
                        </div>
                        <!-- /.col-lg-3 -->
                        <div class="col-lg-9">
                            <%--<?php
                            include './barraBusqueda.php';
                            ?>--%>
                            <div class="card mt-4">
                                <img id='imgProducto' class="card-img-top img-fluid" src='<?php echo $img ?>' alt="">
                                <div class="card-body">
                                    <h3 class="card-title"><s:property value="producto.nombre" /></h3>
                                    <h4><s:property value="producto.precio" />€</h4>
                                    <p class="card-text"><s:property value="producto.descripcion" /></p>
                                    <div id="productRating" class="text-warning"></div>
                                    <%--<?php echo number_format($puntuacion, 1) ?> estrellas--%>
                                    <br />
                                    <br />
                                    <%--<?php
                                    if (isset($_SESSION['carrito']) && !empty($_SESSION['carrito'])) {
                                    $index = -1;
                                    foreach ($_SESSION['carrito'] as $indice => $productoSes) {
                                    if ($productoSes['id'] == $producto['id']) {
                                    $index = $indice;
                                    }
                                    }
                                    if ($index == -1) {
                                    ?>
                                    <form action="./utils/anadirEliminarCarrito.php" method="post">
                                        <input type="hidden" name="id" value="<?php echo encriptar($producto['id']); ?>">
                                        <input type="hidden" name="nombre" value="<?php echo encriptar($producto['nombre']); ?>">
                                        <button class="btn btn-primary" name="btnAgregarCarrito" value="Agregar al carrito" type="submit">Agregar al carrito</button>
                                    </form>
                                    <?php
                                    } else {
                                    ?>--%>
                                    <form action="./utils/anadirEliminarCarrito.php" method="post">
                                        <input type="hidden" name="id" value="<?php echo encriptar($producto['id']); ?>">
                                        <button class="btn btn-primary" name="btnEliminarCarritoProducto" value="Eliminar del carrito" type="submit">Eliminar del carrito</button>
                                    </form>
                                    <%--<?php
                                    }
                                    } else if (isset($_SESSION["email"])) {
                                    ?>
                                    <form action="./utils/anadirEliminarCarrito.php" method="post">
                                        <input type="hidden" name="id" value="<?php echo encriptar($producto['id']); ?>">
                                        <input type="hidden" name="nombre" value="<?php echo encriptar($producto['nombre']); ?>">
                                        <button class="btn btn-primary" name="btnAgregarCarrito" value="Agregar al carrito" type="submit">Agregar al carrito</button>
                                    </form>
                                    <?php
                                    } else {
                                    echo '<div class="alert alert-info">Inicia Sesión para comprar este producto</div>';
                                    }
                                    ?>--%>
                                </div>
                            </div>
                            <!-- /.card caracteristicas -->
                            <div class="card card-outline-secondary my-4">
                                <div class="card-header">
                                    Características
                                </div>
                                <div class="card-body">
                                    <ul class="list-group list-group-flush">
                                        
                                        <s:iterator var="i" value="producto.caracteristicasProductoses" step="1">

                                            <li class="list-group-item"><strong><s:property value="id.nombre" /></strong><s:property value="valor" /></li>'

                                        </s:iterator>
                                        
                                    </ul>
                                </div>
                            </div>
                            <!-- fin /.card caracteristicas-->
                            <!-- /.card Opiniones-->
                            <div class="card card-outline-secondary my-4">
                                <div class="card-header">
                                    Opiniones del producto
                                </div>
                                <div class="card-body">
                                    <?php
                                    if (empty($miValoracion) && empty($valoraciones)) {
                                    echo "<p>Aún no hay opiniones para este producto.</p>";
                                    } else {
                                    if (!empty($miValoracion)) {
                                    echo "<div id=miValoracion>";
                                    echo "<span class='text-warning'>";
                                    $nota = $miValoracion["puntuacion"];
                                    for ($i = 0; $i < $nota; $i++) {
                                    echo "&#9733;";
                                    }
                                    echo "</span>";
                                    if ($miValoracion["email_cliente"] == $_SESSION["email"]) {
                                    echo "<button id='btnEliminar' class='btn btn-sm btn-danger pull-right btn-valoracion'>Eliminar</button>";
                                    echo "<button class='btn btn-sm btn-warning pull-right btn-valoracion' onclick='mostrarEditable()'>Editar</button>";
                                    }
                                    echo "<br>";
                                    echo '<p>' . $miValoracion['descripcion'] . '</p>';
                                    echo '<small>Por: ' . $miValoracion['email_cliente'] . '</small>';
                                    echo "<br>";
                                    echo '<small>Fecha: ' . $miValoracion['fecha'] . '</small>';
                                    echo "</div>";
                                    echo "<hr>";
                                    }
                                    foreach ($valoraciones as $v) {
                                    echo "<div>";
                                    echo "<span class='text-warning'>";
                                    $nota = $v["puntuacion"];
                                    for ($i = 0; $i < $nota; $i++) {
                                    echo "&#9733;";
                                    }
                                    echo "</span>";
                                    echo "<br>";
                                    echo '<p>' . $v['descripcion'] . '</p>';
                                    echo '<small>Por: ' . $v['email_cliente'] . '</small>';
                                    echo "<br>";
                                    echo '<small>Fecha: ' . $v['fecha'] . '</small>';
                                    echo "</div>";
                                    echo "<hr>";
                                    }
                                    }
                                    if (isset($_SESSION["email"]) && empty($miValoracion) && compradoPorMi($_SESSION["email"], $idProducto)) {
                                    mostrarValorar();
                                    }
                                    ?>
                                </div>
                            </div>
                            <!-- fin /.card Opiniones-->
                        </div>
                        <!-- /.col-lg-9 -->
                        <?php }
                        ?>
                    </div>
                </main>
                <!-- /.container -->
                <?php
                include '../html/footer.html';
                ?>
                <form id='formEliminarValoracion' method='GET'>
                    <button id="eliminarSubmit" type="submit" name="eliminarValoracion" hidden></button>
                </form>
            </body>
            </html>
            <%--</s:else>--%>