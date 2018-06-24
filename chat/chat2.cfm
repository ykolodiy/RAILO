
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>chat2 - Customer Module</title>
<link type="text/css" rel="stylesheet" href="style.css" />

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js"></script>

</head>
<body>



<cfif not structKeyExists(session, "name")>
<cfinvoke method="login">

<!--- IF LOGGED IN SHOW chat2 BOX --->
<cfelse>
<!--- chat2box here --->
<script type="text/javascript">
			//Load the file containing the chat2 log
	function loadLog(){		
		var oldscrollHeight = $("#chat2box").attr("scrollHeight") - 20; //Scroll height before the request
		$.ajax({
			url: "log.html",
			cache: false,
			success: function(html){		
				$("#chat2box").html(html); //Insert chat2 log into the #chat2box div	
				
				//Auto-scroll			
				var newscrollHeight = $("#chat2box").attr("scrollHeight") - 20; //Scroll height after the request
				if(newscrollHeight > oldscrollHeight){
					$("#chat2box").animate({ scrollTop: newscrollHeight }, 'normal'); //Autoscroll to bottom of div
				}				
		  	},
		});
	}


setInterval (loadLog, 1000);

</script>

<div id="wrapper">
    <div id="menu">
        <p class="welcome">Welcome, <cfoutput>#session.name# </cfoutput><b></b></p>
        <p class="logout"><a id="exit" href="#">Exit chat2</a></p>
        <div style="clear:both"></div>
    </div>
     
    <div id="chat2box"><!--- JQUERY INSERT LOG.HTML HERE ---></div>
     
 <input name="usermsg" type="text" id="usermsg" size="63" /> 
 <button id="buttonsend" onclick="SendMessage()">Send</button>

 <script>
  function SendMessage() {
  	var name = "<cfoutput>#session.name#</cfoutput> wrote: "
  	var datamsg = name + document.getElementById("usermsg").value;
    var ajaxResponse = $.ajax({
            type: "post",
            url: "./chat3.cfm",
            contentType: "application/json",
            data: datamsg,
            dataType: "text"
        })

    document.getElementById("usermsg").value='';
    }
</script>


    
</div>

<!--- LOGOUT LOGIC --->
<script type="text/javascript">
// jQuery Document
$(document).ready(function(){
	//If user wants to end session
	$("#exit").click(function(){
		var exit = confirm("Are you sure you want to end the session?");
		if(exit==true){window.location = 'chat2.cfm?logout=true';}		
	});
});
</script>
<!--- logout destroy session  --->
<cfif structKeyExists(url, "logout")>
<cfset exituser = "<div class='msgln'><i>User " & "#session.name#"  & " has left the chat2 session.</i><br></div>" >
<cffile action = "append" file = "log.html" attributes = normal output = "#exituser#">
<cfset StructClear(session)>
<cflocation url="chat2.cfm" addtoken="false">
</cfif>
<!--- END OF LOGOUT LOGIC --->



<!--- grab user input and append to file --->
<cfif structKeyExists(form, "submitmsg") and form.usermsg NEQ "">
<cfset umessage = "#session.name#" & " wrote: " & "#form.usermsg#" & "<br>" />
<cffile action = "append" file = "log.html" attributes = normal output = "#umessage#">
</cfif>


</cfif>

<!--- LOGIN HANDLER--->
<cfif structKeyExists(form, "submitform") and form.name NEQ "">
	<cfset session.name = form.name >
	<cflocation url="chat2.cfm" addtoken="false">
</cfif>
<cffunction name="login">
<cfoutput>
   <div id="loginform">
    <cfform action="chat2.cfm" method="post" name="submitform">
        <p>Please enter your name to continue:</p>
        <label for="name">Name:</label>
        <cfinput type="text" name="name" id="name" />
        <cfinput type="submit" name="submitform" id="submitform" value="Enter" />
    </cfform>
    </div>
</cfoutput>
</cffunction>
<!--- END OF LOGIN HANDLER--->



<!---
<cfdump var="#SESSION#">
--->
</body>
</html>