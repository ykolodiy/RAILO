<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PDFtoText Example</title>
</head>
<body>
<cfparam name="form.from" 	default="3">
<cfparam name="form.topage" 	default="3">

<form action="index.cfm" method="post">
<a href="sample.pdf">PDF</a>
Show Text from Page 
<select name="from">
<cfloop from="0" to="18" index="i">
<option <cfif form.from eq i>selected="selected"</cfif>><cfoutput>#i#</cfoutput></option>
</cfloop>
</select> to 
<select name="topage">
<cfloop from="0" to="18" index="i">
<option <cfif form.topage eq i>selected="selected"</cfif>><cfoutput>#i#</cfoutput></option>
</cfloop>
</select>
<input type="submit" name="Show" value="Show" />
</form>

<cfif IsDefined('form.Show')>
	<cfset pdf = createObject("component", "pdftotext")>
	<cfset pdfText = pdf.pdftotext('#ExpandPath('./')#sample.pdf',val(form.from),val(form.topage))>
	<hr />
	<cfdump var="#pdfText#">
</cfif>
</body>
</html>