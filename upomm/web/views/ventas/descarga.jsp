<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags" %>
<s:if test="#session.usuario==null">
    <jsp:forward page="/views/principal.jsp"/>
</s:if>
<s:else>
    <html>
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>JSP Page</title>
            <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
            <script>
                $(document).ready(function () {
                    var a = document.createElement('a');
                    a.download = "<s:property value="recurso"/>";
                    a.href = "<s:property value="recurso"/>";
                    document.body.appendChild(a);
                    a.click();
                    window.onblur = function () {
                        window.close();
                    };
                });
            </script>
        </head>
        <body>
        </body>
    </html>
</s:else>
