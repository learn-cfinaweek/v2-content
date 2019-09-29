<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfset adminPath = createObject('learncfinaweek.www.admin.cfc.system').getBasePath(cgi.script_name) />

<!--- Pull Categories --->

<cfoutput>
	<ct:layout section="blog">
		<ct:navigation section="blog" active="category"/>
		
		<div class="span10">
			<h2>Category</h2>
			    <form class="navbar-form pull-right">
			    	<a class="btn btn-primary" href="<cfoutput>#adminPath#</cfoutput>/content/blog/editcategory.cfm">
						<i class="icon-plus icon-white"></i> 
						New Category
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
					<cfloop array="#blogCategories#" index="blogCategory">
						<tr>
							<td>
								<!--- Name --->
							</td>
							<td>
								<!--- Edit Category --->
								<a href="#adminPath#/content/blog/editcategory.cfm?id="><i class="icon-edit"></i></a>
							</td>
						</tr>
					</cfloop>
				</tbody>
		    </table>
		</div>	
	</ct:layout>	
</cfoutput>
