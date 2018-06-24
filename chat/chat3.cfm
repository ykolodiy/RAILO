<cfset requestBody = toString( getHttpRequestData().content ) & "<br>" />
<cffile action = "append" file = "log.html" attributes = normal output = "#requestBody#">