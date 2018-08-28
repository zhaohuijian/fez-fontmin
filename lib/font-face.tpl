@font-face {
    font-family: "<%=fontFamily%>";
    src: url("<%=fontPath%><%=fontFile%>.eot"); /* IE9 Compat Modes */
    src: <%if (local) {%>local("<%=local%>"), <%}%><% if (base64) { %>url(<%=base64%>) format("truetype"), /* chrome, firefox, opera, Safari, Android, iOS 4.2+ */<% } else { %>url("<%=fontPath%><%=fontFile%>.woff2") format("woff2"), /* Modern Browsers */
    url("<%=fontPath%><%=fontFile%>.woff") format("woff"), /* chrome, firefox */
    url("<%=fontPath%><%=fontFile%>.ttf") format("truetype"); /* chrome, firefox, opera, Safari, Android, iOS 4.2+ */<% } %>
    font-style: normal;
    font-weight: normal;
}

<% if (glyph) { %>
[class^="<%=iconPrefix%>-"],
[class*=" <%=iconPrefix%>-"]:after {
    font-family: "<%=fontFamily%>";
    speak: none;
    font-style: normal;
    font-weight: normal;
    font-variant: normal;
    text-transform: none;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}

<% _.each(glyfList, function(glyf) { %>
.<%=iconPrefix%>-<%=glyf.name%>:before {
    content: "<%=glyf.codeName%>";
}
<% }); %>
<% }; %>
