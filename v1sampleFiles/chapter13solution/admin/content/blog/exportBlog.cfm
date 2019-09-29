<cfscript>
	blogPosts = EntityLoad('BlogPost');
	exportSpreadsheet = SpreadsheetNew('Blog Posts');
	SpreadsheetAddRow(exportSpreadsheet,'ID,Title,Summary,Body,Date Posted');
	SpreadsheetFormatRow(exportSpreadsheet,{bold=true,slignment='Center'},1);
	for(blogPost in blogPosts){
		spreadsheetAddRow(exportSpreadsheet,'#blogPost.id#,#blogPost.title#,#blogPost.summary#,#blogPost.body#,#blogPost.datePosted#');
	}
	SpreadsheetWrite(exportSpreadsheet,getTempDirectory() & 'blogPosts.xls',true);
</cfscript>	
<cfheader name="Content-Disposition" value="inline; filename=blogPosts.xls" />
<cfcontent file="#getTempDirectory()#blogPosts.xls" type="vnd.ms-excel" />
