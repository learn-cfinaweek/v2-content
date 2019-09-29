<cfparam name="attributes.redirectPage" default="" />

<cfif thisTag.executionMode eq "start">
	<cfif !structKeyExists(session,'adminID') || !val(session.adminID)>
		<cfset adminPath = cgi.script_name/>
		<cfloop from="#listLen(cgi.script_name,'/')#" to="#listfindnocase(cgi.script_name,'admin','/')+1#" index="i" step="-1">	
			<cfset adminPath = ListDeleteAt(adminPath,i,'/') />
		</cfloop>
		<cflocation url="#adminpath#/login.cfm?redirectPage=#urlencodedformat(attributes.redirectPage)#" addtoken="no">
	</cfif>	
</cfif>	