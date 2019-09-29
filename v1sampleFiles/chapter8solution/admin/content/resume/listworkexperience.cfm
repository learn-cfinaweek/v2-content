<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfset adminPath = createObject('learncfinaweek.www.admin.cfc.system').getBasePath(cgi.script_name) />

<cfquery name="qWorkExperience">
	SELECT
		id,
		title,
		startDate,
		endDate
	FROM
		resume
	WHERE
		type = 'workexperience'
</cfquery>

<ct:layout section="resume">
	<ct:navigation section="resume" active="workexperience"/>
	
	<div class="span10">
		<h2>Work Experience</h2>
		    <form class="navbar-form pull-right">
		    	<a class="btn btn-primary" href="<cfoutput>#adminPath#</cfoutput>/content/resume/editworkexperience.cfm">
					<i class="icon-plus icon-white"></i> 
					New Work Experience
				</a>
		    </form>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Position</th>
					<th>Dates</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<cfoutput query="qWorkExperience">
					<tr>
						<td>
							#qWorkExperience.title#
						</td>
						<td>
							#dateformat(qWorkExperience.startDate,'mm/dd/yyyy')# to <cfif qWorkExperience.endDate eq "">present<cfelse>#dateformat(qWorkExperience.endDate,'mm/dd/yyyy')#</cfif>
						</td>
						<td>
							<a href="#adminPath#/content/resume/editworkexperience.cfm?id=#qWorkExperience.id#"><i class="icon-edit"></i></a>
						</td>
					</tr>
				</cfoutput>
			</tbody>
	    </table>
	</div>	
</ct:layout>	
