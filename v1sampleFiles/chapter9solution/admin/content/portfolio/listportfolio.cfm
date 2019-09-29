<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfset adminPath = createObject('learncfinaweek.www.admin.cfc.system').getBasePath(cgi.script_name) />

<cfquery name="qPortfolio">
	SELECT
		id,
		title,
		website
	FROM
		portfolio
	ORDER BY
		title
</cfquery>

<ct:layout section="portfolio">
	<div class="span10">
		<h2>Skillsets</h2>
		    <form class="navbar-form pull-right">
		    	<a class="btn btn-primary" href="<cfoutput>#adminPath#</cfoutput>/content/portfolio/editportfolio.cfm">
					<i class="icon-plus icon-white"></i> 
					New Portfolio
				</a>
		    </form>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Title</th>
					<th>Website</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<cfoutput query="qPortfolio">
					<tr>
						<td>
							#qPortfolio.title#
						</td>
						<td>
							#qPortfolio.website#
						</td>
						<td>
							<a href="#adminPath#/content/portfolio/editportfolio.cfm?id=#qPortfolio.id#"><i class="icon-edit"></i></a>
						</td>
					</tr>
				</cfoutput>
			</tbody>
	    </table>
	</div>	
</ct:layout>	
