<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfparam name="url.id" default="0" />
<cfparam name="form.submitted" default="0" />
<cfparam name="form.id" default="0" />
<cfparam name="form.firstname" default="" />
<cfparam name="form.lastname" default="" />
<cfparam name="form.emailAddress" default="" />
<cfparam name="form.password" default="" />

<cfset errorBean = createObject('learncfinaweek.www.admin.cfc.errorBean').init() />

<cfif form.submitted>

	<!--- check if data is valid--->
		
	<cfif !len(trim(form.firstname))>
		<cfset errorBean.addError('First name is required','firstname') />
	</cfif>	
	
	<cfif !len(trim(form.lastname))>
		<cfset errorBean.addError('Last name is required','lastname') />
	</cfif>	
	
	<cfif !len(trim(form.emailaddress))>
		<cfset errorBean.addError('Email Address is required','emailaddress') />
	</cfif>	
	
	<cfif !len(trim(form.password)) && !val(form.id)>
		<cfset errorBean.addError('Password is required','password') />
	</cfif>
	
	<cfif trim(form.password) neq trim(form.password2)>
		<cfset errorBean.addError('Passwords do not match','password') />
	</cfif>				
	
	<cfif !errorBean.hasErrors()>
		<cfif val(form.id)>
			<cfquery>
				UPDATE
					administrator
				SET
					firstname = <cfqueryparam value="#trim(form.firstname)#" cfsqltype="cf_sql_varchar" />,
					lastname = <cfqueryparam value="#trim(form.lastname)#" cfsqltype="cf_sql_varchar" />,
					emailaddress = <cfqueryparam value="#trim(form.emailaddress)#" cfsqltype="cf_sql_varchar" />
					<cfif len(trim(form.password))>
						,password = <cfqueryparam value="#trim(form.password)#" cfsqltype="cf_sql_varchar" />
					</cfif>
				WHERE
					id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer" />	
			</cfquery>
		<cfelse>
			<cfquery>
				INSERT INTO
					administrator (
					firstname,
					lastname,
					emailaddress,
					password
				) VALUES (
					<cfqueryparam value="#trim(form.firstname)#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#trim(form.lastname)#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#trim(form.emailaddress)#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#trim(form.password)#" cfsqltype="cf_sql_varchar" />
				)
			</cfquery>
		</cfif>
		
		<cflocation url="listadministrator.cfm?message=#urlencodedformat('Administrator Saved')#" addtoken="false" />
	</cfif>	
</cfif>

<cfif val(url.id)>
	<cfquery name="qAdministrator">
		SELECT
			id,
			firstname,
			lastname,
			emailaddress
		FROM
			administrator
		WHERE
			id=<cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer" />	
	</cfquery>
	
	<cfset form.id = qAdministrator.id />
	<cfset form.firstname = qAdministrator.firstname />
	<cfset form.lastname = qAdministrator.lastname />
	<cfset form.emailaddress = qAdministrator.emailaddress />
</cfif>

<cfoutput>
	<ct:layout section="system">
		<ct:navigation section="system" active="administrator"/>
		
		<div class="span10">
			<cfif val(url.id)>
				<h2>Edit Administrator</h2>
			<cfelse>
				<h2>Add Administrator</h2>
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
					<label class="control-label" for="firstname">First Name</label>
					<div class="controls">
						<input type="text" id="firstname" name="firstname" value="#form.firstname#">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="lastname">Last Name</label>
					<div class="controls">
						<input type="text" id="lastname" name="lastname" value="#form.lastname#">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="emailAddress">Email Address</label>
					<div class="controls">
						<input type="text" id="emailAddress" name="emailAddress" value="#form.emailAddress#">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="password">Password</label>
					<div class="controls">
						<input type="password" id="password" name="password" value="">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="password2">Password (retype)</label>
					<div class="controls">
						<input type="password" id="password2" name="password2" value="">
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
