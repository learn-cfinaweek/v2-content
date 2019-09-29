<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>


<cfparam name="url.id" default="0" />
<cfparam name="form.submitted" default="0" />
<cfparam name="form.id" default="0" />
<cfparam name="form.title" default="" />
<cfparam name="form.summary" default="" />
<cfparam name="form.body" default="" />
<cfparam name="form.datePosted" default="" />
<cfparam name="form.categories" default="" />

<cfset errorBean = createObject('learncfinaweek.www.admin.cfc.errorBean').init() />

<cfif form.submitted>

	<!--- check if data is valid--->
		
	<cfif !len(trim(form.title))>
		<cfset errorBean.addError('Title is required','title') />
	</cfif>	
	
	<cfif !len(trim(form.summary))>
		<cfset errorBean.addError('A summary is required','startDate') />
	</cfif>	
	
	<cfif !len(trim(form.body))>
		<cfset errorBean.addError('You need to provide a body','details') />
	</cfif>	
	
	<cfif !len(trim(form.datePosted))>
		<cfset errorBean.addError('You need to provide a release date','details') />
	</cfif>			
	
	<!--- Only process if there are no errors --->
	<cfif !errorBean.hasErrors()>
		<cfif val(form.id)>
			<!--- Edit Entity  --->
		<cfelse>
			<!--- Create Entity --->
		</cfif>
		
		<cfset entitySave(blogPost) />
		
		<cfloop list="#form.categories#" index="categoryID">
			<!--- Add Category to Entity --->
		</cfloop>
		
		<cfset ormFlush() />
		
		<cflocation url="listblogpost.cfm?message=#urlencodedformat('Blog Post Saved')#" addtoken="false" />
	</cfif>	
</cfif>

<cfif val(url.id)>
	<!--- Get Entity Data --->

</cfif>

<cfset categories = entityLoad('BlogCategory' ) />

<cfoutput>
	<ct:layout section="blog">
		<ct:navigation section="blog" active="post"/>
		
		<div class="span10">
			<cfif val(url.id)>
				<h2>Edit Blog Post</h2>
			<cfelse>
				<h2>Add Blog Post</h2>
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
					<label class="control-label" for="title">Title</label>
					<div class="controls">
						<input type="text" id="title" name="title" value="#form.title#">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="title">Summary</label>
					<div class="controls">
						<textarea rows="6" id="summary" name="summary" class="input-xlarge">#form.summary#</textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="title">Body</label>
					<div class="controls">
						<textarea rows="3" id="body" name="body" class="wysiwyg">#form.body#</textarea>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="details">Publish Date</label>
					<div class="controls">
						<input type="text" id="datePosted" name="datePosted" class="datepicker" value="#dateFormat(form.datePosted,'mm/dd/yyyy')#">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="details">Categories</label>
					<div class="controls">
							<label class="checkbox">
							<cfloop array="#categories#" index="category">
								<input type="checkbox" name="Categories" value="#category.id#" <cfif listfind(form.categories,category.id)>checked</cfif>>#category.name#<br />
							</cfloop>
						</label>
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
