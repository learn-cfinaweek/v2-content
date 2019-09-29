<cfset session.adminID = '' />
<cfset session.emailaddress = '' />
<cfset sessionInvalidate() />
<cflocation url="login.cfm" addToken="false" />