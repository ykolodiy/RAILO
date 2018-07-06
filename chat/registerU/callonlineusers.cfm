<!--- http://localhost:5555/chat/registerU/callonlineusers.cfm --->

<p id="demo"></p>


<script type="text/javascript">

function getusers() {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.getElementById("demo").innerHTML = this.responseText;
    }
  };
  xhttp.open("GET", "onlineusers.cfm", true);
  xhttp.send();
}



var myVar = setInterval(getusers, 1000);
</script>