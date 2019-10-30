In this hands on example, you are going to update the front end of the web site to pull in the blog information you have entered through the admin.

**Tags Used**: [\<cfloop>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-j-l/cfloop.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html), [\<cfparam>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfparam.html), [\<cfset>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-r-s/cfset.html), [\<cfif>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-i/cfif.html)

**Functions Used**: [EntityLoad](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entityload.html), [dateFormat](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-c-d/DateFormat.html), [arrayLen](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-a-b/arraylen.html), [dateFormat](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-c-d/DateFormat.html), [timeFormat](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-t-z/TimeFormat.html), [EntityNew](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entitynew.html), [EntitySave](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-functions/functions-e-g/entitysave.html)

> If you did not do the Data Handling homework you will have a difficulty following along. Copy the `blog.cfm` file from the `/chapter6solution/` folder into your `/www/` folder so you can proceed.

1. Open up the `/www/blog.cfm` file in your code editor.
1. First, pull all blog posts (in real life, you would only want to pull 10 or so entries per page). To pull all entries, call the `EntityLoad` function passing in the string 'blogPost' and assigning that to a `blogPosts` variable. Do this by replacing the `<cfquery>` block with the following line of code:

    ```cfml
    <cfset blogPosts = EntityLoad( 'blogPost' )>
    ```

1. Next, loop over the objects and output them. To do this, we will use a `<cfloop>` tag. Locate the `<cfoutput>` tag and replace it with the following line of code:

    ```cfml
    <cfloop array="#blogPosts#" index="blogPost">
    ```

1. Replace the closing `</cfoutput>` tag with a closing `</cfloop>` tag, on or around line 39.
1. Before proceeding, wrap the `<cfloop>` block with a `<cfoutput>` so that the data will be output to the screen.
1. You now need to start replacing the placeholder information with the variables from the `blogPost` object. First, append the `ID` to the `URL` so that you can view the more detailed blog post later. Update the href attribute of the `<a>` tag and append `#blogPost.id#` to the link. The link should now read:

    ```cfml
    blogpost.cfm?id=#blogpost.id#
    ```

1. Next, replace the `myBlog.title` variable with `blogPost.title`.
1. Replace the `myBlog.datePosted` variable with `blogPost.datePosted`.
1. Replace the `myBlog.summary` variable with `blogPost.summary`.
1. The final step is to output the number of comments that the blog post contains. To do this, call the `getComments()` function on the `blogPost` object and use the `arrayLen` function to count how many entries were returned by replacing the number '12' with the following code:

    ```cfml
    #arrayLen( blogPost.getComents() )#
    ```

1. Go to the `/www/blog.cfm` page in your browser and confirm that you now see all your blog posts listing on the page.
1. Next, update the blog post detail page to display the relevant blog post information. Open up the `/www/blogpost.cfm` file in your code editor.
1. At the top of the file, load in the blog post object and set it to a variable called `blogPost` using the following code:

    ```cfml
    <cfset blogPost = EntityLoad( 'BlogPost', url.id, true )>
    ```

1. Then replace the placeholder content with the real content. Locate the `<h2>` tag and replace its content with `#blogPost.title#`.
1. Replace the date with `#dateformat(blogPost.dateposted,'mm/dd/yyyy')#`.
1. Replace the blog body placeholder text; this is the next five `<p>` tags. Delete these and replace them with `#blogPost.body#`.
1. The last step is to put the blog post's ID value into the 'Export to PDF' link. Append the following code to the hef value of the `<a>` tag:

    ```cfml
    #blogPost.id#
    ```

1. Your code should look similar to this:

    ```cfml
    <h2>
        #blogPost.title#
    </h2>
    <p>
        <strong>Date Posted</strong>: #dateformat( blogPost.datePosted, 'mm/dd/yyyy' )#
    </p>
    #blogPost.body#
    <p>
        <a href="exportToPDF.html?id=#blogPost.id#" target=”_new”>Export to PDF</a>
    </p>
    <h3>
        Comments (2)
    </h3>
    ```

1. You need to output how many comments the blog has, which is done by doing the same thing you have done previously by using the `arrayLen` function. Replace the number '2' with the following code:

    ```cfml
    #arrayLen( blogPost.getComments() )#
    ```

1. Now, loop over the comments and output them. To do this, use a `<cfloop>` tag. Just after the HTML comment tag, `Start Comment`, create a `<cfloop>` tag with the following attributes:
    * **array**: #blogPost.getComents()#
    * **index**: comment
1. Place a closing `</cfloop>` tag before the HTML comment tag, `End Comment` and remove the other `<li>` tag.
1. The comment object will now be available in the comment variable. Replace the date with the following code:

    ```cfml
    #dateFormat( comment.createdDateTime, 'mm/dd/yyyy' )#
    ```

1. Replace the time with the following code:

    ```cfml
    #timeformat( comment.createdDateTime, 'short' )#
    ```

1. Replace 'Simon Free' with the following code:

    ```cfml
    #comment.author#
    ```

1. And finally, replace the placeholder text in the `<p>` tag with the following code:

    ```cfml
    #comment.comment#
    ```

1. Your code should look similar to this:

    ```cfml
    <ul>
        <cfloop array="#blogPost.getComents()#" index="comment">
        <li>
            <p>
                Posted On: #dateFormat( comment.createdDateTime, 'mm/dd/yyyy' )# at #timeformat( comment.createdDateTime, 'short' )# By #comment.author#
            </p>
            <p>
                #comment.comment#
            </p>
            <div class="clr hline"></div>
        </li>
        </cfloop>
    </ul>
    ```

1. Next, wrap the entire `<div class="left>` block in a `<cfoutput>` tag block. The opening `<cfoutput>` will start on or around line 25. The closing `</cfoutput>` should be placed on or around line 93.
1. If you were to run this page now, you would see no comments as there are no comments in the system. The next step is to allow users to submit comments. Go to the top of the file and create a `<cfparam>` tag with the following attributes:
    * **name**: form.submitted
    * **default**: 0
1. Next, add the logic to save the comment only if the form has been submitted. You can check if the form has been submitted by looking at the `form.submitted` value. After the `<cfset>` tag on or around line two, create a `<cfif>` tag, which checks if `form.submitted` is true. Your code should look similar to this:

    ```cfml
    <cfparam name="form.submitted" default="0">
    <cfset blogPost = EntityLoad( 'blogPost', url.id, true )>
    <cfif form.submitted>

    </cfif>
    ```

1. Inside the `<cfif>` block, create a new instance of the `blogComment` entity and set the author and comment values from the `form` scope. Your code should look similar to this:

    ```cfml
    <cfset comment = entityNew( 'blogComment' )>
    <cfset comment.author = form.author>
    <cfset comment.comment = form.comment>
    ```

1. Next, set the `createdDateTime` value using the `now()` function and add the comment to the `blogPost` object. Your code should look similar to this:

    ```cfml
    <cfset comment = entityNew( 'blogComment' )>
    <cfset comment.author = form.author>
    <cfset comment.comment = form.comment>
    <cfset comment.createdDateTime = now()>
    <cfset blogPost.addComment( comment )>
    ```

1. Now that you have created the comment and added it to the blog post, you need to save these changes by calling `entitySave` on the `blogPost` object. Add the following line of code after your last `<cfset>` tag:

    ```cfml
    <cfset EntitySave( blogPost )>
    ```

1. Your final code block should look similar to this:

    ```cfml
    <cfif form.submitted>
        <cfset comment = entityNew( 'blogComment' )>
        <cfset comment.author = form.author>
        <cfset comment.comment = form.comment>
        <cfset comment.createdDateTime = now()>
        <cfset blogPost.addComment( comment )>
        <cfset EntitySave( blogPost )>
    </cfif>
    ```

1. Locate the `<form>` tag on or around line 78 and append the following code to the action attribute:

    ```cfml
    #blogPost.id#
    ```

1. Open up the `/www/blog.cfm` page in your browser. Navigate to a blog post and enter a comment. You should now see your comment displayed in the comment section.
