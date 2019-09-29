<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfquery name="qAdministrator">
	SELECT
		id,
		firstname,
		lastname,
		emailaddress
	FROM
		administrator
	ORDER BY
		lastname, firstname
</cfquery>

<cfset adminPath = createObject('learncfinaweek.www.admin.cfc.system').getBasePath(cgi.script_name) />

<ct:layout section="system">
	<ct:navigation section="system" active="administrator"/>
	
	<div class="span10">
		<h2>Administrators</h2>
		    <form class="navbar-form pull-right">
		    	<a class="btn btn-primary" href="<cfoutput>#adminPath#</cfoutput>/content/system/editadministrator.cfm">
					<i class="icon-plus icon-white"></i> 
					New Administrator
				</a>
		    </form>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email Address</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<cfoutput query="qAdministrator">
					<tr>
						<td>
							#qAdministrator.firstname#
						</td>
						<td>
							#qAdministrator.lastname#
						</td>	
						<td>
							#qAdministrator.emailaddress#
						</td>	
						<td>
							<a href="#adminPath#/content/system/editadministrator.cfm?id=#qAdministrator.id#"><i class="icon-edit"></i></a>
						</td>
					</tr>
				</cfoutput>
			</tbody>
	    </table>
	</div>	
</ct:layout>	
