In this hands on, we are going to import and export data into the blog section using Excel.

**Tags Used**: [\<cffile>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-f/cffile.html), [\<cfspreadsheet>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfspreadsheet.html), [\<cfloop>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-j-l/cfloop.html), [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html), [\<cfscript>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfscript.html), [\<cfheader>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-g-h/cfheader.html), [\<cfcontent>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-c/cfcontent.html)

**Functions Used**: [getTempDirectory](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/gettempdirectory.html), [EntityNew](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entitynew.html), [EntitySave](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entitysave.html), [ormFlush](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-m-r/ormflush.html), [EntityLoad](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entityload.html), [spreadsheetNew](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-s/spreadsheetnew.html), [spreadsheetAddRow](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-s/spreadsheetaddrow.html), [spreadsheetFormatRow](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-s/spreadsheetformatrow.html), [spreadsheetAddRows](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-s/spreadsheetaddrows.html), [spreadsheetWrite](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-s/spreadsheetwrite.html)

1. First, let's look at the import process. Open up the `/www/admin/content/blog/importBlog.cfm` file in your code editor.
1. Before importing a spreadsheet, we must first move it to the server. Locate the `Upload File` comment tag. On the line below, create a `<cffile>` tag with the following attributes:
    * **action**: upload
    * **destination**: #getTempDirectory()#
    * **fileField**: importFile
    * **nameconflict**: makeunique
1. Your code should look similar to this:

    <cffile action="upload" destination="#getTempDirectory()#" filefield="importFile" nameconflict="makeunique">

1. Once the file is on the server, we can parse the file and put it into a query variable by using the `<cfspreadsheet>` tag. Locate the `Read Spreadsheet` comment and create a `<cfspreadsheet>` tag on the line below with the following attributes:
    * **action**: read
    * **src**: #cffile.serverDirectory#/#cffile.serverfile#
    * **query**: importData
    * **headerRow**: 1
    * **excludeHeaderRow**: true
1. Your code should look similar to this:

    ```cfml
    <cfspreadsheet action="read" src="#cffile.serverDirectory#/#cffile.serverfile#" query="importData" headerrow="1" excludeheaderrow="true">
    ```

1. Once the spreadsheet has been read into a query variable, loop over the query and create a new `blogPost` entity for each row. To do this, locate the `Import Data` comment tag and create a new `<cfloop>` tag below it with the following attribute:
    * **query**: importData
1. Inside the `<cfloop>` tag, create a `<cfset>` tag that loads in a new `blogPost` entity and saves it in a variable called `blogPost`.
1. Below the `<cfset>`, create new `<cfset>` tags that set the title, summary, body, and date posted values. Note that because the Date Posted column in the spreadsheet has a space in it, you must use bracket notation to access the value rather than dot notation. Your code should look similar to this:

    ```cfml
    <cfloop query="importData">
        <cfset blogPost = EntityNew( 'blogPost' )>
        <cfset blogPost.title = importData.title>
        <cfset blogPost.summary = importData.summary>
        <cfset blogPost.body = importData.body>
        <cfset blogPost.dateposted = importData\['Date Posted'\]>
    </cfloop>
    ```

1. The next step is to save the entity. Just before the closing `</cfloop>` tag, create a `<cfset>` tag that calls `EntitySave` on the `blogPost` entity.
1. After the closing `</cfloop>` tag, create another `<cfset>` tag that calls `ormFlush()`. This will commit all changes to the database. Your final code should look similar to this:

    ```cfml
    <!--- Upload File--->
    <cffile action="upload" destination="#getTempDirectory()#" filefield="importFile" nameconflict="makeunique">

    <!--- Read Spreadsheet --->
    <cfspreadsheet action="read" src="#cffile.serverDirectory#/#cffile.serverfile#" query="importData" headerrow="1" excludeheaderrow="true">

    <!--- Import Data --->
    <cfloop query="importData">
        <cfset blogPost = EntityNew( 'blogPost' )>
        <cfset blogPost.title = importData.title>
        <cfset blogPost.summary = importData.summary>
        <cfset blogPost.body = importData.body>
        <cfset blogPost.dateposted = importData\['Date Posted'\]>
        <cfset EntitySave(blogPost)>
    </cfloop>

    <cfset ormFlush()>
    ```

1. Open up the `/www/admin/content/blog/importBlog.cfm` page in your browser.
1. Select an Excel file and click 'Import'. A template Excel file can be found at: `/www/assets/blogImport.xslx`.
1. Go to the `/www/admin/content/blog/listblogpost.cfm` page in your browser and you will see the imported blog posts.
1. Now that the import process is completed, you are going to create an export process. Create a new file called `exportBlog.cfm` in the `/www/admin/content/blog/` folder.
1. Open up the `/www/admin/content/blog/exportBlog.cfm` file in your code editor.
1. For this task, you are going to write some of it in *cfscript*, so you will need to create a new `<cfscript>` block.
1. Inside the `<cfscript>`, create a variable called `blogPosts` that contains all the `blogPost` entities. You can do this by calling `EntityLoad('blogPost')`.
1. On the next line, create a new spreadsheet called `exportSpreadhseet` by calling the `SpreadsheetNew` function and pass it in a string of 'Blog Posts'. This will name our first sheet Blog Posts. Your code should look similar to this:

    ```cfml
    <cfscript>
        blogPosts = EntityLoad( 'blogPost' );
        exportSpreadsheet = SpreadsheetNew( 'Blog Posts' );
    </cfscript>
    ```

1. Once you have the spreadsheet object created, add a heading row. To do this, call the `SpreadsheetAddRow` function and pass it in the `exportSpreadhseet` object with a comma delimited string of the column headings you want. For this example, the code will look similar to:

    ```cfml
    SpreadsheetAddRow( exportSpreadsheet, 'ID,Title,Summary,Body,Date Posted' );
    ```

1. As this row is a header row, you will want to add some styles to denote that. Using the `SpreadsheetFormatRow` function, format the first row so it is Bold and aligned center. To do this, place the following code below the `SpreadsheetAddRow` call:

    ```cfml
    SpreadsheetFormatRow( exportSpreadsheet, {bold=true,alignment='Center'}, 1 );
    ```

1. Once the header is formatted, add the remaining data to the spreadsheet. Loop over the query and call `SpreadsheetAddRow` on each iteration and pass in the `spreadsheetObject`, in this case `exportSpreadsheet`, and a list of data. The code should look like this:

    ```cfml
    for ( blogPost in blogPosts ){
        SpreadsheetAddRow( exportSpreadsheet, '#blogPost.id#,#blogPost.title#,#blogPost.summary#,#blogPost.body#,#blogPost.datePosted#' );
    }
    ```

1. Now that all the data is in the spreadsheet, save the spreadsheet to the server. To do that, call the `spreadsheetWrite` function and pass it in the `spreadsheetObject`, which is the path of the file we want it to be written to, and you can choose to overwrite the file that might already be there. In this case, write the file to the servers temp directory and have it overwrite any file that might already exist with the same name by using the following code:

    ```cfml
    SpreadsheetWrite( exportSpreadsheet, getTempDirectory() & 'blogPosts.xls', true );
    ```

1. Our completed `<cfscript\>` block should look similar to this:

    ```cfml
    <cfscript>
        blogPosts = EntityLoad( 'blogPost' );
        exportSpreadsheet = SpreadsheetNew( 'Blog Posts' );
        SpreadsheetAddRow( exportSpreadsheet, 'ID,Title,Summary,Body,Date Posted' );
        SpreadsheetFormatRow( exportSpreadsheet, {bold=true,alignment='Center'}, 1 );
        for ( blogPost in blogPosts ){
            SpreadsheetAddRow( exportSpreadsheet, '#blogPost.id#,#blogPost.title#,#blogPost.summary#,#blogPost.body#,#blogPost.datePosted#' );
        }
        SpreadsheetWrite( exportSpreadsheet, getTempDirectory() & 'blogPosts.xls', true );
    </cfscript>
    ```

1. Now that the spreadsheet has been created, you need to serve it up to the user. Use a `<cfheader>` tag and a `<cfcontent>` tag. First, start with the `<cfheader>` tag, which tells the browser to serve it up in line and what the filename should be. Place the following code after the closing `</cfscript>` tag:

    ```cfml
    <cfheader name="Content-Disposition" value="inline; filename=blogPosts.xls">
    ```

1. Finally, use the `<cfcontent>` tag, which tells what file needs to be served and what type of file it is.You can do this by using the following code, which should be placed right after the `<cfheader>` tag:

    ```cfml
    <cfcontent file="#getTempDirectory()#blogPosts.xls" type="vnd.ms-excel">
    ```

1. Your completed file should look similar to this:

    ```cfml
    <cfscript>
        blogPosts = EntityLoad( 'blogPost' );
        exportSpreadsheet = SpreadsheetNew( 'Blog Posts' );
        SpreadsheetAddRow( exportSpreadsheet, 'ID,Title,Summary,Body,Date Posted' );
        SpreadsheetFormatRow( exportSpreadsheet, {bold=true,alignment='Center'}, 1 );
        for ( blogPost in blogPosts ){
            SpreadsheetAddRow( exportSpreadsheet, '#blogPost.id#,#blogPost.title#,#blogPost.summary#,#blogPost.body#,#blogPost.datePosted#' );
        }
        SpreadsheetWrite( exportSpreadsheet, getTempDirectory() & 'blogPosts.xls', true );
    </cfscript>

    <cfheader name="Content-Disposition" value="inline; filename=blogPosts.xls">
    <cfcontent file="#getTempDirectory()#blogPosts.xls" type="vnd.ms-excel">
    ```

1. In a browser, navigate to the `/www/admin/content/blog/exportBlog.cfm` page. You might be prompted to download a file if the download does not start automatically. Open up the Excel file and review the data that has been exported.
