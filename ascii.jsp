<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Résultat ASCII</title></head>
<body>
    <h1>Résultat</h1>
    <div>
        <%= request.getAttribute("ascii") %>
    </div>
    <a href="hono.html">Retour</a>
</body>
</html>
