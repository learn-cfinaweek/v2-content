<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfparam name="url.id" default="0" />
<cfparam name="form.submitted" default="0" />
<cfparam name="form.id" default="0" />
<cfparam name="form.name" default="" />

<cfset errorBean = createObject('learncfinaweek.www.admin.cfc.errorBean').init() />

<cfif form.submitted>

	<!--- check if data is valid--->
	
	<cfif !errorBean.hasErrors()>
		<cfif val(form.id)>
			<!--- Edit Entity  --->
		<cfelse>
			<!--- Create Entity --->
		</cfif>
		
		<cfset entitySave(BlogCategory) />
		<cfset ormFlush() />
		
		<cflocation url="listcategory.cfm?message=#urlencodedformat('Blog Category Saved')#" addtoken="false" />
	</cfif>	
</cfif>

<cfif val(url.id)>
	<!--- Get Entity Data --->
</cfif>

<cfoutput>
	<ct:layout section="blog">
		<ct:navigation section="blog" active="post"/>
		
		<div class="span10">
			<cfif val(url.id)>
				<h2>Edit Category</h2>
			<cfelse>
				<h2>Add Category</h2>
			</cfif>
			
			<cfif errorBean.hasErrors()>
			    <div class="alert alert-error">
			    	<strong>Error</strong><br />
					The following errors occured:
					<ul>
						<cfloop array="#errorBean.getErrors()#" index="error">
							<li>#error.message#</li>
						</cfloop>
					</ul>
			    </div>
			</cfif>
			
			<form class="form-horizontal" action="#cgi.script_name#" method="post">
				<div class="control-group">
					<label class="control-label" for="title">Name</label>
					<div class="controls">
						<input type="text" id="name" name="name" value="#form.name#">
					</div>
				</div>
				
				<div class="control-group">
					<div class="controls">
						<button type="submit" class="btn btn-primary">Save</button>
					</div>
				</div>
				<input type="hidden" name="submitted" value="1" />
				<input type="hidden" name="id" value="#url.id#" />
			</form>
		</div>	
	</ct:layout>	
</cfoutput>
