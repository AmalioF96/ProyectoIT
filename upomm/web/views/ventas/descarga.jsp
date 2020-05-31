<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:else>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Descarga - UPOMediaMarket</title>
            <%@include file="/views/utils/includes.jsp"%>
            <script>
                $(document).ready(function () {
                    $('#modalDescarga').modal({
                        show: true,
                        backdrop: 'static',
                        keyboard: false
                    });
                    var a = document.createElement('a');
                    a.download = "<s:property value="recurso"/>";
                    a.href = "<s:property value="recurso"/>";
                    document.body.appendChild(a);
                    a.click();
                    window.setTimeout(function () {
                        window.close();
                    }, 2000);
                });
            </script>
        </head>
        <body>
            <!-- Modal -->
            <div class="modal" id="modalDescarga"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered cascading-modal" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Preparando tu descarga..</h5>
                        </div>
                        <div class="modal-body m-2">
                            <div class="spinner-border text-primary mx-auto d-block"></div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
    </html>
</s:else>
