<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfset adminPath = createObject('learncfinaweek.www.admin.cfc.system').getBasePath(cgi.script_name) />

<!--- Pull Blog Posts --->
<cfset blogPosts = EntityLoad('BlogPost') />
<cfoutput>
	<ct:layout section="blog">
		<ct:navigation section="blog" active="post"/>
		
		<div class="span10">
			<h2>Blog</h2>
			    <form class="navbar-form pull-right">
			    	<a class="btn btn-primary" href="<cfoutput>#adminPath#</cfoutput>/content/blog/editblogpost.cfm">
						<i class="icon-plus icon-white"></i> 
						New Blog Post
					</a>
			    </form>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Title</th>
						<th>Publish Date</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<cfloop array="#blogPosts#" index="blogPost">
						<tr>
							<td>
								<!--- Title --->
									#blogPost.title#
							</td>
							<td>
								<!--- Date Posted --->
								#dateFormat(blogPost.datePosted,"mm/dd/yyyy")#
							</td>
							<td>
								<!--- Edit Post --->
								<a href="#adminPath#/content/blog/editblogpost.cfm?id=#blogPost.id#"><i class="icon-edit"></i></a>
							</td>
						</tr>
					</cfloop>
				</tbody>
		    </table>
		</div>	
	</ct:layout>	
</cfoutput>
