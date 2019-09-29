<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfset adminPath = createObject('learncfinaweek.www.admin.cfc.system').getBasePath(cgi.script_name) />

<cfquery name="qEducation">
	SELECT
		id,
		title,
		startDate,
		endDate
	FROM
		resume
	WHERE
		type = 'education'
</cfquery>

<ct:layout section="resume">
	<ct:navigation section="resume" active="education"/>
	
	<div class="span10">
		<h2>Education</h2>
		    <form class="navbar-form pull-right">
		    	<a class="btn btn-primary" href="<cfoutput>#adminPath#</cfoutput>/content/resume/editeducation.cfm">
					<i class="icon-plus icon-white"></i> 
					New Education
				</a>
		    </form>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>School</th>
					<th>Dates</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<cfoutput query="qEducation">
					<tr>
						<td>
							#qEducation.title#
						</td>
						<td>
							#dateformat(qEducation.startDate,'mm/dd/yyyy')# to <cfif qEducation.endDate eq "">present<cfelse>#dateformat(qEducation.endDate,'m/dd/yyyy')#</cfif>
						</td>
						<td>
							<a href="#adminPath#/content/resume/editeducation.cfm?id=#qEducation.id#"><i class="icon-edit"></i></a>
						</td>
					</tr>
				</cfoutput>
			</tbody>
	    </table>
	</div>	
</ct:layout>	
