In this next hands on, you are going to add functionality that will allow you to export a blog post in PDF format. We will also add a watermark to the PDF.

**Tags Used**: [\<cfparam>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfparam.html), [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html), [\<cfif>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-i/cfif.html), [\<cfdocument>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-d-e/cfdocument.html), [\<cfdocumentitem>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-d-e/cfdocumentitem.html), [\<cfpdf>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfpdf.html), [\<cfcontent>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-c/cfcontent.html)

**Functions Used**: [EntityLoad](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entityload.html), [isNull](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-in-k/isnull.html), [toBinary](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-t-z/tobinary.html)

1. Create a new file in the `/www/` folder called `ExportToPDF.cfm`.
1. Open the `/www/ExportToPDF.cfm` file in your code editor.
1. On the first line of the file, create a `<cfparam>` tag with the following attributes:
    * **name**: url.id
    * **default**: 0
1. Next, load in the blog post so you can get the data needed. To do this, create a `<cfset>` that does an `entityLoad` call requesting a `blogPost` with the ID of 'url.id' and sets it into a `blogPost` variable by adding the following line of code:

    ```cfml
    <cfset blogPost = EntityLoad( 'blogPost', url.id, true )>
    ```

1. Before proceeding with the PDF generation, make sure that the ID that was passed was for a valid blog post by checking to make sure the `blogPost` object does not have a null value. To do this, create a `<cfif>` statement and use the `isNull` function on the `blogPost` variable. Your code should look similar to this:

    ```cfml
    <cfparam name="url.id" default="0" >
    <cfset blogPost = EntityLoad( 'blogPost', url.id, true )>

    <cfif !isNull( blogPost )>

    </cfif>
    ```

1. Inside of the `<cfif>` block, create a `<cfdocument>` tag with the following attribute:
    * **format**: PDF
1. Add a closing `</cfdocument>` tag.
1. Inside the `<cfdocument>` tags add the following code:

    ```cfml
    <cfoutput>
        <h1>
            #blogPost.title#
        </h1>
        <p>
            <strong>Date Posted</strong>: #dateformat( blogPost.datePosted, 'mm/dd/yyyy' )#
        </p>
        <p>
        #blogPost.body#
        </p>
    </cfoutput>
    ```

1. Open up the `/www/blog.cfm` page in your browser, navigate to a blog post, and click on 'Export To PDF'. You should see a PDF of the blog post.
1. Next, add a header to the PDF which states it came from the website. Go back to the `ExportToPDF.cfm` file in your code editor and add a `<cfdocumentitem>` tag inside the `<cfdocument>` tag that has the following property:
    *   **type**: header
1. Inside the <cfdocumentitem> add the following code:

    ```cfml
    <h1 style="text-align:center;">Generated from our website</h1>
    ```

1. Your `<cfdocument>` code should looks similar to this:

    ```cfml
    <cfdocument format="PDF">
        <cfdocumentitem type="header">
            <h1 style="text-align:center;">Generated from our website</h1>
        </cfdocumentitem>
        <cfoutput>
        <h1>
            #blogPost.title#
        </h1>
        <p>
            <strong>Date Posted</strong>: #dateformat( blogPost.datePosted, 'mm/dd/yyyy' )#
        </p>
        <p>
        #blogPost.body#
        </p>
        </cfoutput>
    </cfdocument>
    ```

1. Go back to the `ExportToPDF.cfm` file in your browser and refresh. You should now see the title displayed in the PDF.
1. Now add a watermark to the PDF. First, save the generated PDF to a variable rather than having it automatically output on the page. You can do this by updating the `<cfdocument>` tag and adding the following property:
    * **name**: myGeneratedPDF
1. If you were to re-run the `ExportToPDF.cfm` file in your browser, you would no longer see the PDF as it is now stored in a variable. Now, create a `<cfpdf>` tag that will allow us to add the watermark. After the closing `</cfdocument>` tag, create a `<cfpdf>` tag with the following attributes:
    * **action**: addWatermark
    * **source**: myGeneratedPDF
    * **image**: assets/images/watermark.jpeg
    * **foreground**: yes
    * **overwrite**: yes
1. Once again, if you were to run this file, you would still see no output; you need to manually tell ColdFusion to display the PDF. This is done with the `<cfcontent>` tag. After the `<cfpdf>` tag, create a `<cfcontent>` tag with the following attributes:
    * **variable**: #toBinary(myGeneratedPDF)#
    * **type**: application/pdf
1. Reload the `ExportToPDF.cfm` file in your browser and you should now see your PDF with a large W in the middle. The W is the Watermark.
