<cfparam name="attributes.section" default="" />
<cfparam name="attributes.active" default="" />

<cfif thisTag.executionMode eq "end">
	<cfset adminPath = cgi.script_name/>
	<cfloop from="#listLen(cgi.script_name,'/')#" to="#listfindnocase(cgi.script_name,'admin','/')+1#" index="i" step="-1">	
		<cfset adminPath = ListDeleteAt(adminPath,i,'/') />
	</cfloop>	
	<cfoutput>
		<div class="span2">
		  <div class="well sidebar-nav">
			<cfswitch expression="#attributes.section#" >
				<cfcase value="resume">
					<ul class="nav nav-list">
						<li class="nav-header">Options</li>
						<li <cfif attributes.active eq "workexperience">class="active"</cfif>><a href="#adminPath#/content/resume/listworkexperience.cfm">Work Experience</a></li>
						<li <cfif attributes.active eq "education">class="active"</cfif>><a href="#adminPath#/content/resume/listeducation.cfm">Education</a></li>
						<li <cfif attributes.active eq "skillset">class="active"</cfif>><a href="#adminPath#/content/resume/listskillset.cfm">Skillset</a></li>
					</ul>
				</cfcase>
				
				<cfcase value="blog">
					<ul class="nav nav-list">
						<li class="nav-header">Options</li>
						<li <cfif attributes.active eq "post">class="active"</cfif>><a href="#adminPath#/content/blog/listblogpost.cfm">Blog Posts</a></li>
						<li <cfif attributes.active eq "category">class="active"</cfif>><a href="#adminPath#/content/blog/listcategory.cfm">Category</a></li>
					</ul>
				</cfcase>
				
				<cfcase value="system">
					<ul class="nav nav-list">
						<li class="nav-header">Options</li>
						<li <cfif attributes.active eq "administrator">class="active"</cfif>><a href="#adminPath#/content/system/listadministrator.cfm">Administrators</a></li>
					</ul>
				</cfcase>
			
			</cfswitch>  	
		    
		  </div><!--/.well -->
		</div>
	</cfoutput>
</cfif>
