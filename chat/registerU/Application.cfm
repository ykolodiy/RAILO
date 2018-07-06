<!--- HERE I JUST NEED TO CREATE APPLICATION SCOPE AND VARIABLE ARRAY USERS ---> 

<!--- Set application name and enable Client and Session variables. ---> 
<cfapplication name="Users" 
clientmanagement="Yes" 
sessionmanagement="Yes"> 

<!--- Set page processing attributes. ---> 
<cfsetting showDebugOutput="No"> 

<!--- Set custom global error handling pages for this application.
<cferror type="request" 
template="requesterr.cfm" 
mailto="admin@company.com"> 
<cferror type="validation" 
template="validationerr.cfm"> 
---> 


<!--- Set the Application variables if they aren't defined. ---> 
<!--- Initialize local app_is_initialized flag to false. ---> 
<cfset app_is_initialized = False> 
<!--- Get a read-only lock. ---> 
<cflock scope="application" type="readonly" timeout=10> 
<!--- Read init flag and store it in local variable. ---> 
<cfset app_is_initialized = IsDefined("Application.initialized")> 
</cflock> 
<!--- Check the local flag. ---> 
<cfif not app_is_initialized> 
<!--- Application variables are not initialized yet.  Get an exclusive lock to write scope. ---> 
<cflock scope="application" type="exclusive" timeout=10> 
<!--- Check the Application scope initialized flag since another request 
could have set the variables after this page released the read-only 
lock. ---> 
<cfif not IsDefined("Application.initialized")> 


<!--- Do initializations ---> 
<cfset Application.exclusive.Users = arrayNew(1)> 
<!--- and so on ---> 
<!--- Set the Application scope initialization flag. ---> 
<cfset Application.initialized = "yes"> 
</cfif> 
</cflock> 
</cfif> 

<!--- Set a Session variable.
<cflock timeout="20" scope="Session" type="exclusive"> 
<cfif not IsDefined("session.pagesHit")> 
<cfset session.pagesHit=1> 
<cfelse> 
<cfset session.pagesHit=session.pagesHit+1> 
</cfif> 
</cflock> 
---> 

