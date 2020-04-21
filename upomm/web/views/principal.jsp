<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>UMM-Principal</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="/upomm/css/header.css" rel="stylesheet" type="text/css"/>
        <link href="/upomm/css/footer.css" rel="stylesheet" type="text/css"/>
        <link href="/upomm/css/principal.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js" integrity="sha384-6khuMg9gaYr5AxOqhkVIODVIvm9ynTT5J4V1cfthmT+emCG6yVmEZsRHdxlotUnm" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    </head>
    <body>
        <s:if test="categorias==null">
            <s:action executeResult="true" name="listarCategorias"/>
        </s:if>
        <s:if test="productos==null">
           <s:action executeResult="true" name="listarProductos"/> 
        </s:if>
        <s:else>
            <%@include file="utils/header.jsp" %>
            <main class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <nav id='categorias' class="list-group">
                            <h4 class="text-center">Categorías</h4>
                            <ul class="list-unstyled">
                                <s:iterator value="categorias">
                                    <li class="list-group-item"><a class="categoria" href=""><s:property value="nombre"/></a></li>
                                    </s:iterator>
                            </ul>
                        </nav>
                    </div>


                    <div class="col-lg-9">
                        <div class="row">
                            
                        </div>
                    </div>
                </div>
            </main>
            <%@include file="utils/footer.html" %>
        </s:else>
    </body>
</html>
