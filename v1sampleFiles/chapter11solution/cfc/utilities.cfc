<cfcomponent>
	<cffunction name="convertStringToASCII" output="false" returntype="string" hint="Converts String to ASCII String" access="public">
		<cfargument name="stringToBeConverted" type="String" required="true" />
		<cfset var convertedString = '' />
		<cfloop from="1" to="#len(arguments.stringToBeConverted)#" index="i">
			<cfset convertedString &= '&##' & asc(mid(arguments.stringToBeConverted,i,1)) & ';' />
		</cfloop>
		<cfreturn convertedString />		
	</cffunction>
</cfcomponent>