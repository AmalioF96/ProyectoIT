<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="/upomm/views/principal.jsp"><img height="40" src="/upomm/imagenes/UPOMediaMarket.jpg" alt="upomediamarket_nav"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span id="tooglerMovil" class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <s:if test="#session.usuario==null">
                    <li class="nav-item">
                        <a class="nav-link" href="/upomm/views/usuarios/login.jsp">Iniciar Sesi�n</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/upomm/views/usuarios/signUp.jsp">Registrarse</a>
                    </li>
                </s:if>
                <s:elseif test="#session.usuario.tipo=='admin'">
                    <li class="nav-item">
                        <a class="nav-link" href="/upomm/views/reclamaciones/disputasAdmin.jsp">Admin</a>
                    </li>
                    <li id="profile" class="nav-item">
                        <a class="nav-link" href="/upomm/views/usuarios/perfil.jsp"><i class="fas fa-user"></i>
                            <s:property value="#session.usuario.nombre"/>
                        </a>
                    </li>
                    <li class="nav-item">
                    <s:a action="accionLogout" cssClass="nav-link">
                        Cerrar Sesi�n
                    </s:a>
                    </li>
                </s:elseif>
                <s:elseif test="#session.usuario.tipo=='cliente'">
                    <li class="nav-item">
                        <a class="nav-link" href="/upomm/views/ventas/misCompras.jsp">Compras</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/upomm/views/ventas/carrito.jsp"><i class="fa fa-shopping-cart"></i> Cesta (<s:property value="#session.carrito.size"/>)</a>
                    </li>
                    <li id="profile" class="nav-item">
                        <a class="nav-link" href="/upomm/views/usuarios/perfil.jsp"><i class="fas fa-user"></i>
                            <s:property value="#session.usuario.nombre"/>
                        </a>
                    </li>
                    <li class="nav-item">
                    <s:a action="accionLogout" cssClass="nav-link">
                        Cerrar Sesi�n
                    </s:a>
                    </li>
                </s:elseif>
                <s:elseif test="#session.usuario.tipo=='vendedor'">
                    <li class="nav-item">
                        <a class="nav-link" href="/upomm/views/ventas/misCompras.jsp">Compras</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/upomm/views/ventas/menuVentas.jsp">Ventas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/upomm/views/ventas/carrito.jsp"><i class="fa fa-shopping-cart"></i> Cesta (<s:property value="#session.carrito.size"/>)</a>
                    </li>
                    <li id="profile" class="nav-item">
                        <a class="nav-link" href="/upomm/views/usuarios/perfil.jsp"><i class="fas fa-user"></i>
                            <s:property value="#session.usuario.nombre"/>
                        </a>
                    </li>
                    <li class="nav-item">
                    <s:a action="accionLogout" cssClass="nav-link">
                        Cerrar Sesi�n
                    </s:a>
                    </li>
                </s:elseif>
            </ul>
        </div>
    </div>
</nav>
