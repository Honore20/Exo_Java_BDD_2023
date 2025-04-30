<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>ASCII Art</title>
</head>
<body bgcolor="white">
<h1>Générateur ASCII Art</h1>

<form method="post" action="ascii">
    <p>Saisir un texte : <input type="text" name="chaine" />
    <input type="submit" value="Générer">
</form>

<%
    String originalText = (String) request.getAttribute("originalText");
    StringBuilder[] asciiLines = (StringBuilder[]) request.getAttribute("asciiResult");

    if (asciiLines != null) {
%>
    <h2>Résultat pour : <%= originalText %></h2>
    <pre>
<% for (StringBuilder line : asciiLines) { %>
<%= line.toString() %>
<% } %>
    </pre>
<% } %>

</body>
</html>
