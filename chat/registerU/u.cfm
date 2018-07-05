<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="style.css" />
<meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>




<cfquery datasource="acermysql" name="users">
	SELECT * FROM users
</cfquery>

<h3>
	users 
</h3>
<table >
  <tr>
    <th>name</th>
    <th>sex</th> 

  </tr>
  
  <cfoutput query="users">
  <tr>
    <td>#users.name#</td>
    <td>#users.sex#</td>
  

  </tr>
  </cfoutput>
  
</table>

</body>
</html>