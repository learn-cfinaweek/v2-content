<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfparam name="url.id" default="0" />
<cfparam name="form.submitted" default="0" />
<cfparam name="form.id" default="0" />
<cfparam name="form.title" default="" />
<cfparam name="form.summary" default="" />
<cfparam name="form.website" default="" />
<cfparam name="form.image" default="" />

<cfset errorBean = createObject('learncfinaweek.www.admin.cfc.errorBean').init() />

<cfif form.submitted>

	<!--- check if data is valid--->
		
	<cfif !len(trim(form.title))>
		<cfset errorBean.addError('A Title is required','title') />
	</cfif>	
	
	
	<cfif !errorBean.hasErrors()>
		<!--- Image Upload Process --->
		<cfif len(trim(form.image))>	
			<cffile action="upload" filefield="image" destination="#getTempDirectory()#" nameconflict="makeunique"  />
			<cfif listFindNoCase(getReadableImageFormats(),cffile.serverFileExt)>
				<cfset imageObject = imageRead(cffile.serverDirectory & '/' & cffile.serverfile) />
				<cfset imageSCaleToFit(imageObject,'202','131') />
				<cfset imageWrite(imageObject,expandpath('../../../assets/images/portfolio/#cffile.serverfile#')) />
				<cfset form.image = cffile.serverfile />
			<cfelse>
				<cfset form.image='' />
			</cfif>	 	
		</cfif>
		<!--- Save Portfolio --->	
		<cfif val(form.id)>
			<cfquery>
				UPDATE
					portfolio
				SET
					title = <cfqueryparam value="#trim(form.title)#" cfsqltype="cf_sql_varchar" />,
					summary = <cfqueryparam value="#trim(form.summary)#" cfsqltype="cf_sql_varchar" />,
					website = <cfqueryparam value="#trim(form.website)#" cfsqltype="cf_sql_varchar" />
					<cfif len(form.image)>
					, image=<cfqueryparam value="#trim(form.image)#" cfsqltype="cf_sql_varchar" />	
					</cfif>	
				WHERE
					id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer" />	
			</cfquery>
		<cfelse>
			<cfquery>
				INSERT INTO
					portfolio (
					title,
					summary,
					website
					<cfif len(form.image)>
						, image
					</cfif>		
				) VALUES (
					<cfqueryparam value="#trim(form.title)#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#trim(form.summary)#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#trim(form.website)#" cfsqltype="cf_sql_varchar" />
					<cfif len(form.image)>
						<cfqueryparam value="#trim(form.image)#" cfsqltype="cf_sql_varchar" />
					</cfif>	
				)
			</cfquery>
		</cfif>
		
		<cflocation url="listportfolio.cfm?message=#urlencodedformat('Portfolio Saved')#" addtoken="false" />
	</cfif>	
</cfif>

<cfif val(url.id)>
	<cfquery name="qPortfolio">
		SELECT
			id,
			title,
			summary,
			website,
			image
		FROM
			portfolio
		WHERE
			id=<cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer" />	
	</cfquery>
	
	<cfset form.id = qPortfolio.id />
	<cfset form.title = qPortfolio.title />
	<cfset form.summary = qPortfolio.summary />
	<cfset form.website = qPortfolio.website />
	<cfset form.image = qPortfolio.image />
</cfif>

<cfoutput>
	<ct:layout section="portfolio">
		
		<div class="span10">
			<cfif val(url.id)>
				<h2>Edit Portfolio</h2>
			<cfelse>
				<h2>Add Portfolio</h2>
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
			
			<form class="form-horizontal" action="#cgi.script_name#" method="post" enctype="multipart/form-data">
				<div class="control-group">
					<label class="control-label" for="title">Title</label>
					<div class="controls">
						<input type="text" id="title" name="title" value="#form.title#">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="summary">Summary</label>
					<div class="controls">
						<textarea rows="3" id="summary" name="summary">#form.summary#</textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="website">Website</label>
					<div class="controls">
						<input type="text" id="website" name="website" value="#form.website#">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="image">Image</label>
					<div class="controls">
						<input type="file" id="image" name="image" value="">
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
