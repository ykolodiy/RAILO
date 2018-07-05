<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>my chat</title>
<link type="text/css" rel="stylesheet" href="style.css" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<cfoutput>online now: #serialize(Application.exclusive.Users)#</cfoutput>



<!--- this writes to file users input via ajax call --->
<cfif len(toString(getHttpRequestData().content)) GT 0  and not findNoCase("Enter", toString(getHttpRequestData().content))>
    <!--- write to file --->
    <cfset requestBody = toString( getHttpRequestData().content ) & "<br>" />
    <cffile action = "append" file = "log.html" attributes = normal output = "#requestBody#">
<cfelse>
    <!--- do nothing because no request --->
</cfif>



<!--- CHAT ONLY IF SESSION IS ON, LOGGED IN --->
<cfif not structKeyExists(session, "name") >
<cflocation url="index.cfm">

<!--- IF LOGGED IN SHOW chat2 BOX --->
<cfelse>

<!--- chat5box here --->
<script type="text/javascript">
			//Load the file containing the chat5 log
	function loadLog(){		
		var oldscrollHeight = $("#chat2box").attr("scrollHeight") - 20; //Scroll height before the request
		$.ajax({
			url: "log.html",
			cache: false,
			success: function(html){		
				$("#chat2box").html(html); //Insert chat log into the #chat2box div	
				
				//Auto-scroll			
				var newscrollHeight = $("#chat2box").attr("scrollHeight") - 20; //Scroll height after the request
				if(newscrollHeight > oldscrollHeight){
					$("#chat2box").animate({ scrollTop: newscrollHeight }, 'normal'); //Autoscroll to bottom of div
				}				
		  	},
		});
	}







<!--- UPDATE chat and activeusers every 1 second --->

setInterval(function () {
    loadLog();
    
}, 1000);


</script>



<!--- TEMPLATE OF CHAT WINDOW --->
<div id="wrapper" >
    <div id="menu" >
        <p class="welcome">Welcome, <cfoutput>#session.name# </cfoutput><b></b></p>
        <p class="logout"><a id="exit" href="#">Exit Chat</a></p>
        <div style="clear:both"></div>
    </div>
     
    <div id="chat2box" ><!--- JQUERY INSERT LOG.HTML HERE ---></div>
     
 <input name="usermsg" type="text" id="usermsg" /> 
 <button id="buttonsend" onclick="SendMessage()">Send</button>


<!--- TEMPLATE OF ACTIVE USERS --->
<div id="activeusers" ><!--- JQUERY INSERT AU.HTML HERE ---></div>
<!--- END OF TEMPLATE OF ACTIVE USERS --->



 <script>
    <!--- send users message to chat box --->
  function SendMessage() {
  	var name = "<cfoutput>#DateFormat(Now())#, #TimeFormat(Now())#   #UCase(session.name)# </cfoutput> wrote>> "
  	var datamsg = name + document.getElementById("usermsg").value;
    var ajaxResponse = $.ajax({
            type: "post",
            url: "./chat5.cfm",
            contentType: "application/json",
            data: datamsg,
            dataType: "text"
        })
    <!--- to empty the input box --->
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
		if(exit==true){window.location = 'chat5.cfm?logout=true';}		
	});
});
</script>
<!--- logout destroy session  --->
<cfif structKeyExists(url, "logout")>
<cfset exituser = "<div class='msgln'><i>User " & "#session.name#"  & " has left the chat session.</i><br></div>" >
<cffile action = "append" file = "log.html" attributes = normal output = "#exituser#">
<!--- DELETE --->
<cfset Application.exclusive.Users.delete("#session.name#")> 

<cfset StructClear(session)>

<cflocation url="index.cfm" addtoken="false">
</cfif>
<!--- END OF LOGOUT LOGIC --->


</cfif>



</body>
</html>