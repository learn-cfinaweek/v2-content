In this hands on, we will do a simple database call and output the data.

**Tags Used**: [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html), [\<cfquery>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfquery.html), [\<cfloop>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-j-l/cfloop.html)

1. Open up the `/www/resume.cfm` file in your code editor.
1. First, replace the list with a call to the database. On line 1, replace the `<cfset>` tag with an open `<cfquery>` tag with the following attributes:
    * **name**: mySkillSet
    * **datasource**: Learncfinaweek
1. On the next line enter the following SQL code:

    ```sql
    SELECT
        name
    FROM
        skillset
    ORDER BY
        name DESC
    ```

1. On the next line, write a closing `</cfquery>` tag.
1. Your code should look similar to this:

    ```cfml
    <cfquery name="mySkillset" datasource="learncfinaweek">
        SELECT
            name
        FROM
            skillset
        ORDER BY
            name DESC
    </cfquery>
    ```

1. Please note that the data source you are using was created during the initial setup process for you.
1. Now that you have a query, you need to update the loop to accept the query rather than the list. Locate the opening `<cfloop>` tag on or around line 120 and replace its attributes with:
    * **query**: mySkillset
1. Inside the `<cfloop>` tag, replace all references to skill with `#mySkillset.name#`.
1. Your code should look similar to this:

    ```cfml
    <cfloop query="mySkillset">
        <li class="#mySkillset.name#" id="#mySkillset.name#">#mySkillset.name#</li>
    </cfloop>
    ```

1. Open up your browser and navigate to the `/www/resume.cfm` page. Confirm that the Skills are still displaying.
