<link href="/upomm/css/barraBusqueda.css" rel="stylesheet" type="text/css"/>
<script>
    $(document).ready(function () {
        $("#ordenarResultados select").change(function () {
            $("#ordenarResultados").submit();
        });
        $("body").click(function () {
            $("#livesearch").empty();
        });
    });
    function showResult(str) {
        $("#livesearch").empty();

        if (str.length == 0) {
            return;
        }

        var xmlhttp = new XMLHttpRequest();
        xmlhttp.open("GET", "http://localhost:8080/PruebaREST/webresources/productos.productos/" + str, true);
        xmlhttp.setRequestHeader("Accept", "application/xml");

        xmlhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var rawXML = xmlhttp.responseXML;
                var xmlRow = $(rawXML).find('productos');
                if (xmlRow.length > 0 && str.trim().length>0) {
                    $(xmlRow).each(function () {
                        var nombre = $(this).find('nombre').text();
                        var listElement = document.createElement("li");
                        $(listElement).append(nombre);
                        $(listElement).addClass("list-group-item searchResult");
                        $(listElement).css("opacity", "0.95");
                        $(listElement).on("click",function(){
                           $("#searchBar").val($(this).text());
                           $("#searchForm").submit();
                        });
                        $("#livesearch").append(listElement);
                    });
                } else if ($("#livesearch").children().length==0) {
                    var texto = document.createTextNode("No hay coincidencias");
                    var listElement = document.createElement("li");
                    $(listElement).append(texto);
                    $(listElement).addClass("list-group-item");
                    $(listElement).css("opacity", "0.95");
                    $("#livesearch").append(listElement);
                }
            }
        };
        xmlhttp.send();
    }
</script>
<div class="container-fluid mb-4">
    <div class="row mx-auto">
        <div class="col-xl-9 mt-3 mx-auto">
            <s:form id='searchForm' cssClass="form-inline md-form mr-auto mb-1" action='listarProductos' theme="simple" method="GET" autocomplete="off">
                <s:select cssClass="form-control" name="categoria" list="categorias" listKey="nombre" listValue="nombre" headerKey="" headerValue="Todas las categorías">
                </s:select>
                <div class="input-group">
                    <s:textfield id='searchBar' cssClass="form-control" placeholder="Buscar productos" name='busqueda' onkeyup="showResult(this.value)"/>
                    <div class="input-group-append">
                        <button class="btn btn-secondary" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </s:form>
        </div>
        <div class="col-xl-3 mb-0 mt-3 mx-auto ordenacion">
            <s:form id="ordenarResultados" class="form-inline mr-auto mb-1" method="GET" theme="simple">
                <s:if test="#parameters.categoria!=null">
                    <s:textfield name="categoria" value="%{#parameters.categoria}" hidden="true"/>
                </s:if>
                <s:if test="#parameters.busqueda!=null">
                    <s:textfield name="busqueda" value="%{#parameters.busqueda}" hidden="true"/>
                </s:if>
                <select class="form-control" name="ordenar">
                    <s:if test="%{#ordenar==-1}">
                        <option value="-1" selected>
                    </s:if>
                    <s:else>
                        <option value="-1">
                    </s:else>
                    Ordenar (por defecto)
                    </option>
                    <s:if test="%{#ordenar==0}">
                        <option value="0" selected>
                    </s:if>
                    <s:else>
                        <option value="0">
                    </s:else>
                    Mejor Valorados
                    </option>
                    <s:if test="%{#ordenar==1}">
                        <option value="1" selected>
                    </s:if>
                    <s:else>
                        <option value="1">
                    </s:else>
                    Más Vendidos
                    </option>
                    <s:if test="%{#ordenar==2}">
                        <option value="2" selected>
                    </s:if>
                    <s:else>
                        <option value="2">
                    </s:else>
                    Novedades
                    </option>
                    <s:if test="%{#ordenar==3}">
                        <option value="3" selected>
                    </s:if>
                    <s:else>
                        <option value="3">
                    </s:else>
                    Precio: ascendente
                    </option>
                    <s:if test="%{#ordenar==4}">
                        <option value="4" selected>
                    </s:if>
                    <s:else>
                        <option value="4">
                    </s:else>
                    Precio: descendente
                    </option>
                </select>
            </s:form>
        </div>
    </div>
    <div class="row mt-0">
        <div class="col-xl-3 mt-0">
        </div>
        <div id="searchResult" class="col-xl-5 p-0 mt-0">
            <ul id="livesearch" class="list-unstyled overflow-auto"></ul>
        </div>
    </div>
</div>