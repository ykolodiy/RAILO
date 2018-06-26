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
table {
    width: 100%;    
    background-color: #f1f1c1;
}
</style>

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