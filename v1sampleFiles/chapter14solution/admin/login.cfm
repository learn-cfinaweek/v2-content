<cfimport taglib="customTags" prefix="ct" />

<cfparam name="form.submitted" default="0" />
<cfparam name="form.emailaddress" default="" />
<cfparam name="form.redirectPage" default="index.cfm" />

<cfset errorBean = createObject('learncfinaweek.www.admin.cfc.errorBean').init() />

<cfif form.submitted>
	<cfquery name="qLoginCheck">
		SELECT
			id,
			emailaddress,
			password,
			salt
		FROM
			administrator
		WHERE
			emailAddress = <cfqueryparam value="#trim(form.emailaddress)#" cfsqltype="cf_sql_varchar" />
	</cfquery>	
	
	<cfif !qLoginCheck.recordcount || qLoginCheck.password NEQ Hash(form.password & qLoginCheck.salt, "SHA-512")>
		<cfset errorBean.addError('Incorrect Login Details','emailaddress') />
	<cfelse>
		<cfset session.adminID = qLoginCheck.id />
		<cfset session.emailaddress = qLoginCheck.emailaddress />
		<cfset sessionRotate() />
		<cflocation url="#form.redirectPage#" addToken="no" />
	</cfif>		
	
</cfif>	
<cfoutput>
	<ct:layout section="login">
		<div class="span6 offset2 well">
			<h2>
				Login
			</h2>
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
			<form class="form-horizontal" action="login.cfm" method="post">
				<div class="control-group">
					<label class="control-label" for="emailaddress">Email Address</label>
					<div class="controls">
						<input type="text" id="emailaddress" name="emailaddress" value="#form.emailaddress#">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="password">Password</label>
					<div class="controls">
						<input type="password" id="Password" name="Password" value="">
					</div>
				</div>
				<div class="control-group">
					<div class="controls">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</div>
				<input type="hidden" name="submitted" value="1" />
				<input type="hidden" name="redirectPage" value="#redirectPage#" />
			</form>	
		</div>	
	</ct:layout>	
</cfoutput>
