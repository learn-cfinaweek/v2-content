<cfparam name="url.id" default="0" />
<cfset blogPost = EntityLoad('BlogPost', url.id, true) />

<cfif !isNull(blogPost)>
	<cfdocument format="pdf" name="myGeneratedPDF">
		<cfdocumentitem type="header">
			<h1 style="text-align:center;">Generated from our website</h1>
		</cfdocumentitem>	
		<cfoutput>
		<h1>
			#blogPost.title#
		</h1>
		<p>
			<strong>Date Posted</strong>: #dateformat(blogPost.datePosted,'mm/dd/yyyy')#
		</p>
		<p>	
		#blogPost.body#
		</p>		
		</cfoutput>
	</cfdocument>	
	<cfpdf action="addWatermark" source="myGeneratedPDF" image="assets/images/watermark.jpeg" foreground="yes" overwrite="yes" />
	<cfcontent variable="#toBinary(myGeneratedPDF)#" type="application/pdf" /> 
</cfif>	