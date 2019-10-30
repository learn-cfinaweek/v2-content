In this hands on, we are going to create a more complex query and output that to the page.

**Tags Used**: [\<cfquery>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfquery.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html), [\<cfelse>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-d-e/cfelse.html)

**Functions Used**: [dateFormat](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-c-d/DateFormat.html), [len](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-l/len.html)

1. Open up the `/www/resume.cfm` file in your code editor.
1. Below the `mySkillset` query, create another open `<cfquery>` tag with the following attributes:
    *   **name**: myResume
    *   **datasource**: learncfinaweek
1. After the opening `<cfquery>` tag, provide the following SQL text:

    ```sql
    SELECT
        title,
        startDate,
        endDate,
        details,
        type
    FROM
        resume
    ORDER BY
        type,
        endDate,
        startDate
    ```

1. After the SQL text, add a close `</cfquery>` tag.
1. Your code should look similar to this:

    ```cfml
    <cfquery name="myResume" datasource="learncfinaweek">
        SELECT
            title,
            startDate,
            endDate,
            details,
            type
        FROM
            resume
        ORDER BY
            type DESC,
            endDate,
            startDate
    </cfquery>
    ```

1. Locate the `Resume Listings` comment tag on or around line 90.
1. After the comment, add a `<cfoutput>` tag with the following attributes:
    * **query**: myResume
    * **group**: type
1. Add a closing `</cfoutput>` tag after the `End Resume Listing` comment.
1. Delete the lines of code from right after the closing `</cfoutput>` tag to the closing `</div>` tag on or around line 141.
1. Your code should look similar to this:

    ```cfml
    <div class="left">
        <!-- Resume Listing -->
        <cfoutput query="myResume" group="type">
            <h2>Work Experience <span> </span></h2>
            <h5>Senior Developer - Google Inc <span>2010 to present </span> </h5>
            <p>Lorem ipsum dolor sit amet, habitasse pretium dolor sociis. Nulla et facilisis interdum elit amet erat, consectetuer condimentum eaque, ante maecenas Suspendisse libero diam.</p>
            <!-- End Resume Listing -->
        </cfoutput>
    </div>
    ```

1. Replace the text "Work Experience" with `#myResume.type#`.
1. After that line, place an opening `<cfoutput>` tag.
1. Note that we are using the group functionality within ColdFusion; this allows sub loops to be performed inside of a `<cfoutput>`. This is the only time that a `<cfoutput>` tag should be nested inside of another `<cfoutput>` tag.
1. Place a closing `</cfoutput>` tag just before the other `</cfoutput>` closing tag.
1. Your code should look similar to this:

    ```cfml
    <div class="left">
        <!-- Resume Listing -->
        <cfoutput query="myResume" group="type">
            <h2>#type# <span> </span></h2>
            <cfoutput>
                <h5>Senior Developer - Google Inc <span>2010 to present </span> </h5>
                <p>Lorem ipsum dolor sit amet, habitasse pretium dolor sociis. Nulla et facilisis interdum elit amet erat, consectetuer condimentum eaque, ante maecenas Suspendisse libero diam.</p>
                <!-- End Resume Listing -->
            </cfoutput>
        </cfoutput>
    </div>
    ```

1. Replace the "Senior Developer –Google Inc" text with `#myResume.title#`.
1. Replace the "2010 to present" text with `#myResume.startDate#` to `#myResume.endDate#`.
1. Replace the contents of the `<p>` tag with `#myResume.details#`.
1. Your code should look similar to this:

    ```cfml
    <div class="left">
        <!-- Resume Listing -->
        <cfoutput query="myResume" group="type">
            <h2>#type# <span> </span></h2>
            <cfoutput>
                <h5>#myResume.title# <span>#myResume.startDate# to #myResume.endDate# </span> </h5>
                <p>#myResume.details#</p>
                <!-- End Resume Listing -->
            </cfoutput>
        </cfoutput>
    </div>
    ```

1. Open up a browser and navigate to the `/www/resume.cfm` page.
1. Note that there are new Work Experience and Education information displaying. Also note that the dates are not displaying in a nice, readable format.
1. Go to the `myResume.startDate` output on or around line 123 and change it to read:

    ```cfml
    #dateFormat( myResume.startDate, "mm/dd/yyyy" )#
    ```

1. Reload the `/www/resume.cfm` page in the browser and note that the start dates are now in a nice, readable format.
1. Go to the `myResume.endDate` output on or around line 123 and make the same update. The code should read:

    ```cfml
    #dateFormat( myResume.endDate, "mm/dd/yyyy" )#
    ```

1. Reload the `/www/resume.cfm` page in the browser. Notice that the date range does not show an end date for the Senior Developer position. This is because there is no end date in the database. Let's make that a bit more readable.
1. Go back to the reference to `myResume.endDate` on or around line 123.
1. After the word "to" and before the start of the `dateformat` function, add the following code:

    ```cfml
    <cfif len( myResume.endDate )>
    ```

1. After the end of the `dateFormat` function, add the following code:

    ```cfml
    <cfelse>present</cfif>
    ```

1. Your code should look similar to the following:

    ```cfml
    <div class="left">
        <!-- Resume Listing -->
        <cfoutput query="myResume" group="type">
            <h2>#type# <span>&nbsp; </span></h2>
            <cfoutput>
                <h5>#myResume.title# <span>#dateFormat( myResume.startDate, "mm/dd/yyyy" )# to <cfif len( myResume.endDate )>#dateFormat( myResume.endDate, "mm/dd/yyyy" )#<cfelse>present</cfif> </span> </h5>
                <p>#myResume.details#</p>
                <!-- End Resume Listing -->
            </cfoutput>
        </cfoutput>
    </div>
    ```

1. Reload the `/www/resume.cfm` page in your browser.
1. You should now see that the Senior Developer entry has a more readable output.

Homework
--------

Update the Blog and Portfolio sections to pull the data from the database.
