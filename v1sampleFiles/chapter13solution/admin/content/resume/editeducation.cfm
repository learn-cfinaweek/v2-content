<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfparam name="url.id" default="0" />
<cfparam name="form.submitted" default="0" />
<cfparam name="form.id" default="0" />
<cfparam name="form.title" default="" />
<cfparam name="form.startDate" default="" />
<cfparam name="form.endDate" default="" />
<cfparam name="form.details" default="" />

<cfset errorBean = createObject('learncfinaweek.www.admin.cfc.errorBean').init() />

<cfif form.submitted>

	<!--- check if data is valid--->
		
	<cfif !len(trim(form.title))>
		<cfset errorBean.addError('School name is required','title') />
	</cfif>	
	
	<cfif !len(trim(form.startDate))>
		<cfset errorBean.addError('A start date is required','startDate') />
	</cfif>	
	
	<cfif !len(trim(form.details))>
		<cfset errorBean.addError('You need to provide some details','details') />
	</cfif>			
	
	<cfif !errorBean.hasErrors()>
		<cfif val(form.id)>
			<cfquery>
				UPDATE
					resume
				SET
					title = <cfqueryparam value="#trim(form.title)#" cfsqltype="cf_sql_varchar" />,
					startDate = <cfqueryparam value="#trim(form.startDate)#" cfsqltype="cf_sql_date" />,
					endDate = <cfqueryparam value="#trim(form.endDate)#" cfsqltype="cf_sql_date" />,
					details = <cfqueryparam value="#trim(form.details)#" cfsqltype="cf_sql_varchar" />
				WHERE
					id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer" />	
			</cfquery>
		<cfelse>
			<cfquery>
				INSERT INTO
					resume (
					title,
					startDate,
					endDate,
					details,
					type
				) VALUES (
					<cfqueryparam value="#trim(form.title)#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#trim(form.startDate)#" cfsqltype="cf_sql_date" />,
					<cfqueryparam value="#trim(form.endDate)#" cfsqltype="cf_sql_date" />,
					<cfqueryparam value="#trim(form.details)#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#trim(form.type)#" cfsqltype="cf_sql_varchar" />
				)
			</cfquery>
		</cfif>
		
		<cflocation url="listeducation.cfm?message=#urlencodedformat('Education Saved')#" addtoken="false" />
	</cfif>	
</cfif>

<cfif val(url.id)>
	<cfquery name="qEducation">
		SELECT
			id,
			title,
			startDate,
			endDate,
			details
		FROM
			resume
		WHERE
			id=<cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer" />	
	</cfquery>
	
	<cfset form.id = qEducation.id />
	<cfset form.title = qEducation.title />
	<cfset form.startDate = qEducation.startDate />
	<cfset form.endDate = qEducation.endDate />
	<cfset form.details = qEducation.details />
</cfif>

<cfoutput>
	<ct:layout section="resume">
		<ct:navigation section="resume" active="education"/>
		
		<div class="span10">
			<cfif val(url.id)>
				<h2>Edit Education</h2>
			<cfelse>
				<h2>Add Education</h2>
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
					<label class="control-label" for="title">School</label>
					<div class="controls">
						<input type="text" id="title" name="title" value="#form.title#">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="dates">Dates</label>
					<div class="controls">
						<input type="text" id="startDate" name="startdate" class="input-medium datepicker" value="#dateformat(form.startDate,'mm/dd/yyyy')#"> to <input type="text" id="endDate" name="endDate" class="input-medium datepicker" value="#dateformat(form.endDate,'mm/dd/yyyy')#">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="details">Details</label>
					<div class="controls">
						<textarea rows="3" id="details" name="details" class="wysiwyg">#form.details#</textarea>
					</div>
				</div>
				<div class="control-group">
					<div class="controls">
						<button type="submit" class="btn btn-primary">Save</button>
					</div>
				</div>
				<input type="hidden" name="submitted" value="1" />
				<input type="hidden" name="id" value="#url.id#" />
				<input type="hidden" name="type" value="education" />
			</form>
		</div>	
	</ct:layout>	
</cfoutput>
