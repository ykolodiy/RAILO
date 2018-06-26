<meta name="viewport" content="width=device-width, initial-scale=1">


<!---Form processing Script http://ukrtv.biz:8080/railowww/chat/register/register.cfm --->
<cfif structKeyExists(form, 'submituser')>
	<cftry> 

	<!--- Start server side data validation --->
	<cfset aErrorMessages = ArrayNew(1) />
	
		<!--- validate ID --->
		<cfif form.name EQ ''>
			<cfset arrayAppend(aErrorMessages, 'Please provide a valid login') />
		</cfif>
		<!--- validate Domain --->
		<cfif form.password EQ ''>
			<cfset arrayAppend(aErrorMessages, 'Please provide a valid password') />
		</cfif>
		
		<!--- Lets check if aErrorMessages empty? --->
		<cfif ArrayIsEmpty(aErrorMessages)>
			<!---goon on form process coz no error --->


		

			<cfquery datasource="acermysql">
				INSERT INTO users 
				(name, password, sex)
				VALUES 
				('#form.name#', 
				'#form.password#', 
				"#form.sex#"
				)
			</cfquery>
			
			<!---feedback --->
			<cfset userisinserted = true>

		</cfif>


			<cfcatch type="database" >
			<!--- <cfdump var="#cfcatch#" /> --->
	<script>
      alert("Try another login");
   </script>
			</cfcatch>
			</cftry>

</cfif>


<!DOCTYPE html>
<html>
<head>
<style>
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}
th, td {
    padding: 5px;
    text-align: left;
}

</style>
</head>





<body>
	<!--- server side data validation error messages goes here if any --->
<cfif isDefined('aErrorMessages')  >
	<cfoutput >
	<cfloop array="#aErrorMessages#" index="message">
		<p>
			#message#
		</p>
	</cfloop>
	</cfoutput>
</cfif>

<cfif isDefined('userisinserted')>
<cfset structClear(form)>
<cfset userisinserted = false>
<cflocation url="chat5.cfm" addtoken="false">
</cfif>



<cfform id="insertuser" name= "insertuser" method="post" action="register.cfm">
<fieldset style="display: inline-block">	 <legend>User Registration</legend>
<table style="width:auto">
  <tr>
    <th>Login</th>
    <th>Password</th>
    <th>Sex</th>
  </tr>

  <tr>
    <td><input type="text" name="name"  required ></td>
    <td><input type="text" name="password"  required ></td>
    <td> 
    	<input type="radio" name="sex" value="m" checked> Male<br>
  		<input type="radio" name="sex" value="f"> Female<br>
   </td>
  </tr>

</table>


  <cfinput type="submit" name="submituser" value="Submit">
   </fieldset>
</cfform> 

</body>
</html>