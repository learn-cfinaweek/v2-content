<cfimport taglib="../../customTags" prefix="ct" />
<ct:securityCheck redirectPage="#cgi.script_name#"/>

<cfparam name="form.submitted" default="0" />
<cfparam name="form.importFile" default="" />

<cfif form.submitted>

	<!--- Upload File--->
	<cffile action="upload" destination="#getTempDirectory()#" filefield="importFile" nameconflict="makeunique" />

	<!--- Read Spreadsheet --->
	<cfspreadsheet action="read" src="#cffile.serverDirectory#/#cffile.serverFile#" query="importData" headerRow="1" excludeheaderrow="true" />		
	
	<!--- Import Data --->
	<cfloop query="importData">
		<cfset blogPost = EntityNew('blogPost') />
		<cfset blogPost.title = importData.title />
		<cfset blogPost.summary = importData.summary />
		<cfset blogPost.body = importData.body />
		<cfset blogPost.dateposted = importData['Date Posted'] />
		<cfset entitySave(blogPost) />
	</cfloop>				
	<cfset ormFlush() />
	
	<cflocation url="listblogpost.cfm?message=#urlencodedformat('Blog Posts Imported Successfully')#" addtoken="false" />
</cfif>

<cfoutput>
	<ct:layout section="resume">
		<ct:navigation section="blog" active="post"/>
		
		<div class="span10">
			<h2>Upload Blog Posts</h2>
			
			<form class="form-horizontal" action="#cgi.script_name#" method="post" enctype="multipart/form-data">
				<div class="control-group">
					<label class="control-label" for="importFile">Import File</label>
					<div class="controls">
						<input type="file" id="importFile" name="importFile" value="#form.importFile#">
					</div>
				</div>
				
				<div class="control-group">
					<div class="controls">
						<button type="submit" class="btn btn-primary">Upload</button>
					</div>
				</div>
				<input type="hidden" name="submitted" value="1" />
			</form>
		</div>	
	</ct:layout>	
</cfoutput>
