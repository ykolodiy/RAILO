<!DOCTYPE html>
<html lang="en">
<head>
 
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<!--- open the file containing the words --->
<cfset wordsFilePath = "/opt/cf/cfusion/wwwroot/words/words.txt" />
<div class="container">

<cfform action = "words.cfm" name = "form1">

<table class="table table-striped">
    <tbody>
     <tr>
        <th> ENG<cfinput name="word1" type="text" maxlength="20"  required > <br></th>
        <th> UKR<cfinput name="word2"  type="text" maxlength="20"  required> <br></th>
     </tr>
   </tbody>
</table>
<cfinput name="submit"  type="submit">
</cfform>




<table class="table table-striped">
    <thead>
      <tr>
        <th>ENG</th>
        <th>UKR</th>
      </tr>
    </thead>
<tbody>
 
<cfset f=ArrayNew(1)>





<cfloop 
file="#wordsFilePath#"   index="i" item="currentLine" charset = "utf-8">
  
<cfset f[i]=currentLine >

</cfloop>
<!--- loop through 10 lines of the file --->



<cfloop index="i" from="#arrayLen(f)#" to="1" step="-1">

   <cfset wordsArray        = listToArray(f[i], ",") />
  <cfset eng                   = wordsArray[1] />
  <cfset ukr                   = wordsArray[2] />
<cfoutput>
      <tr>
        <td>#eng# </td>
        <td>#ukr# </td>
      </tr>
</cfoutput>

</cfloop>

</tbody>
</table>
</div>
	<cfif IsDefined("FORM.WORD1")>
		
		
		<cfset new = #FORM.WORD1# & "," & #FORM.WORD2#   />
		
	<!--- append results to file --->
<cffile action="append" file="/opt/cf/cfusion/wwwroot/words/words.txt" charset = "utf-8" output="#new#" />

 <cflocation url="words.cfm" >
	</cfif>

</body>
</html>
