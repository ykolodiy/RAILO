<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PDFtoText Example</title>
</head>
<body>
<cfparam name="form.from" 	default="3">
<cfparam name="form.topage" 	default="3">


<cfpdf action    = "getInfo" source = "yura.pdf" name = "PDFInfo" >
<cfset pageCount = "#PDFInfo.TotalPages#" >

<cfoutput>yura: #pageCount# pages</cfoutput>



	<cfset pdf = createObject("component", "pdftotext")>
	<cfset pdfText = pdf.pdftotext('#ExpandPath('./')#yura.pdf',1, #pageCount#)>
	<hr />
	<cfdump var="#pdfText#">

</body>
</html>