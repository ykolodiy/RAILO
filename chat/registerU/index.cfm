<link type="text/css" rel="stylesheet" href="style.css" />
<meta name="viewport" content="width=device-width, initial-scale=1">


<!--- 
<cfoutput>online now: #serialize(Application.ReadOnlyData.Users)#</cfoutput> --->
<cfoutput>online now: #serialize(Application.exclusive.Users)#</cfoutput>







<cfif not structKeyExists(session, "name") >

	<cfif structKeyExists(form, "submitform") and form.name NEQ "" and form.password NEQ "">
		<cftry> 

			<cfquery datasource="acermysql" name="auth">
				SELECT name, password 
				FROM users 
				WHERE name = '#form.name#' AND password =  '#form.password#' 
			</cfquery>

			<cfif auth.RecordCount EQ 1 >
				<cfset session.name = form.name >

				<!--- APPEND --->
				<cfset Application.exclusive.Users.append("#session.name#")>
				<cflocation url="chat5.cfm" addtoken="false">
			<cfelse>
			<cfset structClear(form)>
			<cfoutput>Found records: #auth.RecordCount#</cfoutput>
			</cfif>

			<cfcatch type="database" >
				<!--- <cfdump var="#cfcatch#" /> --->
				<cfset structClear(form)>
				<script>
					alert("wrong login or password");
				</script>
			</cfcatch>
		</cftry>

	</cfif>

	<cfoutput>
		<div id="loginform">
			<cfform action="index.cfm" method="post" name="submitform">
				<p>LOG IN</p>
		
				<TABLE BORDER="0">
				  <TR>
				    <TD>Name:</TD><TD><cfinput type="text" name="name" id="name" /></TD>
				  </TR>
				  <TR>
				    <TD>Password:</TD><TD><cfinput type="password" name="password" id="password" /></TD>
				  </TR>
				</TABLE>


				<cfinput type="submit" name="submitform" id="submitform" value="SIGN IN" />
			</cfform>
			<br>or<br>
			<a href="register.cfm" id="register">REGISTER</a>
		</div>
	</cfoutput>

<cfelse>
	<cflocation url="chat5.cfm" addtoken="false">
</cfif>


</body>
</html>