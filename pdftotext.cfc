<cfcomponent>
	<cffunction name="pdftotext" access="public" returntype="string">
		<cfargument name="file" 		type="string" required="yes">
        <cfargument name="StartPage" 	type="string" default="">
        <cfargument name="EndPage" 		type="string" default="">
		<cfargument name="loaderpath" 	hint="JavaLoader.cfc path"	default="JavaLoader">
        
        <cfif not StructKeyExists(Application,'Reader')>
			<cfset in		= ArrayNew(1)>
			<cfset in[1]	= "#ExpandPath('./')#pdfbox.jar">
			<cfset loader  	= createObject("component", loaderpath).init(in)>
			
			<cfset Application.Reader 		= loader.create("org.pdfbox.pdmodel.PDDocument")>
			<cfset Application.Stripper 	= loader.create("org.pdfbox.util.PDFTextStripper")>
        </cfif>
		
		<cfif val(arguments.StartPage)>
			<cfset Application.Stripper.setStartPage(arguments.StartPage)>
		</cfif>
		<cfif val(arguments.EndPage)>
			<cfset Application.Stripper.setEndPage(arguments.EndPage)>
		</cfif>

		<cfset mypdf 		= Application.Reader.load(arguments.file)>
        <cfset text		 	= Application.Stripper.getText(mypdf)>
		<cfset Application.Reader.close()>

		<cfreturn text>
	</cffunction>
</cfcomponent>