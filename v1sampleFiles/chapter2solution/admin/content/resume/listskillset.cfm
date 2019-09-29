<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfset adminPath = createObject('learncfinaweek.www.admin.cfc.system').getBasePath(cgi.script_name) />

<cfquery name="qSkillsets">
	SELECT
		id,
		name
	FROM
		skillset
	ORDER BY
		name
</cfquery>

<ct:layout section="resume">
	<ct:navigation section="resume" active="skillset"/>
	
	<div class="span10">
		<h2>Skillsets</h2>
		    <form class="navbar-form pull-right">
		    	<a class="btn btn-primary" href="<cfoutput>#adminPath#</cfoutput>/content/resume/editskillset.cfm">
					<i class="icon-plus icon-white"></i> 
					New Skillset
				</a>
		    </form>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Name</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<cfoutput query="qSkillsets">
					<tr>
						<td>
							#qSkillsets.name#
						</td>
						<td>
							<a href="#adminPath#/content/resume/editskillset.cfm?id=#qSkillsets.id#"><i class="icon-edit"></i></a>
						</td>
					</tr>
				</cfoutput>
			</tbody>
	    </table>
	</div>	
</ct:layout>	
